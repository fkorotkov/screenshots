import 'image_magick.dart';

/// default config file name
const String kConfigFileName = 'screenshots.yaml';

/// screenshots environment file name
const String kEnvFileName = 'env.json';

/// Image extension
const kImageExtension = 'png';

/// Directory for capturing screenshots during a test
const kTestScreenshotsDir = 'test';

/// Distinguish device OS.
enum DeviceType { android, ios }

/// Run mode
enum RunMode { normal, recording, comparison, archive }

/// singleton
ImageMagick get im => ImageMagick();

/// No flavor
const String kNoFlavor = 'no flavor';
