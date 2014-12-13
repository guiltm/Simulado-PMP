//
//  MenuViewController.m
//  Simulado PMP
//
//  Created by Thiago Montenegro on 29/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "MenuViewController.h"
#import "QuestoesViewController.h"
#import "Utilidades.h"
#import <AFNetworking.h>

@interface MenuViewController ()


@end

@implementation MenuViewController

static NSString * const BaseURLString = @"http://localhost:8080/RestFullWebService/rest/business/questoes/";
NSMutableArray* listaFavoritasRede = nil;
Questao* qfavoritas = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    [self carregarQuestoesDoWS];
    return NO;
}
#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
<<<<<<< HEAD
=======
    
     /*
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
         }
     }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:8080/WSServer/services/Server?wsdl" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://localhost:8080/WSServer/services/Server" parameters:nil error:nil];*/

    
    
>>>>>>> FETCH_HEAD
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"questoesFavoritas"]){
        Utilidades* util = [Utilidades sharedManager];
        QuestoesViewController* questoes = [segue destinationViewController];
        questoes.listaQuestoes = listaFavoritasRede;
        if(questoes.listaQuestoes.count > 0){
        questoes.questaoSelecionada = [questoes.listaQuestoes objectAtIndex:0];
        }
    }
}

- (void) carregarQuestoesDoWS{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:BaseURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSDictionary* dic = (NSDictionary*)responseObject;
     NSLog(@"JSON: %@",dic);
        listaFavoritasRede = [[NSMutableArray alloc]init];
         for (NSDictionary* dics in dic) {
             qfavoritas = [[Questao alloc]init];
             qfavoritas.numero = [[dics objectForKey:@"numero"] stringValue];
             qfavoritas.descricao = [dics objectForKey:@"descricao"];
             qfavoritas.favorita = [dics objectForKey:@"favorito"];
             qfavoritas.idQuestao = [dics objectForKey:@"id"];
             qfavoritas.itemA = [dics objectForKey:@"itemA"];
             qfavoritas.itemB = [dics objectForKey:@"itemB"];
             qfavoritas.itemC = [dics objectForKey:@"itemC"];
             qfavoritas.itemD = [dics objectForKey:@"itemD"];
             qfavoritas.Usuario = [dics objectForKey:@"usuario"];
             [listaFavoritasRede addObject:qfavoritas];
         }
        [self performSegueWithIdentifier:@"questoesFavoritas" sender:nil];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog
     (@"Error: %@", error);
     }];

}

@end
