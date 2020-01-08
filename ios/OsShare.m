#import "OsShare.h"


@implementation OsShare

NSError *noPathError = [NSError errorWithDomain:@"ShareOs.noPath" code:0 userInfo:nil];

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(share,
                 shareOptions:(NSDictionary *)options
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *path = [RCTConvert NSString:options[@"path"]];
    
    if (!path) {
        reject(@"", @"No path provided", noPath);
    }
}

@end
