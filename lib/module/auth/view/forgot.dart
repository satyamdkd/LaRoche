import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/auth/view/otp_screen.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import '../../../const/colors.dart';
import '../../../services/network/network.dart';
import '../../../utils/helper/form_validation.dart';
import '../../../utils/widgets/appbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white.withOpacity(0.99),
      appBar: buildCustomAppBar(title: "  Forgot Password"),
      body: buildBody(),
    );
  }

  TextEditingController email = TextEditingController();

  var formKeyLogin = GlobalKey<FormState>();

  formValidator() {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    forgotApi();
    formKeyLogin.currentState!.save();
  }

  forgotApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response =
          await API().post(context: context, URLs.forgotPassword, data: {
        "email": email.text.trim(),
      });

      if (jsonDecode(response.toString())['responseCode'] == 1) {
        if (jsonDecode(response.toString())['user_id'] != null) {
          final data = jsonDecode(response.toString()) as Map<String, dynamic>;
          SharedPref.saveUserDetails(data);
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                            userID: int.parse(
                                jsonDecode(response.toString())['user_id']),
                            email: email.text,
                            isForgotPassword: true,
                            data: {
                              "email": email.text.trim(),
                            })));
          });
        }
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

  Widget buildBody() {
    return Form(
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
                controller: email,
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
                      : Text("GET OTP", style: theme.textTheme.titleMedium)),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
