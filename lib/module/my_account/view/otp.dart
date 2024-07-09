import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/my_account/bloc/account_bloc.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import 'package:pinput/pinput.dart';

class OtpScreenForChangePassword extends StatefulWidget {
  const OtpScreenForChangePassword({
    super.key,
    required this.email,
    required this.accountController,
  });
  final String email;

  final AccountController accountController;

  @override
  State<OtpScreenForChangePassword> createState() =>
      _OtpScreenForChangePasswordState();
}

class _OtpScreenForChangePasswordState
    extends State<OtpScreenForChangePassword> {
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
            controller: widget.accountController.otpController,
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
                  widget.accountController.changePassword(
                      callBack: () => setState(() {}),
                      context: context,
                      accountController: widget.accountController);
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
                if (widget.accountController.otpController.text.isEmpty &&
                    widget.accountController.otpController.text.length != 4) {
                  errorDialog(
                      context: context, message: "please enter valid otp");
                } else {
                  widget.accountController.verifyOTPForChangePassword(
                      accountController: widget.accountController,
                      context: context,
                      callBack: () => setState(() {}));
                }
              },
              child: widget.accountController.isLoading
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
        const Spacer(flex: 2),
      ],
    ));
  }
}
