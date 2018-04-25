//
//  XShopViewController.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/21.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XShopViewController.h"
#import "XOrderPayViewController.h"
#import "DCEmptyCartView.h"
#define LINE_OR_FRAME_COLOR RGB(210, 210, 210)


@interface XShopViewController ()<UITableViewDataSource,UITableViewDelegate,cartlistCellDelegate,UIAlertViewDelegate>{
    BOOL checkAllFlag;
    
    
    int removeTag;
    

    NSMutableArray *allValueArray;
    
    NSString *firstStr;
}
@property (nonatomic,strong)UILabel *totalPriceLabel;
@property (nonatomic,strong)DCEmptyCartView *emptyCartView;
@end

@implementation XShopViewController

#pragma mark - 初始化空购物车View
- (void)setUpEmptyCartView
{
    _emptyCartView = [[DCEmptyCartView alloc] init];
    [self.view addSubview:_emptyCartView];
    _emptyCartView.hidden = YES;
    
    _emptyCartView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - DCTopNavH - DCBottomTabH);
    _emptyCartView.buyingClickBlock = ^{
        NSLog(@"点击了立即抢购");
    };
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"购物车";
    firstStr = @"first";
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    checkAllFlag = NO;//一开始全不选
    
    UIView *V = [[UIView alloc] initWithFrame:CGRectZero];
    [self.myTableView setTableFooterView:V];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = RGB(247, 247, 247);
    self.labTotalPrice.adjustsFontSizeToFitWidth = YES;
    
    [self.singleAllBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpEmptyCartView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    allValueArray = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    if (allValueArray && allValueArray.count) {
        _emptyCartView.hidden = YES;
    }else{
        _emptyCartView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeCart:(CartListTableViewCell *)cell{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return allValueArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[CartListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.CartListTableViewCellDelegate = self;
  
    }
    
    cell.selectButton.rowTag = indexPath.row;
    cell.addButton.addTag = indexPath.row;
    cell.delButton.delTag = indexPath.row;
    cell.removeButton.removeTag = indexPath.row;
    
    cell.itemData = [allValueArray objectAtIndex:indexPath.row];
    
    [cell reloadData];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (allValueArray.count-1 == indexPath.row && [firstStr isEqualToString:@"first"]) {
        [self carSelectButtonClicked:nil WithSectionIndexPath:indexPath.section WithIndexPath:indexPath.row addOrDel:@"first"];
    }
    
    
    [CommonMethod setLastCellSeperatorToLeft:cell];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128.0;
}
- (void)allSelectAction:(XButtonSingle *)button{
    NSMutableArray *allVaule = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    button.selected = !button.selected;
    
    
    CGFloat allAmount = 0.00f;
    NSInteger allQuantity = 0;
    for (int i=0;i<allVaule.count;i++) {
        NSMutableDictionary *sectionDictionary = [allVaule objectAtIndex:i];
        
        CGFloat sectionAmount = 0.00f;
        NSInteger sectionQuantity = 0;

        if (button.selected) {
            [[allVaule objectAtIndex:i] setObject:[[NSNumber alloc] initWithBool:button.selected?YES:NO] forKey:@"selected"];
            
            [allVaule writeToFile:[CommonMethod getFilePath] atomically:YES];
            CGFloat realPrice = [[sectionDictionary objectForKey:@"price"] floatValue];
            NSInteger quantity = [[sectionDictionary objectForKey:@"num"] integerValue];
            sectionAmount += realPrice * quantity;
            sectionQuantity += quantity;
            
            [self.isOkBtn setBackgroundColor:[CommonMethod hexColor:@"#FF5E00"]];
            self.isOkBtn.enabled = YES;
        }
        else
        {
            [[allVaule objectAtIndex:i] setObject:[[NSNumber alloc] initWithBool:button.selected?YES:NO] forKey:@"selected"];
            
            [allVaule writeToFile:[CommonMethod getFilePath] atomically:YES];
            sectionQuantity = 0;
            sectionAmount = 0.00f;
            
            [self.isOkBtn setBackgroundColor:[CommonMethod hexColor:@"#AAAAAA"]];
            self.isOkBtn.enabled = NO;
        }

        allAmount += sectionAmount;
        allQuantity += sectionQuantity;
    }
    
    
    self.labTotalPrice.text = [NSString stringWithFormat:@"￥%.0f",allAmount];

    
    allValueArray = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    
    [self.myTableView reloadData];

}


- (IBAction)isOkPurchaseBtn:(id)sender {
    XOrderPayViewController *order = [[XOrderPayViewController alloc] init];
    order.titelStr = @"购物车进入";
    [self.navigationController pushViewController:order animated:YES];
}

-(void)carSelectButtonClicked:(NSDictionary *)item WithSectionIndexPath:(NSInteger)section WithIndexPath:(NSInteger)row addOrDel:(NSString *)addOrDel
{
    
    
    NSMutableArray *addarr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    
    if ([addOrDel isEqualToString:@"add"]) {
        NSMutableDictionary *dicadd = [addarr objectAtIndex:row] ;
        int addnum = [[dicadd objectForKey:@"num"] intValue];
        addnum+=1;
        [dicadd setObject:[NSString stringWithFormat:@"%d",addnum] forKey:@"num"];
        [addarr writeToFile:[CommonMethod getFilePath] atomically:YES];
        
        CGFloat currentsectionamount = [self showPrice:addarr select:NO];
        
        NSLog(@"%f",currentsectionamount);

        
    }else if ([addOrDel isEqualToString:@"del"]){
        
        NSMutableDictionary *dicdel = [addarr objectAtIndex:row] ;
        int addnum = [[dicdel objectForKey:@"num"] intValue];
        
        
        
        if (addnum>1) {
            addnum-=1;
            [dicdel setObject:[NSString stringWithFormat:@"%d",addnum] forKey:@"num"];
            [addarr writeToFile:[CommonMethod getFilePath] atomically:YES];

        }
        
        CGFloat currentsectionamount = [self showPrice:addarr select:NO];
        
        NSLog(@"%f",currentsectionamount);

        
        
    }else if ([addOrDel isEqualToString:@"remove"]){
        removeTag = row;
        
        AlertViewShow(@"删除宝贝", @"确定", @"取消")

        
//        NSLog(@"%f",currentsectionamount);
    }
    
    else{
        NSMutableArray *arrc = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
        
        if([firstStr isEqualToString:@"notfirst"]){
            BOOL cellSelected = ![[[arrc objectAtIndex:row] objectForKey:@"selected"] boolValue];
            [[arrc objectAtIndex:row] setObject:[[NSNumber alloc] initWithBool:cellSelected] forKey:@"selected"];
            [arrc writeToFile:[CommonMethod getFilePath] atomically:YES];
        }
        
        BOOL sectionSelected = YES;
        
        CGFloat currentSectionAmount = [self showPrice:arrc select:sectionSelected];
        
        if (currentSectionAmount > 0) {
            [self.isOkBtn setBackgroundColor:[CommonMethod hexColor:@"#f7941e"]];
            self.isOkBtn.enabled = YES;
        }else{
            [self.isOkBtn setBackgroundColor:[CommonMethod hexColor:@"#aaaaaa"]];
            self.isOkBtn.enabled = NO;
        }
        if (sectionSelected) {
            for (int i=0;i<arrc.count;i++) {
                BOOL secSelect = [[[arrc objectAtIndex:i] objectForKey:@"selected"] boolValue];
                
                sectionSelected = sectionSelected && secSelect;
            }
            self.singleAllBtn.selected = sectionSelected;
        }
        else
        {
            self.singleAllBtn.selected = NO;
        }
        

    }


    if ([firstStr isEqualToString:@"first"]) {
        firstStr = @"notfirst";
        
    }else{
        allValueArray = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
        [self.myTableView reloadData];
    }
    
  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
    }else{
    }
}

- (CGFloat)showPrice:(NSMutableArray *)arrc select:(BOOL)select{
    CGFloat currentSectionAmount = 0.00f;
    NSInteger currentSectionQuantity = 0;
    
    
    for (int i=0;i<arrc.count;i++) {
        NSMutableDictionary *dictCell = [arrc objectAtIndex:i];
        
        NSString *isSale = [NSString stringWithFormat:@"%@",[dictCell objectForKey:@"selected"]];
        if ([isSale isEqualToString:@"1"]) {
            BOOL selectedCell = [[dictCell objectForKey:@"selected"] boolValue];
            select = select && selectedCell;
            
            
            CGFloat realPrice = [[dictCell objectForKey:@"price"] floatValue];
            NSInteger quantity = [[dictCell objectForKey:@"num"] integerValue];
            if (selectedCell) {
                currentSectionAmount += realPrice * quantity;
                currentSectionQuantity += quantity;
            }
        }
    }
    
    self.labTotalPrice.text = [NSString stringWithFormat:@"￥%.0f",currentSectionAmount];
    
    return currentSectionAmount;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    if (@available(iOS 11.0, *)) {
        UIContextualAction *deleteAction = [UIContextualAction
                                            contextualActionWithStyle:UIContextualActionStyleDestructive
                                            title:@"删除"
                                            handler:^(UIContextualAction * _Nonnull action,
                                                      __kindof UIView * _Nonnull sourceView,
                                                      void (^ _Nonnull completionHandler)(BOOL))
                                            {
                                                [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
                                                [self deleteCell:indexPath];
                                                /*
                                                 这中间为代码删除的具体逻辑实现
                                                 */
                                                completionHandler(true);
                                            }];
        
        
        UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
        actions.performsFirstActionWithFullSwipe = NO;
        
        return actions;
    }else{
        return nil;
    }
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self deleteCell:indexPath];
    }
}

- (void)deleteCell:(NSIndexPath *)indexPath
{
    NSMutableArray *addarr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    [addarr removeObjectAtIndex:indexPath.row];
    [addarr writeToFile:[CommonMethod getFilePath] atomically:YES];
    
    addarr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    CGFloat currentsectionamount = [self showPrice:addarr select:NO];
    
    if (currentsectionamount == 0) {
        [self.isOkBtn setBackgroundColor:[CommonMethod hexColor:@"#aaaaaa"]];
        self.isOkBtn.enabled = NO;
        self.singleAllBtn.selected = NO;
        
    }
    if ([addarr count]== 0) {
        _emptyCartView.hidden = NO;
    }
    
    allValueArray = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    [self.myTableView reloadData];
}
@end
