//
//  NSString+Sandbox.m
//
//
//  Created by Sam Lau on 6/19/15.
//
//

#import "NSString+Sandbox.h"

@implementation NSString (Sandbox)

#pragma mark - Sandbox directories
+ (NSString*)homeDirectory
{
    return NSHomeDirectory();
}

+ (NSString*)appDirectory
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString*)documentDirectory
{
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [docPaths objectAtIndex:0];
}

+ (NSString*)libraryDirectory
{
    NSArray* libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return libPaths[0];
}

+ (NSString*)cacheDirectory
{
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return cachePaths[0];
}

+ (NSString*)tmpDirecotory
{
    return NSTemporaryDirectory();
}

#pragma mark - Extending directories


@end
