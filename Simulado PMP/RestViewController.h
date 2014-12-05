//
//  RestViewController.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 05/12/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;

- (IBAction)fetchGreeting;
@end
