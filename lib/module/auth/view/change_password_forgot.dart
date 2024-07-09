import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/auth/view/login.dart';
import 'package:laroch/services/network/network.dart';
import 'package:laroch/utils/helper/form_validation.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../routes.dart';
import '../../../utils/widgets/appbar.dart';
import '../../../utils/widgets/dialogs/dailog.dart';
import '../../../utils/widgets/textfield.dart';

class ChangePasswordForgot extends StatefulWidget {
  const ChangePasswordForgot({super.key, required this.userId});

  final String userId;

  @override
  State<ChangePasswordForgot> createState() => _ChangePasswordForgotState();
}

class _ChangePasswordForgotState extends State<ChangePasswordForgot> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Change Password",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  bool isLoading = false;

  var formKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  updateApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await API().post(
          context: context,
          URLs.changePasswordForgot,
          data: {
            "user_id": widget.userId,
            "password": newPassword.text.trim()
          });

      if (jsonDecode(response.toString())['responseCode'] == 1) {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context,
              message: "Password changed successfully please login");
        });

        Future.delayed(Duration.zero, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ));
        });
      } else {
        Future.delayed(Duration.zero, () {
          errorDialog(
              message: jsonDecode(response.toString())['responseMessage'],
              context: context);
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

  validate() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    await updateApi();

    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    AppTextFormField(
                      labelText: "New Password",
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          FormValidation.passwordValidator(value),
                      controller: newPassword,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AppTextFormField(
                      labelText: "Confirm Password",
                      validator: (value) =>
                          FormValidation.confirmPasswordValidator(
                              value, newPassword.text),
                      controller: confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                          onPressed: () {
                            validate();
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
                              : Text("Update",
                                  style: theme.textTheme.titleMedium)),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
