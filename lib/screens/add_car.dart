import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/car.dart';
import 'package:safari_web/models/offices/transportion_office.dart';

import '../models/offices/hotel.dart';
import '../server/database_server.dart';
import '../widgets/form_field.dart';
import '../widgets/slider.dart';

class AddCar extends StatefulWidget {
  final TransportationOffice transOffice;
  const AddCar({Key? key,
  required this.transOffice}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  var namecontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var callscontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var capacitycontroller = TextEditingController();
  var mpgController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late File Image;

  final Picker = ImagePicker();

  int _imageIndex = 0;
  late Responsive _responsive;
  List<String> _images = [];
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
        Car car = Car(
            id: 'id',
            name: namecontroller.text,
            phone: {
              'calls':callscontroller.text,
              'messages':phonecontroller.text
            },
            capacity: int.tryParse(capacitycontroller.text)??0,
            costPerHour: double.tryParse(costcontroller.text)??0,
            imagePath: _images,
            description: descriptioncontroller.text,
            mpg: double.tryParse(mpgController.text)??0);
        await DataBaseServer.addCar(car);
        await DataBaseServer.updateOffice(widget.transOffice, 'hotels');
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
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
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
                          controller: namecontroller,
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
                            hintText: "cost ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
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
                          controller: callscontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "calls must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.money,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "Calls ", //S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
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
                          controller: mpgController,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.money,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "MPG ", //S.of(context).pageEnterEmail,
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
                          controller: capacitycontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "capacity must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "capacity  ",
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
                          controller: descriptioncontroller,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "description must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "description  ",
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
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone must not be empty"; //S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "phone  ", //S.of(context).pageEnterEmail,
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
                            "ADD CAR",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
