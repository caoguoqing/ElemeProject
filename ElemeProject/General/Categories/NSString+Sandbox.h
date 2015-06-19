//
//  NSString+Sandbox.h
//
//
//  Created by Sam Lau on 6/19/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Sandbox)

// Sandbox directories
+ (NSString*)homeDirectory;
+ (NSString*)appDirectory;
+ (NSString*)documentDirectory;
+ (NSString*)libraryDirectory;
+ (NSString*)cacheDirectory;
+ (NSString*)tmpDirecotory;

@end
