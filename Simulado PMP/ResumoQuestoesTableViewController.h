//
//  ResumoQuestoesTableViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZXLSReader.h"
#import "Questao.h"

@interface ResumoQuestoesTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray* listaQuestoes;
@property (strong,nonatomic) Questao* questaoSelecionada;

@end
