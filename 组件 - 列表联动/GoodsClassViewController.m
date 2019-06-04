//
//  GoodsClassViewController.m
//  PH869-iOS
//
//  Created by Best 石 稳 on 2019/3/19.
//  Copyright © 2019 yjz. All rights reserved.
//  商品分类

// 当前屏幕宽度
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
// 当前屏幕高度
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
//根据宽度适配
#define kFitWithWidth   kScreenWidth / 720.0
// 状态栏
#define kStatusHeight   [[UIApplication sharedApplication] statusBarFrame].size.height

// 导航栏高度
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height

// 界面头部高度
#define kHeaderHeight (kStatusHeight + kNavigationBarHeight)

//设置字体
#define FONT(size) [UIFont systemFontOfSize:size]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//设置颜色
#define kGrayBackgroundColor RGB(240,240,240)
#define kTitleBlackColor RGB(54, 72, 87) //标题黑色 #333333
#define kGrayBackgroundColor RGB(240,240,240)
#define kWhiteColor [UIColor whiteColor]

#import "GoodsClassViewController.h"
#import "GoodsClassCollectionViewFlowLayout.h"
#import "GoodsClassHeaderView.h"
#import "GoodsClassCollectionViewCell.h"
#import "LeftTableViewCell.h"
#import "GoodsShopModel.h"
#import "NSObject+Property.h"
#import "UIView+Layout.h"

@interface GoodsClassViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,GoodsClassFlowLayoutDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UICollectionView *goodsCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic, strong) UITextField *searchTextField ;
@end

@implementation GoodsClassViewController

{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}


#pragma mark - Getters

- (NSMutableArray *)dataSource{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas{
    if (!_collectionDatas)
    {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (UITableView *)leftTableView{
    if (!_leftTableView){
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 155 * kFitWithWidth, kScreenHeight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = kGrayBackgroundColor ;
        _leftTableView.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0) ;
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UICollectionView *)goodsCollectionView{
    if (!_goodsCollectionView){
        GoodsClassCollectionViewFlowLayout *flowlayout = [[GoodsClassCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 10 * kFitWithWidth ;
        
        flowlayout.sectionInset = UIEdgeInsetsMake(32 * kFitWithWidth, 0, 10 * kFitWithWidth, 0) ;
        
        //上下间距
        //flowlayout.minimumLineSpacing = 16 * kFitWithWidth ;
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.leftTableView.maxX + 24 * kFitWithWidth, kHeaderHeight - 2 , 518 * kFitWithWidth , kScreenHeight - kHeaderHeight - 4) collectionViewLayout:flowlayout];
        _goodsCollectionView.delegate = self;
        _goodsCollectionView.dataSource = self;
        _goodsCollectionView.showsVerticalScrollIndicator = NO;
        _goodsCollectionView.showsHorizontalScrollIndicator = NO;
        [_goodsCollectionView setBackgroundColor:RGB(245, 244, 247)];
        //注册cell
        [_goodsCollectionView registerClass:[GoodsClassCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        //注册分区头标题
        [_goodsCollectionView registerClass:[GoodsClassHeaderView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:@"CollectionViewHeaderView"];
    }
    return _goodsCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self initWithNavView] ;
    
    [self initWithUIData] ;
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    self.view.backgroundColor = RGB(245, 244, 247) ;
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.goodsCollectionView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES] ;
}

#pragma mark - 主体数据
-(void)initWithUIData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    for (NSDictionary *dict in categories){
        GoodsShopModel *model = [GoodsShopModel objectWithDictionary:dict];
        [self.dataSource addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (SubCategoryModel *sModel in model.subcategories){
            [datas addObject:sModel];
        }
        [self.collectionDatas addObject:datas];
    }
    NSLog(@"self.collectionDatas = %@",self.collectionDatas) ;
    [self.leftTableView reloadData];
    [self.goodsCollectionView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 导航栏
-(void)initWithNavView{
    UIImage *image = [UIImage imageNamed:@"icon_store_back"] ;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction)] ;
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 612 * kFitWithWidth, 65 * kFitWithWidth)] ;
    searchView.layer.cornerRadius = 10 * kFitWithWidth ;
    searchView.layer.masksToBounds = YES ;
    searchView.backgroundColor = RGB(247, 247, 247) ;
    self.navigationItem.titleView = searchView ;
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 * kFitWithWidth, 0, 30  *kFitWithWidth, 30 * kFitWithWidth)] ;
    searchImageView.centerY = searchView.centerY ;
    searchImageView.image = [UIImage imageNamed:@"icon_store_search_small"] ;
    [searchView addSubview:searchImageView] ;
    
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(searchImageView.maxX + 12 *kFitWithWidth, 0, 450 * kFitWithWidth, 30 * kFitWithWidth)] ;
    searchTextField.centerY = searchImageView.centerY ;
    searchTextField.placeholder = @"请搜索你想要的" ;
    searchTextField.font = FONT(25 * kFitWithWidth) ;
    searchTextField.textColor = kTitleBlackColor ;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing ;
    [searchView addSubview:searchTextField] ;
    self.searchTextField = searchTextField ;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(searchTextField.maxX  + 5 * kFitWithWidth, 0, 2 * kFitWithWidth, 40 *kFitWithWidth)] ;
    lineView.centerY = searchTextField.centerY ;
    lineView.backgroundColor = RGB(192, 201, 209) ;
    [searchView addSubview:lineView] ;
    
    UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(5 * kFitWithWidth + lineView.maxX, 0, 80 * kFitWithWidth, 40 * kFitWithWidth)] ;
    searchButton.centerY = lineView.centerY ;
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside] ;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal] ;
    searchButton.titleLabel.font = FONT(30 * kFitWithWidth) ;
    [searchButton setTitleColor:RGB(61, 199, 190) forState:UIControlStateNormal] ;
    [searchView addSubview:searchButton] ;
    
}

-(void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark - 搜索按钮事件
-(void)searchButtonAction{
    
}

#pragma mark - UITableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90 * kFitWithWidth ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    GoodsShopModel *model = self.dataSource[indexPath.row];
    cell.name.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [self.goodsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    GoodsShopModel *model = self.dataSource[section];
    return model.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    
    SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

//cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(162 * kFitWithWidth,148 * kFitWithWidth ) ;
}


//头部标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        // header
        reuseIdentifier = @"CollectionViewHeaderView";
    }
    GoodsClassHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        GoodsShopModel *model = self.dataSource[indexPath.section];
        view.title.text = model.name;
        //view.title.text = @"biaoti" ;
    }
    return view;
}

//头部高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(0, 0) ;
    }else{
         return CGSizeMake(kScreenWidth, 80 * kFitWithWidth);
    }
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index{
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    
    if (section == 0) {
        return [UIColor clearColor] ;
    }else{
        return  kWhiteColor ;
    }
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    
    if (self.goodsCollectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

@end
