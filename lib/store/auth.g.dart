// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$tokenAtom = Atom(name: '_AuthStore.token');

  @override
  String get token {
    _$tokenAtom.context.enforceReadPolicy(_$tokenAtom);
    _$tokenAtom.reportObserved();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.context.conditionallyRunInAction(() {
      super.token = value;
      _$tokenAtom.reportChanged();
    }, _$tokenAtom, name: '${_$tokenAtom.name}_set');
  }

  final _$inUseAtom = Atom(name: '_AuthStore.inUse');

  @override
  bool get inUse {
    _$inUseAtom.context.enforceReadPolicy(_$inUseAtom);
    _$inUseAtom.reportObserved();
    return super.inUse;
  }

  @override
  set inUse(bool value) {
    _$inUseAtom.context.conditionallyRunInAction(() {
      super.inUse = value;
      _$inUseAtom.reportChanged();
    }, _$inUseAtom, name: '${_$inUseAtom.name}_set');
  }

  final _$isSharingAtom = Atom(name: '_AuthStore.isSharing');

  @override
  bool get isSharing {
    _$isSharingAtom.context.enforceReadPolicy(_$isSharingAtom);
    _$isSharingAtom.reportObserved();
    return super.isSharing;
  }

  @override
  set isSharing(bool value) {
    _$isSharingAtom.context.conditionallyRunInAction(() {
      super.isSharing = value;
      _$isSharingAtom.reportChanged();
    }, _$isSharingAtom, name: '${_$isSharingAtom.name}_set');
  }

  final _$getMeAsyncAction = AsyncAction('getMe');

  @override
  Future<void> getMe() {
    return _$getMeAsyncAction.run(() => super.getMe());
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$socialLoginAsyncAction = AsyncAction('socialLogin');

  @override
  Future<dynamic> socialLogin(String provider, GoogleSignInAccount googleUser) {
    return _$socialLoginAsyncAction
        .run(() => super.socialLogin(provider, googleUser));
  }
}
