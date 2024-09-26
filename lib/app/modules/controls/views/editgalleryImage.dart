import 'package:cached_network_image/cached_network_image.dart';
import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGalleryImage extends GetView<ControlsController> {
  const EditGalleryImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery Images",style: TextStyle(
            fontSize: 15
        ),),
        actions: [
          Container(
            height: 40,
            margin: const EdgeInsets.all(8).copyWith(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)

            ),
            child: IconButton(
              color: Colors.blue,
              onPressed: (){
                controller.confirmAction(
                    controller.imageListGallery,
                    'gallery_images/',
                    'gallery'
                );
              },
              icon:  const Text("Confirm change",style: TextStyle(
                  fontSize: 12
              ),), // Confirm button action

            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // List of images
          Expanded(
            child: Obx(() {
              if (controller.imageListGallery.isEmpty) {
                return const Center(child: Text("No images selected"));
              }
              return GridView.builder(
                itemCount: controller.imageListGallery.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust this based on your design
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.file(
                        controller.imageListGallery[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: GestureDetector(
                          onTap: () => controller.deleteImage(index,controller.fetchedList),
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.upload),
                label: const Text("Upload Images"),
                onPressed: ()
                {
                  controller.pickImageFromGallery(controller.imageListGallery);
                } // Upload action
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (controller.fetchedList.isEmpty) {
                return const Center(child: Text("No images uploaded"));
              }
              return GridView.builder(
                itemCount: controller.fetchedList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust this based on your design
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: controller.fetchedList[index],
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.fill,
                        width: Get.width *0.33,
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: GestureDetector(
                          onTap: () {
                            controller.deleteImage(index,controller.fetchedList);
                            controller.deleteSingleImages(index,'gallery');
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          // Button to pick images
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Delete All"),
                onPressed: ()
                {
                  if (controller.fetchedList.isNotEmpty) {
                    controller.deleteOldImages('gallery');
                  }else{
                    Get.showSnackbar(const GetSnackBar(
                      title: 'Warning',
                      message : 'Upload items Fist',
                      backgroundColor: AppColors.warningRed,
                    ));
                  }
                } // Upload action
            ),
          ),
        ],
      ),
    );
  }
}
