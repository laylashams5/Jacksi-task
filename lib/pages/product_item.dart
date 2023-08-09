import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jacksi/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isVertical;

  ProductItem({required this.product, required this.isVertical});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final imageSize = isPortrait ? screenWidth * 0.25 : screenWidth * 0.20;
    print('isVertical $isVertical');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isVertical
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the image of the product
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: product.imagePaths.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(product.imagePaths.first),
                                width: imageSize,
                                height: imageSize,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: imageSize,
                              height: imageSize,
                            ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the name
                          Text(
                            product.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isPortrait ? 16.0 : 18.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          // Display the price
                          Row(
                            children: [
                              Text(
                                '${product.price}',
                                style: TextStyle(
                                  color: Color(0xff3EB86F),
                                  fontSize: isPortrait ? 14.0 : 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                'دولار',
                                style: TextStyle(
                                  color: Color(0xff3E3E68),
                                  fontSize: isPortrait ? 14.0 : 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          // Display the store
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              product.store,
                              style: TextStyle(
                                color: Color(0xffA1A1A1),
                                fontSize: isPortrait ? 12.0 : 14.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the image of the product
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: product.imagePaths.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(product.imagePaths.first),
                                width: imageSize,
                                height: imageSize,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: imageSize,
                              height: imageSize,
                            ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the name
                          Text(
                            product.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isPortrait ? 16.0 : 18.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          // Display the price
                          Row(
                            children: [
                              Text(
                                '${product.price}',
                                style: TextStyle(
                                  color: Color(0xff3EB86F),
                                  fontSize: isPortrait ? 14.0 : 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'دولار',
                                style: TextStyle(
                                  color: Color(0xff3E3E68),
                                  fontSize: isPortrait ? 14.0 : 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          // Display the store
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              product.store,
                              style: TextStyle(
                                color: Color(0xffA1A1A1),
                                fontSize: isPortrait ? 12.0 : 14.0,
                              ),
                            ),
                          )
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
