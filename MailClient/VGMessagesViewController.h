//
//  VGMessagesViewController.h
//  VGMail
//
//  Created by Skilover® on 12/10/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VGAccountConfiguration;

@interface VGMessagesViewController : UITableViewController

@property (nonatomic, strong) VGAccountConfiguration *accountConfiguration;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSArray *folderNames;

@end
