//
//  UserModel.h
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "BaseModel.h"
@class HXRelationOperateModel;
@interface UserModel : BaseModel<NSCopying>

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;       //用户名
@property (nonatomic, strong) NSString *account;        //惠信号

@property (nonatomic, copy) NSString *nickName;         // 昵称用户名
@property (nonatomic, copy) NSString *phone;            // 手机号

@property (nonatomic, copy) NSString *remarkName;       // 备注
@property (nonatomic, copy) NSString *headerImg;
// 头像图片url,相对路径，小图[UserModel thumbImageUrl:model.deployUserImg];大图：[UserModel fullUrl:model.deployUserImg];
@property (nonatomic, copy) NSString *maritalStatus;    // 婚否
@property (nonatomic, copy) NSString *sign;             // 个性签名
@property (nonatomic, copy) NSString *annuaIncome;      // 月收入
@property (nonatomic, copy) NSString *bodily;           // 体型

@property (nonatomic, copy) NSString *permanent;        // 常住地
@property (nonatomic, copy) NSString *educationLevel;   // 教育程度

@property (nonatomic, strong) NSString *pinYin;         //拼音
@property (nonatomic, assign) BOOL isFriend;            //是好友

@property (nonatomic, strong) NSString *lastUpdate;     //用户信息最后更新时间

//@property (nonatomic, copy) NSDate *birthday;           // 生日
@property (nonatomic, copy) NSNumber *birthday;           // 生日


@property (nonatomic, strong) NSNumber *height;           // 身高
@property (nonatomic, strong) NSNumber *gender;           // 1男,2女 
@property (nonatomic, strong) NSNumber *age;              // 年龄

//备注-->昵称-->用户名
- (NSString *)showRemarkName;
+ (NSString*)fullUrl:(NSString*)url;
+ (NSString*)thumbImageUrl:(NSString*)url;


//根据UID搜索好友
+ (UserModel*)searchWithUid:(UInt64)uid;
//删除好友
+ (void)deleteFriendWithUid:(UInt64)uid;
//添加好友
+ (void)addFriendWithModel:(HXRelationOperateModel *)model success:(void (^)(void))success;

+ (int)getFriendCount;

//验证是否好友
+(BOOL)isFriend:(UInt64)uid;

//获取本地黑名单用户信息
+(NSArray *)getBlackUserWithIds:(NSArray *)userIds;

/**
 *  登录验证
 *  @param userName 用户名
 *  @param success  返回
 */
+ (void)loginValidateUsername:(NSString*)userName password:(NSString *)password success:(void (^)(id data))success;

/**
 *  短信验证 | 加字段，判断手机是否已绑定
 *  @param phoneNumber 手机号
 */
+ (void)getSMSverificationForMemberRegiteWithPhoneNumber:(NSString *)phone
                                                 success:(void(^)(id data))success;

/**
 *  用户注册 |yx
 *  @param userName 用户名
 *  @param password 密码
 *  @param referrer 推荐人
 *  @param key      获取验证码
 *  @param validataCode 验证码
 *  @param phone    手机号
 *  @param success  注册返回信息
 */
+ (void)registerWithUserName:(NSString *)userName
                    password:(NSString *)password
                    referrer:(NSString *)referrer
                         key:(NSString *)key
                validateCode:(NSString *)validateCode
                       phone:(NSString *)phone
                     success:(void (^)(id data))success;


/**
 *  获取好友列表
 *  @param success 成功返回信息
 */
+ (void)getFriendListSuccess:(void (^)(NSArray *array))success;

//web接口，根据uid 批量查询用户信息
+ (void)getAccountListWithArray:(NSArray *)list success:(void (^)(NSArray *array))success;


//获取黑名单列表
+(void)getBlackUsers:(void (^)(NSArray *))success;

/*
 * 登录，验证用户
 */
+(void)LoginValidateWithUserId:(NSString*)userId
                      withPass:(NSString*)pass
                     onSuccess:(void (^)(id userModel))success
                        onFail:(void (^)(NSString *failMsg))fail;

/**
 *  获取个人信息
 *  @param userId 用户id
 */
+(void)getUserInfoWithUserId:(NSString *)userId
                   onSuccess:(void (^)(id userModel))success
                      onFail:(void (^)(NSString *failMsg))fail;



/*
 * 完善资料
 * @param userId         用户ID
 * @param perfectInfoDic 完善资料（imgPath,nickName,gender,birthday）
 * @param success        请求成功返回
 */

+(void)perfectInforWithUserId:(NSString *)userId
                  withInfoDic:(NSDictionary*)infoDic
                      success:(void(^)(id data))success;

/*
 * 修改资料
 * @param userId         用户ID
 * @param type           修改属性
 * @param content        修改值
 */
+(void)modifyUserInfoWithUserId:(NSString *)userId
                 withModityType:(NSString *)type
              withModityContent:(NSString *)content
                        success:(void(^)(id data))success;


/**
 *  举报
 */

+(void)reportUserWithUserId:(NSString *)userId
                   withType:(NSString *)type
                withContent:(NSString *)content
         withactivityUserId:(NSString *)actUserId
                    success:(void(^)(StatusModel *data))success;

/**
 *  检查昵称是否唯一
 *
 *  @param userId   用户Id
 *  @param nickname 昵称
 *  @param success  回调
 */
+(void)doCheckNickNameByUserId:(NSString *)userId
                nickname:(NSString *)nickname
                    success:(void(^)(StatusModel *data))success;



/**
 *  3.18.	搜索电友
 *
 *  @param userId   用户Id
 *  @param keyword  搜索关键字
 *  @param whole    1:精确查找，2：模糊查找
 *  @param success  回调
 */
+(void)searchUserinfoByUserId:(NSString *)userId
                      keyword:(NSString *)keyword
                      whole:(NSInteger)whole
                       success:(void(^)(StatusModel *data))success;







/**
 *  登录日志
 *  @param userId       用户Id
 *  @param loginSource  登录来源(1：网站，2：Android，3-IOS)
 *  @param loginAddress 登录地址
 */
+(void)loginWriteLogWithUserId:(NSString *)userId
                   loginSource:(NSString *)source
                  loginAddress:(NSString *)address
                       success:(void(^)(StatusModel *data))success;




@end
