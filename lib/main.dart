import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/categories/categories_bloc.dart';
import 'package:manager_accounts/data/bloc/settings/settings_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/repositories_impl/accounts_repository_impl.dart';
import 'package:manager_accounts/data/repositories_impl/categories_repository_impl.dart';
import 'package:manager_accounts/data/repositories_impl/users_repository_impl.dart';
import 'package:manager_accounts/domain/repository/firebase_notification_repository.dart';
import 'package:manager_accounts/presentation/screens/screens.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/utils/config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await FirebaseNotificationRepository().flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.actionId == 'whatsapp') {
        final phone = response.payload ?? '';
        debugPrint("tel: $phone");
        if (phone.isNotEmpty) {
          final url = Uri.parse('https://wa.me/+57$phone');
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
      }
    },
  );


  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  void initState() {
    super.initState();
     FirebaseNotificationRepository().initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AccountsRepositoryImpl(httpClient: HttpClient()),
        ),
        RepositoryProvider(
          create: (context) => UsersRespositoryImpl(httpClient: HttpClient()),
        ),
        RepositoryProvider(
            create: (context) =>
                CategoriesRepositoryImpl(httpClient: HttpClient())),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => AccountBloc(
                accountRepository: context.read<AccountsRepositoryImpl>())),
        BlocProvider(
            create: (context) =>
                UsersBloc(repository: context.read<UsersRespositoryImpl>())),
        BlocProvider(
            create: (context) => SettingsBloc()..add(GetThemeStatus())),
        BlocProvider(create: (context) => CategoriesBloc(categoriesRepository: context.read<CategoriesRepositoryImpl>())),
      ], child: const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SetStateStyleMode) {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) => MaterialApp(
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: const [
                          Locale('es', 'ES'), // Español
                          Locale('en', 'US'), // Inglés
                        ],
                        debugShowCheckedModeBanner: false,
                        title: 'Eliane App',
                        theme: state.theme,
                        home: const HomeScreen(),
                        initialRoute: '/splash',
                        routes: routes,
                      ));
            }
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) => MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Eliane App',
                      theme: AppTheme.appTheme,
                      home: const HomeScreen(),
                      initialRoute: '/splash',
                      routes: routes,
                    ));
          },
        );
      },
    );
  }
}
