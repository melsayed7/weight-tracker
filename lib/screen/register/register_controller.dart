import 'package:weight_tracker/model/my_user.dart';

abstract class RegisterController {
  void showLoading();

  void hideLoading();

  void showMessage(String message);

  void navigateToHome(MyUser user);
}
