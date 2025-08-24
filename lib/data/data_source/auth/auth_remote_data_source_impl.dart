import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result.dart' show Result, Success, Fail;
import 'auth_remote_data_source.dart' show AuthRemoteDataSource;

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _auth;

  AuthRemoteDataSourceImpl(this._auth);

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    }
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      print('=== DEBUG: Starting password reset process ===');
      print('Email: $email');
      print('Auth instance: ${_auth.hashCode}');
      print('Current user: ${_auth.currentUser?.email ?? 'No user'}');

      // Check if user exists first (optional - remove if you don't want to reveal user existence)
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      print('Sign-in methods for email: $signInMethods');

      if (signInMethods.isEmpty) {
        print('WARNING: No sign-in methods found for this email');
        // You might want to return success anyway for security reasons
      }

      print('Attempting to send password reset email...');

      // Add language code for better localization
      await _auth.setLanguageCode('en'); // or user's preferred language

      await _auth.sendPasswordResetEmail(email: email);

      print('✅ Password reset email sent successfully to: $email');
      print('=== DEBUG: Process completed ===');

      return Success(data: null);
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuth error: ${e.code} - ${e.message}');
      print('Error details: $e');

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          // For security, you might want to return success even if user doesn't exist
          errorMessage =
              'If an account with this email exists, you will receive a reset link.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Password reset is currently disabled.';
          break;
        default:
          errorMessage = e.message ?? 'Failed to send reset email';
      }
      return Fail(exception: Exception(errorMessage));
    } catch (e) {
      print('❌ General error: $e');
      print('Error type: ${e.runtimeType}');
      return Fail(
        exception: Exception('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
