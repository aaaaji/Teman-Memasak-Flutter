import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teman_memasak/app.dart';

void main() {
  testWidgets('Aplikasi Teman Memasak dapat ditampilkan',
          (WidgetTester tester) async {
        // Menjalankan aplikasi
        await tester.pumpWidget(const TemanMemasakApp());

        // Menunggu proses pemuatan data dan rendering
        await tester.pumpAndSettle();

        // Memastikan MaterialApp tersedia
        expect(find.byType(MaterialApp), findsOneWidget);

        // Memastikan halaman utama memiliki Scaffold
        expect(find.byType(Scaffold), findsWidgets);
      });
}
