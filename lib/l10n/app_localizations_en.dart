// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Griffe';

  @override
  String get appTagline => 'Sign with Nostr';

  @override
  String get signTitle => 'Sign';

  @override
  String get logoutTooltip => 'Sign out';

  @override
  String get kindLabel => 'Kind (integer)';

  @override
  String get contentSection => 'Content';

  @override
  String get contentHint => 'Write the content here…';

  @override
  String get tagsSection => 'Tags';

  @override
  String get tagsAddButton => 'Add';

  @override
  String get tagsEmptyHint => 'No tags.';

  @override
  String get tagNameLabel => 'name';

  @override
  String get tagValueLabel => 'value';

  @override
  String get signButton => 'Sign';

  @override
  String get errorInvalidKind => 'Invalid kind';

  @override
  String get errorCannotSign =>
      'This session cannot sign (read-only account). Sign in again with a private key.';

  @override
  String errorSaveFile(String error) {
    return 'Save error: $error';
  }

  @override
  String get signedEventSection => 'Signed event';

  @override
  String get copyButton => 'Copy';

  @override
  String get saveJsonButton => 'Save .json';

  @override
  String get copiedSnackbar => 'JSON copied to clipboard';

  @override
  String savedSnackbar(String path) {
    return 'File saved: $path';
  }
}
