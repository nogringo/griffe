import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class SignedEventCard extends StatelessWidget {
  const SignedEventCard({
    super.key,
    required this.json,
    required this.onCopy,
    required this.onSave,
  });

  final String json;
  final VoidCallback onCopy;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.signedEventSection,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy),
                  label: Text(l10n.copyButton),
                ),
                FilledButton.icon(
                  onPressed: onSave,
                  icon: const Icon(Icons.save_alt),
                  label: Text(l10n.saveJsonButton),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                json,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
