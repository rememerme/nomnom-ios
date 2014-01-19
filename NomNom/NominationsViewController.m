//
//  NominationsViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "NominationsViewController.h"

@interface NominationsViewController ()

@end

@implementation NominationsViewController

-(id) initWithUser:(User *)user andGame:(Game *)game {
    self = [super init];
    _user = user;
    _game = game;
    GameService *gs = [[GameService alloc] init];
    Round *r = [gs getCurrentRoundForGameID:_game.game_id andSession:_user.user_id];
    _phrase_card = [gs getCardWithRound:r andSession:_user];
    _nominations = [[NSArray alloc]init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *nominations = [[UIView alloc]initWithFrame:CGRectMake(20, 140, 280, 40*[_nominations count])];
    nominations.backgroundColor = [UIColor whiteColor];
    nominations.layer.cornerRadius = 5.f;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height*3)];
    [self generateLabelsOnView:nominations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateLabelsOnView:(UIView*)view {
    int i = 0;
    NSLog(@"Size of _routes: %i", [_nominations count]);
    for (NominationCard* nom in _nominations) {
        UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, i*40, 280, 40)];
        //subView.layer.cornerRadius = 5.f;
        subView.backgroundColor = [UIColor whiteColor];
        subView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        subView.layer.borderWidth = 0.5f;
        UILabel *favLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 40)];
        favLabel.text = nom.term;
        favLabel.accessibilityLabel = nom.description;
        favLabel.textColor = [UIColor darkTextColor];
        [subView addSubview:favLabel];
        [view addSubview:subView];
        i++;
        NSLog(@"Made entry for %@", nom.term);
    }
}


@end
