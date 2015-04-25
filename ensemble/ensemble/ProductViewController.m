//
//  ProductViewController.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "ProductViewController.h"
#import "ProductCell.h"
#import "UIImage+ImageEffects.h"
#import "ENHelpers.h"
#import "UINavigationItem+Spacing.h"
#import "SkuVC.h"

#define kCellHeight 369

@interface ProductViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addbutton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonBottomConstraint;
@property (nonatomic, strong) NSArray *products;
@end

@implementation ProductViewController

- (id)initWithProductCategory:(ProductCategory *)productCategory{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [NSArray arrayWithObjects:@"sdasd",@"asd",@"asds2", @"asds2",@"asds2",@"asds2", nil];
    [self registerTableCell];
    [self customizeNavigationBar];
    [self.tableView setTableFooterView:[UIView new]];
    // navigation bar title
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)registerTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
}

- (void)customizeNavigationBar {
    UIBarButtonItem *backButtonItem = [ENHelpers backButtonItemWithTarget:self action:@selector(backButtonTapped)];
    [self.navigationItem setBackLeftBarButtonItem:backButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeAll;
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource and helpers

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [self getCellForTableView:tableView];
    cell.preservesSuperviewLayoutMargins = NO;
    [self productDetailsForCell:cell AtRow:indexPath.row];
    return cell;
}

- (void)productDetailsForCell:(ProductCell *)cell AtRow:(NSInteger)row {
    cell.nameLabel.text = self.products[row];
    cell.priceLabel.text = @"299.00";
    UIImage *image = [UIImage imageNamed:@"product"];
    cell.productImageView.image = image;
    UIImage *blurredImage = [self blurredImageforImage:image];
    cell.backgroundImageView.transform = CGAffineTransformMakeScale(5.0, 5.0);
    cell.backgroundImageView.image = blurredImage;
}

- (UIImage *)blurredImageforImage:(UIImage *)image {
    return [image applyBlurWithRadius:4
                           tintColor:[UIColor colorWithWhite:0.0 alpha:0.1]
               saturationDeltaFactor:1
                           maskImage:nil];
}

- (ProductCell *)getCellForTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"ProductCell";
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = (ProductCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SkuVC *skuVC = [[SkuVC alloc] initWithNibName:@"SkuVC" bundle:nil];
    [self.navigationController pushViewController:skuVC animated:YES];
}

#pragma mark - scrollview delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self animateSearchViewConstraint:self.addButtonBottomConstraint withConstant:-1 * self.addbutton.frame.size.height];
}

- (void) animateSearchViewConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat) constant {
    [UIView animateWithDuration:0.5 animations:^{
        constraint.constant = constant;
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self animateSearchViewConstraint:self.addButtonBottomConstraint withConstant:11];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self animateSearchViewConstraint:self.addButtonBottomConstraint withConstant:11];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleCells = [self.tableView visibleCells];
    for (ProductCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}
- (void)reloadWithoutAnimation {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [self.tableView reloadData];
    [CATransaction commit];
}

@end
