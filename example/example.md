# example
``` dart
import 'package:flutter/material.dart';
import 'package:tex_markdown/tex_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return GptMarkdown(
                        _controller.text,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      );
                    }),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              maxLines: null,
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}

```

Use `SelectableAdapter` to make any non selectable widget selectable.

```dart
SelectableAdapter(
  selectedText: 'sin(x^2)',
  child: Math.tex('sin(x^2)'),
);
```

Use `GptMarkdownTheme` widget and `GptMarkdownThemeData` to customize the GptMarkdown.

```dart
GptMarkdownTheme(
  data: GptMarkdownThemeData.of(context).copyWith(
    highlightColor: Colors.red,
  ),
  child: GptMarkdown(
    text,
  ),
);
```

In theme extension you can use `GptMarkdownThemeData` to customize the GptMarkdown.

```dart
theme: ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.blue,
  extensions: [
    GptMarkdownThemeData(
      brightness: Brightness.light,
      highlightColor: Colors.red,
    ),
  ],
),
darkTheme: ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.blue,
  extensions: [
    GptMarkdownThemeData(
      brightness: Brightness.dark,
      highlightColor: Colors.red,
    ),
  ],
),
```

Use `tableBuilder` to customize table rendering:

```dart
GptMarkdown(
  markdownText,
  tableBuilder: (context, tableRows, textStyle, config) {
    return Table(
      border: TableBorder.all(
        width: 1,
        color: Colors.red,
      ),
      children: tableRows.map((e) {
        return TableRow(
          children: e.fields.map((e) {
            return Text(e.data);
          }).toList(),
        );
      }).toList(),
    );
  },
);
```

Please see the [README.md](https://github.com/Infinitix-LLC/gpt_markdown) and also [example](https://github.com/Infinitix-LLC/gpt_markdown/tree/main/example/lib/main.dart) app for more details.

