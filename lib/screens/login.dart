import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/screens/offices.dart';
import 'package:safari_web/server/authintacation.dart';
import 'package:safari_web/utils/validator.dart';
import 'package:safari_web/widgets/button.dart';
import 'package:safari_web/widgets/form_field.dart';
import 'package:safari_web/widgets/loader.dart';

import '../widgets/appBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late  Responsive _responsive;

  Future<void> _login() async {
    try {
      _loading.value = true;
      await Login.login(_email.text, _password.text);
      _loading.value = false;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>const Offices()));
    } on FirebaseException catch (e) {
      _loading.value = false;
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.message??"error")));
    }on Exception catch (e) {
      _loading.value = false;
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("some error happened")));
    }
  }
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _responsive = Responsive(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SizedBox(
          width: _responsive.responsiveWidth(forUnInitialDevices: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images.png'),
              MyFormField(
                hint: "email",
                validator: Validator.validTextBox,
                controller: _email,
              ),
              MyFormField(
                hint: "password",
                validator: Validator.validTextBox,
                controller: _password,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _loading,
                  builder: (c,value,child)=>value?const Loader():child!,
                    child: Button(
                  onPressed: _login,
                  child: const Text("Submit"),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
