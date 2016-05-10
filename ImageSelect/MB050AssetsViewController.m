//
//  MB050ImageSelectViewController.m
//  ImageSelect
//
//  Created by Dinh Van Nhat on 5/9/16.
//

#import "MB050AssetsViewController.h"
#import "QBAssetCell.h"
#import "QBCheckmarkView.h"
#import "QBImagePickerController.h"
#import <Photos/Photos.h>

@interface MB050AssetsViewController()<PHPhotoLibraryChangeObserver, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) PHFetchResult *fetchResult;

@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGRect previousPreheatRect;

@property (nonatomic, assign) BOOL disableScrollToBottom;
@property (nonatomic, strong) NSIndexPath *lastSelectedItemIndexPath;
@end

@implementation MB050AssetsViewController

static CGSize AssetGridThumbnailSize;
static NSInteger imageNumberInOneRow = 4;
static NSInteger interItemSpacing = 2;

- (void)calculateAssetGridThumbnailSize {
//    AssetGridThumbnailSize =  CGSizeMake(50, 50);
    CGFloat thumbnailWidth = ([UIScreen mainScreen].bounds.size.width - interItemSpacing * (imageNumberInOneRow - 1))/ imageNumberInOneRow;
    AssetGridThumbnailSize = CGSizeMake(thumbnailWidth, thumbnailWidth);
    NSLog(@"AssetGridThumbnailSize %f %f", AssetGridThumbnailSize.width, AssetGridThumbnailSize.height);
}

- (id)initWithImagePicker:(QBImagePickerController*)imagePicker {
    if (self = [super initWithCollectionViewLayout:[UICollectionViewFlowLayout new]]) {
        [self calculateAssetGridThumbnailSize];
        self.imagePickerController = imagePicker;
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = AssetGridThumbnailSize;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[QBAssetCell class] forCellWithReuseIdentifier:@"qb_asset_cell"];

    self.collectionView.alwaysBounceVertical = YES;
    
    NSLog(@"mau backgroudn %@ ", self.collectionView.backgroundColor);
    NSLog(@"frame height = %f", self.collectionView.frame.size.height);
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.fetchResult = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    NSLog(@"fetchresult count = %@" , self.fetchResult);
}

- (void)setAssetCollection:(PHAssetCollection *)assetCollection
{

    _assetCollection = assetCollection;
    [self updateFetchRequest];
    [self.collectionView reloadData];
}

- (void)updateFetchRequest
{
    if (self.assetCollection) {
        PHFetchOptions *options = [PHFetchOptions new];
        
//        switch (self.imagePickerController.mediaType) {
//            case QBImagePickerMediaTypeImage:
//                options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
//                break;
//                
//            case QBImagePickerMediaTypeVideo:
//                options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeVideo];
//                break;
//                
//            default:
//                break;
//        }
        
        self.fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:options];
        
   
//        
//        if ([self isAutoDeselectEnabled] && self.imagePickerController.selectedAssets.count > 0) {
//            // Get index of previous selected asset
//            PHAsset *asset = [self.imagePickerController.selectedAssets firstObject];
//            NSInteger assetIndex = [self.fetchResult indexOfObject:asset];
//            self.lastSelectedItemIndexPath = [NSIndexPath indexPathForItem:assetIndex inSection:0];
//        }
    } else {
        self.fetchResult = nil;
    }
}


// -------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
//    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[QBAssetCell class] forCellWithReuseIdentifier:@"qb_asset_cell"];

    QBAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qb_asset_cell" forIndexPath:indexPath];

    cell.tag = indexPath.item;
    
    if (cell == nil) {
        cell = [[QBAssetCell alloc] initWithFrame:CGRectMake(0, 0, AssetGridThumbnailSize.width, AssetGridThumbnailSize.height)];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
//    UIImage *img = [UIImage imageNamed:@"photo4.jpg"];
//    cell.imageView.image = img;

    
    // Image
    PHAsset *asset = self.fetchResult[indexPath.item];
    
    CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
//    CGSize targetSize = CGSizeScale(itemSize, self.traitCollection.displayScale);

    [[PHImageManager defaultManager] requestImageForAsset:asset
                                 targetSize:AssetGridThumbnailSize
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  
                                  if (cell.tag == indexPath.item) {
                                      cell.imageView.image = result;
                                      NSLog(@"da set duoc");
                                  }
                                      NSLog(@"da set duoc xxxx");
                              }];
    
    // Video indicator
