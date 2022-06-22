import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/application/user_notifier.dart';
import 'package:fictional_spork/presentation/user_detail_screen.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UsersListScreenState();
}

class _UsersListScreenState extends ConsumerState<UsersListScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(userNotifierProvider.notifier).getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usersListState = ref.watch(userNotifierProvider);
    if (usersListState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (usersListState.error != null) {
      return Scaffold(
        body: Center(
          child: Text(usersListState.error!),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(userNotifierProvider.notifier).getUsers();
          },
          child: ListView.builder(
              itemCount: usersListState.data.length,
              itemBuilder: ((context, index) {
                final user = usersListState.data[index];
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(userId: user.id),
                    ),
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text(user.email),
                  trailing: Text(user.profileVerificationStatus),
                );
              })),
        ),
      ),
    );
  }
}
