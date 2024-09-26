
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choco_bliss_mobile/app/data/Models/catogery.dart';
import 'package:choco_bliss_mobile/app/data/color_const.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function onPressDelete;
  final Function onPressEdit;

  const CategoryCard({super.key, required this.category, required this.onPressDelete, required this.onPressEdit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressEdit();
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: SizedBox(
          height: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Image
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl:
                      category.imageURL,
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
                      placeholder: (context, url) => const Center(child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      onPressDelete();
                    },
                    child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.delete,
                        color: AppColors.warningRed,
                          size: 32,
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Name
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Category Description
                    Text(
                      category.description,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}