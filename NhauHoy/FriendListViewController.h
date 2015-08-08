//
//  FriendListViewController.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendListViewController;

@protocol FriendListViewControllerDelegate <NSObject>

- (void)friendListViewControllerDidSave:(FriendListViewController *)friendListViewController;

@end

@interface FriendListViewController : UITableViewController

@property (nonatomic) NSArray *selectedFriendIdList;
@property (nonatomic, weak) id<FriendListViewControllerDelegate> delegate;

@end
