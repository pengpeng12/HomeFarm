//
//  ViewController.m
//  HomeFarm
//
//  Created by 宋鹏鹏 on 18/4/5.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"首页";
    
    //测试sign验证
//    , @{@"other":@"abc"}
    NSArray *dicArray = @[@{@"username":@"chen"}, @{@"pass":@"chen"}];
    __block NSMutableArray *keyArray = [NSMutableArray array];
    [dicArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        NSLog(@"%@---%@",dicArray[idx], [NSThread currentThread]);
        NSDictionary *dic = dicArray[idx];
        [keyArray addObject:[dic allKeys][0]];
    }];
    NSLog(@"%@", keyArray);
    NSArray *sortKeyArray = [self handelDictionary:keyArray];
    NSLog(@"%@", sortKeyArray);
    NSMutableArray *tempSortArray = [NSMutableArray array];
    for (int i = 0; i < sortKeyArray.count; i ++) {
        NSString * key = sortKeyArray[i];
        for (NSDictionary *dic in dicArray) {
            if ([[dic allKeys][0] isEqualToString:key]) {
                [tempSortArray addObject:dic];
            }
        }
    }
    NSArray *finalArray = [tempSortArray copy];
    NSLog(@"finalArray==%@", finalArray);
    
}

//md5加密
- (NSString *)md5String:(NSString *)originStr{
    //先转为UTF_8编码的字符串
    const char* str = originStr.UTF8String;
    NSLog(@"utf8str==%s", str);
    //设置一个接受字符数组
    //md5加密后是128bit, 16 字节 * 8位/字节 = 128 位
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH* 2];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    //将16字节的16进制转成32字节的16进制字符串
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

//数组内元素按升序排
-(NSArray *)handelDictionary:(NSArray *)array
{
    NSMutableArray *sortArray = [[NSMutableArray alloc]init];
    for (id _obj in [array sortedArrayUsingSelector:@selector(compare:)]) {
        [sortArray addObject:_obj];
    }
    return [sortArray copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
