//
//  CropImageViewController.m
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//

#import "CropImageViewController.h"
#import "TKImageView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
#define CROP_PROPORTION_IMAGE_SPACE 48.0f
#define CROP_PROPORTION_IMAGE_PADDING 20.0f

@interface CropImageViewController () {
    
    NSArray *proportionImageNameArr;
    NSArray *proportionImageNameHLArr;
    NSArray *proportionArr;
    NSMutableArray *proportionBtnArr;
    CGFloat currentProportion;

}
@property (weak, nonatomic) IBOutlet UIScrollView *cropProportionScrollView;
@property (weak, nonatomic) IBOutlet TKImageView *tkImageView;

@end

@implementation CropImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpTKImageView];
    [self setUpCropProportionView];
    [self clickProportionBtn: proportionBtnArr[0]];
    currentProportion = 0;
    
}
- (IBAction)btnDone:(id)sender {
    
        [self.delegate imageCropedInCircle: [_tkImageView currentCroppedImage]];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
- (void)setUpTKImageView {
    
    _tkImageView.toCropImage = _image;
    _tkImageView.showMidLines = YES;
    _tkImageView.needScaleCrop = YES;
    _tkImageView.showCrossLines = YES;
    _tkImageView.cornerBorderInImage = NO;
    _tkImageView.cropAreaCornerWidth = 44;
    _tkImageView.cropAreaCornerHeight = 44;
    _tkImageView.minSpace = 30;
    _tkImageView.cropAreaCornerLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaBorderLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCornerLineWidth = 6;
    _tkImageView.cropAreaBorderLineWidth = 4;
    _tkImageView.cropAreaMidLineWidth = 20;
    _tkImageView.cropAreaMidLineHeight = 6;
    _tkImageView.cropAreaMidLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineWidth = 4;
    _tkImageView.initialScaleFactor = .8f;
    
}
- (void)setUpCropProportionView {
    

    proportionArr = @[@1, @(4.0/3.0), @(3.0/4.0), @(16.0/9.0), @(9.0/16.0)];
    
    
}
- (void)clickProportionBtn: (UIButton *)proportionBtn {
    
    for(UIButton *btn in proportionBtnArr) {
        btn.selected = NO;
    }
    proportionBtn.selected = YES;
    NSInteger index = [proportionBtnArr indexOfObject:proportionBtn];
    currentProportion = [proportionArr[index] floatValue];
    _tkImageView.cropAspectRatio = currentProportion;
    
}
#pragma mark - IBActions
- (IBAction)clickCancelBtn:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated: YES];
    
}
- (IBAction)clickOkBtn:(id)sender {
    
    
   id  c  = [_tkImageView currentCroppedImage];
    
    

    
}
@end
