//
//  MenuViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "MenuViewController.h"
#import "QuestoesViewController.h"
#import "Utilidades.h"
#import <AFNetworking.h>

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"questoesFavoritas"]){
        Utilidades* util = [Utilidades sharedManager];
        QuestoesViewController* questoes = [segue destinationViewController];
        questoes.listaQuestoes = [util getAllFavoritas];
        if(questoes.listaQuestoes.count > 0){
        questoes.questaoSelecionada = [questoes.listaQuestoes objectAtIndex:0];
        }
    }
}



- (IBAction)apertarBotao:(id)sender {
    Utilidades* util = [Utilidades sharedManager];
    [util consultarFavoritosRede];
}
@end
