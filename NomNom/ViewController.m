//
//  ViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Settings.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(home)];
    
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
    
    // Submit button
    _login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_login setFrame:CGRectMake(110, 350, 100, 30)];
    //_login.backgroundColor = [UIColor whiteColor];
    [_login setTitle:@"poop" forState:UIControlStateNormal];
    //[_login addTarget:self action:@selector(login) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    // add to view
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_uname];
    [self.view addSubview:_password];
    [self.view addSubview:_login];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
