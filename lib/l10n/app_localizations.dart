import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application name shown on the login screen and as window title.
  ///
  /// In en, this message translates to:
  /// **'Griffe'**
  String get appTitle;

  /// Subtitle under the app name on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Sign with Nostr'**
  String get appTagline;

  /// AppBar title of the sign screen.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get signTitle;

  /// Tooltip for the logout icon in the AppBar.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logoutTooltip;

  /// Label of the integer text field where the user enters the Nostr event kind.
  ///
  /// In en, this message translates to:
  /// **'Kind (integer)'**
  String get kindLabel;

  /// Section title above the content text area.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get contentSection;

  /// Placeholder text inside the content text area.
  ///
  /// In en, this message translates to:
  /// **'Write the content here…'**
  String get contentHint;

  /// Section title above the tag editor.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tagsSection;

  /// Label for the button that appends a new empty tag row.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get tagsAddButton;

  /// Shown in the tags section when no tag rows exist.
  ///
  /// In en, this message translates to:
  /// **'No tags.'**
  String get tagsEmptyHint;

  /// Label for the tag-name field inside a tag row.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get tagNameLabel;

  /// Label for the tag-value field inside a tag row.
  ///
  /// In en, this message translates to:
  /// **'value'**
  String get tagValueLabel;

  /// Main call-to-action button that signs the event.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get signButton;

  /// Error message shown when the user-entered custom kind cannot be parsed as an integer.
  ///
  /// In en, this message translates to:
  /// **'Invalid kind'**
  String get errorInvalidKind;

  /// Error shown when the logged-in account has no private key (npub-only login).
  ///
  /// In en, this message translates to:
  /// **'This session cannot sign (read-only account). Sign in again with a private key.'**
  String get errorCannotSign;

  /// Snackbar message shown when saving the .json file fails. {error} contains the exception string.
  ///
  /// In en, this message translates to:
  /// **'Save error: {error}'**
  String errorSaveFile(String error);

  /// Title of the result card that appears after a successful signature.
  ///
  /// In en, this message translates to:
  /// **'Signed event'**
  String get signedEventSection;

  /// Button that copies the signed event JSON to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyButton;

  /// Button that opens the native save dialog to write the signed event JSON to a file.
  ///
  /// In en, this message translates to:
  /// **'Save .json'**
  String get saveJsonButton;

  /// Snackbar confirming the JSON was copied.
  ///
  /// In en, this message translates to:
  /// **'JSON copied to clipboard'**
  String get copiedSnackbar;

  /// Snackbar confirming the .json file was saved. {path} is the chosen filesystem path.
  ///
  /// In en, this message translates to:
  /// **'File saved: {path}'**
  String savedSnackbar(String path);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
