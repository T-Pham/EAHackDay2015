//
//  ServerHelper.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <AFNetworking.h>

#import "ServerHelper.h"

@implementation ServerHelper
static AFHTTPRequestOperationManager *requestOperationManager;

+ (void)initialize {
    if (self == [ServerHelper class]) {
        requestOperationManager = [AFHTTPRequestOperationManager manager];
        requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}

+ (NSURL *)urlWithPath:(NSString *)path {
    return [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:@"http://192.168.1.1/"]];
}

+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self getJsonFromPath:path parameters:parameters requestMethod:requestMethod timeout:30 success:success failure:failure];
}

+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod timeout:(NSTimeInterval)timeout success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSURL *url = [self urlWithPath:path];
    NSMutableURLRequest *request = [requestOperationManager.requestSerializer requestWithMethod:requestMethod URLString:url.absoluteString parameters:parameters error:nil];
    request.timeoutInterval = timeout;
    AFHTTPRequestOperation *requestOperation = [requestOperationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) failure(error);
    }];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [requestOperation start];
}

@end
