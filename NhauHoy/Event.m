//
//  Event.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <ISO8601DateFormatter.h>

#import "Event.h"

@implementation Event

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    self.data = data;
    return self;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    _startTime = [[[ISO8601DateFormatter alloc] init] dateFromString:_data[@"start_time"]];
}

- (NSString *)eid {
    return _data[@"_id"];
}

- (NSString *)name {
    return _data[@"name"];
}

- (NSArray *)friendIdList {
    return _data[@"rsvps"];
}

- (NSArray *)billIdList {
    return _data[@"bills"];
}

@end
