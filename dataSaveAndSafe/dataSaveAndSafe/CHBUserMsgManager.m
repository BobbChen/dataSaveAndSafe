//
//  CHBUserMsgManager.m
//  1.MD5加密
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 zhizhangweilai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CHBUserMsgManager.h"

@implementation CHBUserMsgManager
static CHBUserMsgManager *_msgManager = nil;
static NSString *keyStr = @"keyChain";

+ (instancetype)sharedTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _msgManager = [[super allocWithZone:NULL] init];
        
    });
    return _msgManager;
    
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [CHBUserMsgManager sharedTool];
}
- (void)saveMsgByKeyChain:(NSString *)key content:(NSString *)content
{
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:keyStr accessGroup:nil];
    
    [keyChain setObject:content forKey:(id)kSecValueData];
    
}

- (NSString *)getKeyChainContent
{
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:keyStr accessGroup:nil];
    return [keyChain objectForKey:(id)kSecValueData];
}

- (void)clearKeyChainMsg
{
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:keyStr accessGroup:nil];
    [keyChain resetKeychainItem];
    
}

- (NSString *)encryptionNSString:(NSString *)str
{
    const char *content = [str UTF8String];
    unsigned char mdc[16];
    CC_MD5(content, (CC_LONG)strlen(content), mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < 16; i ++) {
        [md5String appendFormat:@"%02x",mdc[i]];
    }
    return md5String;
}

- (void)saveMessageByNSDictionary:(NSDictionary *)dict
{
    NSArray *allKeys = [dict allKeys];
    CHBUserMsgManager *msgManager = [CHBUserMsgManager sharedTool];
    for (int i = 0; i < allKeys.count; i ++) {
        NSString *key = allKeys[i];
        NSString *content = dict[key];
        [msgManager setObject:content forKey:key];
    }
    [msgManager synchronize];
}

- (void)removeAllMessage
{
    
    CHBUserMsgManager *msgManager = [CHBUserMsgManager sharedTool];
    NSDictionary *dict  = [msgManager dictionaryRepresentation];
    for (NSString *key in [dict allKeys]) {
        [msgManager removeObjectForKey:key];
        [msgManager synchronize];
        
    }
}
- (NSString *)getSanBoxPath {
    NSString *sanboxPathStr = NSHomeDirectory();
    return sanboxPathStr;
    
}

- (NSString *)getDocumentsPath {
    NSArray *documentPOaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentPath = [documentPOaths objectAtIndex:0];
    return doucmentPath;
    
}

- (NSString *)getLibraryPath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryStrPath = [pathArray objectAtIndex:0];
    return libraryStrPath;
}

- (NSString *)getCachesPath {
    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [cachesPaths objectAtIndex:0];
    return cachesPath;
}

- (NSString *)getTmpPath {
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}




@end
