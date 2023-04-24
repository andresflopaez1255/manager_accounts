import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/config.dart';

class OutlineBtn extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final double? width;
  final Color? background;
  // ignore: prefer_typing_uninitialized_variables
  final double? height;

  const OutlineBtn({
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

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(color: AppTheme.colors['blue_secondary']!, width: 2, style: BorderStyle.solid),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
        ),
        child: Text(
          title,
          style: textStyle ??
              AppTheme.textStyle['subtitle2']
                  ?.copyWith(color:  AppTheme.colors['blue_secondary']),
        ),
      ),
    );
  }
}
