//
//  ScrollPagingViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 25/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "ScrollPagingViewController.h"

@interface ScrollPagingViewController ()

@end

@implementation ScrollPagingViewController
Questao* questaoSelecionada;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_scroller setScrollEnabled:YES];
    int roundedUp = ceil(_listaQuestoes.count / 25);
    _scroller.contentSize = CGSizeMake(320*roundedUp, 480);
    [self.scroller setDelegate:self];//Set delegate
    [self ordenarQuestoes];
}

- (void) ordenarQuestoes {
    
    float x=16.0;
    float y=16.0;
    float larg=45.0;
    float alt=70.0;
    float inicio = 16;
    
    for (int i=1; i<=_listaQuestoes.count; i++) {
        
        UIButton *bt =[UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(x, y, larg, alt); // 16 espaco
        [bt setTitle:[[NSString alloc]initWithFormat:@"%d",i] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(questaoSelecionada:) forControlEvents:UIControlEventTouchUpInside];
        bt.backgroundColor = [UIColor grayColor];
        [bt setTag:i-1];
        
        [bt setBackgroundImage:[UIImage imageNamed:@"inicial.png"] forState:UIControlStateNormal];
        bt.titleLabel.textColor=[UIColor whiteColor];
        x+=larg+16;
        
        if(i%5==0){
            x=inicio;
            y+=alt+16;
        }
        
        if(i%25==0){
            y=16;
            x = inicio += 320; // esse inicio eh pra salvar o x para a proxima tela
        }
        
        [_scroller addSubview:bt];
    }

}


-(void)questaoSelecionada:(UIButton*)btn
{
    questaoSelecionada = [_listaQuestoes objectAtIndex:btn.tag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

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
