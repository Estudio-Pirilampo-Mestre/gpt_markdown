import 'golden_test_utils.dart';

/// Locks the default appearance.
///
/// Customization work must not change how anything looks out of the box. These
/// goldens are captured before a refactor and must still pass after it without
/// `--update-goldens`. If one fails, a default moved.
///
/// Skipped unless run with `just check --golden`: goldens only match on the
/// machine that generated them. To add a case, add an entry here.
const _cases = <String, String>{
  'blockquote':
      '> A quoted line with `code`, **bold** and a\n'
      '> [link](https://example.com) inside it.\n\n'
      'Text after the quote.',
  'lists': '- first item\n- second item\n\n1. one\n2. two',
  'checkbox': '- [x] done already\n- [ ] still to do',
  'headings': '# Heading one\n\n## Heading two\n\nBody text.',
  'table': '| A | B |\n|---|---|\n| 1 | 2 |',
  'code_block': '```dart\nvar x = 1;\n```',
  'inline':
      'Text with `code`, **bold**, *italic* and '
      '[a link](https://example.com).',
  'rule': 'above\n\n---\n\nbelow',
};

void main() {
  for (final entry in _cases.entries) {
    markdownGolden(entry.key, entry.value);
  }
}
