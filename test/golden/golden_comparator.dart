import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';

/// The golden comparator for every test under `test/`, installed by
/// `test/flutter_test_config.dart`.
///
/// It is [LocalFileComparator] plus a **per-pixel tolerance of
/// [maxChannelDelta]**. Every pixel must still match, but each colour channel
/// may be off by a few levels. The engine sometimes antialiases a clipped
/// rounded corner a shade differently from run to run on the same machine
/// (seen as a few levels on the code panel). A real change — a wider bar,
/// another colour, moved padding — moves pixels by tens of levels and still
/// fails, however few pixels it touches. That is why this is not a
/// share-of-pixels tolerance: one of those, at 0.5%, let a blockquote bar
/// widen from 3 to 9 points.
final class GoldenComparator extends LocalFileComparator {
  /// Compares against goldens next to [testFile].
  GoldenComparator(super.testFile);

  /// Largest difference allowed in any one channel (0–255) of any pixel.
  static const maxChannelDelta = 8;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    if (await withinTolerance(imageBytes, await getGoldenBytes(golden))) {
      return true;
    }
    // Out of tolerance: the exact comparison fails too, and writes the usual
    // diff images to `failures/`.
    return super.compare(imageBytes, golden);
  }

  /// Whether the PNGs [a] and [b] have the same size and no channel of any
  /// pixel differs by more than [maxChannelDelta].
  static Future<bool> withinTolerance(List<int> a, List<int> b) async {
    final (aWidth, aHeight, aPixels) = await _decode(a);
    final (bWidth, bHeight, bPixels) = await _decode(b);
    if (aWidth != bWidth || aHeight != bHeight) return false;
    for (var i = 0; i < aPixels.length; i++) {
      if ((aPixels[i] - bPixels[i]).abs() > maxChannelDelta) return false;
    }
    return true;
  }
}

Future<(int, int, Uint8List)> _decode(List<int> png) async {
  final codec = await ui.instantiateImageCodec(Uint8List.fromList(png));
  final image = (await codec.getNextFrame()).image;
  codec.dispose();
  final data = await image.toByteData(
    format: ui.ImageByteFormat.rawStraightRgba,
  );
  final result = (image.width, image.height, data!.buffer.asUint8List());
  image.dispose();
  return result;
}
