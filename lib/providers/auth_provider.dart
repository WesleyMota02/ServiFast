import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provedor instanciando o FirebaseAuth
final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>((ref) {
  return firebase_auth.FirebaseAuth.instance;
});

// Provedor para observar o estado do usuário logado em tempo real
final authStateProvider = StreamProvider<firebase_auth.User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// Modelo de estado de Auth
class AuthState {
  final bool isLoading;
  final String? error;

  const AuthState({this.isLoading = false, this.error});

  AuthState copyWith({bool? isLoading, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier que gerencia as operações de login e cadastro
class AuthNotifier extends Notifier<AuthState> {
  firebase_auth.FirebaseAuth get _auth => ref.read(firebaseAuthProvider);
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  AuthState build() => const AuthState();

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = state.copyWith(isLoading: false);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: _getFirebaseError(e.code));
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ocorreu um erro inesperado.');
      return false;
    }
  }

  Future<bool> registerClient({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String cep,
    required String city,
    required String stateStr,
    required String neighborhood,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Salva os dados no Firestore na coleção 'users'
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'type': 'client',
        'name': name,
        'email': email,
        'phone': phone,
        'cep': cep,
        'city': city,
        'state': stateStr,
        'neighborhood': neighborhood,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Atualiza o nome de exibição no auth
      await userCredential.user!.updateDisplayName(name);

      state = state.copyWith(isLoading: false);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: _getFirebaseError(e.code));
      return false;
    } catch (e) {
      print('Erro no Firestore/Cadastro Cliente: $e');
      state = state.copyWith(isLoading: false, error: 'Erro ao salvar dados: $e');
      return false;
    }
  }

  Future<bool> registerProfessional({
    required String name,
    required String email,
    required String phone,
    required String cpf,
    required String password,
    required String category,
    required String description,
    required String cep,
    required String city,
    required String stateStr,
    required String neighborhood,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Salva no Firestore: primeiro na base geral de usuários
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'type': 'professional',
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Salva os dados específicos na coleção 'professionals'
      await _firestore.collection('professionals').doc(uid).set({
        'uid': uid,
        'cpf': cpf,
        'category': category,
        'description': description,
        'cep': cep,
        'city': city,
        'state': stateStr,
        'neighborhood': neighborhood,
        'available': true,
        'verified': false,
        'rating': 5.0,
        'ratingCount': 0,
      });

      await userCredential.user!.updateDisplayName(name);

      state = state.copyWith(isLoading: false);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: _getFirebaseError(e.code));
      return false;
    } catch (e) {
      print('Erro no Firestore/Cadastro Profissional: $e');
      state = state.copyWith(isLoading: false, error: 'Erro ao salvar dados: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  String _getFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'email-already-in-use':
        return 'Esse e-mail já está em uso.';
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';
      case 'invalid-email':
        return 'O formato do e-mail é inválido.';
      case 'operation-not-allowed':
        return 'Login por e-mail e senha não está habilitado no Firebase Console.';
      default:
        return 'Erro de autenticação: $code';
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
