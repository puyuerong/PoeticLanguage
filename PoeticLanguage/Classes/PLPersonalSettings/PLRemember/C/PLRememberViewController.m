//
//  PLRememberViewController.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/5/21.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLRememberViewController.h"
#import "PLRememberView.h"
#import "PLCollectManager.h"
#import "PLRememberModel.h"
#import "PLSearchManager.h"
#import "PLKeywordSearchDetailedViewController.h"
#import "PLKeywordSearchDetailModel.h"
#import "PLCancelRememberModel.h"
#import "Masonry.h"

@interface PLRememberViewController ()

@end

@implementation PLRememberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backImage = [[UIImage imageNamed:@"allBackgroundImage.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];  //pl_pc_fly.jpg
    _backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goPoem:) name:@"recitePoem" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteRemember:) name:@"delete" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    while ([self.view.subviews lastObject] != nil && [self.view.subviews lastObject] != _backImageView) {
        [(UIView *)[self.view.subviews lastObject] removeFromSuperview];
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.topItem.title = @"已背过的诗词";
    self.tabBarController.tabBar.hidden = NO;
    
    [[PLCollectManager sharedManager] getRemember:^(PLRememberModel * _Nullable rememberModel) {
        if ([rememberModel.msg isEqualToString:@"ok"]) {
            self -> _myView = [[PLRememberView alloc] initWithArray:rememberModel.poet];
            self -> _myView.frame = self.view.bounds;
            [self.view addSubview:self -> _myView];
        } else {
            NSLog(@"rememberModel.msg == %@", rememberModel.msg);
        }
    } error:^(NSError * _Nullable error) {
        NSLog(@"remember error == %@", error);
    }];
    
}

- (void)goPoem:(NSNotification *)keyword {
    NSDictionary *getDictionary = keyword.userInfo;
    [[PLSearchManager sharedManager] getPoet:^(PLKeywordSearchDetailModel * _Nullable searchDetailModel) {
        if ([searchDetailModel.msg isEqualToString:@"ok"]) {
            NSLog(@"model = %@", searchDetailModel);
            PLKeywordSearchDetailedViewController *detail = [[PLKeywordSearchDetailedViewController alloc] init];
            detail.keyword = searchDetailModel.poet;
            detail.content = getDictionary[@"poemContent"];
            [self.navigationController pushViewController:detail animated:NO];
        } else {
            NSLog(@"searchDetailModel.msg == %@", searchDetailModel.msg);
            NSLog(@"getDictionary[@key] = %@", getDictionary[@"key"]);
        }
    } error:^(NSError * _Nullable error) {
        NSLog(@"detailError == %@", error);
    } sid:getDictionary[@"key"]];
}

- (void)deleteRemember:(NSNotification *)keyword {
    NSDictionary *getDictionary = keyword.userInfo;
    [[PLCollectManager sharedManager] cancelRemember:^(PLCancelRememberModel * _Nullable cancelRememberModel) {
        if ([cancelRememberModel.msg isEqualToString:@"ok"]) {
            [self viewWillAppear:NO];
        } else {
            NSLog(@"cancelRememberModel.msg == %@", cancelRememberModel.msg);
        }
    } error:^(NSError * _Nullable error) {
        NSLog(@"cancelRemember error == %@", error);
    } id:getDictionary[@"poemId"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
