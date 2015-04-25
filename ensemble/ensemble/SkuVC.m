//
//  SkuVC.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "SkuVC.h"
#import "UINavigationItem+Spacing.h"
#import "ENHelpers.h"
#import "ProductDetailCell.h"
#import "UIImage+ImageEffects.h"

NSString * const kInCart = @"In Cart";
NSString * const kUpdateCart = @"Update Qty";
NSString * const kAddToCart = @"Add to Cart";


@interface SkuVC () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *productImageCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *productImagePageControl;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIView *quantityLowerSeparator;
@property (weak, nonatomic) IBOutlet UILabel *productQuantityLabel;
@property (weak, nonatomic) IBOutlet UIButton *decreaseQuantity;
@property (weak, nonatomic) IBOutlet UIButton *increaseQuantity;

@property (weak, nonatomic) IBOutlet UIView *productCheckoutContainerView;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;

@property (weak, nonatomic) IBOutlet UILabel *productDescriptionHeader;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@property (nonatomic, strong) NSArray *productItems;
@end


@implementation SkuVC

- (id)initWithProduct {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    [self customizeNavigationBar];
    self.productItems = [NSArray arrayWithObjects:@"sdasd",@"asd",@"asds2", @"asds2",@"asds2",@"asds2", nil];
    [self updateProductDetailUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeTop;
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customizeNavigationBar {
    UIBarButtonItem *backButtonItem = [ENHelpers backButtonItemWithTarget:self action:@selector(backButtonTapped)];
    [self.navigationItem setBackLeftBarButtonItem:backButtonItem];
}

#pragma mark - Update methods
- (void)registerNibs {
    [self.productImageCollectionView registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:nil] forCellWithReuseIdentifier:@"ProductDetailCell"];
}

#pragma mark  - collectionview datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductDetailCell" forIndexPath:indexPath];
    cell.productImageView.image = [UIImage imageNamed:@"product"];
    cell.titleLabel = self.productItems[indexPath.row];
    
    return cell;
}

#pragma mark - collectioview delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.productImageCollectionView) {
        NSUInteger idx = (int)round(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame));
        
        // set the page control to the correct index
        self.productImagePageControl.currentPage = idx;
    }
    
}

#pragma mark - UIButton Actions

- (IBAction)addToCartButtonPressed:(id)sender {
   
}

- (void)updateProductDescription {
    self.productDescription.text = @"Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here Product description goes here";
}

- (void)updateProductDetailUI {
    UIImage *blurredImage = [self blurredImageforImage:[UIImage imageNamed:@"Product"]];
    self.backGroundImageView.transform = CGAffineTransformMakeScale(5.0, 5.0);
    self.backGroundImageView.image = blurredImage;

    [self updateProductDescription];
    
    self.productName.text = @"Cadbury";
    self.productSubtitleLabel.text = @"Eat it away";
    self.productPrice.text = @"$299.00";
    NSAttributedString *attributedText = self.productDescription.attributedText;
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){CGRectGetWidth(self.productDescription.frame), CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGRect descriptionFrame = self.productDescription.frame;
    descriptionFrame.size = rect.size;
    self.productDescription.frame = descriptionFrame;
    [self.view setNeedsLayout];
    
    [self.productImageCollectionView reloadData];
}

- (UIImage *)blurredImageforImage:(UIImage *)image {
    return [image applyBlurWithRadius:4
                            tintColor:[UIColor colorWithWhite:0.0 alpha:0.1]
                saturationDeltaFactor:1
                            maskImage:nil];
}

#pragma mark - UIPageControl Methods
- (IBAction)pageControlClicked:(id)sender {
    NSUInteger idx = [(UIPageControl *)sender currentPage];
    
    [self.productImageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
