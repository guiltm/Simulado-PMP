//
//  SharedView.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 06/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "SharedView.h"

@implementation SharedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    //Note That You Must Change @”BNYSharedView’ With Whatever Your Nib Is Named
    [[NSBundle mainBundle] loadNibNamed:@"SharedView" owner:self options:nil];
    [self addSubview: self.contentView];
}

@end
