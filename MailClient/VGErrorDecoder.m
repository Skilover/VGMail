//
//  VGErrorDecoder.m
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import "VGErrorDecoder.h"

#import <MailCore/MailCoreTypes.h>


@implementation VGErrorDecoder

+ (int)numberFromError:(NSException*)exp {
	
	NSString* error = [NSString stringWithFormat:@"%@", exp];
	
	if(![error hasPrefix:@"Error number: "]) {
		return -1;
	}
	
	return [[error substringFromIndex:[@"Error number: " length]] intValue];
}

+ (NSString*)decodeError:(NSException *)exp
{
	int errorNumber = [VGErrorDecoder numberFromError:exp];
	switch (errorNumber) {
		case MAILIMAP_ERROR_BAD_STATE:
			return @"Bad state";
		case MAILIMAP_ERROR_STREAM:
			return @"Stream error";
		case MAILIMAP_ERROR_PARSE:
			return @"Parse error";
		case MAILIMAP_ERROR_CONNECTION_REFUSED:
			return @"Connection refused";
		case MAILIMAP_ERROR_MEMORY:
			return @"Memory Error";
		case MAILIMAP_ERROR_FATAL:
			return @"Fatal Error";
		case MAILIMAP_ERROR_PROTOCOL:
			return @"Protocol Error";
		case MAILIMAP_ERROR_DONT_ACCEPT_CONNECTION:
			return @"Connection not accepted";
		case MAILIMAP_ERROR_APPEND:
			return @"Append error";
		case MAILIMAP_ERROR_NOOP:
			return @"NOOP error";
		case MAILIMAP_ERROR_LOGOUT:
			return @"Logout error";
		case MAILIMAP_ERROR_CAPABILITY:
			return @"Capability error";
		case MAILIMAP_ERROR_CHECK:
			return @"Check command error";
		case MAILIMAP_ERROR_CLOSE:
			return @"Close command error";
		case MAILIMAP_ERROR_EXPUNGE:
			return @"Expunge command error";
		case MAILIMAP_ERROR_COPY:
			return @"Copy command error";
		case MAILIMAP_ERROR_UID_COPY:
			return @"UID copy command error";
		case MAILIMAP_ERROR_CREATE:
			return @"Create command error";
		case MAILIMAP_ERROR_DELETE:
			return @"Delete error";
		case MAILIMAP_ERROR_EXAMINE:
			return @"Examine command error";
		case MAILIMAP_ERROR_FETCH:
			return @"Fetch command error";
		case MAILIMAP_ERROR_UID_FETCH:
			return @"UID fetch command error";
		case MAILIMAP_ERROR_LIST:
			return @"List command error";
		case MAILIMAP_ERROR_LOGIN:
			return @"Login error";
		case MAILIMAP_ERROR_LSUB:
			return @"Lsub error";
		case MAILIMAP_ERROR_RENAME:
			return @"Rename error";
		case MAILIMAP_ERROR_SEARCH:
			return @"Search error";
		case MAILIMAP_ERROR_UID_SEARCH:
			return @"Uid search error";
		case MAILIMAP_ERROR_SELECT:
			return @"Select cmnd error";
		case MAILIMAP_ERROR_STATUS:
			return @"Status cmnd error";
		case MAILIMAP_ERROR_STORE:
			return @"Store cmnd error";
		case MAILIMAP_ERROR_UID_STORE:
			return @"Uid store cmd error";
		case MAILIMAP_ERROR_SUBSCRIBE:
			return @"Subscribe error";
		case MAILIMAP_ERROR_UNSUBSCRIBE:
			return @"Unsubscribe error";
		case MAILIMAP_ERROR_STARTTLS:
			return @"StartTLS error";
		case MAILIMAP_ERROR_INVAL:
			return @"Inval cmd error";
		case MAILIMAP_ERROR_EXTENSION:
			return @"Extension error";
		case MAILIMAP_ERROR_SASL:
			return @"SASL error";
		case MAILIMAP_ERROR_SSL:
			return @"SSL error";
		case MAIL_ERROR_PROTOCOL:
			return @"Protocol error";
		case MAIL_ERROR_CAPABILITY:
			return @"Capability error";
		case MAIL_ERROR_CLOSE:
			return @"Close error";
		case MAIL_ERROR_FATAL:
			return @"Fatal error";
		case MAIL_ERROR_READONLY:
			return @"Readonly error";
		case MAIL_ERROR_NO_APOP:
			return @"No APOP error";
		case MAIL_ERROR_COMMAND_NOT_SUPPORTED:
			return @"Cmd not supported";
		case MAIL_ERROR_NO_PERMISSION:
			return @"No permission";
		case MAIL_ERROR_PROGRAM_ERROR:
			return @"Program error";
		case MAIL_ERROR_SUBJECT_NOT_FOUND:
			return @"Subject not found";
		case MAIL_ERROR_CHAR_ENCODING_FAILED:
			return @"Encoding failed";
		case MAIL_ERROR_SEND:
			return @"Send error";
		case MAIL_ERROR_COMMAND:
			return @"Command error";
		case MAIL_ERROR_SYSTEM:
			return @"System error";
		case MAIL_ERROR_UNABLE:
			return @"Unable error";
		case MAIL_ERROR_FOLDER:
			return @"Folder errror";
			
		default:
			return [NSString stringWithFormat:@"%@", exp];
	}
}

@end
