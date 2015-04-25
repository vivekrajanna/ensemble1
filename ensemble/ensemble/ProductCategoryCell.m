//
//  ProductCategoryCell.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "ProductCategoryCell.h"
#import "NSLayoutConstraint+HAWHelpers.h"

static const CGFloat fullSizeAndAlphaThresholdCellHeight = 0.9;
static const CGFloat minShadowAlpha = 0.6;
static const CGFloat titleLabelMinScale = 0.75;


@interface ProductCategoryCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIView *shadowView;

@property (assign, nonatomic) CGAffineTransform minTransform;

@end


@implementation ProductCategoryCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // TODO make this static across instances
    self.minTransform = CGAffineTransformMakeScale(titleLabelMinScale, titleLabelMinScale);

    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView = self.backgroundImageView;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    [NSLayoutConstraint centerXOfChild:self.titleLabel toCenterXOfParent:self.contentView];
    [NSLayoutConstraint centerYOfChild:self.titleLabel toCenterYOfParent:self.contentView];
    [NSLayoutConstraint view:self.titleLabel toFixedWidth:320];
    [NSLayoutConstraint view:self.titleLabel toFixedHeight:29];

    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.numberOfLines = 0;
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.subtitleLabel];
    [NSLayoutConstraint leftOfChild:self.subtitleLabel toLeftOfParent:self.contentView withFixedMargin:40];
    [NSLayoutConstraint rightOfChild:self.subtitleLabel toRightOfParent:self.contentView withFixedMargin:-40];
    [NSLayoutConstraint topOfChild:self.subtitleLabel toBottomOfSibling:self.titleLabel withFixedMargin:-4 inParent:self.contentView];
    [NSLayoutConstraint view:self.subtitleLabel toFixedHeight:42];
    
    self.shadowView = [[UIView alloc] init];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView insertSubview:self.shadowView aboveSubview:self.subtitleLabel];
    [NSLayoutConstraint extentOfChild:self.shadowView toExtentOfParent:self.contentView];
}


#pragma mark - setters

- (void)setImage:(UIImage *)image {
    _image = image;
    self.backgroundImageView.image = image;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
}

#pragma mark - static methods

+ (CGFloat)minHeight {
    return 100;
}

+ (CGFloat)maxHeight {
    return 285;
}

#pragma mark - layout

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat alpha = (self.frame.size.height - [ProductCategoryCell minHeight]) / (([ProductCategoryCell maxHeight] - [ProductCategoryCell minHeight]) * fullSizeAndAlphaThresholdCellHeight);
    alpha = MAX(MIN(alpha, 1.0), 0.0);
    self.subtitleLabel.alpha = alpha;
    self.shadowView.alpha =  MAX(MIN(1 - alpha, minShadowAlpha), 0.0);

    [self scaleTitleLabel];
}

- (void)scaleTitleLabel {
    CGFloat heightForFullSize = [ProductCategoryCell maxHeight] * fullSizeAndAlphaThresholdCellHeight;
    if (self.frame.size.height > heightForFullSize) {
        if (!CGAffineTransformEqualToTransform(self.titleLabel.transform, CGAffineTransformIdentity)) {
            self.titleLabel.transform = CGAffineTransformIdentity;
        }

        return;
    }

    if (self.frame.size.height == [ProductCategoryCell minHeight]) {
        if (!CGAffineTransformEqualToTransform(self.titleLabel.transform, self.minTransform)) {
            self.titleLabel.transform = self.minTransform;
        }

        return;
    }

    CGFloat targetProportion = (self.frame.size.height - [ProductCategoryCell minHeight]) / (heightForFullSize - [ProductCategoryCell minHeight]);
    CGFloat titleLabelScaleFactor = titleLabelMinScale + (1.0 - titleLabelMinScale) * targetProportion;
    titleLabelScaleFactor = MIN(MAX(titleLabelScaleFactor, titleLabelMinScale), 1.0);
    self.titleLabel.transform = CGAffineTransformMakeScale(titleLabelScaleFactor, titleLabelScaleFactor);
}

@end
