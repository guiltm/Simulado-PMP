//
//  QuestoesViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestoesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *txtConteudo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemA;
@property (strong, nonatomic) IBOutlet UILabel *lblItemB;
@property (strong, nonatomic) IBOutlet UILabel *lblItemC;
@property (strong, nonatomic) IBOutlet UILabel *lblItemD;

@property (strong, nonatomic) IBOutlet UIButton *btmA;
@property (strong, nonatomic) IBOutlet UIButton *btmB;
@property (strong, nonatomic) IBOutlet UIButton *btmC;
@property (strong, nonatomic) IBOutlet UIButton *btmD;

- (IBAction)btmAClick:(id)sender;

- (IBAction)btmBClick:(id)sender;

- (IBAction)btmCClick:(id)sender;

- (IBAction)btmDClick:(id)sender;

@property (strong,nonatomic)NSMutableArray* listaQuestoes;
@property (strong,nonatomic)NSDictionary* questaoSelecionada;

@end
