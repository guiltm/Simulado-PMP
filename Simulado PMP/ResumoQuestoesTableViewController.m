//
//  ResumoQuestoesTableViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "ResumoQuestoesTableViewController.h"

@interface ResumoQuestoesTableViewController ()
@end

@implementation ResumoQuestoesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listaQuestoes = [[NSMutableArray alloc]init];
    [self carregarValores];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)carregarValores {
    NSURL* url = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImportITIL.xls"]];
    QZWorkbook *excelReader = [[QZWorkbook alloc] initWithContentsOfXLS:url];
    QZWorkSheet *firstWorkSheet = excelReader.workSheets.firstObject;
    [firstWorkSheet open];
    
    //NSLog(@"%@",[firstWorkSheet rows]);
    struct QZLocation localizacao;
    NSMutableDictionary* dic;
    //melhorar isso
    NSMutableArray* numeros = [[NSMutableArray alloc]init];
    
    for (int i=0; i<20; i++) {
    NSInteger numRandom = 1;
    while(numRandom%20!=0 || [numeros containsObject:[NSNumber numberWithInteger:numRandom]]){
        numRandom = arc4random()%(firstWorkSheet.rows.count);
    }
        
    [numeros addObject:[NSNumber numberWithInteger:numRandom]];
    
    localizacao.row = numRandom+1; // de 20 em 20
    
    localizacao.column = 0; // coluna que fica o numero questao

    NSString* numQuestao = [[[firstWorkSheet cellAtPoint:localizacao]content]stringValue]; // a linha 32 tem um \n
    localizacao.column = 2; // descricao questao
    NSString* descricao = [[firstWorkSheet cellAtPoint:localizacao]content];
        
    dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:numQuestao,@"NUMEROQUESTAO", descricao,@"DESCRICAO", nil];
    [self.listaQuestoes addObject:dic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.listaQuestoes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questao" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[[[self.listaQuestoes objectAtIndex:indexPath.row]objectForKey:@"NUMEROQUESTAO"]stringByAppendingString:@") "]stringByAppendingString:[[self.listaQuestoes objectAtIndex:indexPath.row]objectForKey:@"DESCRICAO"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Questao Selecionada" message:[NSString stringWithFormat:@"Pergunta: %@",[self.listaQuestoes objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertView show];
    
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
