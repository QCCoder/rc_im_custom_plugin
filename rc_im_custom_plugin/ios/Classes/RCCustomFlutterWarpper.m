//
//  RCCustomFlutterWarpper.m
//  Runner
//
//  Created by 钱城 on 2020/2/24.
//

#import <Flutter/Flutter.h>
#import <RongIMLib/RongIMLib.h>
#import "RcCustomDefine.h"
#import "RCCustomFlutterWarpper.h"
#import "RCRedPackMessageContent.h"
#import "RCTransferMessageContent.h"
@interface RCCustomFlutterWarpper ()
@property (nonatomic, strong) FlutterMethodChannel *channel;
@end


@implementation RCCustomFlutterWarpper

+ (instancetype)sharedWrapper {
    static RCCustomFlutterWarpper *wrapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wrapper = [[self alloc] init];
    });
    return wrapper;
}

- (void)addFlutterChannel:(FlutterMethodChannel *)channel {
    self.channel = channel;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {   
    if([RCCustomMethodKeyRegisterRedPackMessage isEqualToString:call.method]){
        [self registerRedPackMessage:call.arguments];
    }else if([RCCustomMethodKeySendRedPackMessage isEqualToString:call.method]){
        [self sendRedPackMessage:call.arguments];
    } else if([RCCustomMethodKeyRegisterTransferMessage isEqualToString:call.method]){
        [self registerTransferMessage:call.arguments];
    }else if([RCCustomMethodKeySendTransferMessage isEqualToString:call.method]){
        [self sendTransferMessage:call.arguments];
    }
}

#pragma mark - selector
- (void)registerRedPackMessage:(id)arg {
    NSLog(@"注册自定义红包消息 RCRedPackMessageContent");
   [[RCIMClient sharedRCIMClient] registerMessageType:[RCRedPackMessageContent class]];
}

- (void)sendRedPackMessage:(id)arg {
    NSLog(@"sendRedPackMessage");
    if([arg isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)arg;
        NSInteger conversationType = [dic[@"conversationType"] intValue];
        NSString *targetId = dic[@"targetId"];
        NSString *ID = dic[@"id"];
        NSString *type = dic[@"type"];
        NSString *remark = dic[@"remark"];
        NSString *payType = dic[@"payType"];
        NSString *userId = dic[@"userId"];
        NSString *name = dic[@"name"];
        NSString *portrait = dic[@"portrait"];
        NSString *pushData = dic[@"pushData"];
        NSString *pushContent = dic[@"pushContent"];
        RCRedPackMessageContent *message = [RCRedPackMessageContent messageWithContent:ID type:type remark:remark payType:payType userId:userId name:name portrait:portrait];
        
         __weak typeof(self) ws = self;
        [[RCIMClient sharedRCIMClient] sendMessage:conversationType targetId:targetId content:message pushContent:pushContent pushData:pushData success:^(long messageId) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:@(messageId) forKey:@"messageId"];
            [dic setObject:@(SentStatus_SENT) forKey:@"status"];
            [dic setObject:@(0) forKey:@"code"];
            [ws.channel invokeMethod:RCCustomMethodCallBackKeySendMessage arguments:dic];
        } error:^(RCErrorCode nErrorCode, long messageId) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:@(messageId) forKey:@"messageId"];
            [dic setObject:@(SentStatus_FAILED) forKey:@"status"];
            [dic setObject:@(nErrorCode) forKey:@"code"];
            [ws.channel invokeMethod:RCCustomMethodCallBackKeySendMessage arguments:dic];
        }];
    }else {
        NSLog(@"sendRedPackMessage 非法参数类型");
    }
}


- (void)registerTransferMessage:(id)arg {
    NSLog(@"注册自定义转账消息 RCTransferMessageContent");
   [[RCIMClient sharedRCIMClient] registerMessageType:[RCTransferMessageContent class]];
}

- (void)sendTransferMessage:(id)arg {
    NSLog(@"sendTransferMessage");
    if([arg isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)arg;
        NSInteger conversationType = [dic[@"conversationType"] intValue];
        NSString *targetId = dic[@"targetId"];
        NSString *content = dic[@"content"];
        NSString *remark = dic[@"remark"];
        NSString *amount = dic[@"amount"];
        NSString *payType = dic[@"payType"];
        NSString *userId = dic[@"userId"];
        NSString *name = dic[@"name"];
        NSString *portrait = dic[@"portrait"];
        NSString *pushData = dic[@"pushData"];
        NSString *pushContent = dic[@"pushContent"];
        RCTransferMessageContent *message = [RCTransferMessageContent messageWithContent:content remark:remark amount:amount payType:payType userId:userId name:name portrait:portrait];
        
         __weak typeof(self) ws = self;
        [[RCIMClient sharedRCIMClient] sendMessage:conversationType targetId:targetId content:message pushContent:pushContent pushData:pushData success:^(long messageId) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:@(messageId) forKey:@"messageId"];
            [dic setObject:@(SentStatus_SENT) forKey:@"status"];
            [dic setObject:@(0) forKey:@"code"];
            [ws.channel invokeMethod:RCCustomMethodCallBackKeySendMessage arguments:dic];
        } error:^(RCErrorCode nErrorCode, long messageId) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:@(messageId) forKey:@"messageId"];
            [dic setObject:@(SentStatus_FAILED) forKey:@"status"];
            [dic setObject:@(nErrorCode) forKey:@"code"];
            [ws.channel invokeMethod:RCCustomMethodCallBackKeySendMessage arguments:dic];
        }];
    }else {
        NSLog(@"sendTransferMessage 非法参数类型");
    }
}
@end
