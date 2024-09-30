import 'package:cached_network_image/cached_network_image.dart';
import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewItemView extends GetView<ControlsController> {
  final Item? item;

  const AddNewItemView({super.key, this.item});

  // Holds the selected category

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        controller.resetItemFields();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              controller.resetItemFields();
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text('Add New Item'),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.itemNmeController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: controller.itemPriceController,
                          decoration: const InputDecoration(labelText: 'Price'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: controller.itemDescriptionController,
                          decoration: const InputDecoration(labelText: 'Description'),
                          maxLines: 4,
                        ),
                        TextField(
                          controller: controller.shortDescriptionController,
                          decoration: const InputDecoration(labelText: 'Short Description'),
                        ),
                        TextField(
                          controller: controller.ratingController,
                          decoration: const InputDecoration(labelText: 'Rating'),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        // Dropdown for Category
                        DropdownButtonFormField<String>(
                          value: controller.selectedCategory,
                          decoration: const InputDecoration(labelText: 'Category'),
                          items: controller.categoriesList.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedCategory = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Image Picker
                        GestureDetector(
                          onTap: () {
                            controller.pickImage(controller.imageFile, controller.selectedImageUrlItem);
                          },
                          child: Obx(() {
                            return controller.selectedImageUrlItem.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: controller.selectedImageUrlItem.value,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                      );
                                    },
                                    placeholder: (context, url) => const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator())),
                                  )
                                : controller.imageFile.value != null
                                    ? Image.file(
                                        controller.imageFile.value!,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      )
                                    : Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.grey[800],
                                          size: 50,
                                        ),
                                      );
                          }),
                        ),
                        const SizedBox(height: 20),
                        // Pick Image Button
                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            if (controller.itemNmeController.text.isNotEmpty &&
                                controller.itemPriceController.text.isNotEmpty &&
                                controller.itemDescriptionController.text.isNotEmpty &&
                                controller.shortDescriptionController.text.isNotEmpty &&
                                controller.ratingController.text.isNotEmpty &&
                                controller.selectedCategory != null) {
                              if (item?.id.isNotEmpty ?? false) {
                                if (item != null) {
                                  controller.editItem(item!.id);
                                }
                              } else {
                                controller.addItem(
                                  controller.itemNmeController.text,
                                  controller.itemPriceController.text,
                                  controller.itemDescriptionController.text,
                                  controller.selectedCategory!,
                                  controller.shortDescriptionController.text,
                                  double.parse(controller.ratingController.text),
                                );
                              }
                            } else {
                              Get.snackbar('Error', 'Please fill all fields');
                            }
                          },
                          child: const Text('Add Item'),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
