//
//  Themes.m
//  FinChat
//
//  Created by Roman Nordshtrem on 05/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import "Themes.h"

@implementation Themes

- (Themes *) init {
    [super init];
    _theme1 = [UIColor whiteColor];
    _theme2 = [[UIColor alloc] initWithRed:0.16 green:0.18 blue:0.27 alpha:1.0];
    _theme3 = [[UIColor alloc] initWithRed:0.30 green:0.24 blue:0.35 alpha:1.0];
    return self;
}

- (UIColor *) theme1 {
    return [[_theme1 retain] autorelease];
}

- (UIColor *) theme2 {
    return [[_theme2 retain] autorelease];
}

-(UIColor *) theme3 {
    return [[_theme3 retain] autorelease];
}

- (void)dealloc {
    [_theme1 release];
    [_theme2 release];
    [_theme3 release];
    [super dealloc];
}

/*
 UIColor *lightColor = [[UIColor alloc] initWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
 UIColor *darkColor = [[UIColor alloc] initWithRed:75.0f/255.0f green:75.0f/255.0f blue:75.0f/255.0f alpha:1.0];
 UIColor *champagneColor = [[UIColor alloc] initWithRed:197.0f/255.0f green:179.0f/255.0f blue:88.0f/255.0f alpha:1.0];
*/



@end
