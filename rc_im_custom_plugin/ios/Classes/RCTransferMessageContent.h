//
//  TransferMessageContent.h
//  WeiZhiFu
//
//  Created by ZhiCheng on 16/8/18.
//  Copyright © 2016年 com.ningbo.lepu. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface RCTransferMessageContent : RCMessageContent

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *payType;

+ (instancetype)messageWithContent:(NSString *)ID
                            remark:(NSString *)remark
                            amount:(NSString *)amount
                           payType:(NSString *)payType
                            userId:(NSString *)userId
                               name:(NSString *)name
                           portrait:(NSString *)portrait;

@end
