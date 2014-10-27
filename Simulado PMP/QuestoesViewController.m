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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    [self carregarValores];
    [self organizarItens];
    [self setarTempo:@"50"]; // esse valor sera passado de uma tela anterior]
    
}

-(void)setarTempo:(NSString*)tempo{
    if([tempo isEqualToString:@"50"]){ // 1 hora
        horas = 0;
    }else if([tempo isEqualToString:@"100"]){ // 2 horas
        horas = 1;
    }else if([tempo isEqualToString:@"200"]){ // 4 horas
        horas = 3;
    }
    minutos = 0; // 59
    segundos = 10; // 60
    [self startTime];
}

-(void)startTime {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

-(void)countDown { // fazer ainda alguns testes
    if(segundos > 0){
        segundos--;
    }else if(minutos > 0 ){
        minutos --;
        segundos = 59;
    }else if(horas > 0){
        horas--;
        minutos=59;
        segundos=59;
    }else{
        [timer invalidate]; // para tudo!
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ACABOOOU!" message:@"Acabou o tempo patito!" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK", nil];
        [alert show];// tomar alguma ação
    }
    if(horas == 0 && minutos < 10){
        self.cronometro.textColor = [UIColor redColor];
    }
    
    // formatando
    
    NSString*h = [NSString stringWithFormat:@"%d",horas];
    if(h.length==1) h = [@"0" stringByAppendingString:h];
    NSString*m = [NSString stringWithFormat:@"%d",minutos];
    if(m.length==1) m = [@"0" stringByAppendingString:m];
    NSString*s = [NSString stringWithFormat:@"%d",segundos];
    if(s.length==1) s = [@"0" stringByAppendingString:s];
    
    self.cronometro.text = [NSString stringWithFormat:@"%@:%@:%@" ,h ,m ,s];
}


-(void)organizarItens{
    //
    float sangria = 20.0f;
    // conteudo
    CGSize sizeContent = [self getSize:self.lblConteudo];
    self.lblConteudo.frame = CGRectMake(self.lblConteudo.frame.origin.x, self.lblConteudo.frame.origin.y, sizeContent.width, sizeContent.height);
    //self.btmA.frame = CGRectMake(self.lblConteudo.frame.origin.x, self.lblConteudo.frame.origin.y, sizeContent.width, sizeContent.height);
    
    //a
    CGSize sizeA = [self getSize:self.lblItemA];
    self.lblItemA.frame = CGRectMake(self.lblItemA.frame.origin.x, self.lblConteudo.frame.origin.y + sizeContent.height + sangria, sizeA.width, sizeA.height);
    self.btmA.frame = self.lblItemA.frame;
    
    //b
    CGSize sizeB = [self getSize:self.lblItemB];
    self.lblItemB.frame = CGRectMake(self.lblItemB.frame.origin.x, self.lblItemA.frame.origin.y + sizeA.height + sangria, sizeB.width, sizeB.height);
    self.btmB.frame = self.lblItemB.frame;
    //c
    CGSize sizeC = [self getSize:self.lblItemC];
    self.lblItemC.frame = CGRectMake(self.lblItemC.frame.origin.x, self.lblItemB.frame.origin.y + sizeB.height + sangria, sizeC.width, sizeC.height);
    self.btmC.frame = self.lblItemC.frame;
    
    //d
    CGSize sizeD = [self getSize:self.lblItemD];
    self.lblItemD.frame = CGRectMake(self.lblItemD.frame.origin.x, self.lblItemC.frame.origin.y + sizeC.height + sangria, sizeD.width, sizeD.height);
    self.btmD.frame = self.lblItemD.frame;
    
}

-(CGSize)getSize:(id)sender{
    
    UILabel* umLabel = sender;
    NSDictionary *attributesDictionary;
    if(umLabel.tag == 1){ // Conteudo da descricao da questao que possui boldSystemFontOfSize para diferenciar
        attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont boldSystemFontOfSize:umLabel.font.pointSize], NSFontAttributeName,
                                              nil];
    }else{
        attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:umLabel.font.pointSize], NSFontAttributeName,
                                          nil];
    }
    
    CGRect frame = [umLabel.text boundingRectWithSize:CGSizeMake(umLabel.frame.size.width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributesDictionary
                                            context:nil];
    
    return frame.size;
}
- (void) carregarValores {
    self.lblConteudo.text = [[[[self questaoSelecionada]objectForKey:@"NUMEROQUESTAO"]stringByAppendingString:@") "]stringByAppendingString:[[self questaoSelecionada]objectForKey:@"DESCRICAO"]];
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
