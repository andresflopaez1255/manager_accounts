// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Map<String, Color> colors = {
    'primary': Color(0xffAB3C4B),
    'background': Color(0xffFFFFFF),
    'secondaryColorButton': Color(0xff0D9593),
    'black': Color(0xff000000),
    'secondary': Color(0xff656363),
    'blue_secondary': Color(0xFF1C495E)
  };

  static final textStyle = {
    'subtitle1': TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.sp,
    ),
    'subtitle2': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w900,
      fontSize: 16.sp,
      color: colors['primary'],
    ),
    'titleModal': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color: Colors.black,
    ),
    'button':
        TextStyle(fontFamily: 'Inter', fontSize: 10.sp, color: Colors.white),
    'bodyText1': TextStyle(fontFamily: 'Inter', fontSize: 15.sp),
    'bodyText2': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      color: const Color(0xffAB3C4B),
    ),
    'bodyText3': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: const Color(0xFF1C495E),
    ),
    'bigTitle': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      fontSize: 34.sp,
      color: Colors.white,
    ),
    'smallText': TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: colors['secondary'],
    )
  };

  static final appTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: colors['primary'],
    colorScheme: const ColorScheme.light(primaryContainer: Colors.black),
    appBarTheme: AppBarTheme(backgroundColor: colors['primary']),
     expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.black,
      iconColor: Colors.black,
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      ),
      headerBackgroundColor: colors['primary'],
      dayStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14.sp,
        color: colors['background'],
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        iconColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(70, 223, 223, 233)),
      ),
    ),
  );
  static final appThemeDark = ThemeData(
    useMaterial3: false,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    primaryColor: colors['primary'],
    colorScheme: const ColorScheme.dark(primaryContainer: Colors.white),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    //theme date picker
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      headerBackgroundColor: colors['primary'],
      dayStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14.sp,
        color: colors['background'],
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors['secondary'], // Fondo de los inputs
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        borderSide: BorderSide(
          color: colors['secondary']!, // Color del borde
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: colors['secondary']!, // Color del borde
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: colors['secondary']!, // Color del borde
          width: 1.0,
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14.sp,
        color: Colors.grey[700], // Color del texto del label
      ),
      hintStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14.sp,
        color: Colors.grey[500], // Color del texto del hint
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
    ),
    //buttomtext theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        iconColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(70, 223, 223, 233)),
      ),
    ),

    //textfield theme

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        unselectedIconTheme: const IconThemeData(color: Colors.white)),
  );

  // ignore: prefer_const_constructors
}
