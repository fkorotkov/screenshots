import 'package:mockito/mockito.dart';
import 'package:process/process.dart';
import 'package:screenshots/src/context_runner.dart';
import 'package:screenshots/src/globals.dart';
import 'package:screenshots/src/image_processor.dart';
import 'package:screenshots/src/utils.dart';
import 'package:test/test.dart';
import 'package:tool_base/tool_base.dart';

import 'src/context.dart';

class PlainMockProcessManager extends Mock implements ProcessManager {}

main() {
  group('image magick', () {
    ProcessManager mockProcessManager;

    setUp(() {
      mockProcessManager = PlainMockProcessManager();
      when(mockProcessManager.runSync(
        any,
        environment: anyNamed('environment'),
        workingDirectory: anyNamed('workingDirectory'),
        runInShell: anyNamed('runInShell'),
      )).thenAnswer((Invocation invocation) => ProcessResult(0, 0, null, null));
    });

    testUsingContext('overlay', () async {
      final options = {
        'screenshotPath': 'screenshotPath',
        'statusbarPath': 'statusbarPath',
      };
      final result = await im.convert('overlay', options);
      expect(result, isNull);
    }, overrides: <Type, Generator>{ProcessManager: () => mockProcessManager});

    testUsingContext('append', () async {
      final options = {
        'screenshotPath': 'screenshotPath',
        'screenshotNavbarPath': 'screenshotNavbarPath',
      };
      final result = await im.convert('append', options);
      expect(result, isNull);
    }, overrides: <Type, Generator>{ProcessManager: () => mockProcessManager});

    testUsingContext('frame', () async {
      final options = {
        'framePath': 'framePath',
        'size': 'size',
        'resize': 'resize',
        'offset': 'offset',
        'screenshotPath': 'screenshotPath',
        'backgroundColor': ImageProcessor.kDefaultAndroidBackground,
      };
      final result = await im.convert('frame', options);
      expect(result, isNull);
    }, overrides: <Type, Generator>{ProcessManager: () => mockProcessManager});

    test('threshold exceeded', () async {
      final imagePath = toPlatformPath('./test/resources/0.png');
      final cropSizeOffset = '1242x42+0+0';
      bool isThresholdExceeded = await runInContext<bool>(() async {
        return im.isThresholdExceeded(imagePath, cropSizeOffset, 0.5);
      });
      expect(isThresholdExceeded, isTrue);
      isThresholdExceeded = await runInContext<bool>(() async {
        return im.isThresholdExceeded(imagePath, cropSizeOffset);
      });
      expect(isThresholdExceeded, isFalse);
    });
  });
}
