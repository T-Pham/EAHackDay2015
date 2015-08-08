//
//  FriendListViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIAlertView+Block.h>
#import <MBProgressHUD.h>

#import "FriendListViewController.h"
#import "Friend.h"
#import "FriendStore.h"
#import "ServerHelper.h"

@interface FriendListViewController () {
    NSMutableArray *_selectedFriendIdList;
}

@end

@implementation FriendListViewController

- (instancetype)init {
    self = [super init];
    _selectedFriendIdList = [NSMutableArray array];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friend List";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self fetchFriends];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)fetchFriends {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[FriendStore store].friendList removeAllObjects];
    [ServerHelper getJsonFromPath:@"/v1/friends" parameters:nil requestMethod:@"GET" success:^(id response) {
        for (NSDictionary *friendData in response[@"friends"]) {
            Friend *friend = [[Friend alloc] initWithData:friendData];
            [[FriendStore store].friendList addObject:friend];
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Failed to fetch friend list" message:error.localizedDescription cancelButtonTitle:@"Cancel" otherButtonTitle:@"Retry"] showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self fetchFriends];
            }
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setEvent:(Event *)event {
    _event = event;
    [self setSelectedFriendIdList:_event.friendIdList];
}

- (void)setSelectedFriendIdList:(NSArray *)selectedFriendIdList {
    _selectedFriendIdList = [NSMutableArray arrayWithArray:selectedFriendIdList];
    [self.tableView reloadData];
}

- (void)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonTapped:(id)sender {
    [self sendSaveFriendListRequest];
}

- (void)sendSaveFriendListRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ServerHelper getJsonFromPath:@"/v1/rsvps" parameters:@{@"event_id": _event.eid, @"user_ids": _selectedFriendIdList} requestMethod:@"POST" success:^(id response) {
        _event.friendIdList = _selectedFriendIdList;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Failed to update friend list" message:error.localizedDescription cancelButtonTitle:@"Cancel" otherButtonTitle:@"Retry"] showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self sendSaveFriendListRequest];
            }
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [FriendStore store].friendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Friend *friend = [FriendStore store].friendList[indexPath.row];
    cell.textLabel.text = friend.name;
    if ([_selectedFriendIdList containsObject:friend.fid]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Friend *friend = [FriendStore store].friendList[indexPath.row];
    if ([_selectedFriendIdList containsObject:friend.fid]) {
        [_selectedFriendIdList removeObject:friend.fid];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [_selectedFriendIdList addObject:friend.fid];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
