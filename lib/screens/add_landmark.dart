import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';


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

  TimeOfDay timefrom = TimeOfDay(hour: 10,minute: 30);

  TimeOfDay timeto = TimeOfDay(hour: 10,minute: 30);


  final formKey = GlobalKey<FormState>();

  late File Image;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                          keyboardType: TextInputType.number,
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

                            "ADD LANDMARK",

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

}