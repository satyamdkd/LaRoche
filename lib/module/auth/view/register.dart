import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/business_type.dart';
import 'package:laroch/module/auth/view/otp_screen.dart';
import 'package:laroch/utils/helper/form_validation.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import '../../../services/network/api.dart';
import '../../../utils/widgets/appbar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    getBusinessType();
  }

  bool showPassword = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool termAgreed = false;
  bool isLoading = false;

  TextEditingController businessType = TextEditingController();

  var formKeyRegister = GlobalKey<FormState>();
  formValidator() async {
    log(businessId.toString());
    final isValid = formKeyRegister.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    await registerApi();

    formKeyRegister.currentState!.save();
  }

  registerApi() async {
    try {
      Response? response = await API().post(context, URLs.register, data: {
        "name": firstName.text,
        "last_name": lastName.text,
        "email": email.text.trim(),
        "phone": phone.text,
        "password": password.text,
        "business_name": businessId,
        "termsandprivacypolicy": termAgreed ? 1 : 0,
      });

      if (response != null) {
        if (jsonDecode(response.toString())['responseCode'] == 1) {
          var userId = jsonDecode(response.toString())['user_id'];
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OtpScreen(
                          userID: userId,
                          email: email.text,
                          data: {
                            "name": firstName.text,
                            "last_name": lastName.text,
                            "email": email.text.trim(),
                            "phone": phone.text,
                            "password": password.text,
                            "business_name": businessId,
                            "termsandprivacypolicy": termAgreed ? 1 : 0,
                          },
                        )));
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
    setState(() {
      isLoading = false;
    });
  }

  var list = [
    "Select business type",
  ];
  BusinessType? businessTypeModel;
  getBusinessType() async {
    businessType.text = "Select business type";
    try {
      Response? response = await API().get(context, URLs.businessType);
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          businessTypeModel =

              BusinessType.fromJson(jsonDecode(response.toString()));

          for (var element in businessTypeModel!.data!.data!) {
            list.add(element.businessType!);
          }
        } else {
          Future.delayed(Duration.zero, () {
            errorDialog(
                message: response.data['responseMessage'], context: context);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          errorDialog(message: "Something went wrong!", context: context);
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        errorDialog(message: "Something went wrong!", context: context);
      });
    }
    setState(() {});
  }

  String? businessId;
  reBuildFunction(val) {
    if (val != 0) {
      businessType.text = list[val];
      log(businessType.text);
      var businessTypeId = businessTypeModel!.data!.data!
          .firstWhere((element) => element.businessType == businessType.text);
      businessId = businessTypeId.id;
      setState(() {});
    }
  }

  toggleTermCondition() {
    termAgreed = !termAgreed;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: "  Register"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: SingleChildScrollView(
          child: Form(
            key: formKeyRegister,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                SizedBox(
                  height: 20.h,
                ),
                textField(
                  hintText: "First Name",
                  validator: (value) =>
                      FormValidation.nameValidator(value, tag: "first Name"),
                  controller: firstName,
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Last Name",
                  validator: (value) =>
                      FormValidation.nameValidator(value, tag: "last Name"),
                  controller: lastName,
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Email",
                  validator: (value) => FormValidation.emailValidator(
                    value,
                  ),
                  controller: email,
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Password",
                  isPassword: showPassword,
                  validator: (value) => FormValidation.passwordValidator(
                    value,
                  ),
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
                  controller: password,
                ),
                SizedBox(
                  height: 20.h,
                ),
                textField(
                  hintText: "Mobile",
                  keyboardType: TextInputType.phone,
                  validator: (value) => FormValidation.phoneValidator(
                    value,
                  ),
                  controller: phone,
                ),
                SizedBox(height: 20.h),
                FormField(
                  validator: (value) {
                    if (businessType.text == "Select business type") {
                      return 'Select business type';
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            myBottomSheet(
                              context,
                              list: list,
                              onSelectedItemChanged: reBuildFunction,
                            );
                          },
                          child: IgnorePointer(
                            child: textField(
                              hintText: "Select business type",
                              readOnly: true,
                              suffixIcon: Icon(
                                Icons.expand_more_rounded,
                                color: appColors.gray500,
                              ),
                              controller: businessType,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        if (state.hasError)
                          Text(
                            state.errorText!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                FormField(
                  validator: (value) {
                    if (termAgreed == false) {
                      return 'please check term and condition';
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            toggleTermCondition();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              termAgreed
                                  ? Icon(
                                      Icons.check_box_rounded,
                                      color: appColors.green600,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank_rounded,
                                      color: appColors.gray500,
                                    ),
                              SizedBox(height: 4.h),
                              Text(
                                " I agree to the terms & conditions",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: appColors.gray500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        if (state.hasError)
                          Text(
                            state.errorText!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: ElevatedButton(
                      onPressed: () async {
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
                          : Text(
                              "REGISTER NOW",
                              style: theme.textTheme.titleMedium,
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      {required String hintText,
      controller,
      bool isPassword = false,
      bool readOnly = false,
      validator,
      Widget? suffixIcon,
      void Function()? onTap,
      keyboardType}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hintText,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: appColors.gray500,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              readOnly: readOnly,
              validator: validator,
              obscureText: isPassword,
              cursorColor: appColors.red,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: appColors.greyBackGround, width: 1)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: appColors.greyBackGround, width: 1)),
                labelStyle: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
