//
//  TrainerDashboardViewController.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "TrainerDashboardViewController.h"
#import "DashboardPlayerListCollectionCell.h"
#import "OptionsView.h"

@interface TrainerDashboardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) OptionsView * optionView;

@end

@implementation TrainerDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //DashboardPlayerListCollectionCell.h
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboardPlayerListCollectionCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellPlayer"];

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
    
    DashboardPlayerListCollectionCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellPlayer" forIndexPath:indexPath];
    
    return currentCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}


@end
