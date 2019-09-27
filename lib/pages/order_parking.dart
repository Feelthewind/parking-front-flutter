import 'package:flutter/material.dart';
import 'package:parking_flutter/colors.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/order.dart';
import 'package:parking_flutter/store/parking.dart';
import 'package:parking_flutter/widgets/time_dialog.dart';

class OrderParkingPage extends StatefulWidget {
  static const routeName = '/order-parking';
  @override
  _OrderParkingPageState createState() => _OrderParkingPageState();
}

class _OrderParkingPageState extends State<OrderParkingPage> {
  ParkingStore parking;
  int minutes = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(OrderParkingPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  _showTimeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TimeDialog(minutes);
      },
    ).then((val) {
      if (val != null) {
        setState(() {
          minutes = val;
        });
      }
    });
  }

  _createOrder() async {
    OrderService orderService = locator<OrderService>();
    await orderService.orderParking({
      "parkingId": parking.id,
      "from": parking.timezones[0].from,
      "to": parking.timezones[0].to,
      "minutes": minutes,
      "cardNumber": "00모0000",
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    parking = ModalRoute.of(context).settings.arguments as ParkingStore;
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
                      GestureDetector(
                        onTap: _showTimeDialog,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '${minutes.toString()}분',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            WidgetSpan(
                              style: TextStyle(fontSize: 24),
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                        ),
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
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "00모0000",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          WidgetSpan(
                            style: TextStyle(fontSize: 24),
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.create,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ]),
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
                        '${(int.parse(parking.price.substring(1)) * (minutes / 30)).ceil()}원',
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
                color: Colors.lightBlue,
                child: Text(
                  '구매하기',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                onPressed: _createOrder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
