// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoppingcartapp/cart_items.dart';
import 'package:shoppingcartapp/main.dart';

void main() {
  String proName="Product one";
  String proDesc="Product one Description";
 group("Form inputs", () { 
  //  testWidgets('Add product name and description', (WidgetTester tester) async {

  //   final addName=find.byKey(const ValueKey("ProductName"));
  //   final addDesc=find.byKey(const ValueKey("ProductDescription"));
  //   final addBtn=find.byKey(const ValueKey("addButton"));
    
  //     await tester.pumpWidget( const MyApp());
    
  //   await tester.enterText(addName, proName);
  //   await tester.enterText(addDesc ,proDesc);
  //   await tester.tap(addBtn);
  //   await tester.pumpAndSettle();

  //   expect(find.text(proName), findsOneWidget);
  //   expect(find.text(proDesc), findsOneWidget);
      
  // });

  testWidgets("Test scrolling", (WidgetTester tester)async{
    await tester.pumpWidget(const MaterialApp(
      home: CartPage(),
    ));

    tester.drag(find.byType(ListView), const Offset(0, -300));


    final rowFinder=find.byType(Row);

    expect(rowFinder, findsOneWidget);
  });
 });
}
