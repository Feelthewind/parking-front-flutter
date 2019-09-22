import 'package:flutter/material.dart';

class ParkingExpansionTile extends StatefulWidget {
  @override
  _ParkingExpansionTileState createState() => _ParkingExpansionTileState();
}

class _ParkingExpansionTileState extends State<ParkingExpansionTile> {
  final times = ["30분", "1시간", "2시간", "3시간", "4시간", "6시간", "8시간"];
  var currentTimeIndex = 0;

  List<Widget> buildTimeWidgets(List<String> times) {
    final list = new List<Widget>();
    for (var i = 0; i < times.length; i++) {
      list.add(buildTimeWidget(times[i], i));
    }
    return list;
  }

  Widget buildTimeWidget(String time, int index) {
    return Container(
      width: 80,
      child: RaisedButton(
        color: currentTimeIndex == index ? Colors.blue : Colors.grey[300],
        child: Text(time),
        textColor: currentTimeIndex == index ? Colors.white : Colors.black54,
        onPressed: () {
          setState(() {
            currentTimeIndex = index;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text(
              times[currentTimeIndex],
              style: TextStyle(color: Colors.black87),
            ),
            Icon(
              Icons.arrow_drop_down,
            )
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            print('trailling button pressed');
          },
        ),
        children: <Widget>[
          Text('주차 예정 시간을 선택해주세요.'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 16.0,
              children: buildTimeWidgets(times),
            ),
          ),
        ],
      ),
    );
  }
}
