//
//  MBViewController.m
//  LisCam
//
//  Created by Markus on 21.07.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface MBViewController ()
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

-(void)showError:(NSString*)message;
@end

@implementation MBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.session = [[AVCaptureSession alloc] init];
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        NSError *error = nil;
        AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
        
        if (!error) {
            if ([self.session canAddInput:input]) {
                [self.session addInput:input];
            } else {
                [self showError:@"Could not add input to capture session"];
            }
        } else {
            [self showError:[NSString stringWithFormat:@"Failed to create device input.\n%@", [error localizedDescription]]];
        }
    } else {
        [self showError:@"Could not create video device"];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    self.previewLayer.bounds = self.view.layer.bounds;
    [self.view.layer addSublayer:self.previewLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)showError:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:message
                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

}

@end
