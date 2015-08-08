//
//  EventListViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIAlertView+Block.h>

#import "EventListViewController.h"
#import "ServerHelper.h"
#import "CreateEventViewController.h"
#import "Event.h"
#import "EventStore.h"

@interface EventListViewController ()

@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Event List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self fetchEvents];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)fetchEvents {
    [[EventStore store].eventList removeAllObjects];
    [ServerHelper getJsonFromPath:@"/v1/events" parameters:nil requestMethod:@"GET" success:^(id response) {
        for (NSDictionary *eventData in response[@"events"]) {
            Event *event = [[Event alloc] initWithData:eventData];
            [[EventStore store].eventList addObject:event];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Failed to fetch events" message:error.localizedDescription cancelButtonTitle:@"Cancel" otherButtonTitle:@"Retry"] showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self fetchEvents];
            }
        }];
    }];
}

- (void)addButtonTapped:(id)sender {
    CreateEventViewController *createEventViewController = [[CreateEventViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:createEventViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EventStore store].eventList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[EventStore store].eventList[indexPath.row] name];
    return cell;
}

@end
