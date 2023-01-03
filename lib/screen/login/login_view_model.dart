import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/database/database_helper.dart';
import 'package:weight_tracker/screen/login/login_controller.dart';
import 'package:weight_tracker/shared/component/firebase_error.dart';

class LogInViewModel extends ChangeNotifier {
  late LoginController loginController;

  void loginFirebaseAuth(String email, String password) async {
    try {
      loginController.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      loginController.hideLoading();
      loginController.showMessage('Login Successfully');

      var userObj = await DatabaseHelper.getUser(credential.user?.uid ?? '');
      if (userObj == null) {
        loginController.hideLoading();
        loginController.showMessage('Register failed PLZ try again');
      } else {
        loginController.navigateToHome(userObj);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.userNotFound) {
        loginController.hideLoading();
        loginController.showMessage('No user found for that email');
        print('No user found for that email.');
      } else if (e.code == FirebaseError.wrongPassword) {
        loginController.hideLoading();
        loginController.showMessage('Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }
  }
}
