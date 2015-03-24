//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "LPGViewController.h"

@interface LPGViewController () {
    int appleCount;
}

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation LPGViewController

- (void)viewDidLoad
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    [self.view addGestureRecognizer:doubleTap];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
    [_appleImage addGestureRecognizer:pinchGesture];
    
    
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.inputText.text);
    
    
    if ([_inputText.text containsString:@"?"]) {
        _responseText.text = [NSString stringWithFormat:(@"idk man im just a cat")];
    }
    
    if ([_inputText.text containsString:@"!"]) {
        _responseText.text = [NSString stringWithFormat:(@"fu** off bro")];
    }
    
    if ([_inputText.text containsString:@"."]) {
        _responseText.text = [NSString stringWithFormat:(@"dude i know right")];
    }
    
    
    [self.inputText resignFirstResponder];
    return YES;
}


- (IBAction)didPressSend:(id)sender {
    [self textFieldShouldReturn:_inputText];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch: Keyboard should disappear");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didPinch:(UIPinchGestureRecognizer *)sender {
    
    appleCount++;
    _responseText.text = [NSString stringWithFormat:@"thx 4 aple"];
    
    if (appleCount >= 100) {
        _responseText.text = [NSString stringWithFormat:(@"2 mny aplz plz stop")];
   
    }
    
    
}

- (void)didDoubleTap:(UITapGestureRecognizer *)sender {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"meow"
                                                              ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    _player.numberOfLoops = 1;
    
    [_player play];
    
    _responseText.text = [NSString stringWithFormat:@"Meow!"];
    
}

- (void)didPan:(UIPanGestureRecognizer *)sender {
    
    
    // When gesture recognized do stuff
}


@end
