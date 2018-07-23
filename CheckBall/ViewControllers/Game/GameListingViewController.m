//
//  GameListingViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "GameListingViewController.h"
#import "DashboradTrainerListViewCell.h"

@interface GameListingViewController ()<UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation GameListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboradTrainerListViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellTrainer"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboradTrainerListViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTrainer" forIndexPath:indexPath];
    
    
    //[currentCell updateWithDate:[self.dataSource objectAtIndex:indexPath.row]];
    
   // UITapGestureRecognizer *singleFingerTap =
   // [[UITapGestureRecognizer alloc] initWithTarget:self
   //                                         action:@selector(selectedItem:)];
    currentCell.contentView.tag = indexPath.row;
    currentCell.lblName.text = @"Team Name";
    currentCell.lblType.text = @"Game Name";
    
    return currentCell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    NSLog(@"");
    
    
    
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
