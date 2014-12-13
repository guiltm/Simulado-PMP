//
//  Utilidades.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 16/11/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "Utilidades.h"
#import "AppDelegate.h"

@implementation Utilidades

static Utilidades* sharedInstance = nil;
NSURL* url = nil;
QZWorkbook *excelReader = nil;
QZWorkSheet *firstWorkSheet = nil;
NSCondition *condicao;

+ (id)sharedManager{
    if (!sharedInstance){
        sharedInstance = [[super alloc] init];
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
    
    NSMutableArray* favoritas = [[NSMutableArray alloc]init];
    favoritas = self.getAllFavoritas;
    
    for (int i=0; i<listaQuestoes.count; i++) {
        NSString* index = [[NSString alloc]initWithFormat:@"%d",i];
        [[listaQuestoes objectAtIndex:i]setIndex:index];
        for(int j=0; j<favoritas.count; j++) {
            if([[[listaQuestoes objectAtIndex:i]descricao]isEqualToString:[[favoritas objectAtIndex:j]descricao]])
            {
                [[listaQuestoes objectAtIndex:i]setFavorita:YES];
            }

        }
    }
    return listaQuestoes;
}


-(NSMutableArray*) getAllFavoritas {
    NSMutableArray* todasQuestoes = [[NSMutableArray alloc]init];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:@"Questao" inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    NSError * error = nil;
    NSArray* array = [context executeFetchRequest:request error:&error];
    
    Questao* questao = nil;
    int count = 0;
    for (Questao *q in array) {
        questao = [[Questao alloc]init];
        questao.numero = q.numero;
        questao.descricao = q.descricao;
        questao.comentario = q.comentario;
        questao.correto = q.correto;
        questao.favorita = [NSNumber numberWithBool:q.favorita];
        questao.itemA = q.itemA;
        questao.itemB = q.itemB;
        questao.itemC = q.itemC;
        questao.itemD = q.itemD;
        questao.index = [NSString stringWithFormat:@"%d",count];
        count++;
        [todasQuestoes addObject:questao];
    }
    return todasQuestoes;
}

- (void) adicionarFavorita:(Questao*) questao {
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    NSManagedObject* novaQuestao = [NSEntityDescription insertNewObjectForEntityForName:@"Questao" inManagedObjectContext:context];

    [novaQuestao setValue:questao.numero forKey:@"numero"];
    [novaQuestao setValue:questao.descricao forKey:@"descricao"];
    [novaQuestao setValue:questao.comentario forKey:@"comentario"];
    [novaQuestao setValue:questao.correto forKey:@"correto"];
    [novaQuestao setValue:questao.itemA forKey:@"itemA"];
    [novaQuestao setValue:questao.itemB forKey:@"itemB"];
    [novaQuestao setValue:questao.itemC forKey:@"itemC"];
    [novaQuestao setValue:questao.itemD forKey:@"itemD"];
    [novaQuestao setValue:[NSNumber numberWithBool:questao.favorita] forKey:@"favorita"];
    NSError * error;
    [context save:&error];
}

- (void) removerFavorita:(Questao*) questao {
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
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
    
    questao.comentario = [[[firstWorkSheet cellAtPoint:localizacao]content]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    return questao;
}

@end
