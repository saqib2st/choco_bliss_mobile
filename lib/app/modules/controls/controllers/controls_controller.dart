import 'dart:io';

import 'package:choco_bliss_mobile/app/data/Models/catogery.dart';
import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:choco_bliss_mobile/app/data/utils/apploader.dart';
import 'package:choco_bliss_mobile/app/modules/controls/views/category/new_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

class ControlsController extends GetxController {
  var imageListCarousel = <File>[].obs; // Observable list of images
  var imageListGallery = <File>[].obs; // Observable list of images
  var fetchedList = <String>[].obs; // Observable list of images
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to upload images from gallery
  Future<void> pickImageFromGallery(RxList<File> list) async {
    final pickedImages = await _picker.pickMultiImage(limit: 100);
    list.addAll(pickedImages.map((image) => File(image.path)).toList());
    }

  // Method to delete an image from the list
  void deleteImage(int index,List list) {
    list.removeAt(index);
  }


  // Method to upload new slider images and replace the old ones
  Future<void> updateSliderImages(RxList<File> list,
  {
  String? storagePath,
  String? dataBasePath,
  }
      ) async {
    AppLoader.showLoader();
    try {
      List<String> newImageUrls = [];

      // Upload each image to Firebase Storage
      for (var image in list) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = _storage.ref().child('$storagePath$fileName');
        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        newImageUrls.add(downloadUrl);
      }

      // Save the new list of URLs to Firestore (or another database)
      await _firestore.collection('$dataBasePath').doc('images').set({
        'imageUrls': newImageUrls,
      });

      // If needed, remove old images from Firebase Storage by tracking old image URLs
      AppLoader.hideLoader();
      Get.snackbar('Success', 'Slider images updated successfully!');

    } catch (e) {
      print('Error updating slider images: $e');
      Get.snackbar('Error', 'Failed to update slider images.',
          backgroundColor: AppColors.statusGreen
      );
    }
  }
  Future<List<String>> getImages(String? dataBasePath) async {
    fetchedList.clear();
    AppLoader.showLoader();
    try {
    DocumentSnapshot snapshot =
        await _firestore.collection(dataBasePath??'slider').doc('images').get();
    List<dynamic> fetchedListFromFIreStore = snapshot.get('imageUrls');
    List<String> imageUrlsList = [];
    for (var item in fetchedListFromFIreStore) {
      imageUrlsList.add(item);
    }
    AppLoader.hideLoader();
    return imageUrlsList;
    } catch (e) {
      AppLoader.hideLoader();
      print('Error Getting images: $e');
    }
    return [];
  }

  Future<void> deleteSingleImages(int index, String? dataBasePath) async {
    AppLoader.showLoader();
    try {
      // Get the current slider image URLs from Firestore
      DocumentSnapshot snapshot =
      await _firestore.collection(dataBasePath ?? 'slider').doc('images').get();
      List<dynamic> imageUrlsList = snapshot.get('imageUrls');

      // Get the image URL to delete
      String imageUrlToDelete = imageUrlsList[index];

      // Delete the image from Firebase Storage
      await _storage.refFromURL(imageUrlToDelete).delete();

      // Remove the image URL from the list
      imageUrlsList.removeAt(index);

      // Update Firestore with the new list
      await _firestore.collection(dataBasePath ?? 'slider').doc('images').update({
        'imageUrls': imageUrlsList,
      });

      AppLoader.hideLoader();
    } catch (e) {
      print('Error deleting old slider images: $e');
      AppLoader.hideLoader();
    }
  }



  // Method to delete old slider images from Firebase Storage
  Future<void> deleteOldImages(String? dataBasePath) async {
    AppLoader.showLoader();
    try {

      // Get the current slider image URLs from Firestore
      DocumentSnapshot snapshot =
      await _firestore.collection(dataBasePath ?? 'slider').doc('images').get();
      List<dynamic> oldImageUrls = snapshot.get('imageUrls');

      // Delete each image in Firebase Storage
      for (String imageUrl in oldImageUrls) {
        Reference ref = _storage.refFromURL(imageUrl);
        await ref.delete();
      }

      await _firestore.collection(dataBasePath ?? 'slider').doc('images').update({
        'imageUrls': null,
      });
      fetchedList.clear();
      AppLoader.hideLoader();

    } catch (e) {
      print('Error deleting old slider images: $e');
    }
  }

  // Method to confirm and update slider images
  void confirmAction(RxList<File> list,
        String? storagePath,
        String? dataBasePath,
      ) async {
    if (list.isNotEmpty) {
      await updateSliderImages(list,storagePath: storagePath,dataBasePath: dataBasePath);
    }else{
      Get.snackbar('Warning', 'Select Images first',
      backgroundColor: AppColors.warningRed
      );
    }
  }

