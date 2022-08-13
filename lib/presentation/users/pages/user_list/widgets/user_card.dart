import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:e2e_application/utils/mixins/router_helper.dart';
import 'package:e2e_application/utils/utils_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCard extends StatelessWidget with RouterHelper {
  UserCard({super.key, required this.user});

  final User user;
  late final UserListBloc userListBloc;

  @override
  Widget build(BuildContext context) {
    userListBloc = context.read<UserListBloc>();

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(user.name,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => goUserForm(context, userId: user.id ?? 0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      UtilsHelper.showConfirmationDialog(
                          context,
                          title: 'Please Confirm',
                          description: 'Are you sure to remove ${user.name} ?',
                          onSuccess: () {
                            Navigator.of(context).pop();
                            userListBloc.add(DeleteUser(user: user));
                            final snackBar = SnackBar(
                              content: Text("${user.name}  deleted"),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          onFailure: ()=> Navigator.of(context).pop(),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
