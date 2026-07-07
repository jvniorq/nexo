import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexo/main.dart';

void main() {
  testWidgets('shows the Today dashboard and completes a task', (tester) async {
    await tester.pumpWidget(const NexoApp());

    expect(find.text('Good morning'), findsOneWidget);
    expect(find.text('PRIORITIES'), findsOneWidget);
    expect(find.text('Finish the presentation'), findsOneWidget);

    final taskTitle = find.text('Finish the presentation');
    await tester.scrollUntilVisible(taskTitle, 300);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();

    final task = tester.widget<Text>(taskTitle);
    expect(task.style?.decoration, TextDecoration.lineThrough);
  });

  testWidgets('opens quick create', (tester) async {
    await tester.pumpWidget(const NexoApp());

    await tester.tap(find.byTooltip('Quick create'));
    await tester.pumpAndSettle();

    expect(find.text('What do you need to organize?'), findsOneWidget);
    expect(find.text('Create Task'), findsOneWidget);
  });
}
