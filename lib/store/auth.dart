import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/auth.dart';

part 'auth.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  AuthService authService = locator<AuthService>();

  @observable
  String token;

  @observable
  bool inUse = false;

  @observable
  bool isSharing = false;

  @action
  Future<dynamic> login(String email, String password) async {
    try {
      final result = await authService.authenticate(email, password);
      token = result['accessToken'];
      inUse = result['inUse'];
      isSharing = result['isSharing'];
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @action
  Future<dynamic> socialLogin(String provider, String id) async {
    try {
      final result = await authService.socialLogin(provider, id);
      token = result['accessToken'];
      inUse = result['inUse'];
      isSharing = result['isSharing'];
      return result;
    } catch (e) {
      print('3');
      throw e;
    }
  }

  // @action
  // Future<dynamic> socialLogin(String provider) async {
  //   try {
  //     final result = await authService.googleLogin();
  //     token = result['accessToken'];
  //   } catch (e) {
  //     print('4');
  //     throw e;
  //   }
  // }
}
