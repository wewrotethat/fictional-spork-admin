import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fictional_spork/application/auth_notifier.dart';
import 'package:fictional_spork/presentation/users_list_screen.dart';
import 'package:fictional_spork/presentation/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool value = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (!next.isLoading && next.data != null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const UsersListScreen()));
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFede7f1),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                labelText: "email",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordController,
                obscureText: true,
                // contentPadding: EdgeInsets.all(10),
                labelText: 'Password',
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).reset();
                    authNotifier.login(
                        emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[700],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: ref.watch(authNotifierProvider).isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : const Text("Log In")),
            ],
          ),
        ),
      ),
    );
  }
}
