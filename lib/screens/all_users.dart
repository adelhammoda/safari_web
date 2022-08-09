import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/server/server.dart';
import 'package:safari_web/widgets/list_tile.dart';
import 'package:safari_web/widgets/loader.dart';

import '../models/components/user.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  late final Responsive _responsive=Responsive(context);

@override
initState(){
  super.initState();
  _fetchUsers();
}
  Future _fetchUsers()async{
    try{
      _loading.value = true;
      _users = await Server.getAllUser()??[];
      _loading.value = false;
    }catch(e){
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("some error happened")));
    }
  }
  List<User> _users = [];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: _responsive.responsiveWidth(forUnInitialDevices: 100),
            height: _responsive.responsiveHeight(forUnInitialDevices: 100),
            child: ValueListenableBuilder<bool>(
                valueListenable: _loading,
                builder: (c, value, widget) =>
                value
                    ? const Loader()
                    : _users.isNotEmpty?ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (c, index) =>
                      AdvancedListTile(userName: _users[index].name,
                          changeUserVerification: (bool? value)async{
                          try{
                            _users[index].isVerification = value??false;
                            setState((){});
                            await Server.updateUserVerification(_users[index].id, value??false);
                            setState((){});

                          }catch(e){
                            debugPrint(e.toString());
                            _users[index].isVerification = false;
                            setState((){});
                          }
                          },
                          imageUrl: _users[index].photoUrl,
                          isVerified: _users[index].isVerification,
                          userEmail: _users[index].email),
                ):
                    const Center(child:Text("No Data"))
              // future: ,
            ),
          )
        ],
      ),
    );
  }
}
