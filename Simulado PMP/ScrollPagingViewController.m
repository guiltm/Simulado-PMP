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
    self.totalPontos.text = _pontos;
    int roundedUp = ceil(_listaQuestoes.count / 25);
    _scroller.contentSize = CGSizeMake(320*roundedUp, self.scroller.frame.size.height);
    [self.scroller setDelegate:self];//Set delegate
    _control.numberOfPages = roundedUp;
    [self ordenarQuestoes];
}

- (void) ordenarQuestoes {
    
    float valorFixo = 11.6666667; // 6 x 11.66 = 70
    
    float x=valorFixo;
    float y=valorFixo;
    float inicio=valorFixo;
    
    float larg=50.0; // 5 x 50 = 250
    float alt=70.0;
    
    for (int i=1; i<=_listaQuestoes.count; i++) {
        
        Questao* q = [_listaQuestoes objectAtIndex:i-1];
        
        UIButton *bt =[UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(x, y, larg, alt); // 16 espaco
        
        i < 10 ?[bt setTitle:[[NSString alloc]initWithFormat:@"00%d",i] forState:UIControlStateNormal] : // colocar um zero antes
        [bt setTitle:[[NSString alloc]initWithFormat:@"0%d",i] forState:UIControlStateNormal];
        
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [[bt titleLabel]setFont:[UIFont boldSystemFontOfSize:12]];
        [[bt layer]setBorderWidth:2.f];
        [[bt layer]setBorderColor:[UIColor grayColor].CGColor];
        [bt addTarget:self action:@selector(questaoSelecionada:) forControlEvents:UIControlEventTouchUpInside];
        //bt.backgroundColor = [UIColor grayColor];
        [bt setTag:i-1];
        
        bt.titleEdgeInsets = UIEdgeInsetsMake(0, 20.f, 47.f, 0); // top, left, botton, right
        
        //bt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        //bt.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        if(!q.favorita && !q.acertou)
            [bt setBackgroundImage:[UIImage imageNamed:@"semnada.png"] forState:UIControlStateNormal];
        
        if(q.favorita && !q.acertou)
            [bt setBackgroundImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
        
        if([q.acertou isEqualToString:@"s"]&& !q.favorita)
            [bt setBackgroundImage:[UIImage imageNamed:@"certo.png"] forState:UIControlStateNormal];
        
        if([q.acertou isEqualToString:@"s"] && q.favorita)
            [bt setBackgroundImage:[UIImage imageNamed:@"certoefav.png"] forState:UIControlStateNormal];
        
        if([q.acertou isEqualToString:@"n"] && !q.favorita)
            [bt setBackgroundImage:[UIImage imageNamed:@"errado.png"] forState:UIControlStateNormal];
        
        if([q.acertou isEqualToString:@"n"] && q.favorita)
            [bt setBackgroundImage:[UIImage imageNamed:@"erradoefav.png"] forState:UIControlStateNormal];

        
        
        bt.titleLabel.textColor=[UIColor whiteColor];
        
        x+=larg+valorFixo;
        
        if(i%5==0){
            x=inicio;
            y+=alt+valorFixo;
        }
        
        if(i%30==0){
            y=valorFixo;
            x = inicio += 320; // esse inicio eh pra salvar o x para a proxima tela
        }
        
        [_scroller addSubview:bt];
    }

}


-(void)questaoSelecionada:(UIButton*)btn
{
    [self.delegate setQuestao:[_listaQuestoes objectAtIndex:btn.tag]];
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)fechar:(id)sender
{
    [self.delegate setQuestao:[_listaQuestoes objectAtIndex:0]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _control.currentPage=page;
}
@end
