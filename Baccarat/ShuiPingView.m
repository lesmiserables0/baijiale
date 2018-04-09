

#import "ShuiPingView.h"
#import "ShuiPingCell.h"
#import "UserDefaults.h"
#import "ColorUtil.h"

@interface ShuiPingView()

@property (nonatomic, strong) NSMutableArray *jc_ds;

@property (nonatomic, assign) long ShuJuYuanChang;

@end

@implementation ShuiPingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpWigets];
    }
    return self;
}

- (void)setUpWigets
{
    self.jc_ds = [NSMutableArray arrayWithCapacity:400];
    self.ShuJuYuanChang = 0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.JiHeShiTu = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.JiHeShiTu.backgroundColor = [UIColor clearColor];
    [self.JiHeShiTu registerClass:[ShuiPingCell class] forCellWithReuseIdentifier:@"ShuiPingCell"];
    self.JiHeShiTu.delegate = self;
    self.JiHeShiTu.dataSource = self;
    
    [self addSubview:self.JiHeShiTu];
}

- (void)TianJiaXiangMu:(NSString *)XiangMu
{
    if (!XiangMu ) {
        return;
    }
    
//    OrderedDictionary *dic = [OrderedDictionary dictionary];
//    for (int i=0; i<items.count; i++) {
//        [dic setObject:items[i] forKey:@(self.dataSourceCount + i)];
//    }
    [self DaiTiXiangMu:XiangMu];
}

- (void)DaiTiXiangMu:(NSString *)XiangMu
{
    if (!XiangMu || XiangMu.length == 0) {
        return;
    }
    
    BOOL insert = NO;
    if (self.ShuJuYuanChang >= self.jc_ds.count) {
        insert = YES;
    }
    
    RuoYinYongZiJi
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *GengXinXiaBiao = [NSMutableArray array];
        NSIndexPath *XiaBiao = [NSIndexPath indexPathForItem:self.ShuJuYuanChang inSection:0];
        [GengXinXiaBiao addObject:XiaBiao];

        if (insert) {
            //insert
            [weakSelf.jc_ds addObject:XiangMu];
            [weakSelf.JiHeShiTu insertItemsAtIndexPaths:GengXinXiaBiao];
        } else {
            // replace
            [weakSelf.jc_ds replaceObjectAtIndex:self.ShuJuYuanChang withObject:XiangMu];
            [weakSelf.JiHeShiTu reloadItemsAtIndexPaths:GengXinXiaBiao];
        }
        weakSelf.ShuJuYuanChang += 1;
    });
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.jc_ds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *XiangMuMing = self.jc_ds[indexPath.item];
    ShuiPingCell *Hang = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShuiPingCell" forIndexPath:indexPath];
    [Hang SheZhiTuPianShiTu:XiangMuMing];
    return Hang;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float Gao = 28.0;
    float Kuan = 30.0;
    return CGSizeMake(Kuan, Gao);
}
@end
