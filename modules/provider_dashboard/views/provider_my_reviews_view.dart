import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderMyReviewsView extends GetView<ProviderDashboardController> {
  const ProviderMyReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        _buildHeader(),

        // Stats Summary
        _buildStatsSummary(),

        // Reviews List
        Expanded(
          child: Obx(() => controller.myReviews.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  itemCount: controller.myReviews.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final review = controller.myReviews[index];
                    return _buildReviewCard(review);
                  },
                )),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => controller.changeTab(0),
                icon: Icon(
                  Icons.arrow_forward,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ),
              const SizedBox(),
            ],
          ),
          Text(
            'تقييماتي',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.primary,
            ColorManager.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Total Reviews
          _buildStatItem(
            icon: Icons.rate_review_outlined,
            value: '${controller.myReviews.length}',
            label: 'تقييم',
          ),
          Container(
            height: 50.h,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          // Average Rating
          _buildStatItem(
            icon: Icons.star,
            value: controller.averageRating.value.toStringAsFixed(1),
            label: 'متوسط التقييم',
          ),
          Container(
            height: 50.h,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          // Completed Jobs
          _buildStatItem(
            icon: Icons.check_circle_outline,
            value: '${controller.completedOrders.value}',
            label: 'عمل منجز',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
          // Job Info Header
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.05),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              children: [
                // Job Icon
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: (review['iconColor'] as Color?)?.withOpacity(0.1) ??
                        ColorManager.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    review['icon'] as IconData? ?? Icons.handyman,
                    color:
                        review['iconColor'] as Color? ?? ColorManager.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                // Job Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['jobTitle'] ?? 'عمل منجز',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.slateGrey,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        review['completedDate'] ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Rating Stars
                _buildRatingStars(review['rating'] ?? 5),
              ],
            ),
          ),

          // Client Info & Review
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Client Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          review['clientName'] ?? 'عميل',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.slateGrey,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              review['location'] ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.location_on_outlined,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: ColorManager.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        color: ColorManager.primary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Review Comment
                if (review['comment'] != null && review['comment'].isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'تعليق العميل',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.slateGrey,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.format_quote,
                              size: 16.sp,
                              color: ColorManager.primary,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          review['comment'],
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 12.h),

                // Price Tag
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${review['price'] ?? 0} ر.ي',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey.shade300,
          size: 18.sp,
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.star_outline,
              size: 60.sp,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'لا توجد تقييمات حالياً',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'أكمل طلبات العملاء للحصول على تقييمات',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
