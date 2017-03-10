import 'package:test/test.dart';

import 'package:analyzer/src/generated/engine.dart' show AnalysisContext;
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';

import 'package:recreate_const_test/analysis/create_context.dart';

/// Find the source code that would recreate the const value [dartObject]
///
/// This is the interesting bit that we'd need to implement
String sourceToCreate(DartObject dartObject) {
  // TODO how will this work?
  return 'const ${dartObject.type.displayName}()';
}

void main() {
  AnalysisContext context;
  LibraryElement withPrefix;
  LibraryElement withoutPrefix;

  LibraryElement library(String fileName) {
    var uri = 'package:recreate_const_test/usages/$fileName.dart';
    var source = context.sourceFactory.forUri(uri);
    return context.computeLibraryElement(source);
  }

  setUpAll(() {
    context = buildAnalysisContext();
    withPrefix = library('with_prefix');
    withoutPrefix = library('without_prefix');
    expect(withPrefix, isNotNull);
    expect(withoutPrefix, isNotNull);
  });

  /// Attempt to find the source code that would create the const value for
  /// [dartObject] then load that up in the AnalysisContext and evaluated the
  /// constant value.
  void assertCanCreate(DartObject dartObject) {
    // TODO what about prefix imports?
    final sourceCode =
        'import "package:recreate_const_test/annotations.dart";\n'
        'const variableName = ${sourceToCreate(dartObject)}';
    final uri = new Uri.dataFromString(sourceCode);
    final source = context.sourceFactory.forUri2(uri);
    expect(source, isNotNull);
    final library = context.computeLibraryElement(source);
    final variable = library.units.single.topLevelVariables.single;
    expect(variable.computeConstantValue(), dartObject);
  }

  group('unprefixed', () {
    DartObject findAnnotation(String className) {
      var classElement = withoutPrefix.getType(className);
      return classElement.metadata.single.computeConstantValue();
    }

    test('simple annotation', () {
      final value = findAnnotation('UseSimple');
      assertCanCreate(value);
    });

    test('with field', () {
      final value = findAnnotation('UseComplex');
      assertCanCreate(value);
    });

    test('with named arguments', () {
      final value = findAnnotation('UseNamed');
      assertCanCreate(value);
    });

    test('field from within an annotation', () {
      final annotation = findAnnotation('UseDeepInspection');
      final value = annotation.getField('field');
      assertCanCreate(value);
    });

    test('simple as variable', () {
      final value = findAnnotation('UseSimpleVariable');
      assertCanCreate(value);
    });

    test('with field as variable', () {
      final value = findAnnotation('UseComplexVariable');
      assertCanCreate(value);
    });

    test('with named arguments as variable', () {
      final value = findAnnotation('UseNamedArgumentsVariable');
      assertCanCreate(value);
    });

    test('with private class', () {
      final value = findAnnotation('UsePrivate');
      assertCanCreate(value);
    });
  });
}
