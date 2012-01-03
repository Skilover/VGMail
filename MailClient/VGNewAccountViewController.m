//
//  VGNewAccountViewController.m
//  VGMail
//
//  Created by Skilover® on 12/9/12.
//  Copyright (c) 2012 Skilover®. All rights reserved.
//

#import <MailCore/MailCore.h>

#import "VGNewAccountViewController.h"
#import "VGAccountConfiguration.h"
#import "VGImapSync.h"
#import "VGMailFoldersViewController.h"

@interface VGNewAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *mailFolders;

@end

@implementation VGNewAccountViewController

@synthesize accountConfiguration;
@synthesize activityIndicator;
@synthesize mailFolders;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters/Setters

- (void)setAccountConfiguration:(VGAccountConfiguration *)anAccountConfiguration
{
    accountConfiguration = anAccountConfiguration;
    
    [self setTitle:[accountConfiguration name]];
}

#pragma mark - IBActions

- (IBAction)loginButtonTapped:(id)sender
{
    [[self activityIndicator] startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *receivedMailFolders = [self receiveMailFolders];
        
        if (0 < [receivedMailFolders count]) {
            [self setMailFolders:receivedMailFolders];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self activityIndicator] stopAnimating];
                [self performSegueWithIdentifier:@"MailFolders" sender:self];
            });
        }
    });
}

#pragma mark - 

- (NSArray *)receiveMailFolders
{
    NSString *login = [[self loginTextField] text];
    NSString *password = [[self passwordTextField] text];
    VGAccountConfiguration *anAccountCofiguration = [self accountConfiguration];
    NSMutableArray *folderNames = [NSMutableArray array];
    
    [VGImapSync validate:login
                password:password
                  server:[anAccountCofiguration server]
                    port:[anAccountCofiguration port]
              encryption:[anAccountCofiguration connectionType]
          authentication:[anAccountCofiguration authType]
                 folders:folderNames];
    
    return folderNames;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MailFolders"]) {
        VGMailFoldersViewController *vc = [segue destinationViewController];
        [vc setMailFolders:[self mailFolders]];
        [vc setAccountConfiguration:[self accountConfiguration]];
        [vc setUsername:[[self loginTextField] text]];
        [vc setPassword:[[self passwordTextField] text]];
    }
}

@end
