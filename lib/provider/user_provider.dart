import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:weight_tracker/database/database_helper.dart';
import 'package:weight_tracker/model/my_user.dart';
import 'package:weight_tracker/model/user_weight.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;

  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  initUser() async {
    if (firebaseUser != null) {
      user = await DatabaseHelper.getUser(firebaseUser?.uid ?? '');
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void editWeight(UserWeight weight) {
    DatabaseHelper.updateWeightFromFirebase(weight);
    notifyListeners();
  }
}
