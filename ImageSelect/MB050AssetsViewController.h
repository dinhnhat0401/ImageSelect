//
//  MB050ImageSelectViewController.h
//  ImageSelect
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QBImagePickerController;
@class PHAssetCollection;

@interface MB050AssetsViewController : UICollectionViewController

@property (nonatomic, weak) QBImagePickerController *imagePickerController;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

- (id)initWithImagePicker:(QBImagePickerController*)imagePicker;
@end
