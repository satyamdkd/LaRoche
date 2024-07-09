import 'package:cached_network_image/cached_network_image.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/my_account/bloc/account_bloc.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import 'package:laroch/utils/widgets/textfield.dart';
import '../../../utils/widgets/appbar.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  AccountController accountController = AccountController();

  bool editable = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      accountController.profile(context, callBack: () => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.gray50,
      appBar: buildCustomAppBar(),
      body: buildBody(),
      bottomNavigationBar: accountController.isProfileLoading
          ? const SizedBox()
          : buildBottomNav(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: accountController.isProfileLoading
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          imageUrl://"/data/user/0/la.roch.com.laroch/cache/8d056430-6f85-4fb5-8deb-4d88c3fba3e6/1000000326.jpg",
                              "https://www.larochenigeria.com/api/uploads/${accountController.profileData?['data']['profiledata']['profilephoto']}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,),
                                  child: Icon(Icons.person,size: 50,color: appColors.red,)),
                        ),
                        if (editable)
                          Positioned(
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: appColors.white,
                                  borderRadius: BorderRadius.circular(50.h)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  color: appColors.red,
                                  size: 24.h,
                                ),
                              ),
                            ),
                          ),
                        if (editable)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: appColors.white,

                                borderRadius: BorderRadius.circular(50.h)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: (){


                                  accountController.onProfileImageTap(context);
                                },
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: appColors.red,
                                  size: 24.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  IgnorePointer(
                    ignoring: !editable,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextFormField(
                            labelText: "First Name",
                            controller: accountController.firstname,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          AppTextFormField(
                            labelText: "Last Name",
                            controller: accountController.lastname,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          // AppTextFormField(
                          //   labelText: "Date Of Birth",
                          //   keyboardType: TextInputType.emailAddress,
                          //   controller: accountController.dob,
                          // ),
                          // SizedBox(
                          //   height: 8.h,
                          // ),
                          AppTextFormField(
                            labelText: "Mobile Number",
                            controller: accountController.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          InkWell(
                            onTap: () {
                              showSnackBar(
                                  context: context,
                                  message: "Email can not be modified");
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextFormField(
                                labelText: "Email Address",
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                controller: TextEditingController(
                                    text: SharedPref.getUserDetails()!['data']
                                        ['email']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "My Account",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  Column buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 0.5,
          color: Colors.grey.withOpacity(0.07),
        ),
        editable
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          accountController.updateProfile(lname:accountController.lastname.text,fname: accountController.firstname.text, profilePic: accountController.imagePath, phone: accountController.phone.text, callBack: () => setState(() {}), context: context);
                          editable=!editable;
                        },
                        child: Text(
                          "Update",
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            editable = !editable;
                          });
                        },
                        child: Text(
                          "EDIT PROFILE",
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: appColors.red),
                        ),
                      ),
                    ),
                  ),
                  accountController.isLoading
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: appColors.red,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                accountController.changePassword(
                                    accountController: accountController,
                                    callBack: () => setState(() {}),
                                    context: context);
                              },
                              child: Text(
                                "CHANGE PASSWORD",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ],
    );
  }
}
