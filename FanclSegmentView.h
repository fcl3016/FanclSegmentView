//
//  FanclSegmentView.h
//  yishengdaojia
//
//  Created by Kara on 15/5/11.
//  Copyright (c) 2015年 yisheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FanclSegmentView;

@protocol FanclSegmentViewDelegate <NSObject>

- (void)segmentClickAtIndex:(NSInteger) index;

@end

@interface FanclSegmentView : UIView
{

}

@property (assign, nonatomic) id <FanclSegmentViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray * segmentArray;

@property (strong, nonatomic) UIView * lineView;

@property (assign, nonatomic) BOOL showPaddingView;

- (void)addSegmentWithTitles:(NSArray * )titleArray;

- (void)setSelectSegmentAtIndex:(NSInteger) index;

- (void)updateButtonsTitles:(NSArray *) array;

- (void)updateOneButtonTitleAtIndex:(NSInteger) index title:(NSString *) titleStr;

@end
