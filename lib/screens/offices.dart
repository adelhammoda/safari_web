import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/offices/airplanes.dart';
import 'package:safari_web/models/offices/hotel.dart';
import 'package:safari_web/models/offices/restaurant.dart';
import 'package:safari_web/models/offices/tourist_office.dart';
import 'package:safari_web/models/offices/transportion_office.dart';
import 'package:safari_web/server/database_client.dart';
import 'package:safari_web/server/database_server.dart';
import 'package:safari_web/server/server.dart';
import 'package:safari_web/widgets/Office_widget.dart';
import 'package:safari_web/widgets/loader.dart';

import '../models/offices/office.dart';

class Offices extends StatefulWidget {
  const Offices({Key? key}) : super(key: key);

  @override
  State<Offices> createState() => _OfficesState();
}

class _OfficesState extends State<Offices> {
  late final Responsive _responsive = Responsive(context);
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  List<Office> _offices = [];

  @override
  initState() {
    super.initState();
    _getAllOffice();
  }

  Future<void> _getAllOffice() async {
    try {
      _loading.value = true;
      _offices = await Server.getAllOffice() ?? [];
      _loading.value = false;
    } catch (e) {
      debugPrint(e.toString());
      _loading.value = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('some error happened')));
    }
  }

  Future<void> _deleteOffice(int index) async {
    try {
      String ref = '';
      debugPrint(_offices[index].name);
      debugPrint(_offices[index].id);
      debugPrint(_offices[index].runtimeType.toString());
      switch (_offices[index].runtimeType) {
        case Airplanes:
          {
            ref = 'airplanes/${_offices[index].id}';
            break;
          }
        case Hotel:
          {
            ref = 'hotels/${_offices[index].id}';
            break;
          }
        case Restaurant:
          {
            ref = 'restaurants/${_offices[index].id}';
            break;
          }
        case TouristOffice:
          {
            ref = 'tourist_office/${_offices[index].id}';
            break;
          }
        case TransportationOffice:
          {
            ref = 'transportation_office/${_offices[index].id}';
            break;
          }
        default:
          {
            return;
          }
      }
      debugPrint(ref);
      debugPrint(index.toString());
      await DataBaseServer.delete(ref: ref);
      _offices.removeAt(index);
      setState((){});
      return;
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("some error happened")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Safari"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: _loading,
          builder: (c, value, child) => value
              ? const Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Loader(),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          _responsive.responsiveWidth(forUnInitialDevices: 15),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1),
                  itemBuilder: (c, index) => OfficeWidget(
                      office: _offices[index],
                      onDelete: () => _deleteOffice(index)),
                  itemCount: _offices.length,
                ),
        ),
      ),
    );
  }
}
