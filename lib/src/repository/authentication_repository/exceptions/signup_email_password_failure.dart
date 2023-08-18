import 'package:flutter/material.dart';


class SignUpWithEmailAndPasswordFailure {
   final String message;

  const SignUpWithEmailAndPasswordFailure([this.message= " Une erreur s'est produite."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case'weak-password':
        return const SignUpWithEmailAndPasswordFailure('S\'il vous plaît entrez un mot de passe plus fort.');
      case'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Votre mail n\'est pas valide.');
      case'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('Il existe déjà un compte avec ce mail.');
      case'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('Opération non autorisée. S\'il vous plaît contactez le service client.');
      case'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('Cet utilisateur a été désactivé. S\'il vous plaît contacter le service client pour de l\'aide.');
      default: return SignUpWithEmailAndPasswordFailure();
    }
  }

}