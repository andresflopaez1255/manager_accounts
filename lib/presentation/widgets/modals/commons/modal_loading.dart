import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/config.dart';

OverlayEntry? overlayEntry;
void showLoading(BuildContext context) {
  overlayEntry = OverlayEntry(
    maintainState: true,
    opaque: false,
    builder: (context) {
      return const OverlayLoadingWidget();
    },
  );
  Overlay.of(context).insert(overlayEntry!);
}

void hideLoading(BuildContext context) {
  overlayEntry?.remove();
  overlayEntry = null;
}

class OverlayLoadingWidget extends StatelessWidget {
  const OverlayLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loading_app.gif',
              width: 200,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 31,
              ),
              child: Center(
                child: Text(
                  "Por favor espere, estamos ejecutando su acción",
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle['subtitle1']?.copyWith(
                      color: AppTheme.colors['primary'],
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
