import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laroch/module/address/view/address.dart';
import 'package:laroch/module/auth/view/forgot.dart';
import 'package:laroch/module/auth/view/login.dart';
import 'package:laroch/module/auth/view/register.dart';
import 'package:laroch/module/cart/view/cart.dart';
import 'package:laroch/module/details/view/details.dart';
import 'package:laroch/module/home/views/home.dart';
import 'package:laroch/module/my_account/view/my_account.dart';
import 'package:laroch/module/my_orders/view/my_orders.dart';
import 'package:laroch/module/notification/view/notification.dart';
import 'package:laroch/module/splash/view/splash.dart';
import 'package:laroch/module/track_order/view/track_order.dart';

abstract class Routes {
  Routes._();
  static const home = '/home';
  static const splash = '/splash';
  static const address = '/address';
  static const cart = '/cart';
  static const details = '/details';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgotPassword';
  static const account = '/account';
  static const orders = '/orders';
  static const notifications = '/notifications';
  static const trackOrder = '/trackOrder';
  static const changePassword = '/changePassword';
}

abstract class RouteName {
  RouteName._();
  static const home = 'home';
  static const splash = 'splash';
  static const address = 'address';
  static const cart = 'cart';
  static const details = 'details';
  static const login = 'login';
  static const register = 'register';
  static const forgotPassword = 'forgotPassword';
  static const account = 'account';
  static const orders = 'orders';
  static const notifications = 'notifications';
  static const trackOrder = 'trackOrder';
  static const changePassword = 'changePassword';
}

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.splash,
  observers: [HeroController()],
  routes: [
    GoRoute(
      name: RouteName.splash,
      path: Routes.splash,
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      name: RouteName.home,
      path: Routes.home,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      name: RouteName.address,
      path: Routes.address,
      builder: (context, state) =>  Address( setStateCallbackFromAddressPage:
      (){},),
    ),
    GoRoute(
      name: RouteName.cart,
      path: Routes.cart,
      builder: (context, state) => const Cart(),
    ),
    GoRoute(
      name: RouteName.details,
      path: Routes.details,
      builder: (context, state) => const Details(),
    ),
    GoRoute(
      name: RouteName.login,
      path: Routes.login,
      builder: (context, state) => const Login(),
    ),
    GoRoute(
        name: RouteName.register,
        path: Routes.register,
        builder: (context, state) => const Register()),
    GoRoute(
        name: RouteName.forgotPassword,
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPassword()),
    GoRoute(
      name: RouteName.account,
      path: Routes.account,
      builder: (context, state) => const MyAccount(),
    ),
    GoRoute(
      name: RouteName.notifications,
      path: Routes.notifications,
      builder: (context, state) => const Notifications(),
    ),
    GoRoute(
      name: RouteName.orders,
      path: Routes.orders,
      builder: (context, state) => const MyOrders(),
    ),
    GoRoute(
      name: RouteName.trackOrder,
      path: Routes.trackOrder,
      builder: (context, state) => const TrackOrder(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
      body: Center(
          child: Text(
    state.error.toString(),
  ))),
);
