//
//  SongTool.h
//  NiHongGo
//
//  Created by xss on 15/7/7.
//  Copyright (c) 2015年 beyond. All rights reserved.
//
#import <Foundation/Foundation.h>
// 音乐工具类,必须导入AVFoundation的主头文件
#import <AVFoundation/AVFoundation.h>

@interface SongTool : NSObject
// 类方法, 播放MainBundle中的音乐,  参数:音乐文件名 如@"a.mp3",同时为了能够给播放器AVAudioPlayer对象设置代理,在创建好播放器对象后,将其返回给调用者
// 设置代理后,可以监听播放器被打断和恢复打断
+ (AVAudioPlayer *)playMusic:(NSString *)filename;
// 全路径
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath;

// 全路径 、重复次数
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber;

// 类方法, 暂停音乐,  参数:音乐文件名 如@"a.mp3"
+ (void)pauseMusic:(NSString *)filename;

// 类方法, 停止音乐,  参数:音乐文件名 如@"a.mp3",记得从字典中移除
+ (void)stopMusic:(NSString *)filename;

// 返回当前正在播放的音乐播放器,方便外界控制其快进,后退或其他方法
+ (AVAudioPlayer *)currentPlayingAudioPlayer;


// 全路径 、重复次数 、音频是否加密过
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber isEncoded:(BOOL)isEncoded;
@end

/*
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                
 
 
 
 
 
 
 
                    
                        
 
 
 
 
 
 
 
 
 
 
 
 */