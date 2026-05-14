import 'dart:convert';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';

import '../l10n/app_localizations.dart';
import '../widgets/signed_event_card.dart';
import '../widgets/tag_editor.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key, required this.account});

  final Account account;

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _contentController = TextEditingController();
  final _kindController = TextEditingController(text: '30078');
  final _scrollController = ScrollController();
  final List<TagRow> _tagRows = [];

  Nip01Event? _signedEvent;
  String? _signedJson;
  bool _isSigning = false;
  String? _error;

  @override
  void dispose() {
    _contentController.dispose();
    _kindController.dispose();
    _scrollController.dispose();
    for (final row in _tagRows) {
      row.dispose();
    }
    super.dispose();
  }

  Future<void> _sign() async {
    final ndk = Get.find<Ndk>();
    final l10n = AppLocalizations.of(context);
    final kind = int.tryParse(_kindController.text.trim());
    if (kind == null) {
      setState(() => _error = l10n.errorInvalidKind);
      return;
    }
    if (ndk.accounts.cannotSign) {
      setState(() => _error = l10n.errorCannotSign);
      return;
    }

    setState(() {
      _isSigning = true;
      _error = null;
      _signedEvent = null;
      _signedJson = null;
    });

    try {
      final tags = _tagRows
          .map((r) => r.toTag())
          .where((t) => t[0].trim().isNotEmpty)
          .toList();

      final ts = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final unsigned = Nip01Event(
        pubKey: widget.account.pubkey,
        kind: kind,
        tags: tags,
        content: _contentController.text,
        createdAt: ts,
      );

      final signed = await ndk.accounts.sign(unsigned);
      final json = const JsonEncoder.withIndent('  ').convert({
        'id': signed.id,
        'pubkey': signed.pubKey,
        'created_at': signed.createdAt,
        'kind': signed.kind,
        'tags': signed.tags,
        'content': signed.content,
        'sig': signed.sig,
      });

      setState(() {
        _signedEvent = signed;
        _signedJson = json;
        _isSigning = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isSigning = false;
      });
    }
  }

  Future<void> _copyJson() async {
    if (_signedJson == null) return;
    await Clipboard.setData(ClipboardData(text: _signedJson!));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).copiedSnackbar)),
    );
  }

  Future<void> _saveJsonFile() async {
    if (_signedJson == null || _signedEvent == null) return;
    final bytes = Uint8List.fromList(utf8.encode(_signedJson!));
    final shortId = _signedEvent!.id.substring(0, 8);
    final name = 'griffe-$shortId';
    final l10n = AppLocalizations.of(context);
    try {
      final path = await FileSaver.instance.saveAs(
        name: name,
        bytes: bytes,
        fileExtension: 'json',
        mimeType: MimeType.json,
      );
      if (!mounted) return;
      if (path != null && path.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.savedSnackbar(path))));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.errorSaveFile(e.toString()))));
    }
  }

  void _addTagRow() {
    setState(() => _tagRows.add(TagRow('', '')));
  }

  void _removeTagRow(int index) {
    setState(() {
      _tagRows[index].dispose();
      _tagRows.removeAt(index);
    });
  }

  void _logout() {
    final ndk = Get.find<Ndk>();
    ndk.accounts.removeAccount(pubkey: widget.account.pubkey);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final npub = Nip19.encodePubKey(widget.account.pubkey);
    final shortNpub =
        '${npub.substring(0, 12)}…${npub.substring(npub.length - 6)}';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(shortNpub, style: theme.textTheme.bodySmall),
            ),
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: l10n.logoutTooltip,
          ),
        ],
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _kindController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: l10n.kindLabel),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.contentSection,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contentController,
                        maxLines: 12,
                        minLines: 6,
                        decoration: InputDecoration(hintText: l10n.contentHint),
                      ),
                      const SizedBox(height: 24),
                      TagEditor(
                        rows: _tagRows,
                        onAdd: _addTagRow,
                        onRemove: _removeTagRow,
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: _isSigning ? null : _sign,
                        icon: _isSigning
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.draw_outlined),
                        label: Text(l10n.signButton),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ],
                      if (_signedJson != null) ...[
                        const SizedBox(height: 24),
                        SignedEventCard(
                          json: _signedJson!,
                          onCopy: _copyJson,
                          onSave: _saveJsonFile,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
