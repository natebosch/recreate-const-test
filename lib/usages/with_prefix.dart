import '../annotations.dart' as annotations;

@annotations.SimpleAnnotation()
class UseSimple {}

@annotations.ComplexAnnotation('specified')
class UseComplex {}

@annotations.NamedArguments(field1: 'specified', nonMatchingName: 'specified')
class UseNamed {}

@annotations.DeepInspection(
    field: const annotations.NamedArguments(
        field1: 'specified', nonMatchingName: 'specified'))
class UseDeepInspection {}

@annotations.simpleAnnotation
class UseSimpleField {}

@annotations.complexAnnotation
class UseComplexField {}

@annotations.namedArguments
class UseNamedArgumentsField {}

@annotations.privateAnnotation
class UsePrivate {}
