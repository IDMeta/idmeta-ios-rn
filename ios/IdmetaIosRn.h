// IdmetaIosRn.h

#import <React/RCTBridgeModule.h>
@import Flutter;

@interface IdmetaIosRn : NSObject <RCTBridgeModule>

@property (nonatomic,strong) FlutterEngine *flutterEngine;
+ (void)initWithFlutterEngine:(FlutterEngine * _Nonnull)flutterEngine;

@end

