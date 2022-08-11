//
//
//
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_s/responsive_s.dart';
// import 'package:safari_web/models/offices/office.dart';
// import 'package:safari_web/server/authintacation.dart';
// import 'package:safari_web/server/database_client.dart';
//
// import '../models/offices/login.dart';
// import '../models/components/user.dart' as u;
//
// class MyOffice extends StatefulWidget {
//   final Office office;
//   const MyOffice({Key? key,required this.office}) : super(key: key);
//
//   @override
//   State<MyOffice> createState() => _MyOfficeState();
// }
//
// class _MyOfficeState extends State<MyOffice> {
//   late final Responsive _responsive;
//   final CarouselController _carouselSlider = CarouselController();
//   int _imageIndex=0;
//   bool canEdit=false;
//
//   @override
//   didChangeDependencies(){
//     super.didChangeDependencies();
//     _responsive = Responsive(context);
//   }
//   _checkIfCanEdit()async{
//     if(Authentication.user==null){
//       Navigator.of(context).push(MaterialPageRoute(builder: (c)=>const LoginScreen()));
//     }else{
//       u.User? user =await DataBaseClintServer.getUser(Authentication.user!.email?.split('.').first??'');
//       if(user==null){
//         canEdit = false;
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Some error happened')));
//       }
//     }
//   }
//   @override
//   initState(){
//     super.initState();
//    _checkIfCanEdit();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text(
//               'Add new office',
//               style: TextStyle(fontSize: 32),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   top: _responsive.responsiveWidth(forUnInitialDevices: 5),
//                   bottom: _responsive.responsiveWidth(forUnInitialDevices: 5)),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: _responsive.responsiveWidth(forUnInitialDevices: 50),
//                     // height:
//                     //     _responsive.responsiveHeight(forUnInitialDevices: 70),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 15.0),
//                           child: Stack(
//                             clipBehavior: Clip.hardEdge,
//                             // alignment: Alignment.center,
//                             children: [
//                               Container(
//                                 width: _responsive.responsiveWidth(
//                                     forUnInitialDevices: 40),
//                                 height: _responsive.responsiveHeight(
//                                     forUnInitialDevices: 60),
//                                 color: Colors.green,
//                                 child: CarouselSlider.builder(
//                                     carouselController: _carouselSlider,
//                                     itemCount: widget.office.imagesPath.length,
//                                     itemBuilder: (c, index, index2) {
//                                       _imageIndex = index;
//                                       return imagesUrl.isEmpty
//                                           ? const Text("NO image yet")
//                                           : SizedBox(
//                                         width:
//                                         _responsive.responsiveWidth(
//                                             forUnInitialDevices: 40),
//                                         height:
//                                         _responsive.responsiveHeight(
//                                             forUnInitialDevices: 60),
//                                         child: Image.network(
//                                           imagesUrl[index],
//                                           fit: BoxFit.fill,
//                                         ),
//                                       );
//                                     },
//                                     options: CarouselOptions(
//                                       viewportFraction: 1,
//                                       aspectRatio: 1,
//                                       autoPlay: true,
//                                     )),
//                               ),
//                               Positioned(
//                                 top: _responsive.responsiveHeight(
//                                     forUnInitialDevices: 0),
//                                 left: _responsive.responsiveWidth(
//                                     forUnInitialDevices: 0),
//                                 child: InkWell(
//                                   onTap: _addAndUploadPhoto,
//                                   child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: const BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.only(
//                                             bottomRight: Radius.circular(35),
//                                           )),
//                                       child: const Icon(Icons.add)),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: _responsive.responsiveHeight(
//                                     forUnInitialDevices: 0),
//                                 right: _responsive.responsiveWidth(
//                                     forUnInitialDevices: 0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     imagesUrl.removeAt(_imageIndex);
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: const BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(35),
//                                           )),
//                                       child: const Icon(Icons.minimize)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: _responsive.responsiveWidth(forUnInitialDevices: 50),
//                     // height:
//                     //     _responsive.responsiveHeight(forUnInitialDevices: 70),
//                     child: Form(
//                       key: _formKey,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: _responsive.responsiveWidth(
//                                 forUnInitialDevices: 5)),
//                         child: Column(
//                           children: [
//                             MyFormField(
//                               hint: "Name",
//                               icon: const Icon(Icons.person),
//                               controller: _nameController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "Owner phone for calls",
//                               icon: const Icon(Icons.call),
//                               controller: _ownerPhoneController,
//                               validator: (val) =>
//                                   Validator.validTextBox(val, isNumber: true),
//                             ),
//                             MyFormField(
//                               hint: "Owner phone for messages",
//                               icon: const Icon(Icons.message),
//                               controller: _ownerMessageController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "Description",
//                               icon: const Icon(Icons.description),
//                               controller: _descriptionController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "country",
//                               icon: const Icon(Icons.location_on),
//                               controller: _countryController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "city",
//                               icon: const Icon(Icons.location_city),
//                               controller: _cityController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "Area",
//                               icon: const Icon(Icons.area_chart),
//                               controller: _areaController,
//                               validator: Validator.validTextBox,
//                             ),
//                             MyFormField(
//                               hint: "Owner account",
//                               icon: const Icon(Icons.account_circle),
//                               controller: _ownerAccountController,
//                               validator: Validator.validTextBox,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(15)),
//                               width: _responsive.responsiveWidth(
//                                   forUnInitialDevices: 35),
//                               height: _responsive.responsiveWidth(
//                                   forUnInitialDevices: 2),
//                               alignment: Alignment.center,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   PopupMenuButton<String>(
//                                       initialValue: 'hotels',
//                                       color: Colors.orange,
//                                       padding: const EdgeInsets.all(10),
//                                       constraints: const BoxConstraints(
//                                           maxHeight: 100,
//                                           maxWidth: 200,
//                                           minHeight: 50,
//                                           minWidth: 100),
//                                       onSelected: (value) {
//                                         setState(() {
//                                           choice = value;
//                                         });
//                                       },
//                                       child: Text(
//                                           choice == '' ? "Hotels" : choice),
//                                       itemBuilder: (c) => [
//                                         const PopupMenuItem<String>(
//                                           value: "hotels",
//                                           child: Text("Hotel"),
//                                         ),
//                                         const PopupMenuItem<String>(
//                                           value: "restaurants",
//                                           child: Text("Restaurant"),
//                                         ),
//                                         const PopupMenuItem<String>(
//                                           value: "transportation_office",
//                                           child:
//                                           Text("Transportation office"),
//                                         ),
//                                         const PopupMenuItem<String>(
//                                           value: "tourist_office",
//                                           child: Text("Tourists office"),
//                                         ),
//                                         const PopupMenuItem<String>(
//                                           value: "airplanes",
//                                           child: Text("Airplane"),
//                                         )
//                                       ]),
//                                   const SizedBox(
//                                     width: 100,
//                                   ),
//                                   const Icon(Icons.arrow_downward)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ValueListenableBuilder<bool>(
//               valueListenable: _loading,
//               builder: (c, value, child) => value ? const Loader() : child!,
//               child: Button(
//                 onPressed: _addOffice,
//                 minWidth: _responsive.responsiveWidth(forUnInitialDevices: 80),
//                 height: _responsive.responsiveHeight(forUnInitialDevices: 10),
//                 child: const Text("Submit"),
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
