//
//  PLDailySharingViewController.m
//  PoeticLanguage
//
//  Created by 蒲悦蓉 on 2020/5/24.
//  Copyright © 2020 cinderella. All rights reserved.
//SunYatsenHsingshu- 中山 TpldKhangXiDict 康熙

#import "PLDailySharingViewController.h"
#import "PLGetDateModel.h"

@interface PLDailySharingViewController ()
@property PLDailySharingModel *dataModel;
@property PLDailySharingView *dailySharingView;
@property PLContentModel *contentModel;
@property PLGetDateModel *getdateModel;
@end

@implementation PLDailySharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _getdateModel = [[PLGetDateModel alloc] init];
    
    
    _contentModel = [[PLContentModel alloc] init];
    _dataModel = [[PLDailySharingModel alloc] init];
    [[PLDailySharingManger sharedManger] postData:^(PLDailySharingModel * _Nonnull model) {
        self.dataModel = model;
        
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.contentModel = self.dataModel.poet;
                [self LoadData];
            });
    }] ;
    
    _dailySharingView = [[PLDailySharingView alloc] init];
    [self.view addSubview:_dailySharingView];
    [_dailySharingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
}

- (void)LoadData {
    _dailySharingView.titleLabel.text = _contentModel.title;
    if ([_dailySharingView.titleLabel.text length] >= 10) {
        _dailySharingView.titleLabel.numberOfLines = 0;
    }
    _dailySharingView.dynastyLabel.text = _contentModel.dynasty;
    _dailySharingView.authorLabel.text = _contentModel.author;
    _dailySharingView.paragraphLabel.text = _contentModel.paragraphs;
    
#pragma mark 清除诗词中多余部分
    int m = 0;  //用于记录换行个数
    NSMutableString *all = [NSMutableString stringWithString:_contentModel.paragraphs];
    for (int i = 0; i < _contentModel.paragraphs.length - 1; i++) {
        unichar str =   [_contentModel.paragraphs characterAtIndex:i];
        NSString *str1 = [NSString stringWithFormat:@"%C", str];
        unichar str2 = [_contentModel.paragraphs characterAtIndex:i + 1];
        NSString *str3 = [NSString stringWithFormat:@"%C", str2];
        if ([str1 isEqualToString:@"。"] && ![str3 isEqualToString:@"\n"]) {
            [all insertString:@"\n" atIndex:i + m + 1];
            if (m == 0) {
                _dailySharingView.juhao = i;
            }
            m++;
        }
    }
    NSString *all1 = [NSString stringWithString:all];
    all1 = [all1 stringByReplacingOccurrencesOfString:@"\",\"" withString:@""];
    all1 = [all1 stringByReplacingOccurrencesOfString:@"。\n\"" withString:@""];
    _dailySharingView.paragraphLabel.text = [all1 stringByAppendingString:@"。"];
    
    NSString *str4 = @"丹山西去水东流，亭在山南隔蓼洲。";
    NSLog(@"text = %@ length = %ld 句号 = %ld", _dailySharingView.paragraphLabel.text, [str4 length], _dailySharingView.juhao);
    
#pragma mark 计算view的位置
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect startRact = [_dailySharingView.titleLabel convertRect:_dailySharingView.titleLabel.bounds toView:window];
    CGRect endRact = [_dailySharingView.paragraphLabel convertRect:_dailySharingView.paragraphLabel.bounds toView:window];
    float location = (endRact.origin.y + endRact.size.height - startRact.origin.y) / 2;
    [_dailySharingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-(location + 100));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSDate *dated = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *strDate = [formatter stringFromDate:dated];
    NSString *yTimeStr = [strDate substringWithRange:NSMakeRange(0, 9)];
    
    _getdateModel = [[PLGetDateModel alloc] init];
    NSDate *date = [_getdateModel getDateWithDateString:strDate formatString:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nTimeStr = [_getdateModel getChineseCalendarWithDate:date];
    NSLog(@"阳历%@====农历 = %@", yTimeStr, nTimeStr);
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", nTimeStr];
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
