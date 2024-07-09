import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/my_account/view/change_password.dart';
import 'package:laroch/module/my_account/view/otp.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../const/common_lib.dart';
import '../../../services/network/network.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>((event, emit) {});
  }
}

class AccountController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isLoading = false;

  choosePicture() async {}



  updateProfile({
    required String lname,
    required String fname,
    XFile? profilePic,
    required String phone,
    required callBack,
    required BuildContext? context,
  }) async {
    isProfileLoading = true;
    callBack();
    try {

      Response response =
      await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
          .post(context: context, URLs.editProfile, data: {
        "fname": fname,
        "lname":lname,
            "phone":phone,
       "filename": profilePic!=null? await MultipartFile.fromFile(profilePic!.path,
      filename: (profilePic.path).split('/').last):"",

      });


        if (jsonDecode(response.toString())['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            profile(context!,callBack: (){});
          });
        }
        if (jsonDecode(response.toString())['responseCode'] == 0) {
        Future.delayed(Duration.zero, () {
          isProfileLoading = false;
          showSnackBar(
              context: context!,
              message: jsonDecode(response.toString())['responseMessage']);
        });
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!,
              message: jsonDecode(response.toString())['responseMessage']);
        });
      }


    } catch (e) {
      Future.delayed(Duration.zero, () {

        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }

    isProfileLoading = false;
    callBack();
  }

  changePassword({
    required callBack,
    required BuildContext? context,
    required AccountController? accountController,
  }) async {
    isLoading = true;
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(
        context: context,
        URLs.sendOTPForPasswordChange,
        data: {
          "email": SharedPref.getUserDetails()!['data']['email'].toString()
        },
      );
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            showSnackBar(
              context: context!,
              message: response.data['responseMessage'],
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OtpScreenForChangePassword(
                    email: SharedPref.getUserDetails()!['data']['email']
                        .toString(),
                    accountController: accountController!),
              ),
            );
          });
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context!, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!, message: "Please try after some time");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }

  TextEditingController otpController = TextEditingController();

  verifyOTPForChangePassword(
      {required callBack,
      required BuildContext? context,
      required AccountController? accountController}) async {
    isLoading = true;
    callBack();
    try {
      Response response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(context: context, URLs.otpReceivedForPasswordChange, data: {
        "otp": otpController.text.toString(),
      });

      if (jsonDecode(response.toString())['responseCode'] == 1) {
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context!, message: "Please set a new password");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePassword(
                        accountController: accountController!,
                      )));
        });
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!,
              message: jsonDecode(response.toString())['responseMessage']);
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
    }

    isLoading = false;
    callBack();
  }

  var formKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  validate(
      {required callBack,
      required BuildContext? context,
      required AccountController? accountController}) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    await setPassword(
        callBack: () => callBack,
        accountController: accountController,
        context: context);
    formKey.currentState!.save();
  }

  setPassword(
      {required callBack,
      required BuildContext? context,
      required AccountController? accountController}) async {
    isLoading = true;
    callBack();
    try {
      Response response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(context: context, URLs.changePasswordAccount, data: {
        "password": newPassword.text.toString(),
      });

      if (jsonDecode(response.toString())['responseCode'] == 1) {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!,
              message: jsonDecode(response.toString())['responseMessage']);

          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!,
              message: jsonDecode(response.toString())['responseMessage']);
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
    }

    isLoading = false;
    callBack();
  }

  Map<String, dynamic>? profileData;
  bool isProfileLoading = false;
  profile(BuildContext context, {required void Function() callBack}) async {
    isProfileLoading = true;

    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(context: context, URLs.profile);

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          profileData = response.data;
          firstname.text =
              "${profileData!['data']['profiledata']['name']} ";
          lastname.text ="${profileData!['data']['profiledata']['last_name']}";
          phone.text = "${profileData!['data']['profiledata']['phone']}";
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context, message: "Please try after some time");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isProfileLoading = false;
    callBack();
  }

  XFile? imagePath;
  void onProfileImageTap(BuildContext context) {
    AppBottomSheet.kImagePickerBottomSheet(
      context,
      onCameraTap: () async {

        _pickImage(ImageSource.camera);
      },
      onGalleryTap: () async {

        _pickImage(ImageSource.gallery);
      },
    );
  }

  final ImagePicker _picker = ImagePicker();

  _pickImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source,imageQuality: 85,);
    if (image != null) {
      log(image.name);
     log(image.path+"garima");
      imagePath=image;



    }
  }


}
class AppBottomSheet {
  static kImagePickerBottomSheet(
      BuildContext context, {
        VoidCallback? onCameraTap,
        VoidCallback? onGalleryTap,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _Popover(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(4),
                        color:appColors.red,
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                         SizedBox(height: 10,),
                          const Text('Camera'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onGalleryTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: appColors.red,
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 10,),
                          const Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        );
      },
    );
  }

  static kDefaultBottomSheet(BuildContext context, {Widget? body}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _Popover(
          child: body,
        );
      },
    );
  }
}
class _Popover extends StatelessWidget {
  const _Popover({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: EdgeInsets.all(12.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildHandle(context), if (child != null) child!],
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}