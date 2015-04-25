//
//  ProductCell.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import "ProductCell.h"
#import "NSLayoutConstraint+HAWHelpers.h"
#import "UIFont+customFonts.h"


@interface ProductCell ()

@property (weak, nonatomic) IBOutlet UIView *ribbonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtractCartControlsLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expandedCartControlsWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *inCartLabel;
@property (weak) IBOutlet UIView *cartControlsView;
@property (weak) IBOutlet UIView *subtractCartControlsView;



@property (assign, readonly, nonatomic) CGFloat cartButtonWidth;
@property (assign, readonly, nonatomic) CGFloat expandedCartControlsWidth;
@property (assign, readonly, nonatomic) CGFloat subtractCartControlsWidth;

@end


@implementation ProductCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [self initialize];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UICollectionView *collectionView = (UICollectionView*) self.superview;
    if (collectionView.isDecelerating || collectionView.isDragging) {
        return nil;
    }
        
    return [super hitTest:point withEvent:event];
}

- (void)initialize {
    for (id obj in self.subviews) {
        if ([obj respondsToSelector:@selector(setDelaysContentTouches:)]) {
            [obj setDelaysContentTouches:NO];
        }
    }

    self.productImageView.image = nil;
    self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.ribbonView.hidden = YES;
    self.priceLabel.text = @" ";
}

- (IBAction)addToCartButtonTapped:(id)sender {
    
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundImageView.image = nil;
    self.productImageView.image = nil;
    self.ribbonView.hidden = YES;
    self.priceLabel.text = @"";
    self.productImageView.image = nil;
}

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view {
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    CGFloat distanceFromCenter = CGRectGetHeight(view.frame) / 2 - CGRectGetMinY(rectInSuperview);
    CGFloat difference = 0.1*(CGRectGetHeight(self.backgroundImageView.frame) - CGRectGetHeight(self.frame));
    CGFloat move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    self.backgroundImageTopConstraint.constant = -difference + move;
    [self layoutIfNeeded];
}

@end
