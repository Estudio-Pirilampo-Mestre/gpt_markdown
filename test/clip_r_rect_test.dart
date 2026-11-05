import 'package:flutter_test/flutter_test.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('clips by default', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: GptMarkdown('text')));

    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('can disable clipping on the incremental path', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: GptMarkdown('text', clipView: false)),
    );

    expect(find.byType(ClipRRect), findsNothing);
  });

  testWidgets('can disable clipping on the legacy path', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        // ignore: deprecated_member_use_from_same_package
        home: GptMarkdown('text', incremental: false, clipView: false),
      ),
    );

    expect(find.byType(ClipRRect), findsNothing);
  });
}
