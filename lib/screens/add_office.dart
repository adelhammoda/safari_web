import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/components/offers.dart';
import 'package:safari_web/models/components/user.dart';
import 'package:safari_web/screens/login.dart';
import 'package:safari_web/models/offices/office.dart';
import 'package:safari_web/server/database_client.dart';
import 'package:safari_web/server/database_server.dart';
import 'package:safari_web/utils/validator.dart';
import 'package:safari_web/widgets/appBar.dart';
import 'package:safari_web/widgets/button.dart';
import 'package:safari_web/widgets/form_field.dart';
import 'package:safari_web/widgets/loader.dart';

import '../widgets/slider.dart';

class AddOffice extends StatefulWidget {
  const AddOffice({Key? key}) : super(key: key);

  @override
  State<AddOffice> createState() => _AddOfficeState();
}

class _AddOfficeState extends State<AddOffice> {
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
          imagesUrl.isNotEmpty &&
          choice != '') {
        _loading.value = true;
        await _checkForUser();
        Office offer = Office(
            id: 'id',
            country: _countryController.text,
            stars: [],
            phone: {
              'calls': _ownerPhoneController.text,
              'message': _ownerMessageController.text
            },
            imagesPath: imagesUrl,
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
        await DataBaseServer.addOffice(offer, choice).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Added successfully")));
          imagesUrl.clear();
          _countryController.clear();
          _cityController.clear();
          _areaController.clear();
          _ownerAccountController.clear();
          _nameController.clear();
          _ownerPhoneController.clear();
          _ownerMessageController.clear();
          setState(() {});
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

  Future<void> _checkForUser() async {
    User? u = await DataBaseClintServer.getUser(
        _ownerAccountController.text.split('.').first);
    if (u == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User dose not exist")));
      throw "error user is not exist";
    } else {
      await DataBaseServer.addOwnerToUser(userId: u.id);
    }
  }

  Future<void> _addAndUploadPhoto() async {
    String? url = await _showDialog();
    if (url == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Operation canceled")));
    } else {
      imagesUrl = imagesUrl.toSet().toList();
      imagesUrl.add(url);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Add new office',
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
                        CSlider(
                          onTap: _addAndUploadPhoto,
                            removeF:  () {
                              imagesUrl.removeAt(_imageIndex);
                              setState(() {});
                            },
                            responsive: _responsive,
                            onChanged: (index) {
                              _imageIndex = index;
                            },
                            imagesUrl: imagesUrl,
                            carouselController: _carouselController),
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
                              hint: "Owner account",
                              icon: const Icon(Icons.account_circle),
                              controller: _ownerAccountController,
                              validator: Validator.validTextBox,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              width: _responsive.responsiveWidth(
                                  forUnInitialDevices: 35),
                              height: _responsive.responsiveWidth(
                                  forUnInitialDevices: 2),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PopupMenuButton<String>(
                                      initialValue: 'hotels',
                                      color: Colors.orange,
                                      padding: const EdgeInsets.all(10),
                                      constraints: const BoxConstraints(
                                          maxHeight: 100,
                                          maxWidth: 200,
                                          minHeight: 50,
                                          minWidth: 100),
                                      onSelected: (value) {
                                        setState(() {
                                          choice = value;
                                        });
                                      },
                                      child: Text(
                                          choice == '' ? "Hotels" : choice),
                                      itemBuilder: (c) => [
                                            const PopupMenuItem<String>(
                                              value: "hotels",
                                              child: Text("Hotel"),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: "restaurants",
                                              child: Text("Restaurant"),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: "transportation_office",
                                              child:
                                                  Text("Transportation office"),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: "tourist_office",
                                              child: Text("Tourists office"),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: "airplanes",
                                              child: Text("Airplane"),
                                            )
                                          ]),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  const Icon(Icons.arrow_downward)
                                ],
                              ),
                            )
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
            )
          ],
        ),
      ),
    );
  }
}
