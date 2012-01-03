//
//  VGViewController.m
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import "VGAccountTypesController.h"
#import "VGAccountTypesDataSource.h"
#import "VGAccountConfiguration.h"
#import "VGNewAccountViewController.h"

@interface VGAccountTypesController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) VGAccountTypesDataSource *dataSource;

@end

@implementation VGAccountTypesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDataSource:[[VGAccountTypesDataSource alloc] init]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dataSource] accountTypesCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"MailAccountCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    VGAccountConfiguration *accountTypeConfiguration = [[self dataSource] accountParamForIndex:[indexPath row]];
    [[cell textLabel] setText:[accountTypeConfiguration name]];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"NewAccount" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewAccount"]) {
        NSInteger selectedRow = [[[self tableView] indexPathForSelectedRow] row];
        VGAccountConfiguration *selectedConfiguration = [[self dataSource] accountParamForIndex:selectedRow];
        
        VGNewAccountViewController *vc = [segue destinationViewController];
        [vc setAccountConfiguration:selectedConfiguration];
    }
}

@end
