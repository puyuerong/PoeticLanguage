//
//  PLGroupView.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/7/15.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLGroupView.h"
#import <Masonry.h>
#import "ChangeFontTay.h"

@implementation PLGroupView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(100);
            make.height.equalTo(@(100));
        }];
        _nameLabel.text = @"等级说明";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [[ChangeFontTay sharedManger] downloadWithFontName:@"STKaitiSC-Regular" withLabel:_nameLabel withSize:35];
        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@50);
            make.right.equalTo(@-50);
            make.top.mas_equalTo(self).offset(120);
            make.bottom.mas_equalTo(self).offset(-50);
        }];
        [[ChangeFontTay sharedManger] downloadWithFontName:@"STKaitiSC-Regular" withLabel:_contentLabel withSize:17];
        _contentLabel.text = @" 升级机制：采用\"背诵积分制来对用户进行升级\"，每背诵一首诗积累积分为5分，积分对应的级别分别为:\n0分：1级(默认级别)\n10分：2级\n30分：3级\n60分：4级\n100分：5级";
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
