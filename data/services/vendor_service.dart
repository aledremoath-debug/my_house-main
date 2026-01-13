import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  final String id;
  final String name;
  final List<String> images; // Changed to list
  final String price;
  final String status;
  final bool isLowStock;
  final bool isPublished;
  final String? category;
  final String? quantity;
  final String? description;
  final String? additionalSpecs;

  Product({
    required this.id,
    required this.name,
    List<String>? images, // Changed to optional
    required this.price,
    required this.status,
    this.isLowStock = false,
    this.isPublished = true,
    this.category,
    this.quantity,
    this.description,
    this.additionalSpecs,
  }) : images = images ?? []; // Initialize with empty list if null

  // Backward compatibility
  String get imageUrl => images.isNotEmpty ? images.first : '';

  int get quantityInt => int.tryParse(quantity ?? '0') ?? 0;

  String get effectiveStatus {
    if (quantityInt == 0) return 'نفذت الكمية';
    if (quantityInt <= 5) return 'قريب من النفاذ';
    return 'متوفر';
  }

  Color get statusColor {
    if (quantityInt == 0) return Colors.red;
    if (quantityInt <= 5) return Colors.orange;
    return Colors.green;
  }

  Product copyWith({
    String? id,
    String? name,
    List<String>? images,
    String? price,
    String? status,
    bool? isLowStock,
    bool? isPublished,
    String? category,
    String? quantity,
    String? description,
    String? additionalSpecs,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      price: price ?? this.price,
      status: status ?? this.status,
      isLowStock: isLowStock ?? this.isLowStock,
      isPublished: isPublished ?? this.isPublished,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      additionalSpecs: additionalSpecs ?? this.additionalSpecs,
    );
  }
}

class VendorService extends GetxService {
  final products = <Product>[].obs;

  // Store Data (Centralized)
  final storeName = 'متجر السعادة'.obs;
  final storeLogo = ''.obs;
  final storeBanner = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data
    products.addAll([
      Product(
        id: '1',
        name: 'صمام أمان للغاز',
        images: ['assets/images/product1.png'],
        price: '75 ر.ي',
        status: 'قريب من النفاذ',
        isLowStock: true,
        category: 'صمام',
        quantity: '5',
        description: 'صمام أمان عالي الجودة لأسطوانات الغاز المنزلية',
        additionalSpecs: 'صناعة إيطالية',
      ),
      Product(
        id: '2',
        name: 'فلتر مياه سيراميك',
        images: ['assets/images/product2.png'],
        price: '150 ر.ي',
        status: 'متوفر',
        category: 'فلتر مياه',
        quantity: '20',
        description: 'فلتر مياه سيراميك 7 مراحل لتنقية المياه',
        additionalSpecs: 'ضمان سنة',
      ),
      Product(
        id: '3',
        name: 'سخان مياه فوري',
        images: ['assets/images/product3.png'],
        price: '400 ر.ي',
        status: 'نفذت الكمية',
        isLowStock: true,
        category: 'سخان',
        quantity: '0',
        description: 'سخان مياه فوري موفر للطاقة',
        additionalSpecs: 'كهرباء 220 فولت',
      ),
      Product(
        id: '4',
        name: 'مضخة مياه منزلية',
        images: ['assets/images/product4.png'],
        price: '350 ر.ي',
        status: 'متوفر',
        category: 'مضخة',
        quantity: '15',
        description: 'مضخة مياه صامتة بقوة 1 حصان',
        additionalSpecs: 'صناعة ألمانية',
      ),
    ]);
  }

  void addProduct(Product product) {
    products.add(product);
  }

  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }

  void updateProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  void togglePublishStatus(String id) {
    final index = products.indexWhere((p) => p.id == id);
    if (index != -1) {
      final product = products[index];
      products[index] = product.copyWith(isPublished: !product.isPublished);
    }
  }

  void updateProductQuantity(String id, String newQuantity) {
    final index = products.indexWhere((p) => p.id == id);
    if (index != -1) {
      final product = products[index];
      products[index] = product.copyWith(quantity: newQuantity);
    }
  }
}
