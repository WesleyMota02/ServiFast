import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Stream para ler os dados do usuário atual
final currentUserProvider = StreamProvider.family<Map<String, dynamic>?, String>((ref, uid) {
  return ref.watch(firestoreProvider).collection('users').doc(uid).snapshots().map((doc) => doc.data());
});

// Future para ler todos os profissionais disponíveis
final professionalsListProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final snapshot = await ref.watch(firestoreProvider).collection('professionals').get();
  
  // Para cada profissional, vamos precisar também do NOME que está na coleção `users`
  // Em apps reais de grande porte usaríamos Cloud Functions ou replicação de dados.
  // Aqui vamos fazer um join manual rápido.
  List<Map<String, dynamic>> pros = [];
  
  for (var doc in snapshot.docs) {
    var proData = doc.data();
    final uid = proData['uid'] as String;
    
    // Buscar o nome na coleção users
    final userDoc = await ref.watch(firestoreProvider).collection('users').doc(uid).get();
    if (userDoc.exists) {
      proData['name'] = userDoc.data()?['name'] ?? 'Desconhecido';
      proData['email'] = userDoc.data()?['email'] ?? '';
      proData['phone'] = userDoc.data()?['phone'] ?? '';
    }
    
    pros.add(proData);
  }
  
  return pros;
});

// Stream para ler os dados do perfil profissional específico
final professionalProfileProvider = StreamProvider.family<Map<String, dynamic>?, String>((ref, uid) async* {
  final stream = ref.watch(firestoreProvider).collection('professionals').doc(uid).snapshots();
  
  await for (final snapshot in stream) {
    var proData = snapshot.data();
    if (proData != null) {
      // Buscar o nome
      final userDoc = await ref.watch(firestoreProvider).collection('users').doc(uid).get();
      if (userDoc.exists) {
        proData['name'] = userDoc.data()?['name'] ?? 'Desconhecido';
      }
      yield proData;
    } else {
      yield null;
    }
  }
});

// Stream de Pedidos do Cliente Atual
final clientRequestsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, clientId) {
  return ref.watch(firestoreProvider)
      .collection('requests')
      .where('clientId', isEqualTo: clientId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
});

// Stream de Pedidos do Profissional Atual
final proRequestsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, proId) {
  return ref.watch(firestoreProvider)
      .collection('requests')
      .where('professionalId', isEqualTo: proId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
});

// Stream para ler os dados de uma única solicitação
final requestDetailProvider = StreamProvider.family<Map<String, dynamic>?, String>((ref, reqId) {
  return ref.watch(firestoreProvider)
      .collection('requests')
      .doc(reqId)
      .snapshots()
      .map((doc) => doc.exists ? {'id': doc.id, ...?doc.data()} : null);
});
