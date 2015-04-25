//
//  UINavigationItem+Spacing.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "UINavigationItem+Spacing.h"

@implementation UINavigationItem (Spacing)
- (void)setCustomLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
     UIBarButtonItem *negativeSpacer = [self spacerWithWidth:-16];
    
    self.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil];
}

- (void)setBackLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    UIBarButtonItem *negativeSpacer = [self spacerWithWidth:-22];
    
    self.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil];
}

- (void)setCustomRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    UIBarButtonItem *negativeSpacer = [self spacerWithWidth:-25];
    
    self.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil];
}

- (UIBarButtonItem *)spacerWithWidth:(CGFloat)width {
     UIBarButtonItem * spacer = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
     target:nil action:nil];
    spacer.width = width;
    return spacer;
}


@end
