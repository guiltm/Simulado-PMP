//
//  QuestoesViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "QuestoesViewController.h"
#import "ScrollPagingViewController.h"

@interface QuestoesViewController ()

@end

@implementation QuestoesViewController

- (void)viewDidLoad // adicionar todos os componentes via codigo
{
    [super viewDidLoad];
    _myToolBar.frame = CGRectMake(0, 0, 320, 60);
    _myToolBar.barTintColor = [UIColor colorWithRed:(3/255.f) green:(38/255.f) blue:(74/255.f) alpha:1.0f];
    _favorito.tintColor = [UIColor whiteColor];
    
    [scroller setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [scroller setScrollEnabled:YES];
    if(_listaQuestoes.count > 20)
        simulado=true;
    else
        simulado=false;
    [self carregarInfoIniciais];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)carregarInfoIniciais{
    
    if(![self.questaoSelecionada respondido])
        [self habilitar];
    else {
        [self marcarOldRespondido];
        if(!simulado)
        [self desabilitar];
    }
    
    NSString* cont = [[NSString alloc]initWithFormat:@"%lu",(self.listaQuestoes.count-1)];
    if([[self.questaoSelecionada index]isEqualToString:@"0"]) self.btmAnterior.hidden = YES;
    if([[self.questaoSelecionada index]isEqualToString:cont]) self.btmProximo.hidden = YES;
    
    [self carregarValores];
    [self organizarItens];
    if(![timer isValid])
    [self startTime];
}


- (void) carregarValores {
    // nao sei se isso e preciso
    long index = [[self.questaoSelecionada index]longLongValue];
    self.indiceQuestoes.text = [NSString stringWithFormat:@"%ld/%lu",++index,(unsigned long)self.listaQuestoes.count];
    
    self.lblConteudo.text =[[[self.questaoSelecionada numero]stringByAppendingString:@") "]stringByAppendingString:[self.questaoSelecionada descricao]];
    self.lblItemA.text = self.questaoSelecionada.itemA;
    self.lblItemB.text = self.questaoSelecionada.itemB;
    self.lblItemC.text = self.questaoSelecionada.itemC;
    self.lblItemD.text = self.questaoSelecionada.itemD;
    if(_questaoSelecionada.favorita == YES)
        _favorito.tintColor = [UIColor yellowColor];
    else
        _favorito.tintColor = [UIColor whiteColor];
    
}

#pragma mark - Timer

-(void)setarTempo:(NSString*)tempo{
    if([tempo isEqualToString:@"50"]){ // 1 hora
        horas = 0;
    }else if([tempo isEqualToString:@"100"]){ // 2 horas
        horas = 1;
    }else if([tempo isEqualToString:@"200"]){ // 4 horas
        horas = 3;
    }
    minutos = 59; // 59 (Alterar depois dos testes)
    segundos = 60; // 60
}

-(void)startTime {
    if(!simulado)
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countUp) userInfo:nil repeats:YES]; // tick
    else{
    [self setarTempo:[NSString stringWithFormat:@"%lu",(unsigned long)self.listaQuestoes.count]];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES]; // tick}
    }
}

- (void) formatarHora{
    
    NSString*h = [NSString stringWithFormat:@"%d",horas];
    if(h.length==1) h = [@"0" stringByAppendingString:h];
    NSString*m = [NSString stringWithFormat:@"%d",minutos];
    if(m.length==1) m = [@"0" stringByAppendingString:m];
    NSString*s = [NSString stringWithFormat:@"%d",segundos];
    if(s.length==1) s = [@"0" stringByAppendingString:s];
    
    self.cronometro.text = [NSString stringWithFormat:@"%@:%@:%@" ,h ,m ,s];
}


-(void) countUp {
    segundos++;
    if(segundos==60){
        segundos=0;
        minutos++;
    }
    if(minutos==60){
        minutos=0;
        horas++;
    }
    [self formatarHora];
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
        [self desabilitar];
        [alert show];// tomar alguma ação quando acabar!
    }
    if(horas == 0 && minutos < 10){
        self.cronometro.textColor = [UIColor redColor];
    }
    
    [self formatarHora];
}

#pragma mark - Layout

-(void)organizarItens {
    //
    float sangria = 20.0f;
    // conteudo
    CGSize sizeContent = [self getSize:self.lblConteudo];
    self.lblConteudo.frame = CGRectMake(self.lblConteudo.frame.origin.x, self.lblConteudo.frame.origin.y, sizeContent.width, sizeContent.height);
    
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
    
    CGRect frame = [umLabel.text boundingRectWithSize:CGSizeMake(270, MAXFLOAT)//umLabel.frame.size.width
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributesDictionary
                                            context:nil];
    
    return frame.size;
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
    if([[segue identifier] isEqualToString:@"scrollPageView"]){
        ScrollPagingViewController* controler = [segue destinationViewController];
        controler.listaQuestoes = self.listaQuestoes;
    }
}

