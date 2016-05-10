//
//  QBAssetCell.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBCheckmarkView;

@interface QBAssetCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) QBCheckmarkView *checkMarkView;
@end
