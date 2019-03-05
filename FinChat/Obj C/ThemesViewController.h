//
//  ThemesViewController.h
//  FinChat
//
//  Created by Roman Nordshtrem on 04/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemesViewControllerDelegate.h"

@class Themes;
@protocol ThemesViewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController

@property(retain, nonatomic) Themes *model;
@property(assign, nonatomic) id<ThemesViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
