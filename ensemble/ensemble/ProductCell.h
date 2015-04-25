//
//  ProductCell.h
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductCellDelegate <NSObject>

@end

@interface ProductCell : UITableViewCell

@property NSInteger tempQuantity;
@property (strong, nonatomic) UIImage* blurredImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSubtitlelabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak) IBOutlet UIButton *subtractFromCartButton;
@property (weak, nonatomic) id<ProductCellDelegate> delegate;
@property (assign, nonatomic) BOOL isCartPanelOpen;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
