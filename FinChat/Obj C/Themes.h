//
//  Themes.h
//  FinChat
//
//  Created by Roman Nordshtrem on 05/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Themes : NSObject {
    UIColor* theme1;
    UIColor* theme2;
    UIColor* theme3;
}

- (instancetype) initWithFirstTheme:(UIColor *)theme1 secondTheme:(UIColor *)theme2 thirdTheme:(UIColor *)theme3;
- (void)dealloc;

@property (nonatomic, retain) UIColor *theme1Light;
@property (nonatomic, retain) UIColor *theme2Dark;
@property (nonatomic, retain) UIColor *theme3Champagne;

@end

NS_ASSUME_NONNULL_END
