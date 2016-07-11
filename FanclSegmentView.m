//
//  FanclSegmentView.m
//  yishengdaojia
//
//  Created by Kara on 15/5/11.
//  Copyright (c) 2015年 yisheng. All rights reserved.
//



#define LineViewHeight 2

#define Height_Padding 3  //button距离顶部的高度

#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define Screen_Height [UIScreen mainScreen].bounds.size.height

#import "FanclSegmentView.h"

@implementation FanclSegmentView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}

- (void)updateOneButtonTitleAtIndex:(NSInteger) index title:(NSString *) titleStr{
    
    if (self.segmentArray.count) {
        
        UIButton * button = [self.segmentArray objectAtIndex:index];
        
        [button setTitle:titleStr forState:UIControlStateNormal];
        
    }
}

- (void)updateButtonsTitles:(NSArray *) array{
    
    if (self.segmentArray.count == array.count) {
        
        for (int i = 0; i < self.segmentArray.count; i++) {
            
            UIButton * button = [self.segmentArray objectAtIndex:i];
            
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            
        }
    }
}

- (void)addSegmentWithTitles:(NSArray * )titleArray{
    
    self. segmentArray = [[NSMutableArray alloc] init];
    
    [self.segmentArray removeAllObjects];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        float buttonWidth = self.frame.size.width/(float)(titleArray.count);
        
        float buttonX = i * buttonWidth;
        
        float buttonHeight = self.frame.size.height - Height_Padding * 2;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        button.backgroundColor = [UIColor purpleColor];
        
        button.frame = CGRectMake(buttonX, Height_Padding, buttonWidth, buttonHeight);
        
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        button.titleLabel.numberOfLines = 0;
        
        [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if (self.showPaddingView) {
            
            if (i - 1 >= 0) {
                
                UILabel * label = [[UILabel alloc] init];
                
                label.frame = CGRectMake(buttonX, Height_Padding + 7, 0.5, buttonHeight - 14);
                
                label.backgroundColor = [UIColor colorWithHexString:@"999999"];
                
                [self addSubview:label];
                
            }
            
        }
        
        [self.segmentArray addObject:button];
    }
    [self addLineView];
}

- (void)buttonClick:(id)sender{
    
    UIButton * button = (UIButton *)sender;
    
    for (UIButton * curBtn in self.segmentArray) {
        
        if (curBtn.tag == button.tag) {
            
            [curBtn setTitleColor:[UIColor colorWithHexString:@"31a21f"] forState:UIControlStateNormal];
            
        }else{
            
            [curBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            
        }
        
    }
    
    [self setSelectSegmentAtIndex:button.tag];

    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentClickAtIndex:)]) {
        
        [self.delegate segmentClickAtIndex:button.tag];
        
    }
    
}

- (void)addLineView{
    
    if (!self.segmentArray.count) {
        return;
    }
    
    UIButton * button = (UIButton *)[self.segmentArray objectAtIndex:0];
    
    [button setTitleColor:[UIColor colorWithHexString:@"31a21f"] forState:UIControlStateNormal];
    
    float buttonWidth = [CommonUtils widthForString:button.titleLabel andHeight:21 minWidth:0].width;
    
    _lineView = [[UIView alloc] init];
    
    _lineView.backgroundColor = [UIColor colorWithHexString:@"31a21f"];
    
    _lineView.frame = CGRectMake(0, self.frame.size.height - LineViewHeight, buttonWidth, LineViewHeight);
    
    _lineView.center = CGPointMake(button.frame.origin.x + button.bounds.size.width / 2.0f, _lineView.center.y);
    
    [self addSubview:_lineView];
}

- (void)setSelectSegmentAtIndex:(NSInteger) index{
    
    index = index % 10;
    
    if (index > self.segmentArray.count || self.segmentArray.count == 0) {
        
        return;
        
    }
    
    UIButton * button = (UIButton *)[self.segmentArray objectAtIndex:index];
    
    for (UIButton * curBtn in self.segmentArray) {
        
        if (curBtn.tag == button.tag) {
            
            [curBtn setTitleColor:[UIColor colorWithHexString:@"31a21f"] forState:UIControlStateNormal];
            
        }else{
            
            [curBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            
        }
        
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        
        float buttonWidth = [CommonUtils widthForString:button.titleLabel andHeight:21 minWidth:0].width;
        
        _lineView.frame = CGRectMake(0, self.frame.size.height - LineViewHeight, buttonWidth, LineViewHeight);
        
        _lineView.center = CGPointMake(button.frame.origin.x + button.bounds.size.width / 2.0f, _lineView.center.y);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
