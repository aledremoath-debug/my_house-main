import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../../../data/services/vendor_service.dart';
import '../controllers/my_products_controller.dart';

class MyProductsView extends GetView<MyProductsController> {
  const MyProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Obx(() => controller.isGridView.value
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  )
                : ListView.separated(
                    itemCount: controller.filteredProducts.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return _buildProductListItem(product);
                    },
                  )),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: controller.toggleViewMode,
        child: Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Obx(() => Icon(
                controller.isGridView.value
                    ? Icons.view_list_rounded
                    : Icons.grid_view_rounded,
                color: ColorManager.slateGrey,
              )),
        ),
      ),
      title: Obx(() => controller.isSearching.value
          ? TextField(
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'بحث...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey)),
              style: TextStyle(color: ColorManager.slateGrey),
              onChanged: controller.updateSearch,
            )
          : Text(
              'منتجاتي',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            )),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              left: 10
                  .w), // Adjusted padding since it's the only item now (or maybe searching is there too?)
          child: IconButton(
              onPressed: controller.toggleSearch,
              icon: Obx(() => Icon(
                  controller.isSearching.value ? Icons.close : Icons.search,
                  color: ColorManager.slateGrey,
                  size: 28.sp))),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => controller.showProductDetails(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15.r)),
                  color: Colors.grey[100],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.r)),
                        child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: product.imageUrl.startsWith('assets')
                                ? Image.asset(product.imageUrl,
                                    fit: BoxFit.cover)
                                : Image.file(File(product.imageUrl),
                                    fit: BoxFit.cover))),
                    if (!product.isPublished)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.r)),
                        ),
                        child: Center(
                          child: Text(
                            'مخفي',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    // Removed three dots menu as per request
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.slateGrey,
                      ),
                    ),
                    Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            size: 10.sp, color: product.statusColor),
                        SizedBox(width: 5.w),
                        Text(
                          product.effectiveStatus,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: product.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'الكمية: ${product.quantity ?? "0"}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem(Product product) {
    return GestureDetector(
      onTap: () => controller.showProductDetails(product),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image Section
            Container(
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(15.r)), // RTL support check
                color: Colors.grey[100],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r)),
                      child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: product.imageUrl.startsWith('assets')
                              ? Image.asset(product.imageUrl, fit: BoxFit.cover)
                              : Image.file(File(product.imageUrl),
                                  fit: BoxFit.cover))),
                  if (!product.isPublished)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r)),
                      ),
                      child: Center(
                        child: Text(
                          'مخفي',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Info Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.slateGrey,
                            ),
                          ),
                        ),
                        // Removed three dots menu as per request
                      ],
                    ),
                    Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            size: 10.sp, color: product.statusColor),
                        SizedBox(width: 5.w),
                        Text(
                          product.effectiveStatus,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: product.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'الكمية: ${product.quantity ?? "0"}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
