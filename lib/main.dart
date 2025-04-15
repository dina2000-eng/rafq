import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rafq1/Screens/HomePage.dart';
import 'package:rafq1/Screens/auth/loginscreen.dart';
import 'package:rafq1/Screens/drawerpages/DarkModeProvider.dart';
import 'package:rafq1/Screens/drawerpages/SettingsScreen.dart';
import 'package:rafq1/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("رسالة واردة في الخلفية: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  FirebaseAuth.instance.setLanguageCode('ar');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      startLocale: Locale('ar'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DarkModeProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('ar');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("🔍 اللغات المدعومة: ${EasyLocalization.of(context)!.supportedLocales}");
    print("اللغة الحالية: ${context.locale}");

    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: EasyLocalization.of(context)!.locale,
          supportedLocales: context.supportedLocales,

          localizationsDelegates: [
            EasyLocalization.of(context)!.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          //supportedLocales: [Locale('en'), Locale('ar')],
          theme: darkModeProvider.isDarkMode
              ? ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Cairo'),
          )
              : ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Cairo'),
          ),

          home: SplashScreenSlider(onLocaleChange: _changeLanguage),
          routes: {
            '/home': (context) => HomePage(forumId: "your_forum_id"),
            '/login': (context) => LoginScreen(),
            '/settings': (context) => SettingsScreen(
              onLocaleChange: (Locale locale) {
                context.setLocale(locale);
              },
            ),
          },
        );
      },
    );
  }
}

class SplashScreenSlider extends StatefulWidget {
  final void Function(Locale locale) onLocaleChange;
  const SplashScreenSlider({super.key, required this.onLocaleChange});

  @override
  _SplashScreenSliderState createState() => _SplashScreenSliderState();
}

class _SplashScreenSliderState extends State<SplashScreenSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final List<Widget> splashScreens = [
    SplashScreen1(),
  ];

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("🔔 تم استقبال إشعار:");
        print("📌 العنوان: ${message.notification?.title}");
        print("📌 المحتوى: ${message.notification?.body}");
        print("📌 البيانات: ${message.data}");
      }
    });

    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < splashScreens.length - 1) {
        _currentPage++;
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: splashScreens.length,
        itemBuilder: (context, index) {
          return splashScreens[index];
        },
      ),
    );
  }
}

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/rafq.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Welcome to Rafq',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.07,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
