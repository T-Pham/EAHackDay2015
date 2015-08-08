//
//  Friend.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic) NSDictionary *data;
@property (nonatomic) NSString *fid;
@property (nonatomic) NSString *name;

- (instancetype)initWithData:(NSDictionary *)data;

@end
