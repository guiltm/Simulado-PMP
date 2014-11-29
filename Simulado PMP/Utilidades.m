//
//  Utilidades.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 16/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "Utilidades.h"

@implementation Utilidades


static Utilidades* sharedInstance = nil;
NSURL* url = nil;
QZWorkbook *excelReader = nil;
QZWorkSheet *firstWorkSheet = nil;
static NSMutableArray* favoritas = nil;

+ (id)sharedManager{
    if (!sharedInstance){
        sharedInstance = [[super alloc] init];
        favoritas = [[NSMutableArray alloc]init];
    }

    return sharedInstance;
}

- (void) configurar{
    url = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImportITIL.xls"]]; // caminho do xls
    excelReader = [[QZWorkbook alloc] initWithContentsOfXLS:url]; // pega o workbook
    firstWorkSheet = excelReader.workSheets.firstObject; // pega a primeira worksheet daquele workbook
}

- (NSMutableArray*)carregarValores:(int) numQuestoes {
    [self configurar];
    [firstWorkSheet open];
    
    //NSLog(@"%@",firstWorkSheet.rows);

    
    NSMutableArray* listaQuestoes = [[NSMutableArray alloc]init];
    
    NSMutableArray* numeros = [[NSMutableArray alloc]init]; // numeros possiveis
    
    for (int i=1; i<=1582; i+=20) { // total linhas com questoes 1582
        [numeros addObject:[NSNumber numberWithInteger:i]];
    }
    
    for (int i=0; i<numQuestoes; i++) { // apenas 20 questões
        id numRandom = 0;
        while(![numeros containsObject:numRandom]|| numRandom==0){ // %20 pois questoes sao de 20/20 linhas,e testa se ja saiu
            numRandom = numeros[arc4random_uniform([numeros count])];
        }
        [numeros removeObject:numRandom];
        Questao* questao = [self criarQuestao:numRandom];
        [listaQuestoes addObject:questao];
    }
    
    NSSortDescriptor* brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES]; // ordena pelo numero da questao
    NSArray* sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    listaQuestoes = (NSMutableArray*)[listaQuestoes sortedArrayUsingDescriptors:sortDescriptors];
    
    for (int i=0; i<listaQuestoes.count; i++) {
        NSString* index = [[NSString alloc]initWithFormat:@"%d",i];
        [[listaQuestoes objectAtIndex:i]setIndex:index];
    }
    return listaQuestoes;
}

-(Questao*) criarQuestao:(id) numRandom{
    
    Questao* questao = [[Questao alloc]init];
    
    
    struct QZLocation localizacao;
    
    localizacao.row = [numRandom integerValue]; // de 20 em 20, começando na linha 1
    
    localizacao.column = 0; // coluna que fica o numero da questao
    
    questao.numero = [[[firstWorkSheet cellAtPoint:localizacao]content]stringValue];
    
    if([questao.numero length] == 1){
        questao.numero = [@"0" stringByAppendingString:questao.numero]; // para ordenar certo
    }
    
    localizacao.column = 2; // coluna que fica a descricao da questao
    questao.descricao = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    //prrenchendo valores
    
    localizacao.row ++; // linha item A
    localizacao.column=2;
    if([[firstWorkSheet cellAtPoint:localizacao] content] != nil){questao.correto = @"a";} // verifica o correto
    localizacao.column=3; // coluna dos itens
    
    questao.itemA = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];//tirar quebra linha
    
    localizacao.row+=2; // linha item B
    if(questao.correto==nil || [questao.correto  isEqual:@""]){
        localizacao.column=2;
        if([[firstWorkSheet cellAtPoint:localizacao]content]!=nil){questao.correto = @"b";} // verifica o correto
        localizacao.column=3;
    }
    questao.itemB = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    localizacao.row+=2; // linha item C
    if(questao.correto==nil || [questao.correto isEqualToString:@""]){
        localizacao.column=2;
        if([[firstWorkSheet cellAtPoint:localizacao]content]!=nil){questao.correto = @"c";} // verifica o correto
        localizacao.column=3;
    }
    questao.itemC = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    localizacao.row+=2; // linha item D
    if(questao.correto==nil || [questao.correto isEqualToString:@""]){
        localizacao.column=2;
        if([[firstWorkSheet cellAtPoint:localizacao]content]!=nil){questao.correto = @"d";} // verifica o correto
        localizacao.column=3;
    }
    
    questao.itemD = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    localizacao.column +=3;
    
    questao.comentario = [[firstWorkSheet cellAtPoint:localizacao]content];
    
    return questao;
}

-(NSMutableArray*) getAllFavoritas {
    
    return favoritas;
}

- (void) adicionarFavorita:(Questao*) questao {
    [favoritas addObject:questao];
}

- (void) removerFavorita:(Questao*) questao {
    [favoritas removeObject:questao];
}


@end
