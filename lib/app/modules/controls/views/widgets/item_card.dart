import 'package:choco_bliss_mobile/app/data/Models/items.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image if available
            item.imageUrl.isNotEmpty
                ? Image.network(
              item.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50),
            ),
            const SizedBox(height: 16),
            // Display item name
            Text(
              item.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Display item price
            Text(
              'Price: \$${item.price}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            // Display item short description
            Text(
              item.shortDescription,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            // Display rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${item.rating}', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            // Display category
            Text(
              'Category: ${item.category}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            // Display full description (optional)
            Text(
              item.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Add an edit or delete button (optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement Edit Item functionality
                  },
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement Delete Item functionality
                  },
                  child: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