- (IBAction)proximo:(id)sender {
    
    [UIView beginAnimations:@"Flip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    long index = [[self.questaoSelecionada index]integerValue];
    if([sender tag]==1){ // proximo
        self.btmAnterior.hidden = NO;
        index++;
        if(index < [[self listaQuestoes] count]){
            self.questaoSelecionada = [self.listaQuestoes objectAtIndex:index];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        }else{
            self.btmProximo.hidden = YES;
        }
    }else if([sender tag]==0){ // anterior
        self.btmProximo.hidden = NO;
        if(index > 0){
            self.questaoSelecionada = [self.listaQuestoes objectAtIndex:--index]; // pega o anterior
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        }else{
            self.btmAnterior.hidden = YES;
        }
    }
    [UIView commitAnimations];
    [self viewDidLoad];

}

- (IBAction)finalizar:(id)sender {
    
}

#pragma mark - Actions

- (IBAction)btmAClick:(id)sender {
    [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setRespondido:@"a"];
        if(![[self marcarCorreto] isEqualToString:@"a"]){
            self.lblItemA.textColor = [UIColor redColor];
        }
    if(simulado){
        [self limparCores];
        self.lblItemA.textColor = [UIColor blueColor];
    }
}

- (IBAction)btmBClick:(id)sender {
    [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setRespondido:@"b"];
    if(![[self marcarCorreto] isEqualToString:@"b"]){
        self.lblItemB.textColor = [UIColor redColor];
    }
    if(simulado){
        [self limparCores];
        self.lblItemB.textColor = [UIColor blueColor];
    }
}

- (IBAction)btmCClick:(id)sender {
    [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setRespondido:@"c"];
    if(![[self marcarCorreto] isEqualToString:@"c"]){
        self.lblItemC.textColor = [UIColor redColor];
    }
    if(simulado){
        [self limparCores];
        self.lblItemC.textColor = [UIColor blueColor];
    }
}

- (IBAction)btmDClick:(id)sender {
    [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setRespondido:@"d"];
    if(![[self marcarCorreto] isEqualToString:@"d"]){
        self.lblItemD.textColor = [UIColor redColor];
    }
    if(simulado){
        [self limparCores];
        self.lblItemD.textColor = [UIColor blueColor];
    }
}

- (NSString*)marcarCorreto{ // marca a opcao correta
    NSString*correto = self.questaoSelecionada.correto;
    if(!simulado){
        float red = (35/255.f);
        float green = (142/255.f);
        float blue = (35/255.f) ;
        if([correto  isEqualToString: @"a"]){
            self.lblItemA.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
        }else if([correto isEqualToString:@"b"]){
            self.lblItemB.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
        }else if([correto isEqualToString:@"c"]){
            self.lblItemC.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
        }else if([correto isEqualToString:@"d"]){
            self.lblItemD.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
        }
        [self desabilitar]; // desabilita os botoes
    }
    
    if([correto isEqual:[self.questaoSelecionada respondido]])
        [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setAcertou:@"s"];
    else
        [[self.listaQuestoes objectAtIndex:[[self.questaoSelecionada index]integerValue]]setAcertou:@"n"];
    return correto;
}

#pragma mark - Util

- (void) marcarOldRespondido{
    [self limparCores];
    
    if([self.questaoSelecionada.respondido isEqualToString:@"a"])
        [self.btmA sendActionsForControlEvents:UIControlEventTouchUpInside];
    if([self.questaoSelecionada.respondido isEqualToString:@"b"])
        [self.btmB sendActionsForControlEvents:UIControlEventTouchUpInside];
    if([self.questaoSelecionada.respondido isEqualToString:@"c"])
        [self.btmC sendActionsForControlEvents:UIControlEventTouchUpInside];
    if([self.questaoSelecionada.respondido isEqualToString:@"d"])
        [self.btmD sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void) limparCores{
    self.lblItemA.textColor = [UIColor blackColor];
    self.lblItemB.textColor = [UIColor blackColor];
    self.lblItemC.textColor = [UIColor blackColor];
    self.lblItemD.textColor = [UIColor blackColor];
}

- (void) desabilitar {
    self.btmA.enabled = false;
    self.btmB.enabled = false;
    self.btmC.enabled = false;
    self.btmD.enabled = false;
}

- (void) habilitar {
    self.btmA.enabled = true;
    self.btmB.enabled = true;
    self.btmC.enabled = true;
    self.btmD.enabled = true;
    [self limparCores];
}

- (IBAction)favoritarQuestao:(id)sender {
    UIBarButtonItem* barbutton = sender;
    
    if(barbutton.tintColor == [UIColor whiteColor]){
        barbutton.tintColor = [UIColor yellowColor];
        [[self.listaQuestoes objectAtIndex:[[_questaoSelecionada index]integerValue]]setFavorita:YES];
        // salvar no banco
    }else{
        barbutton.tintColor = [UIColor whiteColor];
        [[self.listaQuestoes objectAtIndex:[[_questaoSelecionada index]integerValue]]setFavorita:NO];
        // salvar no banco
    }
}

- (IBAction)fechar:(id)sender {
    [timer invalidate];
    for (Questao *q in _listaQuestoes) {
        q.respondido = nil;
        q.acertou = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
