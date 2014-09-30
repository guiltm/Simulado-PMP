//
//  QuestoesViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestoesViewController : UIViewController

@property (strong,nonatomic)NSMutableArray* listaQuestoes;
@property (strong,nonatomic)NSDictionary* questaoSelecionada;

@end
