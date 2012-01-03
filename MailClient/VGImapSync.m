//
//  VGImapSync.m
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <MailCore/CTCoreAccount.h>
#import <MailCore/CTCoreFolder.h>
#import <MailCore/CTCoreMessage.h>

#import "VGImapSync.h"
#import "VGErrorDecoder.h"
#import "StringUtil.h"

@implementation VGImapSync

+ (NSString*)validate:(NSString*)username password:(NSString*)password server:(NSString*)server port:(int)port encryption:(int)encryption authentication:(int)authentication folders:(NSMutableArray*)folders
{
	CTCoreAccount* account = [[CTCoreAccount alloc] init];
	
	@try {
        [account connectToServer:server port:port connectionType:encryption authType:authentication login:username password:password];
    } @catch (NSException *exp) {
        NSLog(@"connect exception: %@", exp);
        return [NSString stringWithFormat:@"Connect error: %@", [VGErrorDecoder decodeError:exp]];
	}
	
	NSSet* folderSet;
	@try {
		folderSet = [account allFolders];
	} @catch (NSException *exp) {
		[account disconnect];
        return [NSString stringWithFormat:NSLocalizedString(@"Error getting folders: %@", nil), [VGErrorDecoder decodeError:exp]];
	}
	
	NSString* folderName = nil;
	NSEnumerator *folderEnumError = [folderSet objectEnumerator];
	NSMutableArray *gmailFolders = [NSMutableArray arrayWithCapacity:10];
	while(folderName = [folderEnumError nextObject]) {
		if([folderName isEqualToString:@"[Gmail]"] || [folderName isEqualToString:@"[Google Mail]"]) {
			continue;
		}
		
		if([StringUtil stringStartsWith:folderName subString:@"[Gmail]"] ||[StringUtil stringStartsWith:folderName subString:@"[Google Mail]"]) {
			[gmailFolders addObject:folderName];
		} else {
			[folders addObject:folderName];
		}
	}
	
	[folders sortUsingSelector: @selector( caseInsensitiveCompare: )];
	[gmailFolders sortUsingSelector: @selector( caseInsensitiveCompare: )];
	[folders addObjectsFromArray:gmailFolders];
	
	int inboxIndex = [folders indexOfObject:@"INBOX"];
	if(inboxIndex != NSNotFound) {
		[folders removeObject:@"INBOX"];
		[folders insertObject:@"INBOX" atIndex:0];
	}
	
	[account disconnect];
	return @"OK";
}

+ (NSArray *)loadMessages:(NSString *)username password:(NSString *)password server:(NSString *)server port:(int)port encryption:(int)encryption authentication:(int)authentication folders:(NSArray *)folders
{
    CTCoreAccount* account = [[CTCoreAccount alloc] init];
    
    @try {
        [account connectToServer:server port:port connectionType:encryption authType:authentication login:username password:password];
    } @catch (NSException *exp) {
        NSLog(@"connect exception: %@", exp);
        return nil;
	}
    
    NSMutableArray *messages = [NSMutableArray array];
    for (NSString *folderName in folders) {
        CTCoreFolder *mailFolder = [account folderWithPath:folderName];
        
        NSUInteger totalMessageCount = 0;
        BOOL success = [mailFolder totalMessageCount:&totalMessageCount];
        if (!success) {
            NSError *error = [mailFolder lastError];
            NSLog(@"%@", error);
        }
        
        NSArray *folderMessages = [mailFolder messagesFromSequenceNumber:1 to:totalMessageCount withFetchAttributes:CTFetchAttrEnvelope];
        [messages addObjectsFromArray:folderMessages];
    }
    
    return messages;
}

@end
