import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:safari_web/widgets/loader.dart';

class AdvancedListTile extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userEmail;
  final bool isVerified;
  final Future Function(bool? value) changeUserVerification;
  final ValueNotifier<bool> _notifier = ValueNotifier(false);

  AdvancedListTile(
      {Key? key,
      required this.userName,
      required this.changeUserVerification,
      required this.imageUrl,
      required this.isVerified,
      required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ValueListenableBuilder<bool>(
      valueListenable: _notifier,
      builder: (c,value,child)=>value?const Loader():child!,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        title: Text(userName),
        subtitle: Text(userEmail),
        trailing: SizedBox(
          width: responsive.responsiveWidth(forUnInitialDevices: 10),
          child: Row(
            children: [
              Checkbox(
                value: isVerified,
                onChanged: (value) async{
                  _notifier.value = true;
                  await changeUserVerification(value);
                  _notifier.value = false;

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
