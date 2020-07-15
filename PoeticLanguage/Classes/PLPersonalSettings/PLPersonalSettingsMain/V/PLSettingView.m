//
//  PLSettingView.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/2/27.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLSettingView.h"
#import <Masonry.h>
#import "PLSettingTableViewCell.h"
#import "PLSettingPersonalTableViewCell.h"

@implementation PLSettingView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mainTableView = [[UITableView alloc] init];
        [self addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.bottom.mas_equalTo(self).offset(-50);
            make.left.and.right.mas_equalTo(self);
        }];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [_mainTableView registerClass:[PLSettingPersonalTableViewCell class] forCellReuseIdentifier:@"personal"];
        [_mainTableView registerClass:[PLSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"exit"];
        
        UIView *view = [[UIView alloc] init];
        _mainTableView.tableFooterView = view;
        view.backgroundColor = [UIColor clearColor];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.tableHeaderView.backgroundColor = [UIColor clearColor];
        _mainTableView.tableFooterView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        
        PLSettingPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personal" forIndexPath:indexPath];
        cell.selectionStyle = UIAccessibilityTraitNone;
        cell.backgroundColor = [UIColor clearColor];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"header"]]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        [cell.personalImageButton setImage:[[UIImage imageWithData:imageData] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        cell.nameLabel.text = [userDefaults objectForKey:@"name"];
        cell.nameLabel.font = [UIFont systemFontOfSize:20];
        
        cell.gradeLabel.text = [NSString stringWithFormat:@"LV.%@", [userDefaults objectForKey:@"grades"]];
        cell.gradeLabel.font = [UIFont systemFontOfSize:13];
        
        cell.contentLabel.text = [userDefaults objectForKey:@"signature"];
        cell.contentLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    } else if (indexPath.section == 1){
        PLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UIAccessibilityTraitNone;
        cell.backgroundColor = [UIColor clearColor];
        NSArray *nameArr = @[@"我收藏的", @"我背过的",  @"我的等级", @"修改资料", @"关于诗语"];
        cell.nameLabel.text = nameArr[indexPath.row] ;
        cell.nameLabel.font = [UIFont systemFontOfSize:15] ;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img%ld.png", indexPath.row + 2]] ;
        cell.iimageView.image = image ;
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exit" forIndexPath:indexPath];
        cell.selectionStyle = UIAccessibilityTraitNone;
        cell.backgroundColor = [UIColor clearColor];
        
        NSArray *nameArr = @[@"切换账号", @"退出登陆"];
        cell.textLabel.text = nameArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else if (section == 1){
        return 5;
    } else {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 130;
    } else if (indexPath.section == 2) {
        return 60;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1 || section == 2) {
        return @" ";
    } else {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //修改资料
    if (indexPath.section == 1 && indexPath.row == 3) {
        NSNotification *update = [NSNotification notificationWithName:@"update" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:update];
    }
    //收藏
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSNotification *collect = [NSNotification notificationWithName:@"collect" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:collect];
    }
    //背过
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSNotification *remember = [NSNotification notificationWithName:@"remember" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:remember];
    }
    //退出
    if (indexPath.section == 2 && indexPath.row == 1) {
        NSNotification *exit = [NSNotification notificationWithName:@"exit" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:exit];
    }
    if (indexPath.section == 1 && indexPath.row == 4) {
        NSNotification *about = [NSNotification notificationWithName:@"about" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:about];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSNotification *group = [NSNotification notificationWithName:@"group" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:group];
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
