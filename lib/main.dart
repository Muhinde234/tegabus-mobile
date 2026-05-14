import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/screens/layout.dart';
import 'package:mobile/screens/onbording_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  const storage = FlutterSecureStorage();
  final localeCode = await storage.read(key: 'locale') ?? 'en';
  final themeRaw = await storage.read(key: 'theme_mode');
  final initialThemeMode = ThemeModeNotifier.decode(themeRaw);

  // Session bootstrap: if a PASSENGER token is already present, skip onboarding
  // and drop the user straight into the app. Any non-passenger session is
  // cleared by AuthService.cachedUser().
  final token = await storage.read(key: 'token');
  final userJson = await storage.read(key: 'user_data');
  final hasPassengerSession = (token != null && token.isNotEmpty) &&
      (userJson != null && userJson.contains('"PASSENGER"'));
  final Widget initialScreen =
      hasPassengerSession ? const Layout() : const OnbordingScreen();

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => LocaleNotifier(localeCode)),
        themeModeProvider
            .overrideWith((ref) => ThemeModeNotifier(initialThemeMode)),
      ],
      child: Application(initialScreen: initialScreen),
    ),
  );
}

class Application extends ConsumerWidget {
  final Widget initialScreen;
  const Application({super.key, required this.initialScreen});

  ThemeData _lightTheme(BuildContext context) {
    final base = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DColors.primary,
        brightness: Brightness.light,
        primary: DColors.primary,
        surface: DColors.surface,
      ),
      scaffoldBackgroundColor: DColors.background,
      appBarTheme: DTheme.appBarTheme,
      textTheme: GoogleFonts.outfitTextTheme(base.textTheme),
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
    );
  }

  ThemeData _darkTheme(BuildContext context) {
    final base = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DColorsDark.primary,
        brightness: Brightness.dark,
        primary: DColorsDark.primary,
        surface: DColorsDark.surface,
      ),
      scaffoldBackgroundColor: DColorsDark.background,
      appBarTheme: DTheme.darkAppBarTheme,
      textTheme: GoogleFonts.outfitTextTheme(base.textTheme).apply(
        bodyColor: DColorsDark.neutral6,
        displayColor: DColorsDark.neutral6,
      ),
      elevatedButtonTheme: DTheme.darkElevatedButtonThemeData,
      outlinedButtonTheme: DTheme.darkOutlinedButtonThemeData,
      inputDecorationTheme: DTheme.darkInputDecorationTheme,
      cardTheme: DTheme.darkCardThemeData,
      // Dark navigation bar styling — built inline so it stays in sync with
      // the bottom-nav widget that already overrides this with its own pill.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DColorsDark.surface,
        indicatorColor: DColorsDark.primary1,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: DColorsDark.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            );
          }
          return const TextStyle(color: DColorsDark.neutral4, fontSize: 11);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: DColorsDark.primary, size: 22);
          }
          return const IconThemeData(color: DColorsDark.neutral4, size: 22);
        }),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: DColorsDark.surface,
        surfaceTintColor: DColorsDark.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: DColorsDark.surface,
        surfaceTintColor: DColorsDark.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

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
      theme: _lightTheme(context),
      darkTheme: _darkTheme(context),
      themeMode: themeMode,
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
