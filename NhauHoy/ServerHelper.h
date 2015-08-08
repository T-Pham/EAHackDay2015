//
//  ServerHelper.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerHelper : NSObject

+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
+ (void)getJsonFromPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod timeout:(NSTimeInterval)timeout success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
