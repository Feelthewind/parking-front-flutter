import 'package:flutter/material.dart';
import 'package:parking_flutter/colors.dart';

class OrderParkingPage extends StatefulWidget {
  static const routeName = '/order-parking';
  @override
  _OrderParkingPageState createState() => _OrderParkingPageState();
}

class _OrderParkingPageState extends State<OrderParkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('광진 공유주차장 #990916'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: primaryBlueColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '광진 공유주차장 #990916',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '주차시간',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 20),
                      ),
                      Text(
                        '1시간',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '차량번호',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '00모0000',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Placeholder(),
          ),
          Expanded(
            flex: 3,
            child: Placeholder(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '최종 결제 금액',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),
                      Text(
                        '1,200원',
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '결제수단',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '신한',
                        style: TextStyle(color: Colors.black, fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: primaryBlueColor.withOpacity(0.8),
                child: Text('구매하기'),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
