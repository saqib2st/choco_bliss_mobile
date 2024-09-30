import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/Items.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/categories.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/edit_carousel.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/editgalleryImage.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/widgets/option_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/controls_controller.dart';

class ControlsView extends GetView<ControlsController> {
  const ControlsView({super.key});
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
              onTap: () async {
                controller.fetchedList.value = await controller.getImages('slider');
                Get.to(()=>const EditCarousel());
                // Navigate to slider images editor
              },
            ),
            EditOptionCard(
              title: 'Edit Gallery Images',
              icon: Icons.image,
              onTap: () async {
                controller.fetchedList.value = await controller.getImages('gallery');
                Get.to(()=>const EditGalleryImage());
                // Navigate to gallery images editor
              },
            ),
            EditOptionCard(
              title: 'Edit Category',
              icon: Icons.category,
              onTap: () {
                // Navigate to category editor
                Get.to(()=>const CategoryListScreen());
              },
            ),
            EditOptionCard(
              title: 'Edit Item',
              icon: Icons.edit,
              onTap: () async {
                controller.categoriesList.value = await controller.fetchCategory();
                // Navigate to item editor
                if (controller.categoriesList.isNotEmpty) {
                  Get.to(()=>const ItemsListScreen());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
