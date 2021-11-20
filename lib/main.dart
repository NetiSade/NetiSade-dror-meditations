import 'package:dror_meditations/app_const.dart';
import 'package:dror_meditations/pages/home.dart';
import 'package:dror_meditations/pages/login.dart';
import 'package:dror_meditations/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConst.appName,
        theme: ThemeData(
          primaryColor: Colors.green.shade200,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade200,
          ),
        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const SomethingWentWrong();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: AuthProvider(),
                  ),
                ],
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return authProvider.isLoggedIn
                        ? const HomePage()
                        : const LoginPage();
                  },
                ),
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const Loading();
          },
        ));
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Something went wrong!')));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Loading')));
  }
}
