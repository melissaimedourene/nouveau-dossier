import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:peuty/Authentification/inscription.dart';
import 'package:peuty/HOME/homepage.dart';
import 'package:peuty/Authentification/connexion.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'your-api-key',
        appId: 'your-app-id',
        messagingSenderId: 'your-messaging-sender-id',
        projectId: 'your-project-id',
      ),
    );
  });

  group('LoginScreen Tests', () {
    testWidgets('Email validation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Entrer un email invalide
      await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Vérifier si le message d'erreur approprié est affiché
      expect(find.text('Veuillez entrer un email valide'), findsOneWidget);
    });

    testWidgets('Password validation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Entrer un mot de passe trop court
      await tester.enterText(find.byType(TextFormField).at(1), '12345');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Vérifier si le message d'erreur approprié est affiché
      expect(find.text('Le mot de passe doit contenir au moins 6 caractères'), findsOneWidget);
    });

    testWidgets('Successful login navigation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Entrer des informations de connexion valides
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Vérifier si l'écran HomeScreen est affiché après la connexion réussie
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Password reset dialog', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Appuyer sur le bouton "Mot de passe oublié ?"
      await tester.tap(find.text('Mot de passe oublié ?'));
      await tester.pumpAndSettle();

      // Vérifier si la boîte de dialogue de réinitialisation du mot de passe est affichée
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}


