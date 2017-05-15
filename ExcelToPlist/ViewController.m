//
//  ViewController.m
//  ExcelToPlist
//
//  Created by Power on 2017/5/15.
//  Copyright © 2017年 Power. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *iOSPath = [[NSBundle mainBundle] pathForResource:@"basestation_all" ofType:@"csv"];
    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *baseStationInfoArr= [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSString *names = [baseStationInfoArr objectAtIndex:0];
    NSMutableArray *baseStations = [baseStationInfoArr mutableCopy];
    [baseStations removeObjectAtIndex:0];
    NSMutableArray *allPlists = [NSMutableArray array];
    //    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"baseStation" ofType:@"plist"];
    NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/baseStation.plist"];
    for (int i = 0; i < baseStations.count; i++) {
        if (i % 2 == 0) {
            continue;
        }
        NSArray *allTitle = [names componentsSeparatedByString:@","];
        NSArray *allContents = [baseStations[i] componentsSeparatedByString:@","];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int j = 0; j < allContents.count; j++) {
            [dic setObject:allContents[j] forKey:allTitle[j]];
        }
        [allPlists addObject:dic];
    }
    [allPlists writeToFile:plistPath atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
