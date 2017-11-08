//
//  AFNetReqCls.m
//  RunloopDeepUseage
//
//  Created by kong on 2017/11/8.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "AFNetReqCls.h"
#import <AFNetworking.h>

@implementation AFNetReqCls



+ (void)requestURL:(NSString *)urlStr Method:(Method)m Params:(NSDictionary *)params HeaderParams:(NSDictionary *)headerParams Successs:(SuccessBlock)successblk Failure:(FailureBlock)failureBlk
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    for (NSString *keys in headerParams.allKeys)
    {
        [manager.requestSerializer setValue:keys forHTTPHeaderField:headerParams[keys]];
    }
    switch (m)
    {
        case MethodGET:
        {
            [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successblk)
                {
                    id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    successblk(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlk)
                {
                    failureBlk(error);
                }
            }];
        }
            break;
        case MethodPOST:
        {
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successblk)
                {
                    id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    successblk(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlk)
                {
                    failureBlk(error);
                }

            }];
        }
            break;
        default:
            break;
    }
    
}

@end
