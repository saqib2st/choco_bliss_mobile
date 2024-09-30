import 'package:cached_network_image/cached_network_image.dart';
import 'package:choco_bliss_mobile/app/data/Models/catogery.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCategoryView extends GetView<ControlsController> {
  final Category? category;
  const AddNewCategoryView({super.key,this.category});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (pop){
        controller.selectedImageUrl.value = '';
        controller.nameController.clear();
        controller.descriptionController.clear();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Get.back();
              controller.nameController.clear();
              controller.descriptionController.clear();
              controller.selectedImageUrl.value = '';
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text('Add New Category'),
        ),
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        // Name Input Field
                        TextFormField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description Input Field
                        TextFormField(
                          controller: controller.descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Category Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 9,
                        ),
                        const SizedBox(height: 16),

                        // Image Picker
                        GestureDetector(
                          onTap: () {
                            controller.pickImage(
                              controller.selectedImage,
                              controller.selectedImageUrlItem
                            );
                          },
                          child: Obx(() {
                            return controller.selectedImageUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: controller.selectedImageUrl.value,
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
                                : controller.selectedImage.value != null
                                    ? Image.file(
                                        controller.selectedImage.value!,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
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
                        const SizedBox(height: 16),

                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            if(category!.id.isNotEmpty) {
                              controller.editCategory(category!.id, category!.imageURL);
                              print('Edited');
                            }
                            else{
                              controller.uploadCategory();
                              print('Added');
                            }
                          },
                          child: const Text('Add Category'),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
