import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String clientId;
  final String professionalId;
  final String description;
  final String period; // Manhã, Tarde, Noite
  final String status; // Pendente, Aceita, Recusada, Concluída
  final DateTime createdAt;
  final String? clientName; // Para facilitar exibição na UI
  final String? professionalName; // Para facilitar exibição na UI
  final String? professionalCategory;

  RequestModel({
    required this.id,
    required this.clientId,
    required this.professionalId,
    required this.description,
    required this.period,
    required this.status,
    required this.createdAt,
    this.clientName,
    this.professionalName,
    this.professionalCategory,
  });

  factory RequestModel.fromMap(Map<String, dynamic> map, String id) {
    return RequestModel(
      id: id,
      clientId: map['clientId'] ?? '',
      professionalId: map['professionalId'] ?? '',
      description: map['description'] ?? '',
      period: map['period'] ?? '',
      status: map['status'] ?? 'Pendente',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      clientName: map['clientName'],
      professionalName: map['professionalName'],
      professionalCategory: map['professionalCategory'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'professionalId': professionalId,
      'description': description,
      'period': period,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
      'clientName': clientName,
      'professionalName': professionalName,
      'professionalCategory': professionalCategory,
    };
  }
}
