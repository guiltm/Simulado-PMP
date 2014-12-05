//
//  QuestoesViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questao.h"

@protocol ViewQuestoesProtocol

- (void)setQuestao:(Questao *)qsl;

@end

@interface QuestoesViewController : UIViewController <ViewQuestoesProtocol>{
    IBOutlet UIScrollView* scroller;
    NSTimer* timer;
    int horas;
    int minutos;
    int segundos;
    bool simulado;
}
@property (strong, nonatomic) IBOutlet UILabel *lblConteudo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemA;
@property (strong, nonatomic) IBOutlet UILabel *lblItemB;
@property (strong, nonatomic) IBOutlet UILabel *lblItemC;
@property (strong, nonatomic) IBOutlet UILabel *lblItemD;
@property (strong, nonatomic) IBOutlet UILabel *cronometro;
@property (strong, nonatomic) IBOutlet UILabel *indiceQuestoes;
@property (weak, nonatomic) IBOutlet UILabel *lblComentario;

@property (strong, nonatomic) IBOutlet UIButton *btmA;
@property (strong, nonatomic) IBOutlet UIButton *btmB;
@property (strong, nonatomic) IBOutlet UIButton *btmC;
@property (strong, nonatomic) IBOutlet UIButton *btmD;
@property (weak, nonatomic) IBOutlet UIButton *btmAnterior;
@property (weak, nonatomic) IBOutlet UIButton *btmProximo;

@property (weak, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favorito;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *finalizar;
@property (weak, nonatomic) IBOutlet UIButton *buttonPopUp;

- (IBAction)finalizar:(id)sender;

- (IBAction)mostrarOpcoes:(id)sender;

- (IBAction)mostrarComentario:(id)sender;

- (IBAction)favoritarQuestao:(id)sender;

- (IBAction)btmAClick:(id)sender;

- (IBAction)btmBClick:(id)sender;

- (IBAction)btmCClick:(id)sender;

- (IBAction)btmDClick:(id)sender;

- (IBAction)proximo:(id)sender;

@property (strong,nonatomic)NSMutableArray* listaQuestoes; // todas questoes
@property (strong,nonatomic)Questao* questaoSelecionada; // questao selecionada

@end
