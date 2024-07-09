// Dart imports:
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormValidation {
  static RegExp quotesRegx = RegExp(r'("|<|>)');
  static String quotesError = r'" , < , > not allowed';

  //**************************************Not Empty Validator*********************************//
  static String? notEmptyValidator(value, {bool isMandatory = true}) {
    if (value.length == 0) {
      return isMandatory ? 'Required' : null;
    }
    // else if (quotesRegx.hasMatch(value)) {
    //   return quotesError;
    // }
    return null;
  }

  //************************************** Price  Validator *********************************//
  static String? priceValidator(value) {
    if (value.length == 0) {
      return 'Required';
    } else if (double.parse(value.toString()) <= 0) {
      return 'Invalid amount';
    }
    return null;
  }

  static String? priceValidatorSecondry(value, {bool isMandatory = true}) {
    if (value.length == 0) {
      return null;
    } else if (double.parse(value.toString()) <= 0) {
      return isMandatory ? 'Check your amount' : null;
    }
    return null;
  }

  // //************************************** Discounted Price Validator *********************************//

  static String? discountedPriceVal(String? val, String val2) {
    if (val!.isNotEmpty && val2.isNotEmpty) {
      double valD = double.parse(val);
      double val2D = double.parse(val2);
      if (valD > val2D) {
        return "Invalid price";
      } else if (double.parse(valD.toString()) <= 0) {
        return 'Check your amount';
      }
    }
    return null;
  }

  //**************************************Select Image Validator*********************************//
  static String? selectImageValidator(value, {bool isMandatory = true}) {
    if (value.length == 0) {
      return isMandatory ? 'Please capture or select image' : null;
    }
    return null;
  }

  //**************************************Email Validator*********************************//
  static String? emailValidator(value) {
    if (value.length == 0) {
      return "Email is required";
    } else if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return 'Enter a valid email!';
    }
    return null;
  } //**************************************Email Validator*********************************//

  static String? emailValidatorRegistration(
    value, {
    bool isVerified = false,
  }) {
    if (value.length == 0) {
      return "Email is required";
    } else if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return 'Enter a valid email!';
    } else if (isVerified == false) {
      return 'Please verify your email address';
    }
    return null;
  }

  //**************************************Website Validator*********************************//

  static String? websiteValidator(String value, {bool isMandatory = true}) {
    final isUrl = GetUtils.isURL(value);
    if (value.isEmpty) {
      return isMandatory ? 'Please enter website' : null;
    } else if (!isUrl) {
      return 'Please enter valid website';
    }
    return null;
  }

  //**************************************Website Validator*********************************//

  static String? dobValidator(String value) {
    // final isUrl = GetUtils.isDateTime(value);
    if (value.isEmpty) {
      return 'Please enter DOB';
    }
    // else if (!isUrl) {
    //   return 'Please enter valid DOB';
    // }
    return null;
  }

  //**************************************Full Name Validator*********************************//
  static String? nameValidator(value, {bool isMandatory = true, tag}) {
    String pattern = r"^(?:[a-zA-Z\s]|\P{L})+$";
    RegExp regExp = RegExp(pattern, unicode: true);

    if (value.toString().trim().isEmpty) {
      return 'Please enter $tag';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid $tag';
    } else if (quotesRegx.hasMatch(value)) {
      return quotesError;
    } else {
      return null;
    }
  }

  //**************************************UserName Validator*********************************//
  static String? userNameValidator(value, {bool isMandatory = true}) {
    String patttern = r'^[a-z0-9_]+$';
    RegExp regExp = RegExp(patttern);

    if (value.length == 0) {
      return isMandatory ? 'Username is required' : null;
    } else if (value.length < 3) {
      return 'Minimum 3 characters';
    } else if (value.length > 15) {
      return 'Maximum 15 characters';
    } else if (value.contains(" ")) {
      return "Username must not contain spaces";
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid username';
    } else if (quotesRegx.hasMatch(value)) {
      return quotesError;
    }
    return null;
  }

  //**************************************Business Name Validator*********************************//
  static String? businessNameValidator(value, {bool isMandatory = true}) {
    String patttern = r"^(?:[a-z A-Z]|\P{L})+$";
    RegExp regExp = RegExp(patttern, unicode: true);
    // String patttern = r"^[a-z A-Z,.\-']+$";
    // RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return isMandatory ? 'Business name is required' : null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid business name';
    } else if (quotesRegx.hasMatch(value)) {
      return quotesError;
    }
    return null;
  }

  //**************************************Address Line Validator*********************************//

  static String? addressLineValidator(value) {
    if (value.length == 0) {
      return 'Address line is required';
    }
    return null;
  }

  //**************************************City Validator*********************************//
  static String? cityValidator(value) {
    if (value.length == 0) {
      return 'City is required';
    }
    return null;
  }

  static String? accountValidator(value) {
    if (value.length == 0) {
      return 'Account number is required';
    }
    return null;
  }

  //**************************************State Validator*********************************//
  static String? stateValidator(value, {bool isMandatory = true}) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return isMandatory ? 'State is required' : null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid state';
    } else if (quotesRegx.hasMatch(value)) {
      return quotesError;
    }
    return null;
  }

  //**************************************Zip Code Validator*********************************//

  static String? zipCodeValidator(value, {bool isMandatory = true}) {
    // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    // RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return isMandatory ? 'Zip code is required' : null;
    } else if (value.length < 5 || value.length > 5) {
      return isMandatory ? 'Please enter valid zip code' : null;
    }
    // else if (!regExp.hasMatch(value)) {
    //   return 'Please enter valid zip code';
    // }
    return null;
  }

  //**************************************Phone Number Validator*********************************//

  static String? phoneValidator(String? value, {bool isMandatory = true}) {
    RegExp regExp = RegExp(r'^[0-9]+$');
    if (value!.isEmpty) {
      return isMandatory ? 'Phone number is required' : null;
    } else if (value.length < 10) {
      return 'Please enter 10 digit number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  //************************************** Registration Phone Number Validator*********************************//

  static String? phoneValidatorRegistration(
    String? value, {
    bool isMandatory = true,
  }) {
    RegExp regExp = RegExp(r'^(\+91[\-\s]?)?[1234506789]\d{9}$');
    if (value!.isEmpty) {
      return isMandatory ? 'Phone number is required' : null;
    } else if (value.length < 10) {
      return 'Please enter 10 digit number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  //**************************************OTP Number Validator*********************************//

  static String? otpValidator(value) {
    if (value.length < 4) {
      return 'Please enter 4 digit OTP';
    }
    return null;
  }

  //**************************************PAN Card Validator*********************************//

  static String? panCardValidator(value, {bool isMandatory = false}) {
    RegExp regExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}');
    if (value.length == 0) {
      return isMandatory ? 'Pan Card is required' : null;
    } else if (value.length < 10) {
      return 'Please enter 10 pan card';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid pan card';
    }
    return null;
  }

  //**************************************Material Weight Validator*********************************//

  // static String? materialWeightValidator(value, {bool isMandatory = true, int? maxWeight}) {
  //   RegExp regExp = RegExp(r'^(([1-9]|1[0-6])(\.\d{1,2})?|17(\.0{1,2})?)$');

  //   if (value.length == 0) {
  //     return isMandatory ? 'Material weight is required' : null;
  //   } else if (!regExp.hasMatch(value)) {
  //     return '* $value Ton is not applicable for this truck type choose between 1 to 17 Tons';
  //   }
  //   return null;
  // }

  static String? materialWeightValidator(input,
      {bool isMandatory = true, int maxWeight = 17}) {
    String value = input.toString();
    RegExp regExp = RegExp(r'^[0-9]\d*(\.\d+)?$');

    if (!regExp.hasMatch(value)) {
      return "Invalid material weight.";
    }
    if (value != "") {
      double weight = double.parse(value);
      if (value.isEmpty) {
        return isMandatory ? 'Material weight is required' : null;
      } else if (weight <= 0 || weight > maxWeight) {
        // return 'Weight must be between 0 and $maxWeight';
        return "* $value Ton is not applicable for this truck type choose between 1 to $maxWeight Tons";
      }
    }
    return null;
  }

  //**************************************Card Name Validator*********************************//
  static String? cardNameValidator(value, {bool isMandatory = true}) {
    String patttern = r"^[a-z A-Z,.\-']+$";
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return isMandatory ? 'Please enter name' : null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid name';
    }
    return null;
  }

  //************************************** CVV Number Validator *********************************//

  static String? cvvValidator(String value) {
    if (value.isEmpty) {
      return 'CVV is required';
    } else if (value.length < 3) {
      return 'Please enter valid CVV';
    }
    return null;
  }

  //************************************** Card Expiry Validator *********************************//

  static String? cardExpValidator(String value) {
    String pattern = r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Expiry date is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid date';
    }
    return null;
  }

  //**************************************Card Number Validator*********************************//

  static String? cardNumberValidator(String input) {
    if (input.isEmpty) {
      return "Card number is required";
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      // No need to even proceed with the validation if it's less than 8 characters
      return "Invalid card number";
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "Invalid card number";
  }

  //**************************************Password Validator*********************************//

  static String? passwordValidator(value, {bool isMandatory = true}) {
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');

    if (value.length == 0) {
      return isMandatory ? 'Password is required' : null;
    } else if (value.length < 8) {
      return "Enter minimum 8 characters";
    } else if (!regExp.hasMatch(value)) {
      return 'Should contain at least a number,capital letter';
    }
    return null;
  }

  //**************************************Date Comparision Validator*********************************//
  static String? dateNotGrtValidator(String end, String start) {
    if (end.isNotEmpty && start.isNotEmpty) {
      var defaultEnd = DateFormat('MM/dd/yyyy').parse(end);
      var defaultStart = DateFormat('MM/dd/yyyy').parse(start);

      bool valDate = defaultEnd.isAfter(defaultStart);
      bool valDate2 = defaultEnd.isAtSameMomentAs(defaultStart);
      log(valDate2.toString());
      if (valDate2) {
        return null;
      } else if (!valDate) {
        return "Not valid";
      }
    }
    // if (end.isEmpty) {
    //   return 'Required';
    // }
    return null;
  }

  // //************************************** Confirm Password Validator *********************************//

  static String? confirmPasswordValidator(value, passValue) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value != passValue) {
      return 'Uh oh! Looks like the passwords didn\'t match.';
    }
    return null;
  }

  // //************************************** Select One Validator *********************************//

  static String? selectOneCheckBoxValidator(List<String>? value) {
    log(value.toString());
    if (value == null || value.isEmpty || value == []) {
      return "Please select at least one";
    }
    return null;
  }

  // //************************************** Select One Image Validator *********************************//

  static String? selectOneImageValidator(
      List<File?> value, List<String> apiImage) {
    if (value.isEmpty && apiImage.isEmpty) {
      return "Select atleast one image.";
    }
    return null;
  }

  static String getCleanedNumber(String input) {
    return input.replaceAll(" ", '');
  }

//************************************** Description Validator *********************************//

  static String? descriptionValidator(value, {bool isMandatory = true}) {
    String patttern = r"^(?:[a-z A-Z]|\P{L})+$";
    RegExp regExp = RegExp(patttern, unicode: true);

    if (value.length == 0) {
      return isMandatory ? 'Please enter service description' : null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter service description';
    } else if (quotesRegx.hasMatch(value)) {
      return quotesError;
    }
    return null;
  }
}
