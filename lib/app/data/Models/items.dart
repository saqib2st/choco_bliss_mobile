import 'package:cloud_firestore/cloud_firestore.dart';

class Item {

  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final String category;
  final String shortDescription;
  final String rating;

  Item({required this.id,required this.name,required this.price,required this.description, required this.imageUrl,required this.category, required this.shortDescription,required this.rating});


  factory Item.fromFirestore(DocumentSnapshot doc){
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  return Item(
  id: doc.id,
  name: data['name'],
  price: data['price'],
  description: data['description'],
  imageUrl:data['imageUrl'],
  category:data['category'],
  shortDescription:data['shortDescription'],
  rating: data['rating']
  );
  }
}
