//
//  Questao.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 30/09/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questao : NSObject

@property (strong,nonatomic) NSString* numero;
@property (strong,nonatomic) NSString* descricao;
@property (strong,nonatomic) NSString* correto;
@property (strong,nonatomic) NSString* itemA;
@property (strong,nonatomic) NSString* itemB;
@property (strong,nonatomic) NSString* itemC;
@property (strong,nonatomic) NSString* itemD;
@property (strong,nonatomic) NSString* respondido;
@property (strong,nonatomic) NSString* index;

@end