//    if (asset.mediaType == PHAssetMediaTypeVideo) {
//        cell.videoIndicatorView.hidden = NO;
//        
//        NSInteger minutes = (NSInteger)(asset.duration / 60.0);
//        NSInteger seconds = (NSInteger)ceil(asset.duration - 60.0 * (double)minutes);
//        cell.videoIndicatorView.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
//        
//        if (asset.mediaSubtypes & PHAssetMediaSubtypeVideoHighFrameRate) {
//            cell.videoIndicatorView.videoIcon.hidden = YES;
//            cell.videoIndicatorView.slomoIcon.hidden = NO;
//        }
//        else {
//            cell.videoIndicatorView.videoIcon.hidden = NO;
//            cell.videoIndicatorView.slomoIcon.hidden = YES;
//        }
//    } else {
//        cell.videoIndicatorView.hidden = YES;
//    }
    
    // Selection state
    if ([self.imagePickerController.selectedAssets containsObject:asset]) {
        [cell setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.imagePickerController.delegate respondsToSelector:@selector(qb_imagePickerController:shouldSelectAsset:)]) {
        PHAsset *asset = self.fetchResult[indexPath.item];
        return [self.imagePickerController.delegate qb_imagePickerController:self.imagePickerController shouldSelectAsset:asset];
    }
    
    if ([self isAutoDeselectEnabled]) {
        return YES;
    }
    
    return ![self isMaximumSelectionLimitReached];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QBImagePickerController *imagePickerController = self.imagePickerController;
    NSMutableOrderedSet *selectedAssets = imagePickerController.selectedAssets;
    
    PHAsset *asset = self.fetchResult[indexPath.item];
    
        if ([self isAutoDeselectEnabled] && selectedAssets.count > 0) {
            // Remove previous selected asset from set
            [selectedAssets removeObjectAtIndex:0];
            
            // Deselect previous selected asset
            if (self.lastSelectedItemIndexPath) {
                [collectionView deselectItemAtIndexPath:self.lastSelectedItemIndexPath animated:NO];
            }
        }
        
        // Add asset to set
        [selectedAssets addObject:asset];
        
        self.lastSelectedItemIndexPath = indexPath;
        
//        [self updateDoneButtonState];
    
        if (imagePickerController.showsNumberOfSelectedAssets) {
//            [self updateSelectionInfo];
            
            if (selectedAssets.count == 1) {
                // Show toolbar
                [self.navigationController setToolbarHidden:NO animated:YES];
            }
        }
    
    QBAssetCell *cell = (QBAssetCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.checkMarkView changeColorOfCheckMark];
    
    if ([imagePickerController.delegate respondsToSelector:@selector(qb_imagePickerController:didSelectAsset:)]) {
        [imagePickerController.delegate qb_imagePickerController:imagePickerController didSelectAsset:asset];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

    QBImagePickerController *imagePickerController = self.imagePickerController;
    NSMutableOrderedSet *selectedAssets = imagePickerController.selectedAssets;
    
    PHAsset *asset = self.fetchResult[indexPath.item];
    
    // Remove asset from set
    [selectedAssets removeObject:asset];
    
    self.lastSelectedItemIndexPath = nil;
    
//    [self updateDoneButtonState];
    
    if (imagePickerController.showsNumberOfSelectedAssets) {
//        [self updateSelectionInfo];
        
        if (selectedAssets.count == 0) {
            // Hide toolbar
            [self.navigationController setToolbarHidden:YES animated:YES];
        }
    }
    
    if ([imagePickerController.delegate respondsToSelector:@selector(qb_imagePickerController:didDeselectAsset:)]) {
        [imagePickerController.delegate qb_imagePickerController:imagePickerController didDeselectAsset:asset];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return AssetGridThumbnailSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return interItemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return interItemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - Checking for Selection Limit
- (BOOL)isMaximumSelectionLimitReached
{
    return (self.imagePickerController.maximumNumberOfSelection <= self.imagePickerController.selectedAssets.count);
}

- (BOOL)isAutoDeselectEnabled
{
    return self.imagePickerController.maximumNumberOfSelection == 1;
}


- (PHCachingImageManager *)imageManager
{
    if (_imageManager == nil) {
        _imageManager = [PHCachingImageManager new];
    }
    
    return _imageManager;
}

@end
