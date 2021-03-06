//
//  LoadedViewController.m
//  VideoDownloaderTest
//
//  Created by qianjn on 2017/4/17.
//  Copyright © 2017年 罗元丰. All rights reserved.
//

#import "LoadedViewController.h"
#import "LYFDownloadManager.h"
#import "XCFileManager.h"
#import "ERPlayer.h"
@interface LoadedViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LoadedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    NSArray * list = [XCFileManager listFilesInCachesDirectoryByDeep:YES];
    _dataArray = [NSMutableArray array];
    for (NSString *file in list) {
        if ([file hasSuffix:@".mp4"]) {
            NSString *cacheFile = [XCFileManager cachesDir];
            NSString *path = [NSString stringWithFormat:@"%@/%@", cacheFile,file];
            [_dataArray addObject:path];
        }
    }
    [_tableView reloadData];
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = _dataArray[indexPath.row];
     NSString *title = [path componentsSeparatedByString:@"/"].lastObject;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_iden"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_iden"];
        
    }
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = _dataArray[indexPath.row];
    ERPlayer *player = [ERPlayer new];
    player.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width / 16 * 9  + 40);
    
    [player setViedoUrl:[NSURL fileURLWithPath:path]];
    [self.view addSubview:player];

}

@end
