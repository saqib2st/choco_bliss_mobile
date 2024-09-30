import 'package:cached_network_image/cached_network_image.dart';
import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Function onPressDelete;
  final Function onPressEdit;

  const ItemCard({super.key, required this.item,required this.onPressDelete,required this.onPressEdit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressEdit();
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.imageUrl.isNotEmpty
                      ?
                  CachedNetworkImage(
                    imageUrl:item.imageUrl,
                    height: 180,
                    width: 120,
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
                  ) : Container(
                    height: 180,
                    width: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display item name
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          // Display item price
                          Text(
                            'Price: \$${item.price.toString()}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          // Display rating
                          Row(
                            children: [
                              Text("Rating: ${item.rating}", style: const TextStyle(fontSize: 16)),
                              const Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Display category
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightBlueAccent,
                                width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(
                              item.category,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600],
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Display item short description
              Text(
                item.shortDescription,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Display full description (optional)
              Text(
                item.description,
                style: const TextStyle(fontSize: 14),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              // Add an edit or delete button (optional)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onPressEdit();
                    },
                    child: const Text('Edit'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onPressDelete();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
