//
//  EventListViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIAlertView+Block.h>

#import "EventListViewController.h"

@interface EventListViewController ()

@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Event List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];
}

- (void)addButtonTapped:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Create new event" message:@"Enter event name" cancelButtonTitle:@"Cancel" otherButtonTitle:@"Create"];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSLog(@"%@", [[alertView textFieldAtIndex:0] text]);
        }
    }];
}

@end
