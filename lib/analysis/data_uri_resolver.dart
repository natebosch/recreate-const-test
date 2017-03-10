import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/string_source.dart';

class DataUriResolver implements UriResolver {
  const DataUriResolver();

  @override
  Source resolveAbsolute(Uri uri, [Uri actualUri]) {
    if (uri.scheme != 'data') return null;
    var content = uri.data.contentAsString();
    return new StringSource(content, '$uri');
  }

  @override
  Uri restoreAbsolute(Source source) {
    throw new UnimplementedError();
  }
}
