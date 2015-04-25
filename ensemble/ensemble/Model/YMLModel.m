//
//  YMLModel.m
//  ensemble
//
//  Created by vivek on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import "YMLModel.h"

#import "AFURLResponseSerialization.h"
#import "AFURLConnectionOperation.h"
#import "AFURLRequestSerialization.h"

NSString  *const YLModelErrorDomain = @"YLModelErrorDomain";


@interface NSNull(Integer)
-(NSInteger) integerValue;
@end

@implementation NSNull(Integer)
-(NSInteger)integerValue
{
    return 0;
}
@end

@interface YLModel ()
@end

@implementation YLModel

-(id) initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration ];
    if(self) {
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer = requestSerializer;
    }
    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(YLSuccessBlock) success
        failure:(YLFailureBlock) failure
{
    if(self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:@"Server is not reachable, please try after sometime." forKey:NSLocalizedDescriptionKey];
        if(failure)
            failure([NSError errorWithDomain:YLModelErrorDomain code:eErrorServerNetworkIssue userInfo:userInfo]);
        return;
    }
    
    [super GET:path
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           success(responseObject);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           if(failure)
               failure(error);
       }];
}

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(YLSuccessBlock) success
           failure:(YLFailureBlock) failure
{
    if(self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:@"Server is not reachable, please try after sometime." forKey:NSLocalizedDescriptionKey];
        if(failure)
            failure([NSError errorWithDomain:YLModelErrorDomain code:eErrorServerNetworkIssue userInfo:userInfo]);
        return;
    }
    
    [super DELETE:path
       parameters:parameters
          success:^(NSURLSessionDataTask *task, id responseObject) {
              
              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)task.response;
              if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
                  NSDictionary *dictionary = [httpResponse allHeaderFields];
                  NSLog(@"%@",[dictionary description]);
              }
              
              success(responseObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              
              if(failure)
                  failure(error);
          }];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(YLSuccessBlock) success
         failure:(YLFailureBlock) failure
{
    if(self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:@"Server is not reachable, please try after sometime." forKey:NSLocalizedDescriptionKey];
        if(failure)
            failure([NSError errorWithDomain:YLModelErrorDomain code:eErrorServerNetworkIssue userInfo:userInfo]);
        return;
    }
    
    [super POST:path
     parameters:parameters
        success:^(NSURLSessionDataTask *task, id responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)task.response;
            if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                NSLog(@"%@",[dictionary description]);
            }
            
            success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if(failure)
                failure(error);
        }];
}

@end
