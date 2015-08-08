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

@interface FriendListViewController ()

@end

@implementation FriendListViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [FriendStore store].friendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[FriendStore store].friendList[indexPath.row] name];
    return cell;
}

@end
