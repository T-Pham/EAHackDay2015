//
//  ServerHelper.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <AFNetworking.h>
#import <ISO8601DateFormatter.h>

#import "ServerHelper.h"
#import "Session.h"

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
    return [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:@"http://403f500b.ngrok.com/"]];
}

+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self getJsonFromPath:path parameters:parameters requestMethod:requestMethod timeout:30 success:success failure:failure];
}

+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)originalParameters requestMethod:(NSString *)requestMethod timeout:(NSTimeInterval)timeout success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSURL *url = [self urlWithPath:path];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NSString *key in originalParameters.allKeys) {
        NSObject *value = originalParameters[key];
        if ([value isKindOfClass:[NSDate class]]) {
            value = [[[ISO8601DateFormatter alloc] init] stringFromDate:(NSDate *)value];
        }
        parameters[key] = value;
    }

    NSString *token = [Session currentSession].data[@"session"][@"token"];
    if (token) {
        parameters[@"nhau_i_token"] = token;
    }

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
