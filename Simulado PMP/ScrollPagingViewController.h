//
//  ScrollPagingViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 25/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questao.h"

@interface ScrollPagingViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIPageControl *control;
@property (weak, nonatomic) NSMutableArray* listaQuestoes;
- (IBAction)pageControlClick:(id)sender;

@end
