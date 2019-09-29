import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parking_flutter/pages/order_detail.dart';
import 'package:parking_flutter/store/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (ctx) {
        AuthStore authStore = Provider.of<AuthStore>(context, listen: false);

        return Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('모두의 주차장'),
              ),
              Container(
                color: Colors.blueGrey,
                child: authStore.inUse
                    ? ListTile(
                        leading: Icon(
                          Icons.data_usage,
                          color: Colors.blue,
                        ),
                        title: Text(
                          '사용 중인 주차장',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OrderDetailPage.routeName);
                        },
                      )
                    : Container(),
              ),
              Container(
                color: Colors.blueGrey,
                child: authStore.isSharing
                    ? ListTile(
                        leading: Icon(
                          Icons.data_usage,
                          color: Colors.blue,
                        ),
                        title: Text(
                          '공유 중인 주차장',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // TODO
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
