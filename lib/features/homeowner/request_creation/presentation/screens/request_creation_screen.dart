// request_creation_screen.dart

import 'package:flutter/material.dart';

import '../../../../../shared/repositories/job_repository.dart';

class RequestCreationScreen
    extends StatefulWidget {
  const RequestCreationScreen({
    super.key,
  });

  @override
  State<RequestCreationScreen>
      createState() =>
          _RequestCreationScreenState();
}

class _RequestCreationScreenState
    extends State<RequestCreationScreen> {
  final categoryController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final JobRepository jobRepository =
      JobRepository();

  bool isLoading = false;

  Future<void> submitJob() async {
    try {
      setState(() {
        isLoading = true;
      });

      await jobRepository.createJob(
        category:
            categoryController.text.trim(),
        description:
            descriptionController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          behavior:
              SnackBarBehavior.floating,
          content: Text(
            'Job request submitted',
          ),
        ),
      );

      categoryController.clear();

      descriptionController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          behavior:
              SnackBarBehavior.floating,
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
      appBar: AppBar(
        title: const Text(
          'Create Request',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(
                      colors: [
                        theme
                            .colorScheme.primary,
                        theme.colorScheme.primary
                            .withOpacity(0.8),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      32,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets
                                .all(14),
                        decoration:
                            BoxDecoration(
                          color: Colors.white
                              .withOpacity(
                            0.15,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            18,
                          ),
                        ),
                        child: const Icon(
                          Icons
                              .add_home_work_rounded,
                          color:
                              Colors.white,
                          size: 32,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      const Text(
                        'Submit a Service Request',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight
                                  .w700,
                          color:
                              Colors.white,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        'Provide details about the issue so professionals can review and accept the request.',
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(
                            0.9,
                          ),
                          height: 1.6,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

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
                            categoryController,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Category',
                          hintText:
                              'Plumbing, Electrical, Cleaning...',
                          prefixIcon: Icon(
                            Icons
                                .category_outlined,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller:
                            descriptionController,
                        maxLines: 6,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Description',
                          hintText:
                              'Describe the issue in detail...',
                          alignLabelWithHint:
                              true,
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.only(
                              bottom: 90,
                            ),
                            child: Icon(
                              Icons
                                  .description_outlined,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      SizedBox(
                        width: 220,
                        height: 54,
                        child:
                            ElevatedButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : submitJob,
                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth:
                                        2.5,
                                    color: Colors
                                        .white,
                                  ),
                                )
                              : const Text(
                                  'Submit Request',
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}