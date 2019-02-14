//
//  ViewController.m
//  ZHWTools
//
//  Created by hongwu zhu on 2017/3/7.
//  Copyright © 2017年 zhw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testMD5];
}

-(void)testMD5{
    
    
    NSString *mdStr = @"key笑话needContent1page3showapi_appid32921typeId2cc5b4721bb394890b2cd75128b1189f4";
    
    //参数a~z排序
    NSArray *arr = @[@"key",@"showapi_timestamp",@"page",@"needContent",@"showapi_appid",@"typeId"];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",resultArray);
    
    //对排序后的参数进行md5加密
    NSString *newMdStr = [NSString MD5ForUpper32Bate:mdStr];//[self md532BitUpper:mdStr];
    
    NSString *baseUrlStr = @"https://route.showapi.com/582-2?key=%E7%AC%91%E8%AF%9D&needContent=1&page=3&showapi_appid=32921&typeId=2&showapi_sign=";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseUrlStr,newMdStr];
    
    //复制url在浏览器打开
    NSLog(@"=====================:\n%@\n======:\n%@",newMdStr,urlStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
