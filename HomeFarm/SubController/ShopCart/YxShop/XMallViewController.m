//
//  XMallViewController.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 16/3/18.
//  Copyright © 2016年 dfbe. All rights reserved.
//

#import "XMallViewController.h"
#import "XShopViewController.h"
//#import "FFBadgedBarButtonItem.h"

@interface XMallViewController (){
    int numAll;
}

@property(nonatomic,strong)UIActivityIndicatorView *loadingIndicator;

@end

@implementation XMallViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCartBadgeNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    numAll = 1;
 
    self.mallScroller.frame = CGRectMake( 0, 0, kScreen_Width, kScreen_Height-64-45);
    [self loadDetalImage];
    
    /*
//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yimaster.net/img/prd/%@",self.shopItemData.despImgUrl]]]];
    UIImage *img = [UIImage imageNamed:@"xx1.png"];
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.frame = CGRectMake(0, 15+self.labSales.frame.origin.y+self.labSales.frame.size.height, kScreen_Width, img.size.height);
    imgV.image = img;
    
    [self.mallScroller addSubview:imgV];
     */
    
    self.btnCart.frame = CGRectMake(0, kScreen_Height-45-64, kScreen_Width/2, 45);
    self.btnLiJi.frame = CGRectMake(self.btnCart.frame.origin.x+self.btnCart.frame.size.width, kScreen_Height-45-64, kScreen_Width/2, 45);
    
//    self.navigationItem.rightBarButtonItem = [[FFBadgedBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"basket"] target:self action:@selector(cartIconClicked)];
//    [self setCartBadgeNumber];

    
    self.imgHead.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.exinol.com/img/prd/%@",[self.shopItemData.mainImgUrls objectAtIndex:1]]]]];
    self.imgHead.contentMode = UIViewContentModeScaleAspectFit;
    self.labDes.text = self.shopItemData.name;
    self.labDes.numberOfLines = 2;
    self.labPrice.text = [NSString stringWithFormat:@"¥%@",self.shopItemData.price];
    self.labExpress.text = @"快递：0.00";
    self.labSales.text = [NSString stringWithFormat:@"销量：%@",self.shopItemData.sales];
    
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingIndicator.frame = CGRectMake((kScreen_Width-self.loadingIndicator.frame.size.width)/2, 40+self.labSales.frame.origin.y+self.labSales.frame.size.height, _loadingIndicator.width, _loadingIndicator.height);
    [_loadingIndicator startAnimating];
    [self.mallScroller addSubview:self.loadingIndicator];
}
- (void)loadDetalImage
{
    //取图片
    NSArray *detailUrlArray = [self.shopItemData.despImgUrl componentsSeparatedByString:@","];;
    NSMutableArray *detailUrlTempArray = [NSMutableArray arrayWithArray:detailUrlArray];
    [detailUrlTempArray removeLastObject];

    int count = (int)detailUrlTempArray.count;
    
    NSMutableArray *detailImgArray = [[NSMutableArray alloc] initWithCapacity:0];

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //子线程中开始网络请求数据
        //更新数据模型
        for(int i=0;i<count;i++)
        {
            NSString *each_DetailImgUrl=[detailUrlTempArray objectAtIndex:i];
            UIImage *each_image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.exinol.com/img/prd/desp/%@",each_DetailImgUrl]]]];
            
            
            if (each_image != nil) {
                [detailImgArray addObject:each_image];
            }
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            float height = self.labSales.bottom + 10;
            [self->_loadingIndicator removeFromSuperview];
            self->_loadingIndicator  = nil;
            
            for (int i=0; i<detailImgArray.count; i++) {
                UIImage *img = [detailImgArray objectAtIndex:i];

                
                UIImageView *allImageView = [[UIImageView alloc] init];

                allImageView.frame = CGRectMake(0, height, kScreen_Width, img.size.height/2 );
                
                allImageView.image = img;
                height+=img.size.height/2;
                
                [self.mallScroller addSubview:allImageView];
            }
            
            self.mallScroller.contentSize = CGSizeMake(0, height);
            self.mallScroller.showsVerticalScrollIndicator = NO;
            //
            //[self hideHud];
        });
        
    });
    
}


