//
//  CircleView.h
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

@interface CircleView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
//@property (nonatomic, strong) UIFont *percentFont;
@property (nonatomic, strong) NSArray *percentArray;
@property (nonatomic, strong) NSArray *percentColorArray;


@end
