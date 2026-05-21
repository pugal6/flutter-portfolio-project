import '../enums/job_status.dart';

class JobModel {
  final String id;

  final String homeownerId;

  final String homeownerName;

  final String category;

  final String description;

  final JobStatus status;

  final DateTime createdAt;

  final String? cancelledBy;

  final String? professionalName;

  final String? professionalId;

  JobModel({
    required this.id,
    required this.homeownerId,
    required this.homeownerName,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    this.professionalName,
    this.professionalId,
    this.cancelledBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'homeownerId': homeownerId,
      'homeownerName': homeownerName,
      'category': category,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'professionalName': professionalName,
      'professionalId': professionalId,
      'cancelledBy': cancelledBy,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] ?? '',

      homeownerId: map['homeownerId'] ?? '',

      homeownerName:
          (map['homeownerName'] != null &&
              map['homeownerName'].toString().trim().isNotEmpty)
          ? map['homeownerName']
          : 'Unknown Homeowner',

      category: map['category'] ?? '',

      description: map['description'] ?? '',

      status: JobStatus.values.firstWhere(
        (status) => status.name == map['status'],
        orElse: () => JobStatus.pending,
      ),

      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),

      professionalName:
          (map['professionalName'] != null &&
              map['professionalName'].toString().trim().isNotEmpty)
          ? map['professionalName']
          : null,

      professionalId: map['professionalId'],

      cancelledBy: map['cancelledBy'],
    );
  }
}
