import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class TagRow {
  TagRow(String name, String value)
      : nameController = TextEditingController(text: name),
        valueController = TextEditingController(text: value);

  final TextEditingController nameController;
  final TextEditingController valueController;

  List<String> toTag() => [nameController.text, valueController.text];

  void dispose() {
    nameController.dispose();
    valueController.dispose();
  }
}

class TagEditor extends StatelessWidget {
  const TagEditor({
    super.key,
    required this.rows,
    required this.onAdd,
    required this.onRemove,
  });

  final List<TagRow> rows;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(l10n.tagsSection, style: theme.textTheme.titleMedium),
            const Spacer(),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(l10n.tagsAddButton),
            ),
          ],
        ),
        if (rows.isEmpty)
          Text(
            l10n.tagsEmptyHint,
            style: theme.textTheme.bodySmall,
          ),
        ...rows.asMap().entries.map((entry) {
          final i = entry.key;
          final row = entry.value;
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: row.nameController,
                    decoration: InputDecoration(
                      labelText: l10n.tagNameLabel,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: row.valueController,
                    decoration: InputDecoration(
                      labelText: l10n.tagValueLabel,
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onRemove(i),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
