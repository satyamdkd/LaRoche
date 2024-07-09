import 'package:get_it/get_it.dart';
import 'package:laroch/module/home/bloc/home_bloc.dart';
import 'package:laroch/utils/helper/sharedpref.dart';

final locator = GetIt.instance;

setUp() => locator.registerSingleton<Controller>(Controller());

final homeController = locator.get<Controller>();
final myUserToken = locator.get<SharedPref>(instanceName: SharedPref.getUserDetails()?['data']['token']);
