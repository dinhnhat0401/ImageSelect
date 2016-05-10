//
//  QBCheckmarkView.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckmarkViewDelegate<NSObject>
- (void)onCheckmarkViewChange:(BOOL)isSelected;
@end

IB_DESIGNABLE
@interface QBCheckmarkView : UIView

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat checkmarkLineWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *bodyColor;
@property (nonatomic, strong) IBInspectable UIColor *checkmarkColor;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) NSInteger itemTag;
@property (nonatomic) id<CheckmarkViewDelegate> delegate;

- (void)changeColorOfCheckMark;
@end
