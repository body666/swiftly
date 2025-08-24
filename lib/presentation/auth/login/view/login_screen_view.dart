import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftly/core/styles/colors/app_colors.dart';
import 'package:swiftly/core/styles/fonts/app_fonts.dart';
import 'package:swiftly/core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/functions/validators/validators.dart'
    show Validators;
import '../../../../core/utils/widget/custom_elevated_button.dart'
    show CustomElevatedButton;
import '../../forgot_pass/view/forgot_pass_screen.dart'
    show ForgotPasswordScreenView, ForgotPasswordScreen;
import '../view_model/login_screen_view_model.dart'
    show
        LoginCubit,
        LoginLoading,
        LoginSuccess,
        LoginState,
        LoginError,
        LoginScreenViewModel;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.lightBackground],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.lightBackground],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: BlocConsumer<LoginScreenViewModel, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Logged In Successfully',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is LoginError) {
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
                            'Welcome Back! 👋',
                            style: AppFonts.font28PrimaryBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Log in to your account to continue.',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 40.h),
                          CustomTextFormField(
                            validator: Validators.validateEmail,
                            controller: _emailController,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                            // Example of enhanced border styling
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
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
                          CustomTextFormField(
                            validator: Validators.validatePassword,
                            controller: _passwordController,
                            isPassword: true,
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: AppFonts.font14PrimaryWeight600,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          if (state is LoginLoading)
                            Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          else
                            SizedBox(
                              width: double.infinity,
                              child: CustomElevatedButton(
                                text: 'Login',
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context.read<LoginScreenViewModel>().login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                            ),
                          SizedBox(height: 30.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: AppFonts.font14LightGreyWeight500
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kGray,
                                    ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Navigate to your registration screen
                                },
                                child: Text(
                                  'Sign Up',
                                  style: AppFonts.font14AccentBold,
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
