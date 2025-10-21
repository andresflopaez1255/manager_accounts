import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';
import 'package:manager_accounts/presentation/widgets/users/CardUserList.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersBloc>().add(UsersListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is ListUsersData) {
          if (state.list.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no-results.png',
                    width: 95,
                    height: 95,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No tienes usuarios registrados",
                    style: AppTheme.textStyle["subtitle1"]
                        ?.copyWith(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            );
          }
          return ListView.builder(
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
        return ListSkeleton(
          child: CardUserList(
              item: UsersResponse(
                  id: '',
                  nameUser: '',
                  cellphoneUser: '',
                  emailUser: '',
                  accounts: [])),
        );
      },
    );
  }
}
