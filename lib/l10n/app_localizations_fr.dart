// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Griffe';

  @override
  String get appTagline => 'Signez avec Nostr';

  @override
  String get signTitle => 'Signer';

  @override
  String get logoutTooltip => 'Se déconnecter';

  @override
  String get kindLabel => 'Kind (entier)';

  @override
  String get contentSection => 'Contenu';

  @override
  String get contentHint => 'Saisissez le contenu ici…';

  @override
  String get tagsSection => 'Tags';

  @override
  String get tagsAddButton => 'Ajouter';

  @override
  String get tagsEmptyHint => 'Aucun tag.';

  @override
  String get tagNameLabel => 'nom';

  @override
  String get tagValueLabel => 'valeur';

  @override
  String get signButton => 'Signer';

  @override
  String get errorInvalidKind => 'Kind invalide';

  @override
  String get errorCannotSign =>
      'Cette session ne peut pas signer (compte read-only). Reconnectez-vous avec une clé privée.';

  @override
  String errorSaveFile(String error) {
    return 'Erreur enregistrement : $error';
  }

  @override
  String get signedEventSection => 'Événement signé';

  @override
  String get copyButton => 'Copier';

  @override
  String get saveJsonButton => 'Enregistrer .json';

  @override
  String get copiedSnackbar => 'JSON copié dans le presse-papier';

  @override
  String savedSnackbar(String path) {
    return 'Fichier enregistré : $path';
  }
}
