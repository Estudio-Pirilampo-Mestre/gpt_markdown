import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'golden/golden_comparator.dart';

/// Runs around every test file under `test/`. `flutter test` picks it up by
/// name; no test has to import it.
///
/// It swaps in [GoldenComparator], so every golden in the suite tolerates
/// antialiasing jitter without hiding real changes.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final current = goldenFileComparator;
  if (current is LocalFileComparator) {
    // `basedir` is the test file's directory; any file name in it gives the
    // same one back.
    goldenFileComparator = GoldenComparator(current.basedir.resolve('_.dart'));
  }
  await testMain();
}
