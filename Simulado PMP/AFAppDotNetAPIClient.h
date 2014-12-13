//
//  AFAppDotNetAPIClient.h
//  Simulado PMP
//
//  Created by Thiago Montenegro on 12/12/14.
//  Copyright (c) 2014 Thiago Montenegro. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFAppDotNetAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
