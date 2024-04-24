import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/accounts/list/list_skeleton.dart';
import 'package:manager_accounts/utils/config/config.dart';

class ListAccounts extends StatelessWidget {
  const ListAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
      if (state is DataListEvent) return;

      context.read<AccountBloc>().add(DataListEvent());
    }, builder: (context, state) {
      if (state is DataListAccount) {
        return state.list.isEmpty
            ? Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no-results.png',
                      width: 95.w,
                      height: 95.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "No tienes cuentas registradas",
                      style: AppTheme.textStyle["subtitle1"]
                          ?.copyWith(color: Colors.black, fontSize: 18.sp),
                    )
                  ],
                ),
              )
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
