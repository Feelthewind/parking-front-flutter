import 'package:flutter/material.dart';

class CreateParkingPage extends StatefulWidget {
  static const routeName = '/create-parking';

  @override
  _CreateParkingPageState createState() => _CreateParkingPageState();
}

class _CreateParkingPageState extends State<CreateParkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('거주자우선주차장 등록'),
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Center(
                child: Text(
              '확인',
              style: TextStyle(fontSize: 16),
            )),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '공유자 기본정보 입력하기',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text('주차면 정보를 불러오기 위해 주차면 소유자의 정보를 입력해 주세요 !'),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              padding: const EdgeInsets.all(8.0),
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.card_giftcard, size: 32),
                                      SizedBox(width: 4),
                                      Text('생년월일:'),
                                      Spacer(),
                                      Container(
                                        width: 200,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(2),
                                            hintText: '830717',
                                          ),
                                        ),
                                      ),
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //     hintText: '830717',
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.card_travel, size: 32),
                                      SizedBox(width: 4),
                                      Text('차량번호:'),
                                      Spacer(),
                                      Container(
                                        width: 200,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(2),
                                            hintText: '11가1111',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on, size: 32),
                                      SizedBox(width: 4),
                                      Text('공유주차장 위치:'),
                                      Spacer(),
                                      Container(
                                        width: 200,
                                        child: Text('도봉구'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '주차장 설명 입력하기',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            TextFormField(
                              maxLines: 4,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                                fillColor: Colors.white70,
                                filled: true,
                                hintText:
                                    '이용자가 찾아가기 쉽도록 간단한 설명을 입력해주세요!\n예) 우체국 사잇길 (일방통행입니다.)',
                                hintMaxLines: 3,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '주차 비용',
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Container(
                                width: 110,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '30분 기준 금액',
                                    contentPadding: const EdgeInsets.all(1.0),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text('원',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '관련 사진을 첨부해 주세요',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '최대 4장까지 등록 가능합니다',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Spacer(),
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.add),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.add),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.add),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.add),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
