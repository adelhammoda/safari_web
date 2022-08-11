import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/flight.dart';
import 'package:safari_web/models/offices/airplanes.dart';
import 'package:safari_web/server/database_client.dart';
import 'package:safari_web/server/database_server.dart';

import '../models/components/room.dart';
import '../models/offices/hotel.dart';
import '../widgets/form_field.dart';
import '../widgets/loader.dart';
import '../widgets/slider.dart';

class AddRoom extends StatefulWidget {
  final Hotel hotel;

  const AddRoom({Key? key, required this.hotel}) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  double? height, width;

  var costPerDay = TextEditingController();
  var roomNumber = TextEditingController();
  var roomType = TextEditingController();
  var roomSize = TextEditingController();

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now(), end: (DateTime.now()).add(new Duration(days: 7)));

  bool Chosen = false;

  final formKey = GlobalKey<FormState>();

  List<String> _images = [];

  final Picker = ImagePicker();
  int _imageIndex = 0;
  late Responsive _responsive;
  final CarouselController _controller = CarouselController();
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _responsive = Responsive(context);
  }

  void _addFlight() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You need to add one image at least")));
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        _loading.value = true;
        Room room = Room(
            id: '',
            size: double.tryParse(roomSize.text) ?? 0,
            roomType: roomType.text,
            roomNumber: int.tryParse(roomNumber.text)??0,
            reservedUnitl: dateTimeRange.end,
            reservedFrom: dateTimeRange.start,
            costPerDay: double.tryParse(costPerDay.text) ?? 0);
        await DataBaseServer.addRoom(room);
        await DataBaseServer.updateOffice(widget.hotel, 'hotels');
        _loading.value = false;
      } on Exception catch (e) {
        _loading.value = false;
        debugPrint(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Some error happened")));
      }
      print("success");
      //
    }
  }

  Future<String?> _showDialog() async {
    String? source;

    await showGeneralDialog(
        context: context,
        pageBuilder: (c, a1, a2) => AlertDialog(
              content: SizedBox(
                width: _responsive.responsiveWidth(forUnInitialDevices: 10),
                height: _responsive.responsiveWidth(forUnInitialDevices: 10),
                child: Column(
                  children: [
                    MyFormField(
                      icon: Icon(Icons.image),
                      hint: "Image URl",
                      onSubmit: (value) {
                        source = value;
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ));
    return source;
  }

  Future<void> _addPhoto() async {
    String? url = await _showDialog();
    if (url == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Operation canceled")));
    } else {
      _images = _images.toSet().toList();
      _images.add(url);
      setState(() {});
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CSlider(
              onTap: _addPhoto,
              removeF: () {
                _images.removeAt(_imageIndex);
                setState(() {});
              },
              responsive: _responsive,
              onChanged: (index) {
                _imageIndex = index;
              },
              carouselController: _controller,
              imagesUrl: _images,
            ),
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child: TextFormField(
                                controller: costPerDay,
                                keyboardType: TextInputType.text,
                                cursorColor: Color(0xffF5591F),
                                onFieldSubmitted: (value) {
                                  print(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "from must not be empty"; //S.of(context).pageEmailAddress;
                                  }
                                  if ((num.tryParse(value)) == null) {
                                    return "Only number is allowed";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // icon: Icon(
                                  //   Icons.timer,
                                  //   color: Color(0xffef9b0f),
                                  // ),
                                  hintText: "Cost Per Dey ",
                                  //S.of(context).pageEnterEmail,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),


                            Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child: TextFormField(
                                controller: roomType,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xffF5591F),
                                onFieldSubmitted: (value) {
                                  print(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "num must not be empty"; //S.of(context).pageEmailAddress;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // icon: Icon(
                                  //   Icons.door_back_door,
                                  //   color: Color(0xffef9b0f),
                                  // ),
                                  hintText: " room type",
                                  //S.of(context).pageEnterEmail,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            SizedBox(
                              height: 0,
                            ),

                            Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child: TextFormField(
                                controller: roomNumber,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xffF5591F),
                                onFieldSubmitted: (value) {
                                  print(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "relax must not be empty"; //S.of(context).pageEmailAddress;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // icon: Icon(
                                  //   Icons.door_back_door,
                                  //   color: Color(0xffef9b0f),
                                  // ),
                                  hintText: "room number ",
                                  //S.of(context).pageEnterEmail,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Divider(color: Colors.grey, height: 5),
                            ),
                            //simple divider
                            InkWell(
                                child: Container(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range,
                                          color: Colors.grey),
                                      SizedBox(width: 40),
                                      Column(
                                        children: [
                                          Text(
                                            "Leaving Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            dateTimeRange.start
                                                .toString()
                                                .split(' ')[0],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Chosen
                                                    ? Colors.lightBlue
                                                    : Colors.black45),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: VerticalDivider(
                                          width: 20,
                                          thickness: 2,
                                        ),
                                      ),
                                      Column(children: [
                                        Text(
                                          "Return Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            dateTimeRange.end
                                                .toString()
                                                .split(' ')[0],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Chosen
                                                    ? Colors.lightBlue
                                                    : Colors.black45))
                                      ]),
                                    ],
                                  ),
                                ),
                                onTap: PickDateRange),
                            // the container is necessary for the vertical divider
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Divider(color: Colors.grey, height: 5),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ValueListenableBuilder<bool>(
                                valueListenable: _loading,
                                builder: (c, value, child) => value
                                    ? const Loader()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 10),
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                (new Color(0xffef9b0f)),
                                                new Color(0xffffba00)
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE)),
                                          ],
                                        ),
                                        //width: double.infinity,
                                        child: MaterialButton(
                                          onPressed: _addFlight,
                                          child: Text(
                                            "ADD Flight",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future PickDateRange() async {
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        saveText: "Choose");
    if (newDateTimeRange == null) return;

    setState(() {
      dateTimeRange = newDateTimeRange;
      Chosen = true;
    });
  }



}
