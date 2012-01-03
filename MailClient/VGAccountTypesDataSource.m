//
//  VGAccountTypesDataSource.m
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import "VGAccountTypesDataSource.h"
#import "VGAccountConfiguration.h"

#import "libetpan/mailstorage_types.h"
#import "libetpan/imapdriver_types.h"

@interface VGAccountTypesDataSource ()

@property (nonatomic, strong) NSArray *accountCofigurationItems;

@end

@implementation VGAccountTypesDataSource

- (id)init
{
    self = [super init];
    if (self) {
        [self performInitialSetup];
    }
    return self;
}

- (void)performInitialSetup
{
    VGAccountConfiguration *gmailConfiguration = [[VGAccountConfiguration alloc] init];
    [gmailConfiguration setAuthType:IMAP_AUTH_TYPE_PLAIN];
    [gmailConfiguration setConnectionType:CONNECTION_TYPE_TLS];
    [gmailConfiguration setPort:993];
    [gmailConfiguration setName:@"Gmail"];
    [gmailConfiguration setServer:@"imap.gmail.com"];
    
    [self setAccountCofigurationItems:[NSArray arrayWithObjects:gmailConfiguration, nil]];
}

- (NSInteger)accountTypesCount
{
    return [[self accountCofigurationItems] count];
}

- (VGAccountConfiguration *)accountParamForIndex:(NSInteger)index
{
    return [[self accountCofigurationItems] objectAtIndex:index];
}

@end
