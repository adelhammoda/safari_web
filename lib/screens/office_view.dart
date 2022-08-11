import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/offers.dart';
import 'package:safari_web/screens/add_car.dart';
import 'package:safari_web/screens/add_flight.dart';
import 'package:safari_web/screens/add_room.dart';
import 'package:safari_web/screens/add_tours.dart';
import 'package:safari_web/screens/login.dart';
import 'package:safari_web/models/offices/office.dart';
import 'package:safari_web/server/authintacation.dart';
import 'package:safari_web/server/database_server.dart';
import 'package:safari_web/utils/validator.dart';
import 'package:safari_web/widgets/appBar.dart';
import 'package:safari_web/widgets/button.dart';
import 'package:safari_web/widgets/form_field.dart';
import 'package:safari_web/widgets/loader.dart';

import '../models/offices/airplanes.dart';
import '../models/offices/hotel.dart';
import '../models/offices/restaurant.dart';
import '../models/offices/tourist_office.dart';
import '../models/offices/transportion_office.dart';

class OfficeView extends StatefulWidget {
  final Office office;
  final bool canEdit;

  const OfficeView({Key? key, required this.office, required this.canEdit})
      : super(key: key);

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  late final Responsive _responsive;

  //text editors
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ownerPhoneController = TextEditingController();
  final TextEditingController _ownerMessageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _ownerAccountController = TextEditingController();

