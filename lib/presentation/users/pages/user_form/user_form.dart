import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/presentation/users/bloc/user_form/user_form_bloc.dart';
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:e2e_application/utils/shared_widgets/error_widget.dart';
import 'package:e2e_application/utils/shared_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFormScreen extends StatefulWidget {
  final int? userId;

  const UserFormScreen({super.key,required this.userId});

  @override
  UserFormScreenState createState() => UserFormScreenState();
}

class UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late UserListBloc userListBloc;
  late UserFormBloc userFormBloc;

  String name = '';
  String userName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    userListBloc = context.read<UserListBloc>();
    userFormBloc = context.read<UserFormBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userId != null? "Edit":"Add" } User',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<UserFormBloc, UserFormState>(
              listenWhen: (_, state) {
                return state is Success;
              },
              listener: (context, state) {
                if(state is Success){
                  if (state.successMessage.isNotEmpty) {
                    final snackBar = SnackBar(
                      content: Text(state.successMessage),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  userListBloc.add(GetUsers());
                  Navigator.pop(context);
                }
              },
              child: BlocBuilder<UserFormBloc, UserFormState>(
                  builder: (_, state) {
                if (state is Loaded) {
                  final User user = state.user;
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            maxLength: 40,
                            textInputAction: TextInputAction.next,
                            initialValue: user.name,
                            onSaved: (value) => name = value?.trim() ?? '',
                            validator: (value) {
                              if (value == null|| value.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              if (value.length < 2) {
                                return 'Name must be at least 2 characters';
                              }
                              return null;
                            }),
                        TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            initialValue: user.username,
                            maxLength: 40,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) => userName = value?.trim() ?? '',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username cannot be empty';
                              }
                              if (value.length < 4) {
                                return 'Username must be at least 4 characters';
                              }
                              return null;
                            }),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            initialValue: user.email,
                            maxLength: 60,
                            textInputAction: TextInputAction.done,
                            onSaved: (value) => email = value?.trim() ?? '',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              return null;
                            },),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState?.save();
                            final userData = User(
                              id: user.id,
                              email: email,
                              username: userName,
                              name: name,
                            );
                            userFormBloc.add(user.id == null
                                ? CreateUser(user: userData)
                                : UpdateUser(user: userData));
                          },
                        )
                      ],
                    ),
                  );
                }
                if (state is Error) {
                  return error(state.errorMessage);
                }
                return loading();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
