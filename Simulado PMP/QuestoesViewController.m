//
//  QuestoesViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "QuestoesViewController.h"

@interface QuestoesViewController ()

@end

@implementation QuestoesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //testes
    [[self txtConteudo]sizeToFit];
    
    [self carregarValores];
}

- (void) carregarValores {
    self.txtConteudo.text = [[[[self questaoSelecionada]objectForKey:@"NUMEROQUESTAO"]stringByAppendingString:@") "]stringByAppendingString:[[self questaoSelecionada]objectForKey:@"DESCRICAO"]];
    self.lblItemA.text = [[self questaoSelecionada]objectForKey:@"ITEMA"];
    self.lblItemB.text = [[self questaoSelecionada]objectForKey:@"ITEMB"];
    self.lblItemC.text = [[self questaoSelecionada]objectForKey:@"ITEMC"];
    self.lblItemD.text = [[self questaoSelecionada]objectForKey:@"ITEMD"];
    
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


- (IBAction)btmAClick:(id)sender {
    if(![[self marcarCorreto] isEqualToString:@"a"]){
        self.lblItemA.textColor = [UIColor redColor];
    }
}

- (IBAction)btmBClick:(id)sender {
    if(![[self marcarCorreto] isEqualToString:@"b"]){
        self.lblItemB.textColor = [UIColor redColor];
    }
}
- (IBAction)btmCClick:(id)sender {
    if(![[self marcarCorreto] isEqualToString:@"c"]){
        self.lblItemC.textColor = [UIColor redColor];
    }
}

- (IBAction)btmDClick:(id)sender {
    if(![[self marcarCorreto] isEqualToString:@"d"]){
        self.lblItemD.textColor = [UIColor redColor];
    }
}

- (NSString*)marcarCorreto{ // marca a opcao correta
    NSString*correto = [[self questaoSelecionada]objectForKey:@"CORRETO"];
    if([correto  isEqualToString: @"a"]){
        self.lblItemA.textColor = [UIColor greenColor];
    }else if([correto isEqualToString:@"b"]){
        self.lblItemB.textColor = [UIColor greenColor];
    }else if([correto isEqualToString:@"c"]){
        self.lblItemC.textColor = [UIColor greenColor];
    }else if([correto isEqualToString:@"d"]){
        self.lblItemD.textColor = [UIColor greenColor];
    }
    [self desabilitar]; // desabilita os botoes
    return correto;
}

- (void) desabilitar {
    self.btmA.enabled = false;
    self.btmB.enabled = false;
    self.btmC.enabled = false;
    self.btmD.enabled = false;
}
@end
