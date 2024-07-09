import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/auth/view/forgot.dart';
import 'package:laroch/module/auth/view/register.dart';
import 'package:laroch/module/home/views/home.dart';
import 'package:laroch/routes.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import '../../../const/colors.dart';
import '../../../services/network/network.dart';
import '../../../utils/helper/form_validation.dart';
import '../../../utils/widgets/appbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white.withOpacity(0.99),
      appBar: buildCustomAppBar(title: "  Login"),
      body: buildBody(),
    );
  }

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  /// TextEditingController userName = TextEditingController(
  ///   text: "satyam22@yopmail.com",
  /// );
  /// TextEditingController password = TextEditingController(
  ///   text: "Test@123456@",
  /// );

  var formKeyLogin = GlobalKey<FormState>();

  formValidator() {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginApi();
    formKeyLogin.currentState!.save();
  }

  loginApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await API().post(context: context, URLs.login, data: {
        "email": userName.text.trim(),
        "password": password.text.trim()
      });

      if (response.data['responseCode'] == 1) {
        if (response.data['data'].isNotEmpty &&
            response.data['data']['user_id'] != null) {
          final data = jsonDecode(response.toString()) as Map<String, dynamic>;
          SharedPref.saveUserDetails(data);
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
            ///   GoRouter.of(context).go(Routes.home);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          errorDialog(
              message: response.data['responseMessage'], context: context);
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        errorDialog(message: "Something went wrong!", context: context);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  bool showPassword = false;

  Widget buildBody() {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        exit(0);
      },
      child: Form(
        key: formKeyLogin,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/la_roch_logo.png",
                  height: 100.w,
                  width: 200.w,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                decoration: BoxDecoration(
                    color: AppColors().red.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(5.r)),
                child: TextFormField(
                  controller: userName,
                  maxLines: 1,
                  validator: (value) => FormValidation.emailValidator(
                    value,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                decoration: BoxDecoration(
                    color: appColors.red.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(5.r)),
                child: TextFormField(
                  controller: password,
                  maxLines: 1,
                  validator: (value) =>
                      FormValidation.nameValidator(value, tag: "Password"),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        child: Icon(
                          showPassword
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: appColors.gray500,
                        )),
                  ),
                  obscureText: showPassword,
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: appColors.gray500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ElevatedButton(
                    onPressed: () {
                      formValidator();
                    },
                    child: isLoading
                        ? SizedBox(
                            height: 25.h,
                            width: 25.h,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                              ),
                            ),
                          )
                        : Text("LOGIN", style: theme.textTheme.titleMedium)),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: appColors.gray500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Register()));
                    },
                    child: Text(
                      "Register",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: appColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
