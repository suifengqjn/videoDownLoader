//
//  ResourceListViewController.m
//  VideoDownloaderTest
//
//  Created by 罗元丰 on 2017/2/23.
//  Copyright © 2017年 罗元丰. All rights reserved.
//

#import "ResourceListViewController.h"
#import "DownloadMamageViewController.h"
#import "DownloadManageCell.h"
#import "LoadedViewController.h"
#import "LYFDownloadManager.h"

@interface ResourceListViewController () <DownloadManageCellDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *downLoadBtn;


@end

@implementation ResourceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc] init];
    _textView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
    
    
    
    _downLoadBtn = [UIButton new];
    [_downLoadBtn addTarget:self action:@selector(downLoadAction) forControlEvents:UIControlEventTouchUpInside];
    _downLoadBtn.frame = CGRectMake((self.view.bounds.size.width - 100)/2, 150, 100, 50);
    [_downLoadBtn setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
    [_downLoadBtn setTitle:NSLocalizedString(@"download", nil) forState:UIControlStateNormal];
    _downLoadBtn.titleLabel.textColor = [UIColor whiteColor];
    _downLoadBtn.titleLabel.font = [UIFont fontWithName:@".SFUIText-Medium" size:17];
    _downLoadBtn.layer.cornerRadius = 4;
    _downLoadBtn.clipsToBounds = YES;
    [self.view addSubview:_downLoadBtn];

    
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"loading" style:UIBarButtonItemStyleDone target:self action:@selector(goManage)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"loaded" style:UIBarButtonItemStyleDone target:self action:@selector(goloaded)];
    self.navigationItem.leftBarButtonItem = item2;
    
    
}

-(UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _textView.text = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _textView.text = [UIPasteboard generalPasteboard].string;
    });
    
}



- (void)downLoadAction
{
    if (_textView.text.length > 0) {
        NSString *customKey = [_textView.text componentsSeparatedByString:@"/"].lastObject;
        [[LYFDownloadManager sharedInstance] addDownloadTaskForKey:customKey
                                                               url:_textView.text
                                                        createTime:[[NSDate date] timeIntervalSince1970] * 1000
                                                            status:LYFTaskStatusNew
                                                        customInfo:nil
                                                  expectedFileName:nil
                                                 expectedDirectory:nil];
    }
}

- (void)goManage
{
    DownloadMamageViewController *vc = [[DownloadMamageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)download:(NSString *)url sender:(UIButton *)btn
{
    NSString *customKey = [url componentsSeparatedByString:@"/"].lastObject;
    [[LYFDownloadManager sharedInstance] addDownloadTaskForKey:customKey
                                                           url:url
                                                    createTime:[[NSDate date] timeIntervalSince1970] * 1000
                                                        status:LYFTaskStatusNew
                                                    customInfo:nil
                                              expectedFileName:nil
                                             expectedDirectory:nil];
}

- (void)goloaded
{
    LoadedViewController *loaded = [[LoadedViewController alloc] init];
    [self.navigationController pushViewController:loaded animated:YES];
}
@end
