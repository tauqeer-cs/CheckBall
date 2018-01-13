//
//  PlayerDashboardViewController.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "PlayerDashboardViewController.h"
#import "DashboradTrainerListViewCell.h"
#import "OptionsView.h"


@interface PlayerDashboardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) OptionsView * optionView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


@end

@implementation PlayerDashboardViewController

-(OptionsView *)optionView{
    
    
    if (!_optionView) {
    
        _optionView = (OptionsView *)[self.view getViewFromNibName:@"OptionsView" withWidth:190 withHeight:120];
        
        
        [_optionView setFrame:CGRectMake(self.profileImageView.frame.origin.x-165, self.profileImageView.frame.origin.y+self.profileImageView.frame.size.height+65, _optionView.frame.size.width, _optionView.frame.size.height)];
        
        [self.view addSubview:_optionView];
        
        
        
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: _optionView.bounds
                                               byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
        
        //self.firstContainer.layer.mask = maskLayer;
        
        _optionView.layer.mask = maskLayer;
        
        
        
        
    
    }
    return _optionView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    self.title = @"Dashboard";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboradTrainerListViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellTrainer"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
        self.dataSource = [NSMutableArray new];
    
    [self.dataSource addObject:@"Test"];
    [self.dataSource addObject:@"Test"];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self.collectionView reloadData];
    
   // [self.optionView setHidden:NO];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboradTrainerListViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTrainer" forIndexPath:indexPath];
    
    return currentCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
