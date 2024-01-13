import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/main.dart';

void main() {
  testWidgets('TodoListPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Todo(id: '1', title: '_addTodo') as Widget);

    // Verify that the title 'Todo List' is displayed.
    expect(find.text('Todo List'), findsOneWidget);

    // Verify the initial state - no todos are displayed.
    expect(find.byType(ListTile), findsNothing);

    // Enter a new todo title in the TextField.
    await tester.enterText(find.byType(TextField), 'New Todo');

    // Tap the 'Add Todo' button.
    await tester.tap(find.byType(ElevatedButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Verify that the new todo is now in the list.
    expect(find.text('New Todo'), findsOneWidget);

    // Tap the checkbox to mark the todo as completed.
    await tester.tap(find.byType(Checkbox));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Verify that the completed todo has a checked checkbox.
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);

    // Tap the delete icon to remove the todo.
    await tester.tap(find.byIcon(Icons.delete));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Verify that the todo has been removed from the list.
    expect(find.text('New Todo'), findsNothing);
  });
}
