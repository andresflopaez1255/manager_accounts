import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:manager_accounts/data/bloc/account_bloc.dart';
import 'package:manager_accounts/data/bloc/account_state.dart';
import 'package:manager_accounts/data/bloc/bloc_event.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';

class ListAccounts extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  late final AccountBloc bloc;
  ListAccounts({super.key}) {
    bloc = Injector.appInstance.get<AccountBloc>();
  }

  @override
  State<ListAccounts> createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  @override
  void initState() {
  
     widget.bloc.add(DataListEvent());
   
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if(state is DataListEvent) return ;

          widget.bloc.add(DataListEvent());
      },
        bloc: widget.bloc,
         
        builder: (context, state) {
          if (state is DataListAccount) {

            return state.list.isEmpty
                ? const ListSkeleton()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardAccount(item: state.list[index]);
                    });
          }
          return const ListSkeleton();
        });
  }
}
