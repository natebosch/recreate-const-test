import '../annotations.dart';

@SimpleAnnotation()
class UseSimple {}

@ComplexAnnotation('specified')
class UseComplex {}

@NamedArguments(field1: 'specified', nonMatchingName: 'specified')
class UseNamed {}

@DeepInspection(
    field: const NamedArguments(
        field1: 'specified', nonMatchingName: 'specified'))
class UseDeepInspection {}

@simpleAnnotation
class UseSimpleField {}

@complexAnnotation
class UseComplexField {}

@namedArguments
class UseNamedArgumentsField {}

@privateAnnotation
class UsePrivate {}
