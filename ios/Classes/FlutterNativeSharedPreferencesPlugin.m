#import "FlutterNativeSharedPreferencesPlugin.h"
#if __has_include(<flutter_native_shared_preferences/flutter_native_shared_preferences-Swift.h>)
#import <flutter_native_shared_preferences/flutter_native_shared_preferences-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_native_shared_preferences-Swift.h"
#endif

@implementation FlutterNativeSharedPreferencesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeSharedPreferencesPlugin registerWithRegistrar:registrar];
}
@end
