import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/landmark.dart';

import '../server/database_server.dart';
import '../widgets/form_field.dart';
import '../widgets/loader.dart';
import '../widgets/slider.dart';


class AddLandMark extends StatefulWidget {
  const AddLandMark({Key? key}) : super(key: key);

  @override
  State<AddLandMark> createState() => _AddLandMarkState();
}

class _AddLandMarkState extends State<AddLandMark> {
  var costcontroller = TextEditingController();
  var starscontroller = TextEditingController();
  var dayfromcontroller = TextEditingController();
  var daytocontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var areaController = TextEditingController();
  TimeOfDay timefrom = TimeOfDay(hour: 10,minute: 30);
  TimeOfDay timeto = TimeOfDay(hour: 10,minute: 30);
  int _imageIndex = 0;
  List<String > _images = [];
  late Responsive _responsive;
  final CarouselController _controller = CarouselController();
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  final formKey = GlobalKey<FormState>();

  void _addLandMark() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You need to add one image at least")));
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        _loading.value = true;
        Landmark room = Landmark(
            id: '',
            stars: [],
        description: descriptioncontroller.text,
        name: namecontroller.text,
        cost: int.tryParse(costcontroller.text)??0,
        images: _images,
        dayFrom: dayfromcontroller.text,
        dayTo: daytocontroller.text,
        love: [],
        timeFrom: timefrom,
        timeTo: timeto,
        location: {
              "city":cityController.text,
          "country":countryController.text,
          "area":areaController.text
        });
        await DataBaseServer.addLandMark(room);
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
              SizedBox(height: 50,),
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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "name must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "name ",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),

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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: costcontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "price must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.money,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "cost ",//S.of(context).pageEnterEmail,
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
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xffF5591F),
                      onFieldSubmitted: (value){
                        print(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "price must not be empty";//S.of(context).pageEmailAddress;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // icon: Icon(
                        //   Icons.money,
                        //   color: Color(0xffef9b0f),
                        // ),
                        hintText: "city ",//S.of(context).pageEnterEmail,
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
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: countryController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xffF5591F),
                      onFieldSubmitted: (value){
                        print(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "price must not be empty";//S.of(context).pageEmailAddress;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // icon: Icon(
                        //   Icons.money,
                        //   color: Color(0xffef9b0f),
                        // ),
                        hintText: "country ",//S.of(context).pageEnterEmail,
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
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: areaController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xffF5591F),
                      onFieldSubmitted: (value){
                        print(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "price must not be empty";//S.of(context).pageEmailAddress;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // icon: Icon(
                        //   Icons.money,
                        //   color: Color(0xffef9b0f),
                        // ),
                        hintText: "Area ",//S.of(context).pageEnterEmail,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                      SizedBox(height: 0,),

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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: descriptioncontroller,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "description must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "description  ",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: starscontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "stars must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "stars  ",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: dayfromcontroller,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "day from must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "day from  ",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
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
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: daytocontroller,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "day to must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "day to",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
                      SizedBox(height: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            '${timefrom.hour}:${timefrom.minute}',
                          ),
                          ElevatedButton(
                            onPressed: ()async {
                              TimeOfDay? time1 = await showTimePicker(
                                context: context,
                                initialTime: timefrom,
                              );
                              if(timefrom == null)return;
                              setState(() {
                                timefrom=time1!;
                              });
                            },
                            child: Text(
                              'Select Timefrom',
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            '${timeto.hour}:${timeto.minute}',
                          ),
                          ElevatedButton(
                            onPressed: ()async {
                              TimeOfDay? time2 = await showTimePicker(
                                context: context,
                                initialTime: timeto,
                              );
                              if(timeto == null)return;
                              setState(() {
                                timeto=time2!;
                              });
                            },
                            child: Text(
                              'Select Timeto',
                            ),
                          ),
                        ],
                      ),



                      SizedBox(height: 0,),
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
                          onPressed: _addLandMark,
                          child: Text(
                            "ADD Flight",
                            style:
                            TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                      SizedBox(height: 25,),
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