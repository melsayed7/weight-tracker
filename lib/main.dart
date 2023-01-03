import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/provider/user_provider.dart';
import 'package:weight_tracker/screen/home/edit_weight_item.dart';
import 'package:weight_tracker/screen/home/home_screen.dart';
import 'package:weight_tracker/screen/login/login_screen.dart';
import 'package:weight_tracker/screen/register/register_screen.dart';
import 'package:weight_tracker/shared/style/my_Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        EditWeightItem.routeName: (context) => EditWeightItem(),
      },
      initialRoute: userProvider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
    );
  }
}
