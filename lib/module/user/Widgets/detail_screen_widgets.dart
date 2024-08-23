import 'package:flutter/material.dart';
import '../../constants.dart';
import '../models/product_model.dart';
import '../services/Provider/favorite_provider.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kprimaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailAppBar extends StatelessWidget {
  final Product product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(product.title),
      actions: [
        IconButton(
          icon: Icon(Icons.share_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            provider.isExist(product) ? Icons.favorite : Icons.favorite_border,
            color: Colors.black,
          ),
          onPressed: () {
            provider.toggleFavorite(product);
          },
        ),
      ],
    );
  }
}

class MyImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final String image;
  const MyImageSlider({
    super.key,
    required this.image,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Hero(
            tag: image,
            child: Image.asset(image),
          );
        },
      ),
    );
  }
}

class ItemsDetails extends StatelessWidget {
  final Product product;
  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "₹ ${product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  product.seller,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.white,
                      ),
                      Text(
                        product.rate.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  product.review,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
