import 'package:flutter_test/flutter_test.dart';
import 'package:cousin_crew/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CousinCrewApp());
    expect(find.byType(CousinCrewApp), findsOneWidget);
  });
}
