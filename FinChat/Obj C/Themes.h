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

@interface Themes : NSObject

- (Themes*) init;

@property (nonatomic, retain) UIColor *theme1;
@property (nonatomic, retain) UIColor *theme2;
@property (nonatomic, retain) UIColor *theme3;

@end

NS_ASSUME_NONNULL_END
