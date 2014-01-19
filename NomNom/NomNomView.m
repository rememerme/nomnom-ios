//
//  NomNomView.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "NomNomView.h"

@implementation NomNomView

- (id)initWithFrame:(CGRect)frame andUser:(User*)user andGame:(Game*)game
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _term = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 40)];
        _term.textColor = [UIColor darkTextColor];
        _term.backgroundColor = [UIColor clearColor];
        _term.font=[_term.font fontWithSize:25];
        [self addSubview:_term];
        _description = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 280, 80)];
        _description.textColor = [UIColor darkTextColor];
        _description.backgroundColor = [UIColor clearColor];
        _description.numberOfLines = 2;
        [self addSubview:_description];
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
        // if labelView is not set userInteractionEnabled, you must do so
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

-(void) userTappedOnLink:(id)selector {
    NSString *msg = @"Your friend request to %@ has been approved";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Request Approved" message: msg delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Code for OK button
    }
    if (buttonIndex == 1)
    {
        //Code for download button
        GameService *gs = [[GameService alloc]init];
        NominationCard *nc = [[NominationCard alloc]init];
        nc.nomination_card_id = self.nomination_card_id;
        nc.term = self.term.text;
        nc.description = self.description.text;
        Nomination *n = [gs nominateWithNomination:nc andGame:_game andSession:_user];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