  //
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final CarouselController _carouselController = CarouselController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<String> imagesUrl = [];
  String choice = '';
  int _imageIndex = 0;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _responsive = Responsive(context);
  }

  Future<void> _addOffice() async {
    try {
      if ((_formKey.currentState?.validate() ?? false) &&
          widget.office.imagesPath.isNotEmpty &&
          choice != '') {
        _loading.value = true;
        Office offer = Office(
            id: widget.office.id,
            country: _countryController.text,
            stars: [],
            phone: {
              'calls': _ownerPhoneController.text,
              'message': _ownerMessageController.text
            },
            imagesPath: widget.office.imagesPath + imagesUrl,
            description: _descriptionController.text,
            address: {
              'city': _cityController.text,
              'country': _countryController.text,
              "area": _areaController.text
            },
            account: _ownerAccountController.text,
            name: _nameController.text,
            area: _areaController.text,
            city: _cityController.text,
            loves: [],
            comments: []);
        await DataBaseServer.updateOffice(offer, choice).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("updated successfully")));
        });
        _loading.value = false;
      }
    } catch (e) {
      _loading.value = false;
      debugPrint(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Some error happened")));
    }
  }

  String _choosecommponent() {
    switch (widget.office.runtimeType) {
      case Airplanes:
        {
          return "flights";
        }
      case Hotel:
        {
          return "room";
        }
      case TouristOffice:
        {
          return "tour";
        }
      case TransportationOffice:
        {
          return "car";
        }
      case Restaurant:
        {
          return 'food';
        }
      default:
        {
          return '';
        }
    }
  }

  Future<void> _addComponent() async {
    switch (widget.office.runtimeType) {
      case Airplanes:
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => AddFlight(airplaneId: widget.office as Airplanes)));
          break;
        }
      case Hotel:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) => AddRoom(hotel: widget.office as Hotel)));
          break;
        }
      case TouristOffice:
        {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) =>  AddTour(transportationOffice: widget.office as TouristOffice,)));
          break;
        }
      case Restaurant:
        {
          // Navigator.of(context).push(MaterialPageRoute(builder: (c) =>const AddCar()));
          break;
        }
      case TransportationOffice:
        {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) =>  AddCar(transOffice:widget.office as TransportationOffice)));
          break;
        }
      default:
        {
          return;
        }
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

  Future<void> _addAndUploadPhoto() async {
    String? url = await _showDialog();
    if (url == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Operation canceled")));
    } else {
      widget.office.imagesPath.add(url);
      widget.office.imagesPath = widget.office.imagesPath.toSet().toList();
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    _nameController.text = widget.office.name;
    _ownerMessageController.text = widget.office.phone['calls'] ?? '';
    _ownerPhoneController.text = widget.office.phone['message'] ?? '';
    _cityController.text = widget.office.city;
    _countryController.text = widget.office.country;
    _areaController.text = widget.office.area;
    _ownerAccountController.text = widget.office.account;
    _descriptionController.text = widget.office.description;
    switch (widget.office.runtimeType) {
      case Airplanes:
        {
          choice = 'airplanes';
          break;
        }
      case Hotel:
        {
          choice = 'hotel';
          break;
        }
      case TouristOffice:
        {
          choice = 'tourist_office';
          break;
        }
      case Restaurant:
        {
          choice = 'restaurants';
          break;
        }
      case TransportationOffice:
        {
          choice = 'transportation_office';
          break;
        }
      default:
        {
          return;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.office.runtimeType.toString(),
              style: TextStyle(fontSize: 32),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _responsive.responsiveWidth(forUnInitialDevices: 5),
                  bottom: _responsive.responsiveWidth(forUnInitialDevices: 5)),
              child: Row(
                children: [
                  SizedBox(
                    width: _responsive.responsiveWidth(forUnInitialDevices: 50),
                    // height:
                    //     _responsive.responsiveHeight(forUnInitialDevices: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            // alignment: Alignment.center,
                            children: [
                              Container(
                                width: _responsive.responsiveWidth(
                                    forUnInitialDevices: 40),
                                height: _responsive.responsiveHeight(
                                    forUnInitialDevices: 60),
                                color: Colors.green,
                                child: CarouselSlider.builder(
                                    carouselController: _carouselController,
                                    itemCount: widget.office.imagesPath.length,
                                    itemBuilder: (c, index, index2) {
                                      _imageIndex = index;
                                      return widget.office.imagesPath.isEmpty
                                          ? const Text("NO image yet")
                                          : SizedBox(
                                              width:
                                                  _responsive.responsiveWidth(
                                                      forUnInitialDevices: 40),
                                              height:
                                                  _responsive.responsiveHeight(
                                                      forUnInitialDevices: 60),
                                              child: Image.network(
                                                widget.office.imagesPath[index],
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                    },
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      aspectRatio: 1,
                                      autoPlay: true,
                                    )),
                              ),
                              Positioned(
                                top: _responsive.responsiveHeight(
                                    forUnInitialDevices: 0),
                                left: _responsive.responsiveWidth(
                                    forUnInitialDevices: 0),
                                child: InkWell(
                                  onTap: _addAndUploadPhoto,
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(35),
                                          )),
                                      child: const Icon(Icons.add)),
                                ),
                              ),
                              Positioned(
                                bottom: _responsive.responsiveHeight(
                                    forUnInitialDevices: 0),
                                right: _responsive.responsiveWidth(
                                    forUnInitialDevices: 0),
                                child: InkWell(
                                  onTap: () {
                                    imagesUrl.removeAt(_imageIndex);
                                    setState(() {});
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(35),
                                          )),
                                      child: const Icon(Icons.minimize)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _responsive.responsiveWidth(forUnInitialDevices: 50),
                    // height:
                    //     _responsive.responsiveHeight(forUnInitialDevices: 70),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _responsive.responsiveWidth(
                                forUnInitialDevices: 5)),
                        child: Column(
                          children: [
                            MyFormField(
                              hint: "Name",
                              icon: const Icon(Icons.person),
                              controller: _nameController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              hint: "Owner phone for calls",
                              icon: const Icon(Icons.call),
                              controller: _ownerPhoneController,
                              validator: (val) =>
                                  Validator.validTextBox(val, isNumber: true),
                            ),
                            MyFormField(
                              hint: "Owner phone for messages",
                              icon: const Icon(Icons.message),
                              controller: _ownerMessageController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              hint: "Description",
                              icon: const Icon(Icons.description),
                              controller: _descriptionController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              hint: "country",
                              icon: const Icon(Icons.location_on),
                              controller: _countryController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              hint: "city",
                              icon: const Icon(Icons.location_city),
                              controller: _cityController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              hint: "Area",
                              icon: const Icon(Icons.area_chart),
                              controller: _areaController,
                              validator: Validator.validTextBox,
                            ),
                            MyFormField(
                              canEdit: false,
                              hint: "Owner account",
                              icon: const Icon(Icons.account_circle),
                              controller: _ownerAccountController,
                              validator: Validator.validTextBox,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _loading,
              builder: (c, value, child) => value ? const Loader() : child!,
              child: Button(
                onPressed: _addOffice,
                minWidth: _responsive.responsiveWidth(forUnInitialDevices: 80),
                height: _responsive.responsiveHeight(forUnInitialDevices: 10),
                child: const Text("Submit"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Button(
              onPressed: _addComponent,
              minWidth: _responsive.responsiveWidth(forUnInitialDevices: 80),
              height: _responsive.responsiveHeight(forUnInitialDevices: 10),
              child: Text("Add ${_choosecommponent()}"),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
