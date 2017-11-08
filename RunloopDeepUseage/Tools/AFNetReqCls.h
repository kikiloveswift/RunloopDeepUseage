//
//  AFNetReqCls.h
//  RunloopDeepUseage
//
//  Created by kong on 2017/11/8.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Method)
{
    MethodGET = 1,
    MethodPOST = 2
};

typedef void (^SuccessBlock)(id obj);

typedef void(^FailureBlock)(id obj);


@interface AFNetReqCls : NSObject

+ (void)requestURL:(NSString *)urlStr
            Method:(Method)m
            Params:(NSDictionary *)params
      HeaderParams:(NSDictionary *)headerParams
          Successs:(SuccessBlock)successblk
           Failure:(FailureBlock)failureBlk;


@end
