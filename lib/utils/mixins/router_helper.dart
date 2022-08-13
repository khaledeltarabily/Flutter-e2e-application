import 'package:e2e_application/presentation/users/bloc/user_form/user_form_bloc.dart';
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:e2e_application/presentation/users/pages/user_form/user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e2e_application/di.dart' as di;

mixin RouterHelper {
  void goUserForm(BuildContext context, {int? userId}) {
    Navigator.of(context).push(
      MaterialPageRoute<UserFormScreen>(
        builder: (_) {
          return MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<UserFormBloc>(
                create: (_) => (di.sl<UserFormBloc>()
                  ..add(userId != null
                      ? GetUser(userId: userId)
                      : CreateUserForm())),
              ),
              BlocProvider<UserListBloc>.value(
                value: context.read<UserListBloc>(),
              ),
            ],
            child: UserFormScreen(userId: userId),
          );
        },
      ),
    );
  }
}
