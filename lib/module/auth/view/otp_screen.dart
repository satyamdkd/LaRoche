import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/auth/view/change_password_forgot.dart';
import 'package:laroch/module/home/views/home.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import 'package:pinput/pinput.dart';
import '../../../services/network/network.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key,
      userId,
      required this.userID,
      required this.email,
      required this.data,
      this.isForgotPassword = false});
  final int userID;
  final String email;

  final bool isForgotPassword;

  final Map<String, dynamic> data;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;

  TextEditingController otpController = TextEditingController();

  /// ******************************************************************
  /// ** Checking whether otp is for registration OR forgot password ***
  /// ******************************************************************

  verifyOtpApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await API().post(context: context,
          widget.isForgotPassword ? URLs.forgotPasswordOtp : URLs.registerOtp,
          data: {"user_id": widget.userID, "otp": otpController.text});

      if (widget.isForgotPassword) {
        if (jsonDecode(response.toString())['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordForgot(
                          userId: jsonDecode(response.toString())['user_id'],
                        )));
          });
        } else {
          Future.delayed(Duration.zero, () {
            errorDialog(
                message: jsonDecode(response.toString())['responseMessage'],
                context: context);
          });
        }
        setState(() {
          isLoading = false;
        });
      } else {
        if (response.data['responseCode'] == 1) {
          if (response.data['data'].isNotEmpty &&
              response.data['data']['user_id'] != null) {
            if (widget.isForgotPassword) {
            } else {
              final data =
                  jsonDecode(response.toString()) as Map<String, dynamic>;

              SharedPref.saveUserDetails(data);
              Future.delayed(Duration.zero, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              });
            }
          }
        } else {
          Future.delayed(Duration.zero, () {
            errorDialog(
                message: response.data['responseMessage'], context: context);
          });
        }
        setState(() {
          isLoading = false;
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

  resendApi(data) async {
    otpController.clear();
    isLoading = true;
    setState(() {});
    try {
      Response? response = await API().post(context: context,
          widget.isForgotPassword ? URLs.forgotPassword : URLs.register,
          data: data);
      if (response != null) {
        if (jsonDecode(response.toString())['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            showSnackBar(context: context, message: "Otp sent successfully!");
          });
        } else {
          Future.delayed(Duration.zero, () {
            errorDialog(
                message: jsonDecode(response.toString())['responseMessage'],
                context: context);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          errorDialog(message: "Please try after some time", context: context);
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        errorDialog(message: "Please try after some time", context: context);
      });
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 1,
        ),
        Text(
          "We sent an OTP to your email address",
          style: theme.textTheme.bodyLarge?.copyWith(),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          widget.email,
          maxLines: 1,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: appColors.red,
          ),
        ),
        SizedBox(height: 45.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Pinput(
            controller: otpController,
            defaultPinTheme: PinTheme(
              width: 65.w,
              height: 60.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Didn't received the otp? ",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: appColors.gray500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  resendApi(widget.data);
                },
                child: Text(
                  "Resend",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: appColors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 25.h),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ElevatedButton(
              onPressed: () {
                if (otpController.text.isEmpty &&
                    otpController.text.length != 4) {
                  errorDialog(
                      context: context, message: "please enter valid otp");
                } else {
                  verifyOtpApi();
                }
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
                  : Text("Verify", style: theme.textTheme.titleMedium)),
        ),
        SizedBox(height: 25.h),
        const Spacer(
          flex: 2,
        ),
      ],
    ));
  }
}
