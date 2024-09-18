import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/home/views/widgets/option_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class Controls extends GetView<HomeController> {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            EditOptionCard(
              title: 'Edit Slider/Carousel Images',
              icon: Icons.slideshow,
              onTap: () {
                // Navigate to slider images editor
              },
            ),
            EditOptionCard(
              title: 'Edit Gallery Images',
              icon: Icons.image,
              onTap: () {
                // Navigate to gallery images editor
              },
            ),
            EditOptionCard(
              title: 'Edit Category',
              icon: Icons.category,
              onTap: () {
                // Navigate to category editor
              },
            ),
            EditOptionCard(
              title: 'Edit Item',
              icon: Icons.edit,
              onTap: () {
                // Navigate to item editor
              },
            ),
          ],
        ),
      ),
    );
  }
}
