import 'dart:async';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/utils/helper/sharedpref.dart';

import '../../../routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToPage();
  }

  navigateToPage() async {
    var userExist = SharedPref.getToken();
    Timer(const Duration(seconds: 2), () {
      userExist != null
          ? GoRouter.of(context).go(Routes.home)
          : GoRouter.of(context).go(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/splash_screen.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
