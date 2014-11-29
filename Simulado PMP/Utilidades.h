//
//  Utilidades.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 16/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZXLSReader.h"
#import "Questao.h"

@interface Utilidades : NSObject

+(id)sharedManager;
- (NSMutableArray*)carregarValores:(int) numQuestoes;
- (NSMutableArray*) getAllFavoritas;
- (void) adicionarFavorita:(Questao*) questao;
- (void) removerFavorita:(Questao*) questao;

@end
