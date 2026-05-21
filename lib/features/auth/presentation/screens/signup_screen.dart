// signup_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

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
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 460,
                  ),
                  child: Column(
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
                          Icons.person_add_alt_1_rounded,
                          size: 42,
                          color: theme
                              .colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Create Account',
                        style: theme
                            .textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Join the platform and start managing service requests with ease.',
                        textAlign:
                            TextAlign.center,
                        style: theme
                            .textTheme.bodyMedium
                            ?.copyWith(
                              height: 1.5,
                            ),
                      ),

                    const SizedBox(height: 16),

                      Container(
                        padding:
                           const EdgeInsets.all(24),
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
                                  nameController,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Full Name',
                                hintText:
                                    'Enter your name',
                                prefixIcon: Icon(
                                  Icons
                                      .person_outline_rounded,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

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
                              height: 16,
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
                                    'Create a password',
                                prefixIcon: Icon(
                                  Icons
                                      .lock_outline_rounded,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            TextField(
                              controller:
                                  confirmPasswordController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Confirm Password',
                                hintText:
                                    'Re-enter password',
                                prefixIcon: Icon(
                                  Icons
                                      .lock_reset_rounded,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            SizedBox(
                              width: 190,
                              height: 54,
                              child:
                                  ElevatedButton(
                                onPressed: () {
                                  context.go(
                                    '/role-selection',
                                    extra: {
                                      'name':
                                          nameController
                                              .text
                                              .trim(),
                                      'email':
                                          emailController
                                              .text
                                              .trim(),
                                      'password':
                                          passwordController
                                              .text
                                              .trim(),
                                    },
                                  );
                                },
                                child: const Text(
                                  'Continue',
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
                            'Already have an account?',
                            style: theme
                                .textTheme
                                .bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(
                                '/login',
                              );
                            },
                            child: const Text(
                              'Log In',
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