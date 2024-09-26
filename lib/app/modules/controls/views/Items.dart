import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/category/new_category.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  onPressed: ()
                  {
                    Get.to(()=>const AddNewCategoryView());
                  } // Upload action
              ),
            ),
          ],
        ),
      ),
    );
  }
}