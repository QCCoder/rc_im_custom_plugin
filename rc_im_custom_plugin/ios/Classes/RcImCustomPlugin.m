#import "RcImCustomPlugin.h"
#import "RCCustomFlutterWarpper.h"
#if __has_include(<rc_im_custom_plugin/rc_im_custom_plugin-Swift.h>)
#import <rc_im_custom_plugin/rc_im_custom_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rc_im_custom_plugin-Swift.h"
#endif

@implementation RcImCustomPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"rc_im_custom_plugin" binaryMessenger:[registrar messenger]];
  RcImCustomPlugin* instance = [[RcImCustomPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [[RCCustomFlutterWarpper sharedWrapper] addFlutterChannel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    [[RCCustomFlutterWarpper sharedWrapper] handleMethodCall:call result:result];
}

@end
