//
//  Session.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "Session.h"

@implementation Session
static Session *CurrentSession;

+ (instancetype)currentSession {
    return CurrentSession;
}

+ (void)setCurrentSessionWithData:(NSDictionary *)data {
    if (data) {
        CurrentSession = [[self alloc] init];
        CurrentSession.data = data;
    } else {
        CurrentSession = nil;
    }
}

@end
