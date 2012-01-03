//
//  VGAccountTypesDataSource.h
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VGAccountConfiguration;

@interface VGAccountTypesDataSource : NSObject

- (NSInteger)accountTypesCount;
- (VGAccountConfiguration *)accountParamForIndex:(NSInteger)index;

@end
