import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftly/core/styles/colors/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent, // Bright Coral
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.w,
              ),
            )
          : Text(text),
    );
  }
}
