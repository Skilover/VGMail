//
//  VGMailFoldersViewController.m
//  VGMail
//
//  Created by Skilover® on 12/10/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import "VGMailFoldersViewController.h"
#import "VGImapSync.h"
#import "VGAccountConfiguration.h"
#import "VGMessagesViewController.h"

@interface VGMailFoldersViewController ()

@property (nonatomic, strong) NSMutableArray *selectedFolders;

@end

@implementation VGMailFoldersViewController

// public
@synthesize mailFolders;
@synthesize accountConfiguration;
@synthesize username;
@synthesize password;

// private
@synthesize selectedFolders;

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

    [self setSelectedFolders:[NSMutableArray array]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self mailFolders] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FolderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *folderNameAtIndex = [[self mailFolders] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:folderNameAtIndex];
    if ([[self selectedFolders] containsObject:folderNameAtIndex]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell accessoryType] == UITableViewCellAccessoryCheckmark) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [[self selectedFolders] removeObjectAtIndex:[indexPath row]];
    } else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [[self selectedFolders] addObject:[[self mailFolders] objectAtIndex:[indexPath row]]];
    }
}

- (IBAction)doneButtonTapped:(id)sender
{
    if (0 < [[self selectedFolders] count]) {
        [self performSegueWithIdentifier:@"Messages" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Messages"]) {
        VGMessagesViewController *vc = [segue destinationViewController];
        [vc setAccountConfiguration:[self accountConfiguration]];
        [vc setUsername:[self username]];
        [vc setPassword:[self password]];
        [vc setFolderNames:[self mailFolders]];
    }
}

@end
