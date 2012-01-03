//
//  VGAccountParams.h
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGAccountConfiguration : NSObject

@property (nonatomic) int port;
@property (nonatomic) int connectionType;
@property (nonatomic) int authType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *server;

@end
