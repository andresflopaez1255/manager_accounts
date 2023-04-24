import 'package:injector/injector.dart';
import 'package:manager_accounts/data/bloc/account_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/repositories_impl/accounts_repository_impl.dart';
import 'package:manager_accounts/data/repositories_impl/users_repository_impl.dart';
import 'package:manager_accounts/domain/repository/accounts_repository.dart';
import 'package:manager_accounts/domain/repository/users_repository.dart';

class Register {
  void regist (){
    final injector = Injector.appInstance;
    injector.registerDependency<HttpClient>(() => HttpClient());
    //accounts
    injector.registerDependency<AccountsRepository>(() => AccountsRepositoryImpl(httpClient:  injector.get<HttpClient>() ));
    injector.registerSingleton<AccountBloc>(() => AccountBloc(accountRepository: injector.get<AccountsRepository>()));
    //users 
    injector.registerDependency<UsersRepository>(() => UsersRespositoryImpl(httpClient: injector.get<HttpClient>()));
    injector.registerSingleton<UsersBloc>(() => UsersBloc(repository: injector.get<UsersRepository>()));

  }
  
}