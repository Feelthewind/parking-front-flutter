import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/pages/map.dart';
import 'package:parking_flutter/services/parking.dart';
import 'package:parking_flutter/shared/constants.dart';
import 'package:parking_flutter/store/auth.dart';
import 'package:parking_flutter/store/orders.dart';
import 'package:parking_flutter/widgets/extend_time_dialog.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  static const routeName = '/order-detail';

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final ordersStore = Provider.of<OrdersStore>(context, listen: false);
    final parkingService = locator<ParkingService>();

    _extendOrderTime(val) {
      if (val != false) {
        print('시간 연장');
        print(val);
        OrdersStore ordersStore =
            Provider.of<OrdersStore>(context, listen: false);
        ordersStore.extendOrderTime(val);
      }
    }

    _cancelOrder() async {
      OrdersStore ordersStore =
          Provider.of<OrdersStore>(context, listen: false);
      AuthStore authStore = Provider.of<AuthStore>(context, listen: false);
      await ordersStore.cancelOrder();
      await authStore.getMe();
      Navigator.pushReplacementNamed(context, MapPage.routeName);
    }

    _showExtendTimeDialog(Order currentOrder) async {
      final time =
          await parkingService.getTimeToExtend(currentOrder.parking.id);
      print(time);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExtendTimeDialog(int.parse(time));
        },
      ).then(_extendOrderTime);
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ordersStore.getLatestOrder(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Observer(
                builder: (ctx) {
                  final currentOrder =
                      Provider.of<OrdersStore>(context, listen: false)
                          .currentOrder;
                  if (currentOrder == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final datetimeFrom =
                      DateTime.parse(currentOrder.from).toLocal();
                  final timeFrom = datetimeFrom.toString().split(' ');

                  final datetimeTo = DateTime.parse(currentOrder.to).toLocal();
                  final timeTo = datetimeTo.toString().split(' ');

                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Placeholder(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '시작',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${timeFrom[1].substring(0, 5)}',
                                        style: TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                      Text(
                                        '${timeFrom[0].substring(2)}(${datetimeTo.weekday})',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Text(
                                        '.............',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Positioned(
                                        left: 12,
                                        child: Icon(Icons.train,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '종료',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${timeTo[1].substring(0, 5)}',
                                        style: TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                      Text(
                                        '${timeTo[0].substring(2)}(${datetimeTo.weekday})',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: double.maxFinite,
                                child: int.parse(ordersStore.timeToExtend) >= 30
                                    ? OutlineButton(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        textColor: Colors.blue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          '주차연장',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () =>
                                            _showExtendTimeDialog(currentOrder),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.black),
                          )),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        maxRadius: 16,
                                        // backgroundImage: NetworkImage(
                                        //   'https://avatars2.githubusercontent.com/u/25598340?s=460&v=4',
                                        // ),
                                        backgroundImage: AssetImage(
                                          'assets/avatar.png',
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '김시****',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      currentOrder.parking.description,
                                      style: TextStyle(fontSize: 16),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: currentOrder.parking.images.isNotEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[300])),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 16),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              height: double.infinity,
                                              width: deviceWidth / 2.7,
                                              child: FadeInImage.assetNetwork(
                                                image:
                                                    'http://$BASE_URL${currentOrder.parking.images[0]}',
                                                placeholder:
                                                    'assets/placeholder.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text('No images'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                textColor: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cancel,
                                    ),
                                    Text(
                                      '결제취소',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onPressed: _cancelOrder,
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                textColor: Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.receipt,
                                    ),
                                    Text(
                                      '영수증확인',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
