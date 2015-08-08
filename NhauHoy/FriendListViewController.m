//
//  FriendListViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIAlertView+Block.h>

#import "FriendListViewController.h"
#import "Friend.h"
#import "FriendStore.h"
#import "ServerHelper.h"

@interface FriendListViewController () {
    NSMutableArray *_selectedFriendIdList;
}

@end

@implementation FriendListViewController
@synthesize selectedFriendIdList=_selectedFriendIdList;

- (instancetype)init {
    self = [super init];
    _selectedFriendIdList = [NSMutableArray array];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friend List";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self fetchFriends];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)fetchFriends {
    [[FriendStore store].friendList removeAllObjects];
    [ServerHelper getJsonFromPath:@"/v1/friends" parameters:nil requestMethod:@"GET" success:^(id response) {
        for (NSDictionary *friendData in response[@"friends"]) {
            Friend *friend = [[Friend alloc] initWithData:friendData];
            [[FriendStore store].friendList addObject:friend];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Failed to fetch friend list" message:error.localizedDescription cancelButtonTitle:@"Cancel" otherButtonTitle:@"Retry"] showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self fetchFriends];
            }
        }];
    }];
}

- (void)setSelectedFriendIdList:(NSArray *)selectedFriendIdList {
    _selectedFriendIdList = [NSMutableArray arrayWithArray:selectedFriendIdList];
    [self.tableView reloadData];
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
