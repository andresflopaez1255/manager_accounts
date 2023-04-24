// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Map<String, Color> colors = {
    'primary': Color(0xffAB3C4B),
    'background': Color(0xffFFFFFF),
    'secondaryColorButton': Color(0xff2B82AB),
    'black': Color(0xff000000),
    'secondary': Color(0xff656363),
    'blue_secondary':  Color(0xFF1C495E)
  };
  
  static final appTheme = ThemeData(
    primaryColor: colors['primary'],
    appBarTheme: AppBarTheme(backgroundColor: colors['primary']),
  );

 static final textStyle = {
     'subtitle1':   TextStyle(
      fontFamily: 'Montaga',
      fontSize: 14.sp,
    ),
    'subtitle2':  TextStyle(
      fontFamily: 'Montaga',
      fontWeight: FontWeight.w900,
      fontSize: 18.sp,
      color:  colors['primary'],
    ),
     'titleModal':   TextStyle(
      fontFamily: 'MontaguSlab',
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color:  Colors.black,
    ),
    'button':  TextStyle(
      fontFamily: 'Montaga',
      fontSize: 10.sp,
      color: Colors.white
    ),
     'bodyText1':  TextStyle(
        fontFamily: 'MontaguSlab',  fontSize: 15.sp),
    'bodyText2':  TextStyle(
      fontFamily: 'MontaguSlab',
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      color: const Color(0xffAB3C4B),
    ),
    'bodyText3':  TextStyle(
      fontFamily: 'MontaguSlab',
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: const Color(0xFF1C495E),
    ),
    'bigTitle':  TextStyle(
      fontFamily: 'MontaguSlab',
      fontWeight: FontWeight.bold,
      fontSize: 34.sp,
      color:  Colors.white,
    ),
    'smallText': TextStyle(
      fontFamily: 'MontaguSlab',
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color:  colors['secondary'],
    )
   };
  // ignore: prefer_const_constructors
  
}
