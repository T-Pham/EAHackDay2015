//
//  Session.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+ (instancetype)currentSession;
+ (void)setCurrentSessionWithData:(NSDictionary *)data;

@end
