//
//  Event.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic) NSDictionary *data;
@property (nonatomic) NSString *eid;
@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSArray *friendIdList;
@property (nonatomic) NSArray *billIdList;

- (instancetype)initWithData:(NSDictionary *)data;

@end
