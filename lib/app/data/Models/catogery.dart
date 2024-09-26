import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String imageURL;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      imageURL: data['imageURL'],
    );
  }
}
