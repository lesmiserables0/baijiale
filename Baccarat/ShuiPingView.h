
#import <UIKit/UIKit.h>

@interface ShuiPingView : UIView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *JiHeShiTu;

- (void)TianJiaXiangMu:(NSString *)XiangMu;

/**
 用指定的对象替换原来的对象

 @param dic key:index  value:toReplaceItem
 */
//- (void)replaceItems:(NSDictionary *)dic;

@end
