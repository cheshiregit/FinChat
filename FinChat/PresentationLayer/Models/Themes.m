//
//  Themes.m
//  FinChat
//
//  Created by Roman Nordshtrem on 05/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import "Themes.h"

@implementation Themes

- (instancetype) initWithFirstTheme:(UIColor *)theme1 secondTheme:(UIColor *)theme2 thirdTheme:(UIColor *)theme3 {
    if (self = [super init]) {
        self.theme1Light = theme1;
        self.theme2Dark = theme2;
        self.theme3Champagne = theme3;
    }
    
    return self;
}

- (void)dealloc {
    [theme1 release];
    theme1 = nil;
    
    [theme2 release];
    theme2 = nil;
    
    [theme3 release];
    theme3 = nil;
    
    [super dealloc];
}

@synthesize theme1Light;
@synthesize theme2Dark;
@synthesize theme3Champagne;

- (void)setTheme1Light:(UIColor *)theme1Light {
    [theme1 release];
    theme1 = [theme1Light retain];
}

- (void)setTheme2Dark:(UIColor *)theme2Dark2 {
    [theme2 release];
    theme2 = [theme2Dark retain];
}

- (void)setTheme3Champagne:(UIColor *)theme3Champagne {
    [theme3 release];
    theme3 = [theme3Champagne retain];
}

//MARK: Getters
- (UIColor *)theme1Light {
    return theme1;
}

- (UIColor *)theme2Dark {
    return theme2;
}

- (UIColor *)theme3Champagne {
    return theme3;
}

@end
