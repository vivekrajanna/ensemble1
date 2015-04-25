//
//  YMLModel.h
//  ensemble
//
//  Created by vivek on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"




@class YLModel;

typedef void (^YLSuccessBlock)(id responseObject);
typedef void (^YLFailureBlock)(NSError *error);

@interface YLModel : AFHTTPSessionManager


- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(YLSuccessBlock) success
        failure:(YLFailureBlock) failure;

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(YLSuccessBlock) success
           failure:(YLFailureBlock) failure;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(YLSuccessBlock) success
         failure:(YLFailureBlock) failure;

@end


extern NSString *const YLModelErrorDomain;

typedef enum _ErrorServer {
    eErrorServerFailed = 0,//api failour
    eErrorServerResponseDataNil,
    eErrorServerNetworkIssue,//network issue
    eErrorServerTokenInvalid,
}ErrorServer;
