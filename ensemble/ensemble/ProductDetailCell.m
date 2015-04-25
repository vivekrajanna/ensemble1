//
//  ProductDetailCell.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import "ProductDetailCell.h"
#import "NSLayoutConstraint+HAWHelpers.h"

@interface ProductDetailCell () 

@end

@implementation ProductDetailCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [self initializeCell];
}

- (void)initializeCell {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:imageView];
    
    [NSLayoutConstraint centerOfChild:imageView toCenterOfParent:self.contentView];
    [NSLayoutConstraint view:imageView toFixedWidth:95.0f];
    [NSLayoutConstraint view:imageView toFixedHeight:95.0f];
    
    self.productImageView = imageView;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    [NSLayoutConstraint centerXOfChild:self.titleLabel toCenterXOfParent:self];
    [NSLayoutConstraint bottomOfChild:self.titleLabel toBottomOfParent:self withFixedMargin:10.0];
    [NSLayoutConstraint view:self.titleLabel toFixedWidth:100];
    [NSLayoutConstraint view:self.titleLabel toFixedHeight:29];
}

- (void)prepareForReuse {
    self.productImageView.image = nil;
}

@end
