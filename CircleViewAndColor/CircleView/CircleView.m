//
//  CircleView.m
//  CircleView
//
//  Created by yi on 15/12/16.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CircleView.h"

#define RGB(r,g,b) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define DEGREES_Default(degrees)  ((M_PI * (degrees+270))/180)

@interface CircleView ()

//@property (nonatomic, copy) NSString *percentText;
@property (nonatomic, assign) CGFloat allCount;
@property (nonatomic, assign) CGFloat startAngel;
@property (nonatomic, assign) CGFloat endAngel;

@property (nonatomic, strong) UIBezierPath *edgePath;
@property (nonatomic, strong) NSMutableArray *pathArray;


@end

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _pathArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self setupDefault];
        
    }
    return self;
}


- (void)setupDefault
{
//    _percentText = @"0%";
    _lineWidth = 25;
//    _percentFont = [UIFont fontWithName:@"Arial"size:17];
    _allCount = 0.0;
    _startAngel = 0.0;
    _percentColorArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor grayColor]];
    _percentString = @"";
}

- (void)setPercentArray:(NSArray *)percentArray
{
    _percentArray = percentArray;
    [self setNeedsDisplay];
}

-(void)drawCircle{
    
    if (_edgePath == nil) {
        _edgePath = [UIBezierPath bezierPath];
        [_edgePath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:(self.frame.size.width - self.lineWidth) / 2 - 20 startAngle:DEGREES_Default(0) endAngle:DEGREES_Default(360) clockwise:YES];
        CAShapeLayer *edgeLayer = [CAShapeLayer layer];
        edgeLayer.path = _edgePath.CGPath;
        edgeLayer.fillColor = [UIColor clearColor].CGColor;
        edgeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        edgeLayer.lineWidth = 3;
        edgeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:edgeLayer];
    }
    

    _allCount = 0.0;
    for (id count in _percentArray) {
        _allCount += [count doubleValue];
    }
    
    for (int i =0 ; i<_pathArray.count; i++) {
        CAShapeLayer *edgeLayer = _pathArray[i];
        [edgeLayer removeFromSuperlayer];
    }
    [_pathArray removeAllObjects];
    
    
    for (int i=(int)_percentArray.count-1; i>=0; i--) {
        CGFloat percentCount = [_percentArray[i] doubleValue];
        UIBezierPath *edgePath = [UIBezierPath bezierPath];
        CGFloat endAngel = (_startAngel+(percentCount/_allCount)*360);
        [edgePath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:DEGREES_Default(_startAngel) endAngle:DEGREES_Default(endAngel) clockwise:YES];
        _startAngel = endAngel;

        CAShapeLayer *edgeLayer = [CAShapeLayer layer];
        edgeLayer.path = edgePath.CGPath;
        edgeLayer.fillColor = [UIColor clearColor].CGColor;
        edgeLayer.strokeColor = [_percentColorArray[i] CGColor];
        edgeLayer.lineWidth = self.lineWidth;
        edgeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:edgeLayer];
        [_pathArray addObject:edgeLayer];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    
    [self drawCircle];
    
    if (_percentString.length > 4) {
        //百分比文字
        UIFont *percntfont = [UIFont fontWithName:@"Helvetica" size:15];
        UIColor *percntColor =  [UIColor whiteColor];
        NSDictionary *percntstringAttrs = @{ NSFontAttributeName : percntfont, NSForegroundColorAttributeName : percntColor};
        NSMutableAttributedString *percntAttrStr = [[NSMutableAttributedString alloc] initWithString:_percentString attributes:percntstringAttrs];
        [percntAttrStr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:28.0f]
                        range:NSMakeRange(0, _percentString.length - 4)];
        CGSize percntWidth = [_percentString sizeWithAttributes:percntstringAttrs];
        [percntAttrStr drawAtPoint:CGPointMake(self.bounds.size.width/2 - percntWidth.width / 2.0,  (self.bounds.size.height/2-percntWidth.height/2-10))];
    }
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
