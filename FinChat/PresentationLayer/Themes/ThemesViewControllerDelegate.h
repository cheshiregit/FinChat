//
//  ThemesViewControllerDelegate.h
//  FinChat
//
//  Created by Roman Nordshtrem on 04/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ThemesViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>

-(void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END
