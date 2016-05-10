//
//  QBImagePickerController.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBImagePickerController.h"
#import "MB050AssetsViewController.h"
#import <Photos/Photos.h>

// ViewControllers
//#import "QBAlbumsViewController.h"

@interface QBImagePickerController ()

@property (nonatomic, strong) UINavigationController *albumsNavigationController;

@property (nonatomic, strong) NSBundle *assetBundle;

@end

@implementation QBImagePickerController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // Set default values
        self.assetCollectionSubtypes = @[
                                         @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                         @(PHAssetCollectionSubtypeAlbumMyPhotoStream),
                                         @(PHAssetCollectionSubtypeSmartAlbumPanoramas),
                                         @(PHAssetCollectionSubtypeSmartAlbumVideos),
                                         @(PHAssetCollectionSubtypeSmartAlbumBursts)
                                         ];
        
        _selectedAssets = [NSMutableOrderedSet orderedSet];
        
        // Get asset bundle
        self.assetBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [self.assetBundle pathForResource:@"QBImagePicker" ofType:@"bundle"];
        if (bundlePath) {
            self.assetBundle = [NSBundle bundleWithPath:bundlePath];
        }
        
//        [self setUpAlbumsViewController];
    }
    
    return self;
}

//- (void)setUpAlbumsViewController
//{
//    // Add QBAlbumsViewController as a child
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QBImagePicker" bundle:self.assetBundle];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"QBAlbumsNavigationController"];
//    
//    [self addChildViewController:navigationController];
//    
//    navigationController.view.frame = self.view.bounds;
//    [self.view addSubview:navigationController.view];
//    
//    [navigationController didMoveToParentViewController:self];
//    
//    self.albumsNavigationController = navigationController;
//}

@end
