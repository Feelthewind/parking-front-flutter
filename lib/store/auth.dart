import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/error_response.dart';
import 'package:parking_flutter/models/user.dart';
import 'package:parking_flutter/services/auth.dart';

part 'auth.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  AuthService authService = locator<AuthService>();

  @observable
  User user;

  @observable
  String token;

  @observable
  ErrorResponse error;

  @action
  Future<void> getMe() async {
    try {
      final result = await authService.getMe();
      if (result is User) {
        user = result;
      } else if (result is ErrorResponse) {
        error = result;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @action
  Future<dynamic> login(String email, String password) async {
    try {
      final result = await authService.authenticate(email, password);
      if (result is ErrorResponse) {
        error = result;
      } else {
        user = result;
        token = result.accessToken;
      }
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @action
  Future<dynamic> socialLogin(
    String provider,
    GoogleSignInAccount googleUser,
  ) async {
    try {
      final result = await authService.socialLogin(provider, googleUser);
      if (result is ErrorResponse) {
        error = result;
      } else {
        user = result;
        token = result.accessToken;
      }
      return result;
    } catch (e) {
      print('3');
      throw e;
    }
  }
}
