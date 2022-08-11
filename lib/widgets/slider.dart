import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';

class CSlider extends StatelessWidget {
  final CarouselController carouselController;
  final List<String> imagesUrl;
  final void Function(int index) onChanged;
  final void Function()? onTap;
  final Responsive responsive;
  final void Function()? removeF;

  const CSlider(
      {Key? key,
      required this.responsive,
      this.onTap,
      this.removeF,
      required this.onChanged,
      required this.imagesUrl,
      required this.carouselController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        // alignment: Alignment.center,
        children: [
          Container(
            width: responsive.responsiveWidth(forUnInitialDevices: 40),
            height: responsive.responsiveHeight(forUnInitialDevices: 60),
            color: Colors.orange.withOpacity(0.4),
            child: CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: imagesUrl.length,
                itemBuilder: (c, index, index2) {
                  onChanged(index);
                  return imagesUrl.isEmpty
                      ? const Text("NO image yet")
                      : SizedBox(
                          width: responsive.responsiveWidth(
                              forUnInitialDevices: 40),
                          height: responsive.responsiveHeight(
                              forUnInitialDevices: 60),
                          child: Image.network(
                            imagesUrl[index],
                            fit: BoxFit.fill,
                          ),
                        );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: 1,
                  autoPlay: true,
                )),
          ),
          Positioned(
            top: responsive.responsiveHeight(forUnInitialDevices: 0),
            left: responsive.responsiveWidth(forUnInitialDevices: 0),
            child: InkWell(
              onTap: onTap,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(35),
                      )),
                  child: const Icon(Icons.add)),
            ),
          ),
          Positioned(
            bottom: responsive.responsiveHeight(forUnInitialDevices: 0),
            right: responsive.responsiveWidth(forUnInitialDevices: 0),
            child: InkWell(
              onTap: removeF,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                      )),
                  child: const Icon(Icons.minimize)),
            ),
          ),
        ],
      ),
    );
  }
}
