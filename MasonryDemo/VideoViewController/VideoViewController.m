//
//  VideoViewController.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/4/6.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "VideoViewController.h"
#import "MediaPlayer/MediaPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

@interface VideoViewController ()<AVAudioPlayerDelegate>
{
    MPMoviePlayerViewController *_mPvc;
}
//播放器
@property(nonatomic,strong)AVPlayer *audioPlayer;
//时间更新定时器
@property(nonatomic,weak)NSTimer *timer;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频播放";
    
    //播放视频按钮
    UIButton* playButton= [UIButton buttonWithType:UIButtonTypeSystem];
    [playButton addTarget:self action:@selector(PlayMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    [playButton setTitle:@"播放视频" forState:UIControlStateNormal];
    playButton.backgroundColor=[UIColor redColor];
    [self.view addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(170, 80));
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(100);
        
    }];
    
    //播放音频按钮
    
    UIButton* playButton2= [[UIButton alloc]initWithFrame:CGRectMake(145, 250, 70, 80)];
    [playButton2 addTarget:self action:@selector(PlayAudioAction:) forControlEvents:UIControlEventTouchUpInside];
    playButton2.backgroundColor=[UIColor redColor];
//    [self.view addSubview:playButton2];
    
    
}

-(void)PlayAudioAction:(id)sender
{
    if (!_audioPlayer) {
        
        _audioPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://www.iqiyi.com/w_19rsy7cr35.html"]];
    }
    [_audioPlayer play];
}

-(void)PlayMovieAction:(id)sender{
    
    //注册一个观察者 监听视频是否播放完毕(1.点击Done 2.正常播放完 3.异常)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playVideoBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //懒加载
    if (!_mPvc) {
        _mPvc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://7xq1j6.com2.z0.glb.qiniucdn.com/7320160406123740.mp4?e=1459928133&token=VUakfHTVwRGH0ADoiKEYn2euE-SBu7AxtaWptswp:kEGf_QM-8Mg5wVg4IAYsNzUYGYY="]];
        _mPvc.moviePlayer.shouldAutoplay = YES;
    }
    [_mPvc.moviePlayer play];
    [self presentViewController:_mPvc animated:YES completion:nil];
}

-(void)playVideoBack:(NSNotification *)nf
{
    
    NSLog(@"播放完毕");
    NSLog(@"info:%@",nf.userInfo);
    
    //获取返回的原因
    NSInteger type = [nf.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]integerValue];
    if (type==0) {
        NSLog(@"正常返回");
    }else if (type==1)
    {
        NSLog(@"异常返回");
    }else if (type==2)
    {
        NSLog(@"点击Done返回");
    }
    
    
    if (_mPvc) {
        [_mPvc.moviePlayer stop];//停止
        _mPvc = nil;
    }
    
    //用完观察者要删除
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //模态跳转返回
    [_mPvc dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
