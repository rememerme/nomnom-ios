//
//  ViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UserService.h"
#import "User.h"
#import "Login.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //UIImage *settings = [UIImage imageNamed:@"Settings.png"];
    //UIImage *home = [UIImage imageNamed:@"Home.png"];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:settings.CGImage scale:2.0 orientation:settings.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:home.CGImage scale:2.0 orientation:home.imageOrientation]  style:UIBarButtonItemStyleBordered target:self action:@selector(home)];
    
    // Username field
    _uname = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 250.0f, 300.0f, 30.0f)];
    _uname.backgroundColor = [UIColor whiteColor];
    _uname.textColor = [UIColor blackColor];
    _uname.font = [UIFont systemFontOfSize:14.0f];
    _uname.borderStyle = UITextBorderStyleRoundedRect;
    _uname.clearButtonMode = UITextFieldViewModeWhileEditing;
    _uname.returnKeyType = UIReturnKeyDone;
    _uname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _uname.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _uname.delegate = self;
    
    // Password field
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 290.0f, 300.0f, 30.0f)];
    _password.backgroundColor = [UIColor whiteColor];
    _password.textColor = [UIColor blackColor];
    _password.font = [UIFont systemFontOfSize:14.0f];
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.returnKeyType = UIReturnKeyDone;
    _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _password.secureTextEntry = YES;
    _password.delegate = self;
    
    // Submit button
    _login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_login setFrame:CGRectMake(110, 350, 100, 30)];
    //_login.backgroundColor = [UIColor whiteColor];
    [_login setTitle:@"login" forState:UIControlStateNormal];
    [_login addTarget:self action:@selector(login:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    
    // add to view
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_uname];
    [self.view addSubview:_password];
    [self.view addSubview:_login];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) login:(id)sender {
    Login *creds = [[Login alloc] init];
    creds.username = _uname.text;
    creds.password = _password.text;
    UserService *us = [[UserService alloc] init];
    User *user = [us loginUserWithCredentials:creds];
    HomeViewController *home = [[HomeViewController alloc] initWithUser:user];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:home] animated:YES];
    [[NSUserDefaults standardUserDefaults] setObject:user.username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:user.user_id forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setObject:user.session_id forKey:@"session_id"];
    [[NSUserDefaults standardUserDefaults] setObject:user.date_created forKey:@"date_created"];
    [[NSUserDefaults standardUserDefaults] setObject:user.last_modified forKey:@"last_modified"];
    [[NSUserDefaults standardUserDefaults] setObject:creds.password forKey:@"password"];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
