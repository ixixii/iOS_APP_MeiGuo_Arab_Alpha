//
//  ArabAlphaModel.m
//
//  Created by beyond on 16/9/10.
//  Copyright © 2016年 beyond. All rights reserved.
//

#import "ArabAlphaModel.h"

@implementation ArabAlphaModel

- (NSString *)alpha_mp3
{
    // 阿拉伯语在plist里面没有
    return @"";
}
- (NSString *)alpha_remark
{
    return _read;
}
- (NSString *)menuItem1
{
    return _name;
}
- (NSString *)menuItem2
{
    return super.alpha;
}
- (NSString *)menuItem3
{
    return _read;
}
- (NSString *)menuItem4
{
    return [NSString stringWithFormat:@"%@  %@  %@",_head,_middle,_tail];
}
- (NSString *)hongBaoTopStr
{
    return super.alpha;
}
- (NSString *)hongBaoMiddleStr
{
    return [NSString stringWithFormat:@"%@  %@  %@",_head,_middle,_tail];
}
- (NSString *)hongBaoBottomStr
{
    NSString *readString = [[_read stringByReplacingOccurrencesOfString:@"[" withString:@"/"] stringByReplacingOccurrencesOfString:@"]" withString:@"/"];
    return [NSString stringWithFormat:@"%@ - %@",_name,readString];
}
@end
