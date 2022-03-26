import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'B.Big Food';
  static String domain = 'https://6618-2001-fb1-142-4a0b-c839-61e0-4949-9ff0.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSellerService = '/sellerService';
  static String routeAddFood = '/addFood';
  static String routeEditInformationSeller = '/editInformationSeller';
  static String routeEditInformationBuyer = '/editInformationBuyer';

  // Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String avatar = 'images/avatar.png';

  // Color
  static Color primary = Color(0xff00b8d4);
  static Color dart = Color(0xff0088a3);
  static Color light = Color(0xff62ebff);
  static Map<int, Color> mapMaterialColor = {
    50:Color.fromRGBO(0, 136, 163, 0.1),
    100:Color.fromRGBO(0, 136, 163, 0.2),
    200:Color.fromRGBO(0, 136, 163, 0.3),
    300:Color.fromRGBO(0, 136, 163, 0.4),
    400:Color.fromRGBO(0, 136, 163, 0.5),
    500:Color.fromRGBO(0, 136, 163, 0.6),
    600:Color.fromRGBO(0, 136, 163, 0.7),
    700:Color.fromRGBO(0, 136, 163, 0.8),
    800:Color.fromRGBO(0, 136, 163, 0.9),
    900:Color.fromRGBO(0, 136, 163, 1.0),
    
  };

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dart,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dart,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );
      TextStyle h3redStyle() => TextStyle(
        fontSize: 14,
        color: Colors.red.shade700,
        fontWeight: FontWeight.normal,
      );
      TextStyle h3Whitew700Style() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
