import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class SubtitleHeader extends StatelessWidget {
  const SubtitleHeader({
    Key? key,
    required this.title,
    this.onPress,
  }) : super(key: key);

  final String title;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: AppTheme.textStyle['subtitle1']?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.add_circle,
              size: 30,
              color: AppTheme.colors["primary"],
            )),
      ],
    );
  }
}

