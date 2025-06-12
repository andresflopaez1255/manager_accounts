import 'package:flutter/material.dart';

import '../../utils/config/config.dart';
import '../widgets/accounts/accounts.dart';
import '../widgets/commons/commons.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      'Cuentas registradas',
                      textAlign: TextAlign.left,
                      style: AppTheme.textStyle['subtitle1'],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/accountForm');
                      },
                      icon: const Icon(Icons.add_circle, size: 25,)),
                ],
              ),
              const ListAccounts()
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
