import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/utils/size_config.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Container(
        constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight / 2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: product.images.isNotEmpty
                    ? Image.memory(
                        base64Decode(product.images[0]),
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/home.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(product.title),
                  ),
                  Expanded(
                    child: Text(
                      '\$${product.price.toString()}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(product.updatedAt.toString().substring(5, 16)),
            ],
          ),
        ),
      ),
    );
  }
}
