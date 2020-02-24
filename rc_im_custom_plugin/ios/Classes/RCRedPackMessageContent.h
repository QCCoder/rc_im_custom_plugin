//
//  RedPackMessageContent.h
//  WeiZhiFu
//
//  Created by 钱城 on 16/8/13.
//  Copyright © 2016年 com.ningbo.lepu. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface RCRedPackMessageContent : RCMessageContent <NSCoding, RCMessageContentView>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *payType;

+ (instancetype)messageWithContent:(NSString *)ID
                              type:(NSString *)type
                            remark:(NSString *)remark
                           payType:(NSString *)payType
                            userId:(NSString *)userId
                              name:(NSString *)name
                          portrait:(NSString *)portrait;

@end
