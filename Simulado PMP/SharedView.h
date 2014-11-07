//
//  SharedView.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 06/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharedView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

@end
