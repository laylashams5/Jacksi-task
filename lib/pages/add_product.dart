import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jacksi/models/category.dart';
import 'package:jacksi/models/product.dart';
import 'package:jacksi/widgets/text_filed.dart';

class AddProductPage extends StatefulWidget {
  final void Function(Product) addProduct;
  final List<Category> categoriesList;

  AddProductPage({required this.addProduct, required this.categoriesList});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  List<File?> _images = List.generate(4, (_) => null);

  String selectedCategory = '';

  Future<void> _getImage(int index) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _images[index] = File(pickedImage.path);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images[index] = null;
    });
  }

  void _addFourImages() async {
    int index = _images.indexWhere((image) => image == null);
    if (index != -1) {
      await _getImage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:
            const Text('اضافة منتجات', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xffECECEC)),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.all(1),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffEDEDED)),
                            borderRadius: BorderRadius.circular(5)),
                        child: _images[index] != null
                            ? Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.file(
                                        _images[index]!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFF0000)
                                              .withOpacity(0.4),
                                          elevation: 0,
                                          shape: CircleBorder(),
                                          minimumSize: Size(20, 20)),
                                      onPressed: () => _removeImage(index),
                                      child: Icon(
                                        Icons.clear,
                                        size: 14,
                                        color: Color(0xFFECECEC),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addFourImages,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xFF3EB86F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(
                        double.infinity, 60), // Match the width of TextFields
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/addsquare.png', // Replace with your image path
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'اضغط لاضافة الصور',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                buildTextField(
                  labelText: 'اسم المنتج',
                  hintText: 'اسم المنتج',
                  controller: nameController,
                ),
                SizedBox(height: 12),
                buildTextField(
                  labelText: 'اسم المتجر',
                  hintText: 'اسم المتجر',
                  controller: storeController,
                ),
                SizedBox(height: 12),
                buildTextField(
                  labelText: 'السعر',
                  hintText: 'السعر',
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'التصنيف',
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        child: buildCategoryDropdown(widget.categoriesList)),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        Color(0xFF3EB86F), // Set the desired button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(
                        double.infinity, 60), // Match the width of TextFields
                  ),
                  onPressed: () {
                    final priceText = priceController.text;

                    debugPrint('priceText $priceText');
                    if (priceText.isEmpty) {
                      // Handle the case where the price is empty
                      // You might show an error message or prevent submission
                      return;
                    }

                    final double? price = double.tryParse(priceText);
                    if (price == null) {
                      // Handle the case where the price is not a valid numeric value
                      // You might show an error message or prevent submission
                      return;
                    }
                    debugPrint('price $price');
                    final product = Product(
                      name: nameController.text,
                      store: storeController.text,
                      price: price,
                      category: selectedCategory,
                      imagePaths:
                          _images.map((image) => image?.path ?? '').toList(),
                    );

                    widget.addProduct(product);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'إضافة المنتج',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<Category> buildCategoryDropdown(
      List<Category> categories) {
    return DropdownButtonFormField<Category>(
      value: selectedCategory.isEmpty
          ? null
          : widget.categoriesList
              .firstWhere((cat) => cat.name == selectedCategory),
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue!.name;
        });
      },
      items: categories.map((category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Center(
              child: Text(
            category.name,
            style: TextStyle(
              fontSize: 14,
            ),
          )),
        );
      }).toList(),
      decoration: InputDecoration(
          hintText: 'اسم التصنيف',
          hintStyle: TextStyle(color: Color(0xFf5973DE), fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xFFE1E1E1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xFFE1E1E1)),
          ),
          icon: null // Replace with your custom icon
          ),
      icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Color(0xFf5973DE),
      ),
    );
  }
}
