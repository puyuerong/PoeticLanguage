//
//  PLKeywordPoetView.h
//  PoeticLanguage
//
//  Created by cinderella on 2020/5/5.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLKeywordPoetView : UIView
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSArray *poetryArray;
@property (nonatomic, strong) NSMutableArray *sizeHeightArray;

- (instancetype)initWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
