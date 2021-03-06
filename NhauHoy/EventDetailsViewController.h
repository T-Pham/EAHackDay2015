//
//  EventDetailsViewController.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/9/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UIViewController

@property (nonatomic) Event *event;

@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *billLabel;
@property (nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)editFriendsButtonTapped:(id)sender;

@end
