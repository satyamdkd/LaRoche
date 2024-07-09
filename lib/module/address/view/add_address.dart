import 'package:laroch/const/common_lib.dart';
import 'package:laroch/models/address_response.dart';
import 'package:laroch/module/address/bloc/address_bloc.dart';
import 'package:laroch/utils/helper/form_validation.dart';
import 'package:laroch/utils/widgets/dropdown.dart';
import '../../../utils/widgets/appbar.dart';

class AddUpdateAddress extends StatefulWidget {
  const AddUpdateAddress(
      {super.key,
      required this.addressController,
      this.edit = false,
      this.addressData,
      required this.setStateCallbackFromAddressPage,
      required this.buildContextFromAddressPage});

  final bool edit;

  final void Function() setStateCallbackFromAddressPage;
  final BuildContext buildContextFromAddressPage;
  final AddressController addressController;
  final AddressData? addressData;
  @override
  State<AddUpdateAddress> createState() => _AddUpdateAddressState();
}

class _AddUpdateAddressState extends State<AddUpdateAddress> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await widget.addressController.fetchState(
        callBack: () => setState(() {}),
      );
      if (widget.edit) {
        widget.addressController.setAllValuesToTextFields(
          addressData: widget.addressData!,
          callBack: () => setState(() {}),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          title: widget.edit ? "Update Address" : "Add Address"),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Form(
          key: widget.addressController.formKeyRegister,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textField(
                            hintText: "First Name",
                            controller: widget.addressController.firstName,
                            validator: (value) => FormValidation.nameValidator(
                                widget.addressController.firstName.text,
                                tag: "First Name"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: textField(
                        hintText: "Last Name",
                        controller: widget.addressController.lastName,
                        validator: (value) => FormValidation.nameValidator(
                            widget.addressController.lastName.text,
                            tag: "Last Name"),
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Address Details 1",
                  controller: widget.addressController.addressLine1,
                  validator: (value) => FormValidation.nameValidator(
                    widget.addressController.addressLine1.text,
                    tag: "Address Details 1",
                  ),
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Address Details 2",
                  controller: widget.addressController.addressLine2,
                  validator: (value) => FormValidation.nameValidator(
                    widget.addressController.addressLine2.text,
                    tag: "Address Details 2",
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: textField(
                        hintText: "City",
                        controller: widget.addressController.city,
                        validator: (value) => FormValidation.nameValidator(
                            widget.addressController.city.text,
                            tag: "City"),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "State",
                            textAlign: TextAlign.start,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontFamily: "Inter"),
                          ),
                          SizedBox(height: 10.h),
                          FormField(
                            validator: (value) {
                              if (widget.addressController.dropDownValue ==
                                  "Select state") {
                                return 'Select state';
                              }
                              return null;
                            },
                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDropdown(
                                    selectedValue:
                                        widget.addressController.dropDownValue!,
                                    tag: "State",
                                    dropDownList:
                                        widget.addressController.stateList,
                                    onChanged: (val) {
                                      widget.addressController.dropDownValue =
                                          val!;

                                      widget.addressController.settingStateId(
                                          stateName: widget
                                              .addressController.dropDownValue);
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  if (state.hasError)
                                    Text(
                                      state.errorText!,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Email",
                  controller: widget.addressController.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => FormValidation.emailValidator(
                    widget.addressController.email.text,
                  ),
                ),
                SizedBox(height: 20.h),
                textField(
                  hintText: "Mobile Number",
                  controller: widget.addressController.mobileNumber,
                  keyboardType: TextInputType.phone,
                  validator: (value) => FormValidation.nameValidator(
                      widget.addressController.mobileNumber.text,
                      tag: "Mobile Number"),
                ),
                SizedBox(height: 40.h),
                widget.edit
                    ? ElevatedButton(
                        onPressed: () {
                          widget.addressController.validateForm(
                              id: widget.addressData!.id,
                              context: context,
                              buildContextFromAddressPage:
                                  widget.buildContextFromAddressPage,
                              edit: true,
                              callBack: () => setState(() {}));
                        },
                        child: widget.addressController.loadingAddUpdateForm
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
                                " Update ADDRESS ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          widget.addressController.validateForm(
                              context: context,
                              buildContextFromAddressPage:
                                  widget.buildContextFromAddressPage,
                              callBack: () => setState(() {}));
                        },
                        child: widget.addressController.loadingAddUpdateForm
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
                                " ADD ADDRESS ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
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
      bool readOnly = false,
      TextInputType? keyboardType,
      String? Function(Object?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          hintText,
          textAlign: TextAlign.start,
          style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 10.sp,
              fontFamily: "Inter"),
        ),
        SizedBox(
          height: 10.h,
        ),
        FormField(
            validator: validator,
            builder: (state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: appColors.blueGray700,
                    controller: controller,
                    readOnly: readOnly,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      hintStyle: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                            color: appColors.black900.withOpacity(0.5),
                            width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                            color: appColors.black900.withOpacity(0.5),
                            width: 1.0),
                      ),
                      hintText: 'Enter $hintText',
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
            }),
      ],
    );
  }
}
