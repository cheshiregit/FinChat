//
//  ThemesViewController.m
//  FinChat
//
//  Created by Roman Nordshtrem on 04/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (IBAction)closeButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setTheme1Action:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[self.model theme1]];
}

- (IBAction)setTheme2Action:(id)sender {
}

- (IBAction)setTheme3Action:(id)sender {
}

@synthesize delegate = _delegate;

- (void) setDelegate:(id<ThemesViewControllerDelegate>)delegate{
    _delegate = delegate;
}

- (id<ThemesViewControllerDelegate>) delegate {
    return _delegate;
}

@synthesize model = _model;

-(Themes *) model {
    return [[_model retain] autorelease];
}

-(void) setModel:(Themes *)model {
    [_model autorelease];
    _model = [model retain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[Themes alloc] init];
}

- (void)dealloc {
    [_model release];
    _model = nil;
    _delegate = nil;
    [super dealloc];
}

@end
