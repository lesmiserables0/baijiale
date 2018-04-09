
#import "PuKeUtils.h"

@implementation PuKeUtils

+ (NSDictionary *)DeDaoPuKeZiDian
{
    NSDictionary *dic = @{@"a1.png":@"1",
                          @"a2.png":@"2",
                          @"a3.png":@"3",
                          @"a4.png":@"4",
                          @"a5.png":@"5",
                          @"a6.png":@"6",
                          @"a7.png":@"7",
                          @"a8.png":@"8",
                          @"a9.png":@"9",
                          @"a10.png":@"10",
                          @"a11.png":@"11",
                          @"a12.png":@"12",
                          @"a13.png":@"13",
                          @"b1.png":@"1",
                          @"b2.png":@"2",
                          @"b3.png":@"3",
                          @"b4.png":@"4",
                          @"b5.png":@"5",
                          @"b6.png":@"6",
                          @"b7.png":@"7",
                          @"b8.png":@"8",
                          @"b9.png":@"9",
                          @"b10.png":@"10",
                          @"b11.png":@"11",
                          @"b12.png":@"12",
                          @"b13.png":@"13",
                          @"c1.png":@"1",
                          @"c2.png":@"2",
                          @"c3.png":@"3",
                          @"c4.png":@"4",
                          @"c5.png":@"5",
                          @"c6.png":@"6",
                          @"c7.png":@"7",
                          @"c8.png":@"8",
                          @"c9.png":@"9",
                          @"c10.png":@"10",
                          @"c11.png":@"11",
                          @"c12.png":@"12",
                          @"c13.png":@"13",
                          @"d1.png":@"1",
                          @"d2.png":@"2",
                          @"d3.png":@"3",
                          @"d4.png":@"4",
                          @"d5.png":@"5",
                          @"d6.png":@"6",
                          @"d7.png":@"7",
                          @"d8.png":@"8",
                          @"d9.png":@"9",
                          @"d10.png":@"10",
                          @"d11.png":@"11",
                          @"d12.png":@"12",
                          @"d13.png":@"13"};
    return dic;
}

+ (NSArray *)DeDaoSuiJiPuKeShuZuDeShuLiang:(int)ShuLiang
{
    NSArray *PuKeArray = [[[self class] DeDaoPuKeZiDian] allKeys];
    //随机数从这里边产生
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithArray:PuKeArray];
    //随机数产生结果
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    for (int i=0; i<ShuLiang; i++) {
        int t = arc4random()%startArray.count;
        resultArray[i] = startArray[t];
        startArray [t] = [startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}

@end
