import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';

class ListAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
      if (state is DataListEvent) return;

      context.read<AccountBloc>().add(DataListEvent());
    }, builder: (context, state) {
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
