import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/utils/config/config.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final double? width;
  final Color? background;
  // ignore: prefer_typing_uninitialized_variables
  final double? height;

  const Button({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.title = '',
    this.background,
    this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final backgroundButton = background ?? AppTheme.colors['primary'];

    return SizedBox(
        width: width ?? double.infinity,
        height: height ?? 40,
        child: ElevatedButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              )),
              backgroundColor:
                  WidgetStateProperty.all<Color>(backgroundButton!),
            ),
            child: Text(title,
                style: textStyle ??
                    AppTheme.textStyle['subtitle2']
                        ?.copyWith(color: Colors.white, fontSize: 14.sp))));
  }
}
