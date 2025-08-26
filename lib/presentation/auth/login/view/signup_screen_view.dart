import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/functions/validators/validators.dart' show Validators;
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../view_model/signup_screen_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: BlocProvider(
                // Create the ViewModel using GetIt
                create: (context) => getIt<SignUpScreenViewModel>(),
                child: BlocConsumer<SignUpScreenViewModel, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Signed Up Successfully!',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(context, PageRouteName.login);
                    } else if (state is SignUpError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Start your journey with us.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 40.h),

                        // ### Name Field ###
                        CustomTextFormField(
                          controller: _nameController,
                          labelText: 'Name',
                          validator: Validators.validateName,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // ### Email Field ###
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // ### Password Field ###
                        CustomTextFormField(
                          controller: _passwordController,
                          isPassword: true,
                          labelText: 'Password',
                          validator: Validators.validatePassword,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // ### Sign Up Button ###
                        if (state is SignUpLoading)
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<SignUpScreenViewModel>().signUp(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                    _nameController.text.trim(),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                        SizedBox(height: 30.h),

                        // ### Login Option ###
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, PageRouteName.login);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}