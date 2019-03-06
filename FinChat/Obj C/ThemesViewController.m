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
    [_delegate themesViewController:self didSelectTheme:[self.model theme1Light]];
    self.view.backgroundColor = [self.model theme1Light];
}

- (IBAction)setTheme2Action:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[self.model theme2Dark]];
    self.view.backgroundColor = [self.model theme2Dark];
}

- (IBAction)setTheme3Action:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[self.model theme3Champagne]];
    self.view.backgroundColor = [self.model theme3Champagne];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *firstColor = [UIColor whiteColor];
    UIColor *secondColor = [[UIColor alloc] initWithRed:0.15 green:0.2 blue:0.3 alpha:1.0];
    UIColor *thirdColor = [[UIColor alloc] initWithRed:0.98 green:0.84 blue:0.56 alpha:1.0];
    
    _model = [[Themes alloc] initWithFirstTheme:firstColor secondTheme:secondColor thirdTheme:thirdColor];
    
    [secondColor release];
    [thirdColor release];
}

- (void)dealloc {
    [_model release];
    _model = nil;
    _delegate = nil;
    [super dealloc];
}

- (Themes*)model {
    return _model;
}

- (id<ThemesViewControllerDelegate>)delegate {
    return _delegate;
}

- (void)setModel:(Themes *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
}

- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
    if (_delegate != delegate)
        _delegate = delegate;
}

@end
