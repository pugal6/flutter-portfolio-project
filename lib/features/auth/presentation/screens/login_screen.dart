// login_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/features/auth/data/repository/auth_repository.dart';

import '../../../../shared/enums/user_role.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final AuthRepository authRepository = AuthRepository();

  bool isLoading = false;

  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });

      final role = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      if (role == UserRole.homeowner) {
        context.go('/homeowner');
      } else {
        context.go('/professional');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            e.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF4F7FF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
  horizontal:
      MediaQuery.of(context).size.width < 700
          ? 20
          : 240,
  vertical: 26,
),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: theme
                              .colorScheme.primary
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons
                              .home_repair_service_rounded,
                          size: 42,
                          color: theme
                              .colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Welcome Back',
                        style: theme
                            .textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Login to manage your jobs and connect with professionals.',
                        textAlign:
                            TextAlign.center,
                        style: theme
                            .textTheme.bodyMedium
                            ?.copyWith(
                              height: 1.5,
                            ),
                      ),

                      const SizedBox(height: 36),

                      Container(
                        padding:
                            const EdgeInsets.all(
                          28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                            28,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                0.05,
                              ),
                              blurRadius: 30,
                              offset:
                                  const Offset(
                                0,
                                12,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller:
                                  emailController,
                              keyboardType:
                                  TextInputType
                                      .emailAddress,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Email',
                                hintText:
                                    'Enter your email',
                                prefixIcon: Icon(
                                  Icons
                                      .email_outlined,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            TextField(
                              controller:
                                  passwordController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Password',
                                hintText:
                                    'Enter your password',
                                prefixIcon: Icon(
                                  Icons
                                      .lock_outline_rounded,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            SizedBox(
                              height: 54,
                              width: 180,
                              child:
                                  ElevatedButton(
                                onPressed:
                                    isLoading
                                        ? null
                                        : login,
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height:
                                            22,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth:
                                              2.5,
                                          color: Colors
                                              .white,
                                        ),
                                      )
                                    : const Text(
                                        'Login',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: theme
                                .textTheme
                                .bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(
                                '/signup',
                              );
                            },
                            child: const Text(
                              'Sign Up',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}