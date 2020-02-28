//
//  SongTool.m
//  NiHongGo
//
//  Created by xss on 15/7/7.
//  Copyright (c) 2015年 beyond. All rights reserved.
//
#import "SongTool.h"
//#import "SGTools.h"
//#import "GTMTool.h"

#define kMainBundle [NSBundle mainBundle]
@implementation SongTool
// 字典,存放所有的音乐播放器,键是:音乐名,值是对应的音乐播放器对象audioPlayer
// 一首歌对应一个音乐播放器
static NSMutableDictionary *_audioPlayerDict;

#pragma mark - Life Cycle
+ (void)initialize
{
    // 字典,键是:音乐名,值是对应的音乐播放器对象
    _audioPlayerDict = [NSMutableDictionary dictionary];
    
    // 设置后台播放
    [self sutupForBackgroundPlay];
}

// 设置后台播放
+ (void)sutupForBackgroundPlay
{
    // 后台播放三步曲之第三步，设置 音频会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 类型是:播放和录音
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    // 而且要激活 音频会话
    [session setActive:YES error:nil];
    
    
    
    
    
    
    
//    用AVAudioPlayer播放声音，结果声音是从听筒里出来，而不是扬声器，插了耳机就从耳机出。
//    ok，解决办法如下：
//    添加AudioToolbox这个Framework，然后添加如下代码：
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
//    注意：这里由于我的代码里已经写了：
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
//    所以，我并没有写前两行代码，结果也可以运行。别问为什么，我也不知道我为什么我不写那两行，just follow my fcking heart bitch。。。（请陈老师讲讲。。）
//    运行！成功从扬声器发出声音！而且成功过头了！插了耳机扬声器也发生！怎么办？改成如下：
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof (audioRouteOverride),&audioRouteOverride);

    
    
    
}

#pragma mark - 供外界调用
// 类方法, 播放MainBundle中的音乐,  参数:音乐文件名 如@"a.mp3"
// 同时为了能够给播放器AVAudioPlayer对象设置代理,在创建好播放器对象后,将其返回给调用者
// 设置代理后,可以监听播放器被打断和恢复打断
+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    // 健壮性判断
    if (!filename) return nil;
    
    // 1.先从字典中,根据音乐文件名,取出对应的audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (!audioPlayer) {
        // 如果没有,才需创建对应的音乐播放器,并且存入字典
        // 1.1加载音乐文件
        NSURL *url = [kMainBundle URLForResource:filename withExtension:nil];
        // 健壮性判断
        if (!url) return nil;
        
        // 1.2根据音乐的URL,创建对应的audioPlayer
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 1.3开始缓冲
        [audioPlayer prepareToPlay];
        // 如果要实现变速播放,必须同时设置下面两个参数
        audioPlayer.enableRate = YES;
        audioPlayer.rate = 1.0;
        
        // 1.4最后,放入字典
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    // 2.如果是暂停或停止时,才需要开始播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    // 3.返回创建好的播放器,方便调用者设置代理,监听播放器的进度currentTime
    return audioPlayer;
}
// 全路径
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath
{
    // 健壮性判断
    if (!fullPath) return nil;
    
    // 1.先从字典中,根据音乐文件名,取出对应的audioPlayer
//    AVAudioPlayer *audioPlayer = _audioPlayerDict[fullPath];
    AVAudioPlayer *audioPlayer = nil;
    if (!audioPlayer) {
        // 如果没有,才需创建对应的音乐播放器,并且存入字典
        // 1.1加载音乐文件
        NSURL *url = [[NSURL alloc] initFileURLWithPath:fullPath];
        // 健壮性判断
        if (!url) return nil;
        
        // 1.2根据音乐的URL,创建对应的audioPlayer
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        NSError *err;
        // 通过Data创建播放器
        audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
        if(err){
        }
        
        
//        // 根据用户上次选择的,展示
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        NSString *initType = [userDefault objectForKey:@"userDefault_playInitMode"];
//        if ([initType isEqualToString:@"url"]) {
//            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];  
//        }
        
        
//        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 1.3开始缓冲
        [audioPlayer prepareToPlay];
        // 如果要实现变速播放,必须同时设置下面两个参数
        audioPlayer.enableRate = YES;
        audioPlayer.rate = 1.0;
        [audioPlayer setVolume:1];
        audioPlayer.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
        
        
        // 1.4最后,放入字典
        if (audioPlayer) {
//            _audioPlayerDict[fullPath] = audioPlayer;
        }

    }
    
    // 2.如果是暂停或停止时,才需要开始播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    // 3.返回创建好的播放器,方便调用者设置代理,监听播放器的进度currentTime
    return audioPlayer;
}
// 全路径 、重复次数
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber
{
    // 健壮性判断
    if (!fullPath) return nil;
    // 1.先从字典中,根据音乐文件名,取出对应的audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fullPath];
        // 因为参数可能不同,因此一直都创建新的播放器
        // 1.1加载音乐文件
        NSURL *url = [[NSURL alloc] initFileURLWithPath:fullPath];
//    if ([url.absoluteString isEqualToString:audioPlayer.url.absoluteString] && audioPlayer.isPlaying) {
//        return nil;
//    }
        // 健壮性判断
        if (!url) return nil;
        // 1.2根据音乐的URL,创建对应的audioPlayer
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
    
    
//        data = [GTMTool decodeDataWithData:data];
        NSError *err;
    

    
        audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
        if(err){
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:fullPath] error:&err];
        }
