//
//  Friend.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    self.data = data;
    return self;
}

- (NSString *)fid {
    return _data[@"_id"];
}

- (NSString *)name {
    return _data[@"name"];
}

@end
