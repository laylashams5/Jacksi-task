import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jacksi/models/category.dart';
import 'package:jacksi/models/product.dart';
import 'package:jacksi/pages/add_product.dart';
import 'package:jacksi/pages/product_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  String selectedCategory = 'الكل';
  bool isVerticalView = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingProducts = prefs.getStringList('products') ?? [];

    List<Product> loadedProducts = [];
    for (String productJson in existingProducts) {
      Map<String, dynamic> productMap = jsonDecode(productJson);
      loadedProducts.add(Product.fromJson(productMap));
    }

    setState(() {
      products = loadedProducts;
    });
  }

  Future<void> addProduct(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingProducts = prefs.getStringList('products') ?? [];

    existingProducts.add(jsonEncode(product.toJson()));
    prefs.setStringList('products', existingProducts);

    setState(() {
      products.add(product);
    });
  }

  void filterProducts(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void toggleView() {
    setState(() {
      isVerticalView = !isVerticalView;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = selectedCategory == 'الكل'
        ? products
        : products
            .where((product) => product.category == selectedCategory)
            .toList();

    List<Category> categories = [
      Category(name: 'الكل', imageAsset: 'assets/images/all.png'),
      Category(name: 'تصنيف 1', imageAsset: 'assets/images/cat1.png'),
      Category(name: 'تصنيف 2', imageAsset: 'assets/images/cat2.png'),
      Category(name: 'تصنيف 3', imageAsset: 'assets/images/cat3.png'),
    ];
    List<Category> removeFirstCategory(List<Category> categories) {
      return categories.sublist(1);
    }

    List<Category> NewCategories = removeFirstCategory(categories);
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'المنتجات',
          style: TextStyle(
            color: Color(0xff3E3E68),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(
                    addProduct: addProduct,
                    categoriesList: NewCategories,
                  ),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 80,
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xffECECEC)),
              ),
              child: Icon(
                Icons.add,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the end (right)
        textDirection: TextDirection.rtl,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: const Text(
              'التصنيفات',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff3E3E68),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  for (Category category in categories)
                    CategoryItem(
                        category: category,
                        selectedCategory: selectedCategory,
                        onPressed: filterProducts),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: toggleView,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Change button color to white
                    elevation: 0, // Remove elevation
                  ),
                  child: Row(
                    children: [
                      Text(
                        isVerticalView
                            ? 'تغيير عرض المنتجات أفقي'
                            : 'تغيير عرض المنتجات عمودي',
                        style: const TextStyle(
                          color: Color(0xffFF4155), // Change text color to red
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/btn.png', // Replace with your image path
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: isVerticalView
                ? ListView.builder(
                    itemCount: filteredProducts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ProductItem(
                            product: filteredProducts[index],
                            isVertical: isVerticalView,
                          ));
                    },
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.80),
                      itemCount: filteredProducts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductItem(
                            product: filteredProducts[index],
                            isVertical: isVerticalView,
                          ),
                        );
                      },
                    )),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final String selectedCategory;
  final Function(String) onPressed;

  CategoryItem(
      {required this.category,
      required this.selectedCategory,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool isSelected = category.name == selectedCategory;
    List<Category> categories = [
      Category(name: 'الكل', imageAsset: 'assets/images/all.png'),
      Category(name: 'تصنيف 1', imageAsset: 'assets/images/cat1.png'),
      Category(name: 'تصنيف 2', imageAsset: 'assets/images/cat2.png'),
      Category(name: 'تصنيف 3', imageAsset: 'assets/images/cat3.png'),
    ];

    return GestureDetector(
      onTap: () => onPressed(category.name),
      child: Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3EB86F)
                : Colors.white, // Change border color for selected category
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 60,
              decoration: BoxDecoration(
                color: category.name == categories[0].name
                    ? const Color(0xFF3EB86F)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                category.imageAsset,
                width: 70,
                height: 60,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
