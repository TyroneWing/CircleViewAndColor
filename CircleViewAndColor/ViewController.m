//
//  ViewController.m
//  CircleView
//
//  Created by yi on 16/1/11.
//  Copyright © 2016年 yi. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "UIImage+GradientColor.h"


#define RGB(r,g,b) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

@interface ViewController ()
{
    CircleView *circleView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UIFont 系统字体
    NSArray* familys = [UIFont familyNames];
    for (int i = 0; i<[familys count]; i++) {
        NSString* family = [familys objectAtIndex:i];
        NSLog(@"\r\n\r\nFontfamily:%@\r\n=====",family);
        NSArray* fonts = [UIFont fontNamesForFamilyName:family];
        for (int j = 0; j<[fonts count]; j++) {
            NSLog(@"%@",[fonts objectAtIndex:j]);
        }  
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    UIColor *topleftColor = [UIColor colorWithRed:42/255.0f green:97/255.0f blue:146/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:52/255.0f green:128/255.0f blue:186/255.0f alpha:1.0f];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:back.bounds.size];
    back.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    [self.view addSubview:back];
    UIView *back2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 200)];
    back2.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    [self.view addSubview:back2];
    
    
    circleView = [[CircleView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-150)/2, 130, 150, 150)];
    circleView.lineWidth = 25;
    circleView.percentColorArray = @[RGB(84, 166, 236),RGB(254, 255, 255),RGB(31, 73, 120),RGB(31, 73, 180)];
    circleView.percentArray = @[@5,@3,@1,@"3"];
    
    [self.view addSubview:circleView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
