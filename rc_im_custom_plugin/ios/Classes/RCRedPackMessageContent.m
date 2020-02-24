//
//  RedPackMessageContent.m
//  WeiZhiFu
//
//  Created by 钱城 on 16/8/13.
//  Copyright © 2016年 com.ningbo.lepu. All rights reserved.
//

#import "RCRedPackMessageContent.h"

@implementation RCRedPackMessageContent

+(instancetype)messageWithContent:(NSString *)ID
                             type:(NSString *)type
                           remark:(NSString *)remark
                          payType:(NSString *)payType
                           userId:(NSString *)userId
                             name:(NSString *)name
                         portrait:(NSString *)portrait {
    RCRedPackMessageContent *message = [[RCRedPackMessageContent alloc] init];
    message.remark = remark;
    message.id = ID;
    message.type = type;
    message.payType = payType;
    message.senderUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
    return message;
}


+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

+ (NSString *)getObjectName {
    return @"WZFRedPackMessage";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.payType = [aDecoder decodeObjectForKey:@"payType"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.payType forKey:@"payType"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
}

#pragma mark – RCMessageCoding delegate methods

- (NSData *)encode {

    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.type forKey:@"type"];
    [dataDict setObject:self.id forKey:@"id"];
    [dataDict setObject:self.payType forKey:@"payType"];
    [dataDict setObject:self.remark forKey:@"remark"];

    if (self.senderUserInfo) {
        NSMutableDictionary *__dic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [__dic setObject:self.senderUserInfo.name forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [__dic setObject:self.senderUserInfo.portraitUri forKeyedSubscript:@"icon"];
        }
        if (self.senderUserInfo.userId) {
            [__dic setObject:self.senderUserInfo.userId forKeyedSubscript:@"id"];
        }
        [dataDict setObject:__dic forKey:@"user"];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
    return data;
}

- (void)decodeWithData:(NSData *)data {
    __autoreleasing NSError *__error = nil;
    if (!data) {
        return;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&__error];
    if (json) {
        self.type = json[@"type"];
        self.id = json[@"id"];
        self.payType = json[@"payType"];
        self.remark = json[@"remark"];
    }
}

- (NSString *)conversationDigest {
    return @"彩包";
}

@end
