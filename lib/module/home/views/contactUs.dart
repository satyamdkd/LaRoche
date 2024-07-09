import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/theme_helper.dart';
import '../../../utils/widgets/appbar.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Contact Us",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('''
Corporate Head Office:
Plot 64A, Amuwo Odofin Commercial Scheme,

Oshodi/Apapa Expressway, Lagos

Showroom : +234 908 270 0826
Victoria Island Office:
1224, Bishop Oluwole street, Victoria Island, Lagos

Showroom : +234 1 454 3556
 
For more information, you can call or email us at
Office : +234 810 099 1165
info@larochenigeria.com
Customer Service : +234 909 655 5013
customerservices@larochenigeria.com''',style: TextStyle(color: Colors.black),),
          ),
        ),
      ),
    );
  }
}
