import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:e2e_application/presentation/users/pages/user_list/widgets/user_card.dart';
import 'package:e2e_application/utils/mixins/router_helper.dart';
import 'package:e2e_application/utils/shared_widgets/error_widget.dart';
import 'package:e2e_application/utils/shared_widgets/loading_widget.dart';
import 'package:e2e_application/utils/shared_widgets/no_data_widget.dart';
import 'package:e2e_application/utils/utils_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> with RouterHelper {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late final UserListBloc userListBloc;

  final TextEditingController _searchController = TextEditingController();

  bool hasData = false;

  @override
  void initState() {
    super.initState();
    userListBloc = context.read<UserListBloc>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: _searchController,
            autocorrect: false,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (_)=> userListBloc.add(
              GetUsers(query: _searchController.text),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => userListBloc.add(
                    GetUsers(query: _searchController.text),
                ),
              ),
              hintText: 'Search...',
            ),
          ),
          actions: <IconButton>[
            IconButton(
              onPressed: () {
                if (!hasData) {
                  const snackBar = SnackBar(
                    content: Text("No Data to Delete"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                UtilsHelper.showConfirmationDialog(
                    context,
                    title: 'Please Confirm',
                    description: 'Are you sure to remove All Users?',
                    onSuccess: () {
                      Navigator.of(context).pop();
                      userListBloc.add(DeleteAllUsers());
                    },
                  onFailure: ()=> Navigator.of(context).pop(),
                );
              },
              icon: const Icon(Icons.delete_outline_rounded),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => goUserForm(context),
        ),
        body: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              userListBloc.add(GetUsers());
            },
            child: BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
              if (state is UsersLoaded) {
                hasData = state.users.isNotEmpty;
                return Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: (hasData
                        ? ListView.builder(
                            padding: const EdgeInsets.only(top: 25),
                            itemCount: state.users.length,
                            itemBuilder: (_, index) {
                              User user = state.users[index];
                              return UserCard(user: user);
                            },
                          )
                        : const NoData()));
              }
              if (state is Failure) {
                return error(state.errorMessage);
              }
              return loading();
            }),
          ),
        ));
  }

}
