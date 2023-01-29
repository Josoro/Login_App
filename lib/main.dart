import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_app/src/screens/screens.dart';
import 'package:products_app/src/services/services.dart';
import 'package:products_app/src/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  //Oculta la barra de estados y botones
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        initialRoute: 'Login',
        routes: {
          'Login': (_) => const LoginScreen(),
          'Register': (_) => const RegisterLoginScreen(),
          'Home': (_) => const HomeScreen(),
          'Checkauthscreen': (_) => const CheckAuthScreen()
        },
        scaffoldMessengerKey: NotificationService.messengerKey,
        theme: myTheme);
  }
}
