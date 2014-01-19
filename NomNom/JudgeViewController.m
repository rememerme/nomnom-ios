//
//  JudgeViewController.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "JudgeViewController.h"

@interface JudgeViewController ()

@end

@implementation JudgeViewController

-(id) initWithUser:(User *)user andGame:(Game *)game {
    self = [super init];
    _user = user;
    _game = game;
    GameService *gs = [[GameService alloc] init];
    Round *r = [gs getCurrentRoundForGameID:_game.game_id andSession:_user];
    _phrase_card = [gs getCardWithRound:r andSession:_user];
    _nominations = [[NSArray alloc]init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[@"nom_final.json" stringByDeletingPathExtension] ofType:[@"nom_final.json" pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in results) {
        NominationCard *nom = [[NominationCard alloc] init];
        nom.nomination_card_id = (NSString*)[dict objectForKey:@"nomination_card_id"];
        nom.term = (NSString*)[dict objectForKey:@"term"];
        nom.description = (NSString*)[dict objectForKey:@"description"];
        [ret addObject:nom];
    }
    _nominations = [[NSArray alloc] initWithArray:ret];
    NSLog(@"Loaded: %@", _nominations);
    
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the vie
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NomNomView *v = [[NomNomView alloc] initWithFrame:CGRectMake(10, 10, 300, 120) andUser:_user andGame:_game];
    v.backgroundColor = [UIColor orangeColor];
    v.layer.borderColor = [UIColor lightGrayColor].CGColor;
    v.layer.borderWidth = 0.5f;
    v.term.text = _phrase_card.term;
    v.description.text = _phrase_card.description;
    
    UIView *nominations = [[UIView alloc]initWithFrame:CGRectMake(20, 140, 280, 40*[_nominations count])] ;
    nominations.backgroundColor = [UIColor whiteColor];
    nominations.layer.cornerRadius = 5.f;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    [scrollView addSubview:v];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height*3)];
    [self generateLabelsOnView:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateLabelsOnView:(UIView*)view {
    int i = 0;
    NSLog(@"Size of _nominations: %i", [_nominations count]);
    for (NominationCard* nom in _nominations) {
        
        NomNomView *v = [[NomNomView alloc] initWithFrame:CGRectMake(10, 160+i*160, 300, 120) andUser:_user andGame:_game];
        v.backgroundColor = [UIColor greenColor];
        v.layer.borderColor = [UIColor lightGrayColor].CGColor;
        v.layer.borderWidth = 0.5f;
        v.term.text = nom.term;
        v.description.text = nom.description;
        [view addSubview:v];
        
        
        i++;
        NSLog(@"Made entry for %@", nom.term);
    }
}


@end
