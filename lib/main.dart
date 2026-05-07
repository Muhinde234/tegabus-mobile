import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/screens/onbording_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  const storage = FlutterSecureStorage();
  final localeCode = await storage.read(key: 'locale') ?? 'en';

  // Demo mode: always start at onboarding so the full passenger journey
  // (onboarding → login → home → book → ticket) can be walked through on every
  // launch. Drop any leftover dummy token from previous runs.
  await storage.delete(key: 'token');
  const initialScreen = OnbordingScreen();

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => LocaleNotifier(localeCode)),
      ],
      child: Application(initialScreen: initialScreen),
    ),
  );
}

class Application extends ConsumerWidget {
  final Widget initialScreen;
  const Application({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // Flutter's GlobalMaterialLocalizations / GlobalCupertinoLocalizations
        // don't ship Kinyarwanda. We still want app strings in rw, but Material
        // widgets need *some* MaterialLocalizations to render. These shims
        // satisfy the requirement by reusing the English implementations.
        _RwMaterialLocalizationsDelegate(),
        _RwCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('rw'),
        Locale('fr'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DColors.primary,
          primary: DColors.primary,
          surface: DColors.surface,
        ),
        scaffoldBackgroundColor: DColors.background,
        appBarTheme: DTheme.appBarTheme,
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
        elevatedButtonTheme: DTheme.elevatedButtonThemeData,
        outlinedButtonTheme: DTheme.outlinedButtonThemeData,
        inputDecorationTheme: DTheme.inputDecorationTheme,
        cardTheme: DTheme.cardThemeData,
        navigationBarTheme: DTheme.navigationBarTheme,
        dialogTheme: const DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home: initialScreen,
    );
  }
}

// ── Locale shims ─────────────────────────────────────────────────────────────
// Flutter ships MaterialLocalizations / CupertinoLocalizations for ~80 locales,
// but Kinyarwanda (`rw`) isn't one of them. Without a delegate that accepts
// `rw`, every Material widget throws "No MaterialLocalizations found" the
// moment the user picks Kinyarwanda. These two shims accept `rw` and reuse
// the English implementations so the UI keeps rendering — only our own
// AppLocalizations strings change.

class _RwMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _RwMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_RwMaterialLocalizationsDelegate old) => false;
}

class _RwCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _RwCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_RwCupertinoLocalizationsDelegate old) => false;
}
