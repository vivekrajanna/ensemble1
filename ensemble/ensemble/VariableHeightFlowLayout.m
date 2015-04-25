//
//  VariableHeightFlowLayout.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//


#import "VariableHeightFlowLayout.h"
#import "ProductCategoryCell.h"


@implementation VariableHeightFlowLayout

- (void) prepareLayout {
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width, [ProductCategoryCell minHeight]);
}

// NOTE for debugging purposes
- (void)dumpAttr:(UICollectionViewLayoutAttributes *)attr {

}

// NOTE for debugging purposes
- (void) dumpAttrs:(NSArray*)attrs message:(NSString*)msg {
    [attrs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attr = (UICollectionViewLayoutAttributes*)obj;
        [self dumpAttr:attr];
    }];
}

- (CGFloat)scaledHeightForOffset:(CGFloat)offset {
    CGFloat minHeight = [ProductCategoryCell minHeight];
    CGFloat maxHeight = [ProductCategoryCell maxHeight];
    CGFloat heightDiff = maxHeight - minHeight;

    CGFloat scalingFactor = 1.0 - (offset / maxHeight); // scaling zone is one maxHeight below viewport top
    CGFloat cellHeight = ceil(minHeight + heightDiff * scalingFactor);  // height scales linearly from min to max over scaling zone
    return cellHeight;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat hmin = [ProductCategoryCell minHeight];
    CGFloat hmax = [ProductCategoryCell maxHeight];

    rect.origin.y = 0;
    rect.size = [self collectionViewContentSize];
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];

    // the following is expressed in content space (the "viewport"), not screen space
    CGFloat viewportTop = self.collectionView.contentOffset.y;

    for (UICollectionViewLayoutAttributes *attr in attributes) {
        CGFloat cellTop = attr.indexPath.row * hmin; // sane default value
        CGFloat cellHeight = hmin; // sane default value

        NSInteger attrIndex = [attributes indexOfObject:attr];
        CGFloat maxPossibleCellTop = attrIndex * hmax;

        NSInteger maxHeightCellCount = ceil(viewportTop / hmax);
        CGFloat heightOfAllMaxedCells = hmax * maxHeightCellCount;

        if (maxPossibleCellTop <= viewportTop) { // fully expanded
            cellTop = maxPossibleCellTop;
            cellHeight = hmax + 1;
        } else if ((attrIndex * hmax) < (viewportTop + hmax)) { // expanding
            cellTop = maxPossibleCellTop - 1;
            cellHeight = [self scaledHeightForOffset:(cellTop - viewportTop)] + 1;
        } else { // minimized
            CGFloat topOfExpandingCellInViewport = heightOfAllMaxedCells - viewportTop;
            CGFloat heightOfExpandingCell = [self scaledHeightForOffset:topOfExpandingCellInViewport];

            NSInteger minHeightCellCount = attrIndex - maxHeightCellCount - 1;
            CGFloat heightOfMinCellsAboveMe = minHeightCellCount * hmin;

            cellTop = heightOfAllMaxedCells + heightOfExpandingCell + heightOfMinCellsAboveMe;
        }

        attr.frame = CGRectMake(attr.frame.origin.x, cellTop, attr.size.width, cellHeight);
        // [self dumpAttr:attr];
    }

    return [NSArray arrayWithArray:attributes];
}

- (CGSize)collectionViewContentSize {
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat h = (itemCount - 1) * [ProductCategoryCell maxHeight] + self.collectionView.frame.size.height;
    return CGSizeMake(self.collectionView.frame.size.width, h);
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
