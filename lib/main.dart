import 'dart:io';

import 'package:bbigfood/states/add_food.dart';
import 'package:bbigfood/states/authen.dart';
import 'package:bbigfood/states/buyer_service.dart';
import 'package:bbigfood/states/create_account.dart';
import 'package:bbigfood/states/edit_information_buyer.dart';
import 'package:bbigfood/states/edit_information_seller.dart';
import 'package:bbigfood/states/seller_servive.dart';
import 'package:bbigfood/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/sellerService': (BuildContext context) => SellerService(),
  '/addFood': (BuildContext context) => AddFood(),
  '/editInformationSeller': (BuildContext context) => EditInformationSeller(),
  '/editInformationBuyer': (BuildContext context) => EditInformationBuyer(),
};

String? initlalRoute;

Future<Null> main() async {

  HttpOverrides.global = MyHttpOvverrider();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlalRoute = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initlalRoute = MyConstant.routeSellerService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xff0088a3, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}

class MyHttpOvverrider extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
