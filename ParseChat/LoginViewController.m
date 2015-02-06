//
//  LoginViewController.m
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ChatViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (void) navigateToChatScreen;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordText.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignIn:(id)sender {
    [PFUser logInWithUsernameInBackground:self.userNameText.text password:self.passwordText.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self navigateToChatScreen];
        } else {
            NSLog(@"Error sign in");
        }
    }];
}

- (IBAction)onSignUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.userNameText.text;
    user.password = self.passwordText.text;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        if (!error) {
            [self navigateToChatScreen];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Error sign up : %@", errorString);
        }

    }];
}

- (void)navigateToChatScreen {
    [self presentViewController:[[ChatViewController alloc] init] animated:YES completion:nil];
}

@end
