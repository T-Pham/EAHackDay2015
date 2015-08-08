//
//  Event.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    self.data = data;
    return self;
}

- (NSString *)eid {
    return _data[@"_id"];
}

- (NSString *)name {
    return _data[@"name"];
}

- (NSDate *)startTime {
    return _data[@"start_time"];
}

- (NSArray *)friendIdList {
    return _data[@"rsvps"];
}

- (NSArray *)billIdList {
    return _data[@"bills"];
}

@end
