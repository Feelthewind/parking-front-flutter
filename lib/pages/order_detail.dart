import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parking_flutter/shared/const.dart';
import 'package:parking_flutter/store/orders.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final ordersStore = Provider.of<OrdersStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ordersStore.getLatestOrder(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Observer(
                builder: (ctx) {
                  final order = Provider.of<OrdersStore>(context, listen: false)
                      .currentOrder;

                  final datetimeFrom = DateTime.parse(order.from);
                  final timeFrom = datetimeFrom.toString().split(' ');

                  final datetimeTo = DateTime.parse(order.to);
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
                                child: OutlineButton(
                                  borderSide: BorderSide(color: Colors.blue),
                                  textColor: Colors.blue,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    '주차연장',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                    order.parking.description,
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
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 16),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(right: 8),
                                      height: double.infinity,
                                      width: deviceWidth / 2.6,
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            'http://$BASE_URL${order.parking.images[0]}',
                                        placeholder: 'assets/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                                onPressed: () {},
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
