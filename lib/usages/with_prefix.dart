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
class UseSimpleVariable {}

@annotations.complexAnnotation
class UseComplexVariable {}

@annotations.namedArguments
class UseNamedArgumentsVariable {}

@annotations.privateAnnotation
class UsePrivate {}
