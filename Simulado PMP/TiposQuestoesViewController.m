//
//  TiposQuestoesViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "TiposQuestoesViewController.h"

@interface TiposQuestoesViewController ()

@end

@implementation TiposQuestoesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scroller setScrollEnabled:YES];
    _scroller.contentSize = CGSizeMake(320*2, 300);
    _control.numberOfPages = 2;
    [_scroller setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pageControlClick:(id)sender {
    NSInteger page=_control.currentPage;
    CGRect frame=_scroller.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y=0;
    [_scroller scrollRectToVisible:frame animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _control.currentPage=page;
}

@end
