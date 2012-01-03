//
//  VGMailFoldersViewController.h
//  VGMail
//
//  Created by Skilover® on 12/10/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VGAccountConfiguration;

@interface VGMailFoldersViewController : UITableViewController

@property (nonatomic, strong) NSArray *mailFolders;
@property (nonatomic, strong) VGAccountConfiguration *accountConfiguration;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
