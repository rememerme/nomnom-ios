//
//  ViewController.h
//  NomNom
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *uname;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *login;

@end
