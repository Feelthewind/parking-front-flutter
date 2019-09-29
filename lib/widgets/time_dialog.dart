import 'package:flutter/material.dart';

class TimeDialog extends StatefulWidget {
  final int minutes;

  TimeDialog(this.minutes);

  @override
  _TimeDialogState createState() => _TimeDialogState();
}

class _TimeDialogState extends State<TimeDialog> {
  var minutes;

  @override
  void initState() {
    super.initState();
    minutes = widget.minutes;
  }

  // TODO: Use actual available time slots info from server

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('주차 시간을 선택하세요.'),
            Text(
              '결제 완료 직후 주차가 시작되며, 여유시간 10분이 추가됩니다.',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: 30,
                    groupValue: minutes,
                    onChanged: (value) {
                      setState(() {
                        minutes = value;
                      });
                    },
                  ),
                  Text('30분'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 60,
                    groupValue: minutes,
                    onChanged: (value) {
                      setState(() {
                        minutes = value;
                      });
                    },
                  ),
                  Text('1시간'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 90,
                    groupValue: minutes,
                    onChanged: (value) {
                      setState(() {
                        minutes = value;
                      });
                    },
                  ),
                  Text('1시간 30분'),
                ],
              ),
            ],
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
    Navigator.pop(context);
  }

  _confirmButtonClicked() {
    Navigator.pop(context, minutes);
  }
}
