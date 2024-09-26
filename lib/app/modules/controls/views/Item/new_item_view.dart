// import 'package:choco_bliss_mobile/app/modules/controls/controllers/controls_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AddNewItemView extends GetView<ControlsController> {
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController shortDescriptionController = TextEditingController();
//   final TextEditingController ratingController = TextEditingController();
//   String? selectedCategory; // Holds the selected category
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Item'),
//       ),
//       body: Obx(
//             () => controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   controller: priceController,
//                   decoration: InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(labelText: 'Description'),
//                   maxLines: 4,
//                 ),
//                 TextField(
//                   controller: shortDescriptionController,
//                   decoration: InputDecoration(labelText: 'Short Description'),
//                 ),
//                 TextField(
//                   controller: ratingController,
//                   decoration: InputDecoration(labelText: 'Rating'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 10),
//                 // Dropdown for Category
//                 DropdownButtonFormField<String>(
//                   value: selectedCategory,
//                   decoration: InputDecoration(labelText: 'Category'),
//                   items: <String>['Electronics', 'Fashion', 'Books', 'Home'].map((String category) {
//                     return DropdownMenuItem<String>(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     selectedCategory = value;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 // Image Picker
//                 Obx(() => controller.imageFile.value != null
//                     ? Image.file(
//                   controller.imageFile.value!,
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )
//                     : Container(
//                   height: 150,
//                   color: Colors.grey[300],
//                   child: Icon(Icons.image, size: 50),
//                 )),
//                 SizedBox(height: 20),
//                 // Pick Image Button
//                 ElevatedButton(
//                   onPressed: controller.pickImage,
//                   child: Text('Pick Image'),
//                 ),
//                 SizedBox(height: 20),
//                 // Submit Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (nameController.text.isNotEmpty &&
//                         priceController.text.isNotEmpty &&
//                         descriptionController.text.isNotEmpty &&
//                         shortDescriptionController.text.isNotEmpty &&
//                         ratingController.text.isNotEmpty &&
//                         selectedCategory != null) {
//                       controller.addItem(
//                         nameController.text,
//                         priceController.text,
//                         descriptionController.text,
//                         selectedCategory!,
//                         shortDescriptionController.text,
//                         double.parse(ratingController.text),
//                       );
//                     } else {
//                       Get.snackbar('Error', 'Please fill all fields');
//                     }
//                   },
//                   child: const Text('Add Item'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
