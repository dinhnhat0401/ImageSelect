//
//  ViewController.m
//  ImageSelect
//
//  Created by Dinh Van Nhat on 5/9/16.
//  Copyright © 2016 Dinh Van Nhat. All rights reserved.
//

#import "ViewController.h"
#import "QBImagePickerController.h"
#import "MB050AssetsViewController.h"
#import "QBAssetCell.h"

@interface ViewController ()<QBImagePickerControllerDelegate>
@property (nonatomic, copy) NSArray *fetchResults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)buttonOnClick:(id)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = QBImagePickerMediaTypeAny;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    imagePickerController.maximumNumberOfSelection = 6;
    

    MB050AssetsViewController *assetsVC = [[MB050AssetsViewController alloc] initWithImagePicker:imagePickerController];
    [self presentViewController:assetsVC animated:YES completion:nil];
//    assetsVC.assetCollection = self.assetCollections[self.tableView.indexPathForSelectedRow.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
