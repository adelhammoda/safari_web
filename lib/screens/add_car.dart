import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';


class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  var namecontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var capacitycontroller = TextEditingController();

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
                          controller: capacitycontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "capacity must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "capacity  ",//S.of(context).pageEnterEmail,
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
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffF5591F),
                          onFieldSubmitted: (value){
                            print(value);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "phone must not be empty";//S.of(context).pageEmailAddress;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Color(0xffef9b0f),
                            // ),
                            hintText: "phone  ",//S.of(context).pageEnterEmail,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),

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

                            "ADD CAR",

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