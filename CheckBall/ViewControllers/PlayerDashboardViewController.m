//
//  PlayerDashboardViewController.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "PlayerDashboardViewController.h"
#import "DashboradTrainerListViewCell.h"


@interface PlayerDashboardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * dataSource;


@end

@implementation PlayerDashboardViewController

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
