class SimpleAnnotation {
  const SimpleAnnotation();
}

class ComplexAnnotation {
  final String field;
  const ComplexAnnotation(this.field);
}

class NamedArguments {
  final String field1;
  final String field2;

  const NamedArguments({this.field1, String nonMatchingName})
      : this.field2 = nonMatchingName;
}

class _PrivateAnnotation {
  final String field;
  const _PrivateAnnotation(this.field);
}

class DeepInspection {
  final NamedArguments field;
  const DeepInspection({this.field});
}

const simpleAnnotation = const SimpleAnnotation();
const complexAnnotation = const ComplexAnnotation('value');
const namedArguments =
    const NamedArguments(field1: 'value1', nonMatchingName: 'value2');

const privateAnnotation = const _PrivateAnnotation('value');
