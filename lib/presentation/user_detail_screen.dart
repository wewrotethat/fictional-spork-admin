import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/application/user_notifier.dart';

class UserDetailScreen extends ConsumerWidget {
  final String userId;
  const UserDetailScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<UserState>(userNotifierProvider, (previous, next) {
      if (next.error2 != null && previous?.error2 != next.error2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error2!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    final userNotifier = ref.watch(userNotifierProvider.notifier);
    final user = ref
        .watch(userNotifierProvider)
        .data
        .singleWhere((element) => element.id == userId);
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DetailRow(title: "First Name", value: user.firstName),
              DetailRow(title: "Last Name", value: user.lastName),
              DetailRow(title: "Email", value: user.email),
              DetailRow(title: "Phone Number", value: user.phoneNumber),
              DetailRow(
                  title: "Profile Verification Status",
                  value: user.profileVerificationStatus),
              DetailRow(
                  title: "Phone Verification Status",
                  value: user.phoneVerificationStatus),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => userNotifier.changeVerificationStatus(
                        userId, "VERIFIED"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      // minimumSize: const Size.fromHeight(50),
                    ),
                    child: ref.watch(userNotifierProvider).isLoading2
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Approve',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => userNotifier.changeVerificationStatus(
                          userId, "REJECTED"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        // minimumSize: const Size.fromHeight(40),
                      ),
                      child: ref.watch(userNotifierProvider).isLoading2
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            )),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(
          width: 20,
        ),
        Text(value)
      ],
    );
  }
}
