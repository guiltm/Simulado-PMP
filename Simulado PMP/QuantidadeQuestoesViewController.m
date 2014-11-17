//
//  QuantidadeQuestoesViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 16/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "QuantidadeQuestoesViewController.h"
#import "QuestoesViewController.h"
#import "Utilidades.h"

@interface QuantidadeQuestoesViewController ()

@end

@implementation QuantidadeQuestoesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    QuestoesViewController * controller = [segue destinationViewController];
    Utilidades * util = [Utilidades sharedManager];
    if([[segue identifier] isEqualToString:@"50questoes"])
        controller.listaQuestoes = [util carregarValores:50];
    else if([[segue identifier] isEqualToString:@"150questoes"])
        controller.listaQuestoes = [util carregarValores:150];
    else if([[segue identifier] isEqualToString:@"200questoes"])
        controller.listaQuestoes = [util carregarValores:200];
    
    controller.questaoSelecionada = [controller.listaQuestoes objectAtIndex:0];
}


@end
