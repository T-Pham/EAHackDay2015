//
//  MainViewController.m
//  NhauHoy
//
//  Created by Thanh Pham on 8/8/15.
//  Copyright (c) 2015 Thanh Pham. All rights reserved.
//

#import <FBSDKCoreKit.h>
#import <FBSDKLoginKit.h>

#import "MainViewController.h"

@interface MainViewController () <FBSDKLoginButtonDelegate> {
    FBSDKLoginButton *loginButton;
}

@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    loginButton = [[FBSDKLoginButton alloc] init];
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:loginButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    loginButton.center = self.view.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];

    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessTokenDidChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
}

- (void)accessTokenDidChange:(NSNotification *)notification {
    [self signInWhenReady];
}

- (void)signInWhenReady {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    
    NSLog(@"%@ %@", profile.userID, token.tokenString);
}

#pragma mark - FBSDKLoginButtonDelegate
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        [[[UIAlertView alloc] initWithTitle:NSStringFromClass(error.class) message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {}

@end
