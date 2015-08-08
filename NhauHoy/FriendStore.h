//
//  FriendStore.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendStore : NSObject

+ (instancetype)store;

@property (nonatomic) NSMutableArray *friendList;

@end
