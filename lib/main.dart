
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:e2e_application/presentation/users/pages/user_list/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di.dart' as di;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  final Color blue = const Color(0xff0456e2);
  final Color green = const Color(0xff007B5E);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserListBloc>(
      create: (_) => di.sl<UserListBloc>()..add(GetUsers()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          snackBarTheme: const SnackBarThemeData().copyWith(
            actionTextColor: Colors.white,
            contentTextStyle: const TextStyle(color: Colors.white) ,
          ),
          appBarTheme: const AppBarTheme().copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black12
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            primary: blue,
            secondary: green,
          ),
        ),
        home: const UserListScreen(),
      ),
    );
  }
}