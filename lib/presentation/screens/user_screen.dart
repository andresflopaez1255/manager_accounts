import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:manager_accounts/presentation/widgets/users/form_edit/UsersModalController.dart';
import 'package:manager_accounts/presentation/widgets/users/users.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Usuarios',
                      style: AppTheme.textStyle['subtitle1'],
                    ),
                  ),
                  ButtonAdd(
                    onPressed: (() => UsersModalController.dialogUser(context)),
                  )
                ],
              ),
              const ListUsers(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListUsers extends StatelessWidget {
  const ListUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersListEvent) return;
        context.read<UsersBloc>().add(UsersListEvent());
      },
      builder: (context, state) {
        if (state is ListUsersData) {
          return state.list.isEmpty
              ? const ListSkeleton()
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.list.length,
                  itemBuilder: ((context, index) {
                    return CardUserList(
                      item: state.list[index],
                    );
                  }));
        }
        return const ListSkeleton();
      },
    );
  }
}
