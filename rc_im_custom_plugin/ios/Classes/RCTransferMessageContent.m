//
//  TransferMessageContent.m
//  WeiZhiFu
//
//  Created by ZhiCheng on 16/8/18.
//  Copyright © 2016年 com.ningbo.lepu. All rights reserved.
//

#import "RCTransferMessageContent.h"

@implementation RCTransferMessageContent

+ (instancetype)messageWithContent:(NSString *)ID
                            remark:(NSString *)remark
                            amount:(NSString *)amount
                           payType:(NSString *)payType
                            userId:(NSString *)userId
                               name:(NSString *)name
                           portrait:(NSString *)portrait{
    RCTransferMessageContent *message = [[RCTransferMessageContent alloc] init];
    message.remark = remark;
    message.id = ID;
    message.amount = amount;
    message.payType = payType;
    message.senderUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
    return message;
}

+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

+ (NSString *)getObjectName {
    return @"WZFTransferMessage";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.amount = [aDecoder decodeObjectForKey:@"amount"];
        self.payType = [aDecoder decodeObjectForKey:@"payType"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.payType forKey:@"payType"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
}

#pragma mark – RCMessageCoding delegate methods

- (NSData *)encode {

    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.amount forKey:@"amount"];
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
        self.amount = json[@"amount"];
        self.id = json[@"id"];
        self.payType = json[@"payType"];
        self.remark = json[@"remark"];
    }
}

- (NSString *)conversationDigest {
    return @"兑换";
}

@end
