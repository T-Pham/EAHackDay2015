//
//  CreateEventViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <MBProgressHUD.h>
#import <UIAlertView+Block.h>

#import "CreateEventViewController.h"
#import "ServerHelper.h"
#import "Event.h"
#import "EventStore.h"

@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create Event";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
}

- (void)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonTapped:(id)sender {
    [self sendCreateEventRequest];
}

- (void)sendCreateEventRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *name = _nameField.text;
    NSDate *startDate = _dateField.date;
    NSNumber *totalBill = @(_totalBillField.text.integerValue);

    [ServerHelper getJsonFromPath:@"/v1/events" parameters:@{@"name": name, @"start_time": startDate, @"total_bill": totalBill} requestMethod:@"POST" success:^(id response) {
        Event *event = [[Event alloc] initWithData:response[@"event"]];
        [[EventStore store].eventList addObject:event];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Failed to create event" message:error.localizedDescription cancelButtonTitle:@"Cancel" otherButtonTitle:@"Retry"] showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self sendCreateEventRequest];
            }
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
