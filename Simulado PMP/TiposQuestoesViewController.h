//
//  TiposQuestoesViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiposQuestoesViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *control;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
- (IBAction)pageControlClick:(id)sender;

@end
