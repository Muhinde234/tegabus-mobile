import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final token = await storage.read(key: 'token');
  final localeCode = await storage.read(key: 'locale') ?? 'en';

  final initialScreen =
      token != null ? const Layout() : const OnbordingScreen();

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