- (void)cartIconClicked
{
    NSMutableArray *arrallcount = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    
    int badgeNumber = [arrallcount count];
//    for (int i=0; i<arrallcount.count; i++) {
//        badgeNumber += [arrallcount count];//[[[arrallcount objectAtIndex:i] objectForKey:@"num"] intValue];
//    }
    
//    FFBadgedBarButtonItem *button = (FFBadgedBarButtonItem *)self.navigationItem.rightBarButtonItem;
//    button.badge = (badgeNumber > 0 ? [NSString stringWithFormat:@"%d", (int)badgeNumber] : nil);
//    if ([button.badge intValue] > 0) {
//        XShopViewController *xs = [[XShopViewController alloc] init];
//        [self.navigationController pushViewController:xs animated:YES];
//
//    }else{
//        [CommonMethod hudShow:self hudText:@"您的购物车里没有结算的物品"];
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)btnAddNumClick:(id)sender {
//    numAll +=1;
//    self.textFieldNum.text = [NSString stringWithFormat:@"%d",numAll];
//}
//
//- (IBAction)btnDelNumClick:(id)sender {
//    if (numAll != 1) {
//        numAll -=1;
//        self.textFieldNum.text = [NSString stringWithFormat:@"%d",numAll];
//    }
//}

- (IBAction)btnCartClick:(id)sender {
    NSMutableArray *numIsExis = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    NSString *num = @"1";
    long numValue = [numIsExis count];//numAll;
    if (numValue) {
        for (int i=0; i<numIsExis.count; i++) {
            NSMutableDictionary *dic = [numIsExis objectAtIndex:i];
            
            
            if ([self.shopItemData.mainImgUrl isEqualToString:[dic objectForKey:@"imageUrl"]]) {
                
                numValue = [[dic objectForKey:@"num"] intValue];
                numValue += numAll;
                
                [dic setObject:[NSString stringWithFormat:@"%ld",numValue] forKey:@"num"];
                
                [numIsExis writeToFile:[CommonMethod getFilePath] atomically:YES];
            }
            
        }
        
        num = [NSString stringWithFormat:@"%ld",numValue];
    }
    
    [self writeConfigFile:self.shopItemData.mainImgUrl descirb:self.shopItemData.name price:self.shopItemData.price num:num selected:@"0" isSale:@"1" code:self.shopItemData.code];
    
    [CommonMethod hudShow:self hudText:@"添加成功，在购物车等亲～"];
    
    [self setCartBadgeNumber];

}

-(void)writeConfigFile:(NSString *)imageUrl descirb:(NSString *)descirb price:(NSString *)price num:(NSString *)num selected:(NSString *)selected isSale:(NSString *)isSale code:(NSString *)code{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[CommonMethod getFilePath]]) {//如果文件不存在则创建
        NSFileManager* fm = [NSFileManager defaultManager];
        
        [fm createFileAtPath:[CommonMethod getFilePath] contents:nil attributes:nil];
    }
    
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:imageUrl,@"imageUrl",descirb,@"descirb",price,@"price",num,@"num",selected,@"selected",isSale,@"isSale",code,@"code",nil];//1：表示还未选中
    
    NSMutableArray *addObj = [[NSMutableArray alloc] initWithContentsOfFile:[CommonMethod getFilePath]];
    
    if (addObj == nil) {
        addObj = [[NSMutableArray alloc] initWithCapacity:0];
        [addObj addObject:dic];
        [addObj writeToFile:[CommonMethod getFilePath] atomically:YES];
    }else{
        
        BOOL exis = NO;
        int witchDic = 0;
        for (int i=0; i<addObj.count; i++) {
            NSMutableDictionary *dics = [addObj objectAtIndex:i];
            
            
            if ([self.shopItemData.mainImgUrl isEqualToString:[dics objectForKey:@"imageUrl"]]) {
                
                exis = YES;
                witchDic = i;
                
            }
        }
        
        if (exis == YES) {
            [[addObj objectAtIndex:witchDic] setObject:[NSString stringWithFormat:@"%@",num] forKey:@"num"];
            
            [addObj writeToFile:[CommonMethod getFilePath] atomically:YES];
        }else{
            [addObj addObject:dic];
            
            [addObj writeToFile:[CommonMethod getFilePath] atomically:YES];
        }
    }
    
}

- (void)setCartBadgeNumber
{
    
    NSMutableArray *arrallcount = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    
    int badgeNum = [arrallcount count];
//    for (int i=0; i<arrallcount.count; i++) {
//        badgeNum += [arrallcount count];//[[[arrallcount objectAtIndex:i] objectForKey:@"num"] intValue];
//    }

//    FFBadgedBarButtonItem *button = (FFBadgedBarButtonItem *)self.navigationItem.rightBarButtonItem;
//    button.badge = (badgeNum > 0 ? [NSString stringWithFormat:@"%d", (int)badgeNum] : nil);
}

- (IBAction)btnLiJiClick:(id)sender {
    XOrderPayViewController *order = [[XOrderPayViewController alloc] init];
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [tempDic setObject:self.shopItemData.mainImgUrl forKey:@"imageUrl"];
    [tempDic setObject:self.shopItemData.name forKey:@"descirb"];
    [tempDic setObject:self.shopItemData.price forKey:@"price"];
    [tempDic setObject:[NSString stringWithFormat:@"%d",numAll] forKey:@"num"];
    [tempDic setObject:@"1" forKey:@"selected"];
    [tempDic setObject:@"1" forKey:@"isSale"];
    [tempDic setObject:self.shopItemData.code forKey:@"code"];
    
    order.tempPlistArr = [[NSMutableArray alloc] initWithCapacity:0];
    [order.tempPlistArr addObject:tempDic];
    order.immdetilyBtnStr = @"临时结算物品";
    
    [self.navigationController pushViewController:order animated:YES];
}
@end
