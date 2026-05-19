import 'package:flutter/material.dart';

import '../../../../../shared/repositories/job_repository.dart';


class RequestCreationScreen extends StatefulWidget {
  const RequestCreationScreen({super.key});

  @override
  State<RequestCreationScreen> createState() =>
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
          content: Text(e.toString()),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Request',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: categoryController,

              decoration:
                  const InputDecoration(
                labelText: 'Category',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  descriptionController,

              maxLines: 5,

              decoration:
                  const InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : submitJob,

                child:
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Submit Request',
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}