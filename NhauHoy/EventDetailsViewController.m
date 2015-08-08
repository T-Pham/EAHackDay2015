//
//  EventDetailsViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "NSDate+NhauHoy.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    _nameLabel.text = _event.name;
    _dateLabel.text = _event.startTime.presentationString;
}

- (void)setEvent:(Event *)event {
    _event = event;
    [self reloadData];
}

- (void)editFriendsButtonTapped:(id)sender {
    FriendListViewController *friendListViewController = [[FriendListViewController alloc] init];
    friendListViewController.selectedFriendIdList = _event.friendIdList;
    friendListViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:friendListViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)friendListViewControllerDidSave:(FriendListViewController *)friendListViewController {
    _event.friendIdList = friendListViewController.selectedFriendIdList;
}

@end
