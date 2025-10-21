import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String text;
  const ColumnText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          title,
          style: AppTheme.textStyle['bodyText2'],
          overflow: TextOverflow.clip,
        ),
        const SizedBox(height: 3),
        Text(
          text,
          style: AppTheme.textStyle['bodyText1']?.copyWith(fontSize: 12.sp),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
