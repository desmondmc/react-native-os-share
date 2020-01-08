#import "OsShare.h"
#import <React/RCTConvert.h>

@implementation OsShare


RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(share,
                 shareOptions:(NSDictionary *)options
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    NSURL *url = [RCTConvert NSURL:options[@"url"]];
    
    if (!url) {
        NSError *noPathError = [NSError errorWithDomain:@"ShareOs.noPath" code:0 userInfo:nil];
        reject(@"", @"No path provided", noPathError);
        return;
    }

    NSError *readFileError;
    NSData *fileData = [NSData dataWithContentsOfURL:url
                                         options:(NSDataReadingOptions)0
                                           error:&readFileError];
    if (!fileData) {
        reject(@"", @"Unable to read file", readFileError);
        return;
    }
    
    UIViewController *controller = RCTPresentedViewController();
    UIActivityViewController *shareController = [[UIActivityViewController alloc] initWithActivityItems:@[fileData] applicationActivities:nil];
    
    shareController.modalPresentationStyle = UIModalPresentationPopover;
    shareController.popoverPresentationController.sourceView = controller.view;
    
    [controller presentViewController:shareController animated:YES completion:nil];
}

@end
