import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/widgets/commons/SubtitleHeader.dart';

import '../widgets/accounts/accounts.dart';

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
              SubtitleHeader(
                title: "Cuentas Registradas",
                onPress: () {
                  Navigator.pushNamed(context, '/accountForm');
                },
              ),
              const ListAccounts()
            ],
          ),
        ),
      ),
    );
  }
}
