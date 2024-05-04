import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';
import 'auth_status.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final Account _account;

  AuthNotifier(this._account);

  @override
  AuthState build() {
    state = AuthState();
    _getUser();
    return state;
  }

  Account get account => _account;
  Future _getUser() async {
    try {
      state = state.copyWith(loading: true);
      final user = await _account.get();
      state = state.copyWith(
        user: user,
        loading: false,
        error: null,
        status: AuthStatus.authenticated,
      );
      developer.postEvent(
        'appwrite_kit:authEvent',
        state.toMap(),
      );
    } on AppwriteException catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.message,
        user: null,
        loading: false,
      );
      developer.postEvent('appwrite_kit:authEvent', state.toMap());
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        loading: false,
        user: null,
        status: AuthStatus.unauthenticated,
      );
    }
  }

  Future<bool> deleteSession({String sessionId = 'current'}) async {
    try {
      state = state.copyWith(loading: true);
      await _account.deleteSession(sessionId: sessionId);
      state = state.copyWith(
        error: null,
        status: AuthStatus.unauthenticated,
        loading: false,
        user: null,
      );
      developer.postEvent('appwrite_kit:authEvent', {
        "type": "deleteSession",
        "session": {"id": sessionId}
      });
      return true;
    } on AppwriteException catch (e) {
      state = state.copyWith(error: e.message, user: null, loading: false);
      return false;
    }
  }

  Future<bool> deleteSessions() async {
    try {
      state = state.copyWith(loading: true);
      await _account.deleteSessions();
      state = state.copyWith(
        loading: false,
        user: null,
        status: AuthStatus.unauthenticated,
      );
      return true;
    } on AppwriteException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
      return false;
    }
  }

  Future<bool> createEmailSession({
    required String email,
    required String password,
    bool notify = true,
  }) async {
    state = state.copyWith(
      status: AuthStatus.authenticating,
      loading: true,
    );
    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      await _getUser();
      return true;
    } on AppwriteException catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        loading: false,
        error: e.message,
      );
      return false;
    }
  }
}