//        // 根据用户上次选择的,展示
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        NSString *initType = [userDefault objectForKey:@"userDefault_playInitMode"];
//        if ([initType isEqualToString:@"url"]) {
//            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        }
    
        
        //        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 1.3开始缓冲
        [audioPlayer prepareToPlay];
        // 如果要实现变速播放,必须同时设置下面两个参数
        audioPlayer.enableRate = YES;
        audioPlayer.rate = 1.0;
        [audioPlayer setVolume:1];
        audioPlayer.numberOfLoops = loopNumber; //设置音乐播放次数  -1为一直循环
    
    // 2.如果是暂停或停止时,才需要开始播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    // 3.返回创建好的播放器,方便调用者设置代理,监听播放器的进度currentTime
    return audioPlayer;
}


// 全路径 、重复次数 、音频是否加密过
+ (AVAudioPlayer *)playMusicWithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber isEncoded:(BOOL)isEncoded
{
    // 健壮性判断
    if (!fullPath) return nil;
    // 1.先从字典中,根据音乐文件名,取出对应的audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fullPath];
    // 因为参数可能不同,因此一直都创建新的播放器
    // 1.1加载音乐文件
    NSURL *url = [[NSURL alloc] initFileURLWithPath:fullPath];
    // 健壮性判断
    if (!url) return nil;
    
    
    
    // 1.2根据音乐的URL,创建对应的audioPlayer
    NSData *data = [NSData dataWithContentsOfFile:fullPath];
    
    if (isEncoded) {
        // 如果声音加密了,则使用该方法进行解密
//        data = [GTMTool decodeDataWithData:data];
    }

    NSError *err;
    
    
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
    if(err){
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:fullPath] error:&err];
    }
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *initType = [userDefault objectForKey:@"userDefault_playInitMode"];
    if (!audioPlayer || [initType isEqualToString:@"url"]) {
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    
    
    //        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    // 1.3开始缓冲
    [audioPlayer prepareToPlay];
    // 如果要实现变速播放,必须同时设置下面两个参数
    audioPlayer.enableRate = YES;
    audioPlayer.rate = 1.0;
    [audioPlayer setVolume:1];
    audioPlayer.numberOfLoops = loopNumber; //设置音乐播放次数  -1为一直循环
    
    
    
    // 2.如果是暂停或停止时,才需要开始播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    // 3.返回创建好的播放器,方便调用者设置代理,监听播放器的进度currentTime
    return audioPlayer;
}


// 全路径 、重复次数
+ (AVAudioPlayer *)playMusic_container_WithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber
{
    // 健壮性判断
    if (!fullPath) return nil;
    
    // 1.先从字典中,根据音乐文件名,取出对应的audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fullPath];
    
    
    if (!audioPlayer) {
        // 如果没有,才需创建对应的音乐播放器,并且存入字典
        // 1.1加载音乐文件
        NSURL *url = [[NSURL alloc] initFileURLWithPath:fullPath];
        // 健壮性判断
        if (!url) return nil;
        
        // 1.2根据音乐的URL,创建对应的audioPlayer
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        NSError *err;
        audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&err];
        if(err){
        }
        // 根据用户上次选择的,展示
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *initType = [userDefault objectForKey:@"userDefault_playInitMode"];
        if ([initType isEqualToString:@"url"]) {
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        }
        
        
        //        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 1.3开始缓冲
        [audioPlayer prepareToPlay];
        // 如果要实现变速播放,必须同时设置下面两个参数
        audioPlayer.enableRate = YES;
        audioPlayer.rate = 1.0;
        [audioPlayer setVolume:1];
        audioPlayer.numberOfLoops = loopNumber; //设置音乐播放次数  -1为一直循环
        
        
        // 1.4最后,放入字典
        _audioPlayerDict[fullPath] = audioPlayer;
    }
    
    // 2.如果是暂停或停止时,才需要开始播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    // 3.返回创建好的播放器,方便调用者设置代理,监听播放器的进度currentTime
    return audioPlayer;
}


// 类方法, 暂停音乐,  参数:音乐文件名 如@"a.mp3"
+ (void)pauseMusic:(NSString *)filename
{
    // 健壮性判断
    if (!filename) return;
    
    // 1.先从字典中，根据key【文件名】，取出audioPlayer【肯定 有 值】
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    // 2.如果是正在播放，才需要暂停
    if (audioPlayer.isPlaying) {
        [audioPlayer pause];
    }
}

// 类方法, 停止音乐,  参数:音乐文件名 如@"a.mp3",记得从字典中移除
+ (void)stopMusic:(NSString *)filename
{
    // 健壮性判断
    if (!filename) return;
    
    // 1.先从字典中，根据key【文件名】，取出audioPlayer【肯定 有 值】
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    // 2.如果是正在播放，才需要停止
    if (audioPlayer.isPlaying) {
        // 2.1停止
        [audioPlayer stop];
        
        // 2.2最后,记得从字典中移除
        [_audioPlayerDict removeObjectForKey:filename];
    }
}

// 返回当前正在播放的音乐播放器,方便外界控制其快进,后退或其他方法
+ (AVAudioPlayer *)currentPlayingAudioPlayer
{
    // 遍历字典的键,再根据键取出值,如果它是正在播放,则返回该播放器
    for (NSString *filename in _audioPlayerDict) {
        AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
        
        if (audioPlayer.isPlaying) {
            return audioPlayer;
        }
    }
    
    return nil;
}


@end
