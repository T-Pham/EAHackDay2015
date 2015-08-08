//
//  EventDetailsViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "NSDate+NhauHoy.h"
#import "FriendListViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    _nameLabel.text = _event.name;
    _totalBillLabel.text = _event.totalBill.description;
    _dateLabel.text = _event.startTime.presentationString;
}

- (void)setEvent:(Event *)event {
    _event = event;
    [self reloadData];
}

- (void)editFriendsButtonTapped:(id)sender {
    FriendListViewController *friendListViewController = [[FriendListViewController alloc] init];
    friendListViewController.event = _event;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:friendListViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
