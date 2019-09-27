import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/parking.dart';

class CreateParkingPage extends StatefulWidget {
  static const routeName = '/create-parking';

  @override
  _CreateParkingPageState createState() => _CreateParkingPageState();
}

class _CreateParkingPageState extends State<CreateParkingPage> {
  Map<int, File> _images = {};
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _parkingData = {
    "price": "",
    "description": "",
    "lat": 37.608267,
    "lng": 127.141247,
    "images": [],
    "timezones": [
      {"day": 0, "from": "00:00:00", "to": "24:00:00"},
      {"day": 1, "from": "00:00:00", "to": "12:00:00"},
      {"day": 2, "from": "09:00:00", "to": "18:00:00"},
      {"day": 3, "from": "09:00:00", "to": "18:00:00"},
      {"day": 4, "from": "09:00:00", "to": "18:00:00"},
      {"day": 5, "from": "09:00:00", "to": "22:00:00"},
      {"day": 6, "from": "00:00:00", "to": "22:00:00"}
    ],
  };

  void _submit() async {
    // TODO: Get real coordinates using public api

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    final urls = await _saveImages();
    print('urls');
    print(urls);
    if (urls == null) {
      return;
    }

    ParkingService parkingService = locator<ParkingService>();
    try {
      // {statusCode: 401, error: Unauthorized, message: Invalid credentials}
      _parkingData["images"] = urls;
      await parkingService.createParking(_parkingData);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  handleImagePicked(int order, File image, [String error]) {
    print('handleimagepicked');
    print('called');
    Map<int, File> newImages = {};

    newImages.addAll(_images);
    newImages[order] = image;

    setState(() {
      _images = newImages;
    });

    if (error != null) {
      // TODO: alert file limit
    }
  }

  Future<dynamic> _saveImages() async {
    try {
      ParkingService parkingService = locator<ParkingService>();
      _images.removeWhere((order, file) {
        if (file == null) return true;
        return false;
      });
      List<Future<String>> result = [];
      for (var i = 0; i < _images.length; i++) {
        result.add(parkingService.saveParkingImages(_images[i]));
      }
      return Future.wait(result);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('거주자우선주차장 등록'),
        actions: <Widget>[
          GestureDetector(
            onTap: _submit,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Center(
                  child: Text(
                '확인',
                style: TextStyle(fontSize: 16),
              )),
            ),
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
                  child: Form(
                    key: _formKey,
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                onSaved: (value) {
                                  _parkingData['description'] = value;
                                },
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
                            height: 24,
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
                                  width: 140,
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _parkingData['price'] = value;
                                    },
                                    validator: (val) {
                                      if (double.tryParse(val) == null) {
                                        return '숫자만 입력이 가능합니다.';
                                      }
                                      return null;
                                    },
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
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ImagePickerBox(
                                    order: 0,
                                    image: _images[0],
                                    onImagePicked: handleImagePicked,
                                  ),
                                  ImagePickerBox(
                                    order: 1,
                                    image: _images[1],
                                    onImagePicked: handleImagePicked,
                                  ),
                                  ImagePickerBox(
                                    order: 2,
                                    image: _images[2],
                                    onImagePicked: handleImagePicked,
                                  ),
                                  ImagePickerBox(
                                    order: 3,
                                    image: _images[3],
                                    onImagePicked: handleImagePicked,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildImageBoxes() {
  //   List<Widget> list = List<Widget>();
  //   for (var i = 0; i < _images.length; i++) {
  //     list.add(ImagePickerBox(
  //       image: _images[i],
  //       order: i,
  //       onImagePicked: handleImagePicked,
  //     ));
  //   }
  //   return Row(children: list);
  // }
}

class ImagePickerBox extends StatelessWidget {
  final int order;
  final File image;
  final Function onImagePicked;

  ImagePickerBox({this.order, this.image, this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () => getImage(order),
        child: image != null
            ? Container(
                width: 60,
                height: 60,
                child: Image.file(image),
              )
            : Container(
                width: 60,
                height: 60,
                child: Icon(Icons.add),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
      ),
    );
  }

  Future<void> getImage(int order) async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print(image);
      print(order);

      final fileSize = await image.length();

      print(fileSize);

      if (fileSize > 5 * 1024 * 1024) {
        print('filesize is too large');
        return onImagePicked(order, null, '파일 용량 5메가 바이트 이상은 불가');
      }

      // callback
      onImagePicked(order, image);
    } catch (e) {
      print(e);
      onImagePicked(order, null);
    }
  }
}
