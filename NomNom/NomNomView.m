//
//  NomNomView.m
//  NomNom
//
//  Created by Jake Gregg on 1/19/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "NomNomView.h"

@implementation NomNomView

- (id)initWithFrame:(CGRect)frame
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
    }
    return self;
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
