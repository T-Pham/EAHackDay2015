//
//  FriendStore.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "FriendStore.h"

@implementation FriendStore

+ (instancetype)store {
    static FriendStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

- (instancetype)init {
    self = [super init];
    _friendList = [NSMutableArray array];
    return self;
}

@end
