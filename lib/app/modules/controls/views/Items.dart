import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Item/new_item_view.dart';

class ItemsListScreen extends GetView<ControlsController> {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (pop){
        controller.selectedImageUrl.value = '';

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryBackgroundColor,
          title: const Text("Item"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Item>>(
                stream: controller.readItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.data == null){
                    return const Center(child: Text('No Data'),
                    );
                  }

                  // List of categories
                  List<Item> items = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ItemCard(
                        item: item,
                        onPressEdit: (){
                          controller.itemNmeController.text = item.name;
                          controller.itemDescriptionController.text = item.description;
                          controller.shortDescriptionController.text = item.shortDescription;
                          controller.itemPriceController.text = item.price;
                          controller.ratingController.text = item.rating.toString();
                          controller.selectedCategory = item.category;
                          controller.selectedImageUrlItem.value = item.imageUrl;
                          Get.to(()=>AddNewItemView(item: item));
                          },
                        onPressDelete: (){
                          controller.deleteItem(item.id, item.imageUrl);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                  onPressed: () {
                    Get.to(()=>const AddNewItemView());
                  } // Upload action
              ),
            ),
          ],
        ),
      ),
    );
  }
}