//
//  CategoryViewController.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "CategoryViewController.h"
#import "ProductCategoryCell.h"
#import "ProductViewController.h"

@interface CategoryViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *productCategories;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"CATEGORIES";
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCategoryCell"];
    
    self.productCategories = [NSArray arrayWithObjects:@"sdasd",@"asd",@"asds2", @"asds2",@"asds2",@"asds2", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeAll;
}

#pragma mark - CollectionView datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productCategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCategoryCell" forIndexPath:indexPath];
    cell.title = self.productCategories[indexPath.row];
    cell.backgroundImageView.image = [UIImage imageNamed:@"Home"];
    return cell;
}


#pragma mark - CollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductViewController *productViewController = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    [self.navigationController pushViewController:productViewController animated:YES];
}

@end