// <---------------------------------------------------CATEGORY------------------------------------------------------------->
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  RxList<Category> categoriesList = <Category>[].obs;

  var selectedImage = Rx<File?>(null); // Observable for image
  RxString selectedImageUrl = ''.obs; // Observable for image
  var isLoading = false.obs; // Observable for loading state

  // Image Picker Function
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImageUrl.value = '';
      selectedImage.value = File(pickedImage.path);
    }
  }

  Stream<List<Category>> readCategories() {
    return FirebaseFirestore.instance.collection('categories').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList());
  }

  // Function to upload image and category data to Firebase
  Future<void> uploadCategory() async {
    if (nameController.text.isNotEmpty && descriptionController.text.isNotEmpty && selectedImage.value != null) {
      isLoading.value = true;

      try {
        // Upload Image to Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance.ref().child('category_images/$fileName');
        UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Save Category Data to Firestore
        CollectionReference categories = FirebaseFirestore.instance.collection('categories');
        await categories.add({
          'name': nameController.text,
          'description': descriptionController.text,
          'imageURL': imageUrl,
        });

        // Clear form
        nameController.clear();
        descriptionController.clear();
        selectedImage.value = null;
        isLoading.value = false;

        Get.snackbar('Success', 'Category added successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Error uploading category: $e',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Incomplete', 'Please fill all fields and select an image',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toEditItem(Category category){
    nameController.text = category.name;
    descriptionController.text = category.description;
    selectedImageUrl.value = category.imageURL;
    Get.to(()=> AddNewCategoryView(category:category));
  }


  // Function to edit a category (Firestore and Storage)
  Future<void> editCategory(String docId, String currentImageUrl) async {
    if (nameController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        String imageUrl = currentImageUrl;

        // If a new image is selected, upload the new one and delete the old one
        if (selectedImage.value != null) {
          // Delete the old image
          Reference oldStorageRef = FirebaseStorage.instance.refFromURL(currentImageUrl);
          await oldStorageRef.delete();

          // Upload the new image
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference newStorageRef = FirebaseStorage.instance.ref().child('category_images/$fileName');
          UploadTask uploadTask = newStorageRef.putFile(selectedImage.value!);
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        // Update Category Data in Firestore
        await FirebaseFirestore.instance.collection('categories').doc(docId).update({
          'name': nameController.text,
          'description': descriptionController.text,
          'imageURL': imageUrl,
        });

        // Clear form
        nameController.clear();
        descriptionController.clear();
        selectedImage.value = null;
        selectedImageUrl.value = '';
        isLoading.value = false;

        Get.snackbar('Success', 'Category updated successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Error editing category: $e',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Incomplete', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Function to delete a category (Firestore and Storage)
  Future<void> deleteCategory(String docId, String imageUrl) async {
    AppLoader.showLoader();
    try {
      // Delete the image from Firebase Storage
      Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();

      // Delete the category document from Firestore
      await FirebaseFirestore.instance.collection('categories').doc(docId).delete();

      AppLoader.hideLoader();
      Get.snackbar('Success', 'Category deleted successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      AppLoader.hideLoader();
      Get.snackbar('Error', 'Error deleting category: $e',
          snackPosition: SnackPosition.BOTTOM);
    }finally{
      AppLoader.hideLoader();
    }
  }


// <---------------------------------------------------ITEMS------------------------------------------------------------->


  Stream<List<Item>> readItems() {
    return FirebaseFirestore.instance.collection('items').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList());
  }


}
