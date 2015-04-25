//
//  ProductCategoryCell.h
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ProductCategoryCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

+ (CGFloat)minHeight;
+ (CGFloat)maxHeight;

@end
