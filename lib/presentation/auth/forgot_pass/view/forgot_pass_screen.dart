import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftly/core/styles/colors/app_colors.dart';
import 'package:swiftly/core/styles/fonts/app_fonts.dart';
import 'package:swiftly/core/utils/functions/validators/validators.dart';
import 'package:swiftly/core/utils/widget/custom_elevated_button.dart';
import 'package:swiftly/core/utils/widget/custom_text_form_field.dart';
import '../../../../core/di/di.dart';
import '../view_model/forgot_pass_state.dart'
    show
        ForgotPasswordState,
        ForgotPasswordSuccess,
        ForgotPasswordError,
        ForgotPasswordLoading;
import '../view_model/forgot_pass_view_model.dart' show ForgotPasswordViewModel;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftly/core/styles/colors/app_colors.dart';
import 'package:swiftly/core/styles/fonts/app_fonts.dart';
import 'package:swiftly/core/utils/widget/custom_elevated_button.dart';
import 'package:swiftly/core/utils/widget/custom_text_form_field.dart';
import '../../../../core/di/di.dart';
import '../view_model/forgot_pass_state.dart'
    show
        ForgotPasswordState,
        ForgotPasswordSuccess,
        ForgotPasswordError,
        ForgotPasswordLoading;
import '../view_model/forgot_pass_view_model.dart' show ForgotPasswordViewModel;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordViewModel(getIt()), // Assuming getIt is set up
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.lightBackground],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.email_outlined,
                      color: AppColors.accent,
                      size: 65.sp,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text('Forgot Password', style: AppFonts.font28PrimaryBold),
                  SizedBox(height: 16.h),
                  Text(
                    'Enter your email to reset your password',
                    style: AppFonts.font16GreyWeight400,
                  ),
                  SizedBox(height: 24.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          validator: Validators.validatePassword,
                          controller: _emailController,
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.divider),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocConsumer<ForgotPasswordViewModel, ForgotPasswordState>(
                    listener: (context, state) {
                      if (state is ForgotPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                              style: AppFonts.font14BlackWeight500,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is ForgotPasswordError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                              style: AppFonts.font14BlackWeight500,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is ForgotPasswordLoading;

                      return CustomElevatedButton(
                        text: isLoading ? 'Sending...' : 'Reset Password',
                        onPressed: isLoading
                            ? () {} // Empty function instead of null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ForgotPasswordViewModel>()
                                      .resetPassword(
                                        _emailController.text.trim(),
                                      );
                                }
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
