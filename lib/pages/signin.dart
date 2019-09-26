import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parking_flutter/colors.dart';
import 'package:parking_flutter/store/auth.dart';
import 'package:provider/provider.dart';

import 'map.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();

    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBlueColor,
      body: SafeArea(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mobile_screen_share,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '모두의 주차장',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          validator: validateEmail,
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '이메일 (ex: your@email.com)',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return '최소 5자리 이상';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '비밀번호',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          width: double.infinity,
                          child: OutlineButton(
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 18.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            ),
                            onPressed: _submit,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                '모두의주차장 둘러보기',
                                style: TextStyle(
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  MapPage.routeName,
                                );
                              },
                            ),
                            Text(
                              '비밀번호 찾기',
                              style: TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff30a310),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff30a310),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.nature_people,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                socialLogin('google');
                              } catch (error) {
                                print(error);
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff235caa),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff235caa),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.face,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffedd708),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffedd708),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.chat_bubble,
                              color: Colors.black54,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        width: double.infinity,
                        child: OutlineButton(
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 18.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  socialLogin(String provider) async {
    if (provider == 'google') {
      googleLogin();
    }
  }

  Future<void> googleLogin() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print(googleAuth.accessToken);
      print(googleAuth.idToken);
      AuthStore authStore = Provider.of<AuthStore>(context, listen: false);
      authStore.saveSocialUser('google', googleAuth.idToken);
    } catch (error) {
      print(error);
    }
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    // sign in using provider;
    final authStore = Provider.of<AuthStore>(context, listen: false);
    try {
      // {statusCode: 401, error: Unauthorized, message: Invalid credentials}
      final result =
          await authStore.login(_authData['email'], _authData['password']);
      if (result['error'] != null) {
        _showErrorDialog(result['message']);
      }
    } catch (e) {
      var errorMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    print('show dialog called');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return '유효한 이메일을 입력하세요.';
    else
      return null;
  }
}
