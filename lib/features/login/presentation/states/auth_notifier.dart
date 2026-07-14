import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../states/auth_state.dart';
import '../../../../shared/models/user_model.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthNotifier() : super(AuthState.initial()) {
    checkAuthStatus();
  }

  // ✅ LOGIN CON DEBUG COMPLETO
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ DEBUG FIREBASE RESPONSE
      print('LOGIN RESPONSE USER: ${credential.user}');
      print('UID (credential): ${credential.user?.uid}');
      print('EMAIL (credential): ${credential.user?.email}');

      // ✅ USAR CURRENT USER (más confiable en web)
      final firebaseUser = _auth.currentUser;

      print('CURRENT USER: $firebaseUser');
      print('CURRENT UID: ${firebaseUser?.uid}');
      print('CURRENT EMAIL: ${firebaseUser?.email}');

      if (firebaseUser != null) {
        final uid = firebaseUser.uid;

        print('➡️ ENTRANDO A FIRESTORE CON UID: $uid');

        final userData = await _getUserFromFirestore(uid);

        print('✅ USER FIRESTORE: ${userData.user}');
        print('✅ ROL: ${userData.rol}');

        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: userData,
        );
      } else {
        print('❌ firebaseUser ES NULL');
        throw Exception('No se pudo obtener usuario autenticado');
      }
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      state = state.copyWith(
        isLoading: false,
        error: _mapFirebaseError(e),
      );
    } catch (e) {
      print('❌ ERROR GENERAL LOGIN: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // ✅ FIRESTORE
  Future<UserModel> _getUserFromFirestore(String uid) async {
    print('🔎 Buscando usuario en Firestore con UID: $uid');

    final doc = await _firestore.collection('users').doc(uid).get();

    print('📄 Documento existe: ${doc.exists}');
    print('📄 Data: ${doc.data()}');

    if (!doc.exists) {
      throw Exception('Usuario no encontrado en base de datos');
    }

    final data = doc.data()!;

    print('✅ DATA PROCESADA: $data');

    return UserModel.fromJson(data);
  }

  // ✅ LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    state = AuthState.initial();
  }

  // ✅ CHECK AUTH STATUS (CORREGIDO)
  void checkAuthStatus() {
    final user = _auth.currentUser;

    print('🔁 CHECK AUTH STATUS');
    print('USER: $user');
    print('UID: ${user?.uid}');

    if (user != null) {
      _loadUser(user.uid); // ✅ CORRECTO (antes estaba mal)
    }
  }

  // ✅ LOAD USER (CORREGIDO)
  Future<void> _loadUser(String uid) async {
    try {
      print('🔄 Cargando usuario desde Firestore con UID: $uid');

      final userData = await _getUserFromFirestore(uid);

      print('✅ USER CARGADO: ${userData.user}');

      state = state.copyWith(
        isAuthenticated: true,
        user: userData,
      );
    } catch (e) {
      print('❌ ERROR LOAD USER: $e');
      state = state.copyWith(
        error: e.toString(),
      );
    }
  }

  // ✅ MAPEO ERRORES
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'invalid-email':
        return 'Email inválido';
      default:
        return e.message ?? 'Error de autenticación';
    }
  }
}