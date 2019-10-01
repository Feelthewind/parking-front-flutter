import 'package:flutter/material.dart';

final showErrorDialog = (context, message) => {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('에러!'),
          content: Container(
            width: double.maxFinite,
            height: 200,
            child: Text(message),
          ),
          actions: <Widget>[
            SizedBox(
              width: 80,
              child: RaisedButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  // await authStore.getMe();
                  // Navigator.pushReplacementNamed(context, MapPage.routeName);
                },
              ),
            ),
          ],
        ),
      )
    };
