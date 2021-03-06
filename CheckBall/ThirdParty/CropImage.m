//
//  CropImage.m
//  ImageCirclCropper
//
//  Created by Thabresh on 9/1/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "CropImage.h"
#define BACK_LOGO [UIImage imageNamed:@"back"]
#define GO_BACK [self.navigationController popViewControllerAnimated:YES];
@interface CropImage ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) CGFloat circleRadius;
@property (nonatomic) CGPoint circleCenter;

@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic, weak) CAShapeLayer *circleLayer;

@property (nonatomic, weak) UIPinchGestureRecognizer *pinch;
@property (nonatomic, weak) UIPanGestureRecognizer   *pan;

@end

@implementation CropImage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:BACK_LOGO style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
    self.imageView.image = _origionalImage;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.imageView.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.imageView.layer addSublayer:circleLayer];
    self.circleLayer = circleLayer;
    
    [self CirclePathAtLocation:CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0) radius:self.view.bounds.size.width * 0.30];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [self.imageView addGestureRecognizer:pan];
    self.imageView.userInteractionEnabled = YES;
    self.pan = pan;
    
    // create pan gesture
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    self.pinch = pinch;
}
-(void) backButtonAction:(id)sender {
    GO_BACK
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ((gestureRecognizer == self.pan   && otherGestureRecognizer == self.pinch) ||
        (gestureRecognizer == self.pinch && otherGestureRecognizer == self.pan))
    {
        return YES;
    }
    
    return NO;
}
- (void)CirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    self.circleCenter = location;
    self.circleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.circleCenter
                    radius:self.circleRadius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    self.maskLayer.path = [path CGPath];
    self.circleLayer.path = [path CGPath];
}


-(void)showAlert:(NSString *)title message:(NSString *)currentMessage
{
    
    if ([currentMessage isKindOfClass:[NSArray class]]) {
        
        NSString * result = [[currentMessage valueForKey:@"id"] componentsJoinedByString:@","];
        currentMessage = result;
        
    }
    if (IS_IOS8) {
        UIAlertView *ErrorAlert = [[UIAlertView alloc]
                                   initWithTitle:title
                                   message:currentMessage
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = 0;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
        return;
    }
    
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message: currentMessage
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [myAlertController addAction: ok];
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

- (IBAction)didTouchUpInsideSaveButton:(id)sender {
    CGFloat scale  = [[self.imageView.window screen] scale];
    CGFloat radius = self.circleRadius * scale;
    

    
    CGFloat noMore = self.view.frame.size.width/2;
    
    double noMoreWidth = self.view.frame.size.width*scale;
    double noMoreHeight = self.view.frame.size.height*scale;
    
    if (self.circleRadius > noMore) {
        
        [self showAlert:@"" message:@"Please select the image within boundary"];
        return;
        
    }
    
    
    
    
    CGPoint center = CGPointMake(self.circleCenter.x * scale, self.circleCenter.y * scale);
    
    CGRect frame = CGRectMake(center.x - radius,
                              center.y - radius,
                              radius * 2.0,
                              radius * 2.0);
    
    
    
    double size22 = frame.origin.x + frame.size.width;
    
    double size33 = frame.origin.x + frame.size.height;
    if (frame.origin.x < 0) {
        
                [self showAlert:@"" message:@"Please select the image within boundary"];
        
        return;
        
    }
    else if(size22 > noMoreWidth)
    {
                [self showAlert:@"" message:@"Please select the image within boundary"];
        
        return;
        
    }
    else if (frame.origin.y < 0) {
        
                [self showAlert:@"" message:@"Please select the image within boundary"];
        return;
        
    }
    else if(size33 > noMoreHeight)
    {
                [self showAlert:@"" message:@"Please select the image within boundary"];
        
        return;
        
    }
    CALayer *circleLayer = self.circleLayer;
    [self.circleLayer removeFromSuperlayer];
    
        UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self.imageView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
       
        [self.imageView drawViewHierarchyInRect:self.imageView.bounds afterScreenUpdates:YES];
    }
    else
    {
        CGContextAddArc(context, self.circleCenter.x, self.circleCenter.y, self.circleRadius, 0, M_PI * 2.0, YES);
        CGContextClip(context);
        [self.imageView.layer renderInContext:context];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.imageView.layer addSublayer:circleLayer];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], frame);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    [_delegate imageCropedInCircle:croppedImage];
 //   [self.navigationController popViewControllerAnimated:YES];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark - Gesture recognizers

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    static CGPoint oldCenter;
    CGPoint tranlation = [gesture translationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        oldCenter = self.circleCenter;
    }
    
    CGPoint newCenter = CGPointMake(oldCenter.x + tranlation.x, oldCenter.y + tranlation.y);
    
    [self CirclePathAtLocation:newCenter radius:self.circleRadius];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gesture
{
    static CGFloat oldRadius;
    CGFloat scale = [gesture scale];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        oldRadius = self.circleRadius;
    }
    
    CGFloat newRadius = oldRadius * scale;
    
    [self CirclePathAtLocation:self.circleCenter radius:newRadius];
}



@end

