import 'dart:io';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart'
    show PhysicalResourceProvider;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/package_map_resolver.dart';
import 'package:analyzer/source/pub_package_map_provider.dart';
import 'package:analyzer/src/dart/sdk/sdk.dart';
import 'package:analyzer/src/generated/engine.dart'
    show AnalysisContext, AnalysisEngine;
import 'package:analyzer/src/generated/sdk.dart' show DartSdk;
import 'package:analyzer/src/generated/source.dart';
import 'package:path/path.dart' as p;

import 'data_uri_resolver.dart';

String get dartSdkDirectory {
  final dart = Platform.resolvedExecutable;
  return p.dirname(p.dirname(dart));
}

UriResolver packagesResolver(DartSdk sdk) {
  // Assume we're running at the root of the package
  var pubPackageMapProvider =
      new PubPackageMapProvider(PhysicalResourceProvider.INSTANCE, sdk);
  var packageMapInfo = pubPackageMapProvider
      .computePackageMap(PhysicalResourceProvider.INSTANCE.getResource('.'));
  var packageMap = packageMapInfo.packageMap;
  return new PackageMapUriResolver(
      PhysicalResourceProvider.INSTANCE, packageMap);
}

AnalysisContext buildAnalysisContext() {
  AnalysisEngine.instance.processRequiredPlugins();
  final sdkFolder =
      PhysicalResourceProvider.INSTANCE.getFolder(dartSdkDirectory);
  final sdk =
      new FolderBasedDartSdk(PhysicalResourceProvider.INSTANCE, sdkFolder);
  final sdkResolver = new DartUriResolver(sdk);

  final packageResolver = packagesResolver(sdk);

  final fileResolver =
      new ResourceUriResolver(PhysicalResourceProvider.INSTANCE);

  final resolvers = [
    sdkResolver,
    packageResolver,
    fileResolver,
    const DataUriResolver()
  ];
  var sourceFactory = new SourceFactory(resolvers);

  var context = AnalysisEngine.instance.createAnalysisContext()
    ..sourceFactory = sourceFactory;

  return context;
}
