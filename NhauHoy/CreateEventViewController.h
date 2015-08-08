//
//  CreateEventViewController.h
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVFloatLabeledTextField.h>

@interface CreateEventViewController : UIViewController

@property (nonatomic) IBOutlet JVFloatLabeledTextField *nameField;
@property (nonatomic) IBOutlet JVFloatLabeledTextField *totalBillField;
@property (nonatomic) IBOutlet UIDatePicker *dateField;

@end
