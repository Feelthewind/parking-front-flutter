import 'package:flutter/material.dart';
import 'package:parking_flutter/models/parking.dart';

class ParkingBottomModal extends StatelessWidget {
  final Parking parking;

  ParkingBottomModal(this.parking);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '구획11-25-246 (#020501)',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      Text(
                        '주차요금',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    '${parking.price.substring(1)} 원',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.access_time,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      Text(
                        '운영시간',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            parking.timezones.timezones[0].from.substring(0, 5),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextSpan(
                        text: " ~ ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextSpan(
                        text: parking.timezones.timezones[0].to.substring(0, 5),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
