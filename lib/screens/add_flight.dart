import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddFlight extends StatefulWidget {

  AddFlight({Key? key}) : super(key: key);

  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {


  double ? height,width;

  var fromcontroller = TextEditingController();
  var tocontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var relaxcontroller = TextEditingController();
  var numberOfPassengerscontroller = TextEditingController();
  var passengersCapacitycontroller = TextEditingController();

  DateTimeRange dateTimeRange= DateTimeRange(
      start: DateTime.now(),
      end: (DateTime.now()).add(new Duration(days: 7))
  );

  bool Chosen= false;

  final formKey = GlobalKey<FormState>();

  late File Image;

  late File Image2;

  late File Image3;

  final Picker =ImagePicker();

  Future getImage(ImageSource src) async{
    final PickedFile = await Picker.pickImage(source: src);
    setState(() {
      if (PickedFile!=null)
      {
        Image = File(PickedFile.path);
        print("image loaded");
        //UploadImage();

      }
      else
        print("Could not get photo");

    });
  }
  Future getImage1(ImageSource src) async{
    final PickedFile = await Picker.pickImage(source: src);
    setState(() {
      if (PickedFile!=null)
      {
        Image2 = File(PickedFile.path);
        print("image loaded");
        //UploadImage();

      }
      else
        print("Could not get photo");

    });
  }
  Future getImage2(ImageSource src) async{
    final PickedFile = await Picker.pickImage(source: src);
    setState(() {
      if (PickedFile!=null)
      {
        Image3 = File(PickedFile.path);
        print("image loaded");
        //UploadImage();

      }
      else
        print("Could not get photo");

    });
  }

  //
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

              return Scaffold(

                body: Form(
                  key: formKey,
                  child: SingleChildScrollView(

                    child: Column(

                      children: [
                        SizedBox(height: 25,),
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
                                    controller: fromcontroller,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "from must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.timer,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "from ",//S.of(context).pageEnterEmail,
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
                                    controller:tocontroller,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "to must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.timer,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "to",//S.of(context).pageEnterEmail,
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
                                    controller:costcontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "cost must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.timer,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "cost ",//S.of(context).pageEnterEmail,
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
                                    controller:numberOfPassengerscontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "num must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.door_back_door,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: " number Of Passengers",//S.of(context).pageEnterEmail,
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
                                    controller:passengersCapacitycontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "passengersCapacity must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.door_back_door,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "passengers Capacity ",//S.of(context).pageEnterEmail,
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
                                    controller:relaxcontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "relax must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.door_back_door,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "relax ",//S.of(context).pageEnterEmail,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(color: Colors.grey,height: 5),
                                ), //simple divider
                                InkWell(
                                    child: Container(height: 60,
                                      child: Row(children: [
                                        Icon(Icons.date_range,color: Colors.grey),
                                        SizedBox(width: 40),
                                        Column(children: [
                                          Text("Leaving Date",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54),),
                                          SizedBox(height: 20,),
                                          Text(dateTimeRange.start.toString().split(' ')[0],style: TextStyle(fontWeight:FontWeight.w400,color: Chosen?Colors.lightBlue:Colors.black45),)
                                        ],),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: VerticalDivider(width: 20,thickness: 2,),
                                        ),
                                        Column(children: [
                                          Text("Return Date",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54),),
                                          SizedBox(height: 20,),
                                          Text(dateTimeRange.end.toString().split(' ')[0],style: TextStyle(fontWeight: FontWeight.w400,color:Chosen? Colors.lightBlue:Colors.black45))
                                        ]),

                                      ],),
                                    ),
                                    onTap: PickDateRange
                                ),
                                // the container is necessary for the vertical divider
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(color: Colors.grey,height: 5),
                                ),
                                SizedBox(height: 5,),
                                Center(
                                  child: MaterialButton(color: Color(0xffef9b0f),
                                      child: Text("Add Image", style:TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context){  return new AlertDialog(title: Text("Choose Picture From"),
                                          content: Container(height :150,color: Colors.white,child:
                                          Column(children: [
                                            Container(color:Colors.purple,child: ListTile(leading: Icon(Icons.image),title: Text('Gallery'),onTap: ()
                                            {
                                              getImage(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },),),
                                            SizedBox(height: 30,),
                                            Container(color: Colors.purple,child: ListTile(leading: Icon(Icons.add_a_photo),title: Text('Camera'),onTap: (){
                                              getImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },),),
                                          ],)),);});}

                                  ),),
                                Center(
                                  child: MaterialButton(color: Color(0xffef9b0f),
                                      child: Text("Add Image", style:TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context){  return new AlertDialog(title: Text("Choose Picture From"),
                                          content: Container(height :150,color: Colors.white,child:
                                          Column(children: [
                                            Container(color:Colors.purple,child: ListTile(leading: Icon(Icons.image),title: Text('Gallery'),onTap: ()
                                            {
                                              getImage1(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },),),
                                            SizedBox(height: 30,),
                                            Container(color: Colors.purple,child: ListTile(leading: Icon(Icons.add_a_photo),title: Text('Camera'),onTap: (){
                                              getImage1(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },),),
                                          ],)),);});}

                                  ),),
                                Center(
                                  child: MaterialButton(color: Color(0xffef9b0f),
                                      child: Text("Add Image", style:TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context){  return new AlertDialog(title: Text("Choose Picture From"),
                                          content: Container(height :150,color: Colors.white,child:
                                          Column(children: [
                                            Container(color:Colors.purple,child: ListTile(leading: Icon(Icons.image),title: Text('Gallery'),onTap: ()
                                            {
                                              getImage2(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },),),
                                            SizedBox(height: 30,),
                                            Container(color: Colors.purple,child: ListTile(leading: Icon(Icons.add_a_photo),title: Text('Camera'),onTap: (){
                                              getImage2(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },),),
                                          ],)),);});}

                                  ),),
                                SizedBox(height: 0,),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(gradient: LinearGradient(colors: [(new  Color(0xffef9b0f)), new Color(0xffffba00)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
                                  ),borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 50,
                                          color: Color(0xffEEEEEE)
                                      ),
                                    ],
                                  ),
                                  //width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: (){

                                      if(formKey.currentState!.validate()){

                                        print("success");
                                        //
                                      };


                                    },

                                    child: Text(

                                      "ADD Flight",

                                      style: TextStyle(color: Colors.white),

                                    ),

                                  ),

                                ),
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
  Future PickDateRange()async{
    DateTimeRange? newDateTimeRange= await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        saveText: "Choose"
    );
    if(newDateTimeRange== null)
      return ;

    setState(() {
      dateTimeRange= newDateTimeRange;
      Chosen=true;

    });

  }

}
