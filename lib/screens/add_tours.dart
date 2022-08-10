import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class AddTour extends StatefulWidget {
  const AddTour({Key? key}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                       Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                SizedBox(height: 25,),
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
                                    controller: nametourcontroller,
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
                                    controller: countrycontroller,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "country must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.place,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "country ",//S.of(context).pageEnterEmail,
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
                                    controller: nightcontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "night must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.edit,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "night ",//S.of(context).pageEnterEmail,
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
                                    controller: daycontroller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "day must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.edit,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "day ",//S.of(context).pageEnterEmail,
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
                                      hintText: "price ",//S.of(context).pageEnterEmail,
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
                                    controller: programcontroller,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "program must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.edit,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "program ",//S.of(context).pageEnterEmail,
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
                                    controller: programincludecontroller,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "our program include must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.edit,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "program include ",//S.of(context).pageEnterEmail,
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
                                    controller: phone1controller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "number1 must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.phone,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "phone 1 ",//S.of(context).pageEnterEmail,
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
                                    controller: phone2controller,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffF5591F),
                                    onFieldSubmitted: (value){
                                      print(value);
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "phone 2 must not be empty";//S.of(context).pageEmailAddress;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // icon: Icon(
                                      //   Icons.phone,
                                      //   color: Color(0xffef9b0f),
                                      // ),
                                      hintText: "phone 2 ",//S.of(context).pageEnterEmail,
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

                                      };


                                    },

                                    child: Text(

                                      "ADD TOUR",

                                      style: TextStyle(color: Colors.white),

                                    ),

                                  ),

                                ),
                                SizedBox(height: 25,),
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