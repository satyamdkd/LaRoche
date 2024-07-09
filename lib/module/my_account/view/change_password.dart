import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/my_account/bloc/account_bloc.dart';
import 'package:laroch/utils/helper/form_validation.dart';
import '../../../utils/widgets/appbar.dart';
import '../../../utils/widgets/textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.accountController});

  final AccountController accountController;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Change Password",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.accountController.formKey,
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
                      controller: widget.accountController.newPassword,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AppTextFormField(
                      labelText: "Confirm Password",
                      validator: (value) =>
                          FormValidation.confirmPasswordValidator(
                              value, widget.accountController.newPassword.text),
                      controller: widget.accountController.confirmPassword,
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
                            widget.accountController.validate(
                                accountController: widget.accountController,
                                context: context,
                                callBack: () => setState(() {}));
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
