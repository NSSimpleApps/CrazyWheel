//
//  ViewController.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 04.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.textView.text = self.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
