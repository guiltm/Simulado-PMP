//
//  ResumoQuestoesTableViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "ResumoQuestoesTableViewController.h"
#import "QuestoesViewController.h"
#import "Questao.h"

@interface ResumoQuestoesTableViewController ()
@end

@implementation ResumoQuestoesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listaQuestoes = [[NSMutableArray alloc]init];
    //[self.tableView sizeToFit]; //para caber todas, tem q deixar lines para 0
    [self carregarValores];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)carregarValores {
    NSURL* url = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImportITIL.xls"]]; // caminho do xls
    QZWorkbook *excelReader = [[QZWorkbook alloc] initWithContentsOfXLS:url]; // pega o workbook
    QZWorkSheet *firstWorkSheet = excelReader.workSheets.firstObject; // pega a primeira worksheet daquele workbook
    [firstWorkSheet open];
    
    //NSLog(@"%@",[firstWorkSheet rows]);
    struct QZLocation localizacao;
    
    //melhorar isso
    NSMutableArray* numeros = [[NSMutableArray alloc]init]; // numeros que ja sairam
    
    for (int i=0; i<20; i++) { // apenas 20 questões
    NSInteger numRandom = 1;
    while(numRandom%20!=0 || [numeros containsObject:[NSNumber numberWithInteger:numRandom]]){ // %20 pois questoes sao de 20/20 linhas,e testa se ja saiu
        numRandom = arc4random()%(firstWorkSheet.rows.count);
    }
        Questao* questao = [[Questao alloc]init];
    [numeros addObject:[NSNumber numberWithInteger:numRandom]];
    
    localizacao.row = numRandom+1; // de 20 em 20, começando na linha 1
    
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
        
    [self.listaQuestoes addObject:questao];
        
    }
    NSSortDescriptor* brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES]; // ordena pelo numero da questao
    NSArray* sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    self.listaQuestoes = (NSMutableArray*)[self.listaQuestoes sortedArrayUsingDescriptors:sortDescriptors];
    
    for (int i=0; i<_listaQuestoes.count; i++) {
        NSString* index = [[NSString alloc]initWithFormat:@"%d",i];
        [[self.listaQuestoes objectAtIndex:i]setIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.listaQuestoes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESUMOS" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[[[self.listaQuestoes objectAtIndex:indexPath.row]numero]stringByAppendingString:@") "]stringByAppendingString:[[self.listaQuestoes objectAtIndex:indexPath.row]descricao]];
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Questao Selecionada" message:[NSString stringWithFormat:@"Pergunta: %@",[self.listaQuestoes objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
     [alertView show];
}*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"QUESTOES"]){
        QuestoesViewController* controler = [segue destinationViewController];
        controler.questaoSelecionada = [self.listaQuestoes objectAtIndex:[self.tableView indexPathForCell:sender].row];
        controler.listaQuestoes = self.listaQuestoes;
    }

}


@end
