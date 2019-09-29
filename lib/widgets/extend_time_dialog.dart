import 'package:flutter/material.dart';

class ExtendTimeDialog extends StatefulWidget {
  final int maxTime;

  ExtendTimeDialog(this.maxTime);

  @override
  _ExtendTimeDialogState createState() => _ExtendTimeDialogState();
}

class _ExtendTimeDialogState extends State<ExtendTimeDialog> {
  var minutes = 30;
  Map<int, String> times = {
    30: '30분',
    60: '1시간',
    90: '1시간 30분',
    120: '2시간',
    180: '3시간',
    240: '4시간',
    360: '6시간',
    480: '8시간',
  };
  var filtered = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filtered = Map.from(times)..removeWhere((k, v) => k > widget.maxTime);
    print(filtered);
  }

  List<Widget> _buildSlots() {
    List<Widget> result = [];
    filtered.forEach((key, value) {
      result.add(
        Row(
          children: <Widget>[
            Radio(
              value: key,
              groupValue: minutes,
              onChanged: (val) {
                setState(() {
                  minutes = val;
                });
              },
            ),
            Text(value),
          ],
        ),
      );
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('연장 시간을 선택하세요.'),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: _buildSlots(),
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: 80,
            child: FlatButton(
              child: Text('취소'),
              onPressed: _cancelButtonClicked,
            ),
          ),
          SizedBox(
            width: 80,
            child: RaisedButton(
              child: Text(
                '확인',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _confirmButtonClicked,
            ),
          ),
        ],
      ),
    );
  }

  _cancelButtonClicked() {
    Navigator.pop(context, false);
  }

  _confirmButtonClicked() {
    Navigator.pop(context, minutes);
  }
}
