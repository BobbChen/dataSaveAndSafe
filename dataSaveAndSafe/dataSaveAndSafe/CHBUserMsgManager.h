//
//  CHBUserMsgManager.h
//  1.MD5加密
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 zhizhangweilai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "KeychainItemWrapper.h"

@interface CHBUserMsgManager : NSUserDefaults
#pragma mark - init CHBUserMsgManager
/** 创建CHBUserMsgManager对象 */
+ (instancetype)sharedTool;

/** MD5加密字符串 */
- (NSString *)encryptionNSString:(NSString *)str;

/** 存储基本的数据信息 */
- (void)saveMessageByNSDictionary:(NSDictionary *)dict;

/** 删除用户的所有信息 */
- (void)removeAllMessage;

#pragma mark - keyChain save
/** 保存数据 */
- (void)saveMsgByKeyChain:(NSString *)key content:(NSString *)content;

/** 获取保存的信息 */
- (NSString *)getKeyChainContent;

/** 清空keyChain中的数据 */
- (void)clearKeyChainMsg;

#pragma mark - get SandBox poth
/** 获取沙盒路径 */
- (NSString *)getSanBoxPath;

/** 获取documents路径 */
- (NSString *)getDocumentsPath;

/** 获取Library路径 */
- (NSString *)getLibraryPath;

/** 获取caches路径 */
- (NSString *)getCachesPath;

/** 获取tmp路径 */
- (NSString *)getTmpPath;



@end
