import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' hide Builder;
import 'package:manager_accounts/data/bloc/account_bloc.dart';
import 'package:manager_accounts/data/bloc/account_state.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../utils/config/config.dart';
import '../widgets/accounts/accounts.dart';
import '../widgets/commons/commons.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors['background'],
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Cuentas registradas',
                      style: AppTheme.textStyle['subtitle1'],
                    ),
                  ),
                  ButtonAdd(
                    onPressed: (() =>
                        Navigator.pushNamed(context, '/accountForm')),
                  )
                ],
              ),
              ListAccounts()
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable

