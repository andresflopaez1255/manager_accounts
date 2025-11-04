import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class InfoAccountContent extends StatelessWidget {
  final String title;
  final String content;
  const InfoAccountContent({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final defaultStyle = DefaultTextStyle.of(context).style;

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(
            text: title,
            style: AppTheme.textStyle['bodyText2']
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13.h),
          ),
          TextSpan(
            text: " $content",
            
          ),
        ],
      ),
    );
  }
}