//
//  NSDate+NhauHoy.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "NSDate+NhauHoy.h"

@implementation NSDate (NhauHoy)

- (NSString *)presentationString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy hh:mm a";
    return [formatter stringFromDate:self];
}

@end
