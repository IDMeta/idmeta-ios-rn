@import Flutter;
@import UIKit;
#import "IdmetaIosRn.h"


@interface GeneratedPluginRegistrant : NSObject
+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry> *)registry;
@end

static FlutterEngine *_flutterEngine = nil;
static UIWindow *_flutterWindow = nil;

@implementation IdmetaIosRn

RCT_EXPORT_MODULE(IdmetaIosRn)

+ (void)initWithFlutterEngine:(FlutterEngine * _Nonnull)flutterEngine {
    _flutterEngine = flutterEngine;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (instancetype)init {
    self = [super init];
    return self;
}

+ (void)dismissFlutterWindow {
    if (_flutterWindow) {
        _flutterWindow.hidden = YES;
        _flutterWindow = nil;
    }
    // Restore the RN app window as key so UI stays responsive
    UIWindow *appWindow = UIApplication.sharedApplication.delegate.window;
    if (appWindow) {
        [appWindow makeKeyAndVisible];
    }
}

RCT_EXPORT_METHOD(startActivity:(NSString *)flowId userToken:(NSString *)userToken callback:(RCTResponseSenderBlock)callback)
{
    dispatch_async(dispatch_get_main_queue(), ^{

        if (_flutterEngine) {
            [_flutterEngine destroyContext];
            _flutterEngine = nil;
        }
        [IdmetaIosRn dismissFlutterWindow];

        _flutterEngine = [[FlutterEngine alloc] initWithName:@"my_engine_id"];

        [_flutterEngine runWithEntrypoint:nil];
        [GeneratedPluginRegistrant registerWithRegistry:_flutterEngine];

        // Data channel — provides flowId/userToken to Dart
        FlutterMethodChannel *dataChannel = [FlutterMethodChannel
            methodChannelWithName:@"com.idmetareactnative/data"
                  binaryMessenger:_flutterEngine.binaryMessenger];

        [dataChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            if ([call.method isEqualToString:@"getData"]) {
                result(@{
                    @"flowId": flowId,
                    @"userToken": userToken
                });
            } else {
                result(FlutterMethodNotImplemented);
            }
        }];

        // Close channel — Flutter calls this when the session is done so we can
        // tear down the dedicated window and restore the RN window as key.
        FlutterMethodChannel *closeChannel = [FlutterMethodChannel
            methodChannelWithName:@"com.idmetareactnative/close"
                  binaryMessenger:_flutterEngine.binaryMessenger];

        [closeChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            if ([call.method isEqualToString:@"close"]) {
                result(nil);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [IdmetaIosRn dismissFlutterWindow];
                    if (_flutterEngine) {
                        [_flutterEngine destroyContext];
                        _flutterEngine = nil;
                    }
                });
            } else {
                result(FlutterMethodNotImplemented);
            }
        }];

        FlutterViewController *flutterViewController =
            [[FlutterViewController alloc] initWithEngine:_flutterEngine
                                                  nibName:nil
                                                   bundle:nil];

        _flutterWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _flutterWindow.rootViewController = flutterViewController;
        _flutterWindow.windowLevel = UIWindowLevelNormal;
        [_flutterWindow makeKeyAndVisible];

        callback(@[[NSString stringWithFormat:@"Started: FlowId=%@", flowId]]);
    });
}

@end
