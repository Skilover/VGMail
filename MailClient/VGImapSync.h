//
//  VGImapSync.h
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGImapSync : NSObject

+(NSString*)validate:(NSString*)username password:(NSString*)password server:(NSString*)server port:(int)port encryption:(int)encryption authentication:(int)authentication folders:(NSMutableArray*)folders;

+ (NSArray *)loadMessages:(NSString *)username password:(NSString *)password server:(NSString *)server port:(int)port encryption:(int)encryption authentication:(int)authentication folders:(NSArray *)folders;

@end
