import 'package:flutter/material.dart';

class ParkingExpansionTile extends StatefulWidget {
  ParkingExpansionTile(this.onTimeSelected);

  final onTimeSelected;

  @override
  _ParkingExpansionTileState createState() => _ParkingExpansionTileState();
}

class _ParkingExpansionTileState extends State<ParkingExpansionTile> {
  final times = [
    {"desc": "30분", "count": 1},
    {"desc": "1시간", "count": 2},
    {"desc": "2시간", "count": 4},
    {"desc": "3시간", "count": 6},
    {"desc": "4시간", "count": 8},
    {"desc": "6시간", "count": 12},
    {"desc": "8시간", "count": 16},
  ];
  var currentTimeIndex = 0;

  List<Widget> buildTimeWidgets(List<Map<String, dynamic>> times) {
    final list = new List<Widget>();
    for (var i = 0; i < times.length; i++) {
      list.add(buildTimeWidget(times[i]["desc"], i));
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
          this.widget.onTimeSelected(times[index]["count"]);
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
              times[currentTimeIndex]["desc"],
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
