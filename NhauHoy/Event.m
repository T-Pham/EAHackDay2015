//
//  Event.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <ISO8601DateFormatter.h>

#import "Event.h"

@interface Event () {
    NSMutableArray *_friendIdList;
}

@end

@implementation Event
@synthesize friendIdList=_friendIdList;

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    self.data = data;
    return self;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    _startTime = [[[ISO8601DateFormatter alloc] init] dateFromString:_data[@"start_time"]];
    _friendIdList = [NSMutableArray arrayWithArray:[_data[@"rsvps"] valueForKey:@"user_id"]];
}

- (NSString *)eid {
    return _data[@"_id"];
}

- (NSString *)name {
    return _data[@"name"];
}

- (NSNumber *)totalBill {
    return _data[@"total_bill"];
}

- (void)setFriendIdList:(NSArray *)friendIdList {
    _friendIdList = [NSMutableArray arrayWithArray:friendIdList];
}

@end
