//
//  VGMessagesViewController.m
//  VGMail
//
//  Created by Skilover® on 12/10/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <MailCore/CTCoreMessage.h>

#import "VGMessagesViewController.h"
#import "VGImapSync.h"
#import "VGAccountConfiguration.h"

@interface VGMessagesViewController ()

@property (nonatomic, strong) NSArray *messages;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation VGMessagesViewController

// public
@synthesize accountConfiguration;
@synthesize username;
@synthesize password;
@synthesize folderNames;

//private
@synthesize messages;
@synthesize activityIndicator;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
    [[self activityIndicator] setHidesWhenStopped:YES];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    UINavigationItem *navigationItem = [self navigationItem];
    [navigationItem setRightBarButtonItem:activityItem];
    
    [self loadMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self messages] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CTCoreMessage *message = [[self messages] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[message subject]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Loading messages

- (void)loadMessages
{
    if (0 < [[self folderNames] count]) {
        [[self activityIndicator] startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            self.messages = [VGImapSync loadMessages:[self username]
                            password:[self password]
                              server:[[self accountConfiguration] server]
                                port:[[self accountConfiguration] port]
                          encryption:[[self accountConfiguration] connectionType]
                      authentication:[[self accountConfiguration] authType]
                             folders:[self folderNames]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self tableView] reloadData];
                [[self activityIndicator] stopAnimating];
            });
        });
    }
}

@end
