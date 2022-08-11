import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/tour.dart';
import 'package:safari_web/models/offices/tourist_office.dart';
import 'package:safari_web/models/offices/transportion_office.dart';

import '../server/database_server.dart';
import '../widgets/form_field.dart';
import '../widgets/slider.dart';

class AddTour extends StatefulWidget {
  final TouristOffice transportationOffice;

  const AddTour({Key? key, required this.transportationOffice})
      : super(key: key);

  @override
  State<AddTour> createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  var countrycontroller = TextEditingController();
  var daycontroller = TextEditingController();
  var nametourcontroller = TextEditingController();
  var nightcontroller = TextEditingController();
  var phone1controller = TextEditingController();
  var phone2controller = TextEditingController();
  var costcontroller = TextEditingController();
  var programcontroller = TextEditingController();
  var programincludecontroller = TextEditingController();

  final Picker = ImagePicker();
  int _imageIndex = 0;
  late Responsive _responsive;
  List<String> _images = [];
  final CarouselController _controller = CarouselController();
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now(), end: (DateTime.now()).add(new Duration(days: 7)));

  bool Chosen = false;

  final formKey = GlobalKey<FormState>();

  void _addFlight() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You need to add one image at least")));
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        _loading.value = true;
        Tour tour = Tour(
            id: 'id',
            cost: double.tryParse(costcontroller.text)??0,
            country: countrycontroller.text,
            name: nametourcontroller.text,
            days: int.tryParse(daycontroller.text)??0,
            images: _images,
            leavingDate: dateTimeRange.start,
            nights: int.tryParse(nightcontroller.text)??0,
            phones: {},
            program: programcontroller.text,
            programInclude: programincludecontroller.text,
            returningDate: dateTimeRange.end,
            rate: [],
            favorite: {},
            comments: []);
        await DataBaseServer.addTour(tour);
        await DataBaseServer.updateOffice(widget.transportationOffice, 'tourists_office');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: nametourcontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "name ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: countrycontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "country must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.place,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "country ",
                            //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: nightcontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "night must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "night ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: daycontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "day must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "day ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: costcontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "price must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.money,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "price ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),

                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: programcontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "program must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "program ",
                            //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: programincludecontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "our program include must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "program include ",
                            //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: phone1controller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "number1 must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "phone 1 ",
                            //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          controller: phone2controller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone 2 must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "phone 2 ",
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
                                Icon(Icons.date_range, color: Colors.grey),
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
                        height: 0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                (new Color(0xffef9b0f)),
                                new Color(0xffffba00)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        //width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("success");
                            }
                            ;
                          },
                          child: Text(
                            "ADD TOUR",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
