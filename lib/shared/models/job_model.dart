import '../enums/job_status.dart';

class JobModel {
  final String id;

  final String homeownerId;

  final String category;

  final String description;

  final JobStatus status;

  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.homeownerId,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'homeownerId': homeownerId,
      'category': category,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory JobModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return JobModel(
      id: map['id'] ?? '',

      homeownerId: map['homeownerId'] ?? '',

      category: map['category'] ?? '',

      description: map['description'] ?? '',

      status: JobStatus.values.firstWhere(
        (status) =>
            status.name == map['status'],
      ),

      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }
}