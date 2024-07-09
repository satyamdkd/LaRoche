import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/theme_helper.dart';
import '../../../utils/widgets/appbar.dart';
class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Privacy Policy",
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
            child: Text('''OVERVIEW 
This app is operated by La Roche Equipment LTD, Nigeria. Throughout the site, the terms “we”, “us” and “our” refer to La Roche. La Roche offers this app, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here. 

By visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions, including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content. 

Please read these Terms of Service carefully before accessing or using our app. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the app or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service. 

Any new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our app. It is your responsibility to check this page periodically for changes. Your continued use of or access to the app following the posting of any changes constitutes acceptance of those changes. 

 

SECTION 1 - ONLINE STORE TERMS 
By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site. 
You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws). 
You must not transmit any worms or viruses or any code of a destructive nature. 
A breach or violation of any of the Terms will result in an immediate termination of your Services and you may be criminally liable depending on the nature of Infraction. 

SECTION 2 - GENERAL CONDITIONS 
We reserve the right to refuse service to anyone for any reason at any time. 
You understand that your content (not including credit card information), may be transferred unencrypted and involve

transmissions over various networks;
and changes to conform and adapt to technical requirements of connecting networks or devices.
Credit card information is always encrypted during transfer over networks. 
You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the app through which the service is provided, without express written permission by us. 
 

SECTION 3 - ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION 
We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk. 
This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site. 

SECTION 4 - MODIFICATIONS TO PRICES 
Prices for our products are subject to change without notice. 

We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service. 

SECTION 5 - PRODUCTS OR SERVICES (if applicable) 
Certain products or services may be available exclusively online through the app. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy. 
We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor's display of any color will be accurate. 

Certain products (fragile and high weighted) are to be collected only from La Roche warehouse in Amuwo, Lagos State and not subject for delivery. They will be clearly highlighted in the order summary.
We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited. 
We do not warrant beyond the warranties granted or given by the manufactures that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations.

SECTION 6 - ACCURACY OF BILLING AND ACCOUNT INFORMATION 
We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e‑mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors. 

You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed. 
 

SECTION 7 - PERSONAL INFORMATION 
Your submission of personal information through the store is governed by our Privacy Policy.
 

SECTION 8 - REFUND AND RETURN

At La Roche, customer satisfaction is our priority as we offer replacement of defective products that has been purchased from us. However, we have rules and guidelines relating to the return of products purchased from our app.

We offer returns and repairs of damaged products according to the provisions of the law.

Returns are issued at our discretion as we may reject, replace or repair damaged products. 
 

SECTION 9 - ENTIRE AGREEMENT 
The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision. 
These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service). 
Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party. 

SECTION 10 - GOVERNING LAW 
These Terms and conditions and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the laws of Nigeria. 

SECTION 11 - CHANGES TO TERMS OF SERVICE 
You can review the most current version of the Terms and conditions at any time at this page. 
We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our app. It is your responsibility to check our app periodically for changes. Your continued use of or access to our app or the Service following the posting of any changes to these Terms and conditions  constitutes acceptance of those changes.

 
SECTION 12 - CONTACT INFORMATION 

Contact us 
For more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e‑mail at customerservices@larochenigeria.com.''',style: TextStyle(color: Colors.black),),
          ),
        ),
      ),
    );
  }
}
