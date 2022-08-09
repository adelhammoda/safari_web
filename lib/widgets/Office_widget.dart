import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/models/offices/office.dart';

import 'loader.dart';

class OfficeWidget extends StatelessWidget {
  final Office office;
  final Future Function() onDelete;
  final ValueNotifier<bool> _deleting = ValueNotifier(false);

   OfficeWidget({Key? key, required this.office, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      alignment: Alignment.bottomCenter,
      width: responsive.responsiveWidth(forUnInitialDevices: 10),
      height: responsive.responsiveWidth(forUnInitialDevices: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(office.imagesPath.isEmpty
                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQTGUFUPs1xpgBwZsWNX18TOFpJFC67j7uGw&usqp=CAU"
                : office.imagesPath.first)),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(office.name),
              )
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _deleting,
            builder: (c,value,widget)=>value?const SizedBox(
              width: 10,
              height: 10,
              child: Loader(),
            ):widget!,
            child: InkWell(
              onTap:()async{
                _deleting.value = true;
                await onDelete.call();
                _deleting.value = false;

              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.delete),
              ),
            ),
          ),
          Positioned(
              height: 0,
              right: 0,
              child: Row(
                children: List.generate(
                  office.rateAverage(),
                      (index) =>
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
