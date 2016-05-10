//
//  QBAssetCell.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBAssetCell.h"
#import "QBCheckmarkView.h"

@interface QBAssetCell ()

@end

@implementation QBAssetCell
@synthesize imageView = _imageView;
@synthesize checkMarkView = _checkMarkView;
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

#pragma mark - Cell

- (void)prepareForReuse {
    _imageView.image = nil;
    [super prepareForReuse];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;    
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Image
        _imageView = [UIImageView new];
        _imageView.frame = self.bounds;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_imageView];
        
        _checkMarkView = [[QBCheckmarkView alloc] init];
        [self addSubview:_checkMarkView];
    }
    return self;
}

@end
