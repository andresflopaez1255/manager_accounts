import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:manager_accounts/presentation/widgets/users/form_edit/UsersModalController.dart';
import 'package:manager_accounts/presentation/widgets/users/users.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors['background'],
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

class ListUsers extends StatefulWidget {
  const ListUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late final UsersBloc userBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userBloc = Injector.appInstance.get<UsersBloc>();
    userBloc.add(UsersListEvent());
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UsersBloc, UsersState>(
      bloc: userBloc,
      listener: (context, state) {
       if(state is UsersListEvent) return ;
       userBloc.add(UsersListEvent());
      },
      builder: (context, state) {
        if(state is ListUsersData){
          return state.list.isEmpty ? const ListSkeleton():ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: ((context, index) {
              return  CardUserList(item: state.list[index],);
            }));
        }
        return const ListSkeleton();
      },
    );
  }
}
