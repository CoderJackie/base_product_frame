//
//  BaseModel.m
//
//  QQ:275080225
//  Created by wen jun on 12-10-13.
//  Copyright (c) 2013年 Wen Jun. All rights reserved.
//


#import "BaseModel.h"
#import "StatusModel.h"
#import "RSA.h"
#import "HUDManager.h"

@implementation BaseModel

#pragma mark - DB

+ (LKDBHelper *)getUserLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc] initWithDBName:[DataManager sharedManager].userId];
    });
    return helper;
}

+ (LKDBHelper *)getUsingLKDBHelper
{
    LKDBHelper *helper;
    if (![NSString isNull:[DataManager sharedManager].userId])
    {
        helper = [self getUserLKDBHelper];
    }
    else
    {
        helper = [super getUsingLKDBHelper];
    }
    return helper;
}

+(LKDBHelper *)getDefaultLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    NSString *dbName = @"YD_default";
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc]initWithDBName:dbName];
    });
    [helper setDBName:[NSString stringWithFormat:@"YD%@.db",dbName]];
    return helper;
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

// 升级
+ (LKTableUpdateType)tableUpdateForOldVersion:(int)oldVersion newVersion:(int)newVersion
{
    switch (oldVersion)
    {
        case 1:
        {
            [self tableUpdateAddColumnWithPN:@"color"];
        }
        case 2:
        {
            [self tableUpdateAddColumnWithName:@"address" sqliteType:LKSQL_Type_Text];
            //@"error" is removed
        }
            break;
    }
    return LKTableUpdateTypeDefault;
}

// begin yangxu
- (void)update
{
    
}
// end

#pragma mark - map
+ (NSMutableDictionary *)getMapping
{
    return nil;
}

+ (StatusModel *)statusModelFromJSONObject:(id<JTValidJSONResponse>)object
{
    return [self statusModelFromJSONObject:object class:self];
}

+ (StatusModel *)statusModelFromJSONObject:(id<JTValidJSONResponse>)object class:(Class)class
{
    NSMutableDictionary *myMapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [class mappingWithKey:@"rs"], @"rs", nil];
    return [StatusModel objectFromJSONObject:object mapping:myMapping];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key
{
    return [self mappingWithKey:key mapping:[self getMapping]];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping
{
    if (!mapping)
    {
        return [super mappingWithKey:key mapping:[self getMapping]];
    }
    return [super mappingWithKey:key mapping:mapping];
}

#pragma mark - network related methods

// 上传文件
+ (MKNetworkOperation *)uploadDocumentFromPath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                     filePaths:(NSMutableDictionary*)filePaths
                                  onCompletion:(void (^)(id data))completionBlock
                              onUploadProgress:(MKNKProgressBlock)uploadProgressBlock
{
    //    NSMutableDictionary *myParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:[params jsonEncodedKeyValueString],@"json", nil];
    
    [self encryptForSomeFields:params];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op =[engine operationWithPath:path params:params httpMethod:@"POST" ssl:NO];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [filePaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [op addFile:obj forKey:key];
    }];
    [op addCompletionHandler:^(MKNetworkOperation* operation) {
        NSString *responseString = [operation responseString];
        DLog(@"response==%@",responseString);
        id responseJson = [operation responseJSON];
        if (completionBlock)
        {
            completionBlock(responseJson?responseJson:responseString);
        }
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error) {
        if (completionBlock)
        {
            completionBlock([self getErrorDictionary]);
        }
    }];
    
    if (uploadProgressBlock)
    {
        [op onUploadProgressChanged:uploadProgressBlock];
    }
    
    [engine enqueueOperation:op];
    return op;
}

// begin 上传文件，返回信息包含请求头 张绍裕 20150207

// 上传文件
+ (MKNetworkOperation *)uploadFileFromPath:(NSString *)path
                                    params:(NSMutableDictionary *)params
                                 filePaths:(NSMutableDictionary*)filePaths
                              onCompletion:(void (^)(id data, NSDictionary *dict))completionBlock
                          onUploadProgress:(MKNKProgressBlock)uploadProgressBlock
{
    __block NSString *md5Key = nil;
    [filePaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSData *data = [NSData dataWithContentsOfFile:obj];
        NSString *base64 = [data base64EncodedString];
        NSString *md5 = [DataHelper getMd5_32Bit_String:base64 uppercase:YES];
        if (!md5Key)
        {
            md5Key = md5;
        }
        else
        {
            md5Key = [NSString stringWithFormat:@"%@,%@",md5Key,md5];
        }
    }];
    if (md5Key)
    {
        [params setValue:md5Key forKey:@"validateKey"];
    }
    
    [self encryptForSomeFields:params];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op = [engine operationWithPath:path params:params httpMethod:@"POST" ssl:NO];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [filePaths enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [op addFile:obj forKey:key];
    }];
    __block NSDictionary *postDict = nil;
    [op addCompletionHandler:^(MKNetworkOperation* operation) {
        NSString *responseString = [operation responseString];
        postDict = [operation readonlyPostDictionary];
        DLog(@"response==%@",responseString);
        DLog(@"post dict %@", postDict);
        id responseJson = [operation responseJSON];
        if (completionBlock)
        {
            completionBlock((responseJson ? responseJson : responseString), postDict);
        }
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error) {
        if (completionBlock)
        {
            completionBlock([self getErrorDictionary], postDict);
        }
    }];
    
    if (uploadProgressBlock)
    {
        [op onUploadProgressChanged:uploadProgressBlock];
    }
    
    [engine enqueueOperation:op];
    return op;
}

// end

// 下载文件
+ (MKNetworkOperation *)downloadDocumentFromPath:(NSString *)path
                                          params:(NSMutableDictionary *)params
                                        filePath:(NSString *)filePath
                                    onCompletion:(void (^)(id data))completionBlock
                                onUploadProgress:(MKNKProgressBlock)downloadProgressBlock
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    MKNetworkOperation *op = [engine operationWithURLString:path params:params];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath append:YES]];
    DLog(@"url==%@\nparams==%@\n",op.url,params);
    [op addCompletionHandler:^(MKNetworkOperation* operation) {
        NSString *responseString = [operation responseString];
        DLog(@"response==%@",responseString);
        if (completionBlock)
        {
            completionBlock(responseString);
        }
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error) {
        if (completionBlock)
        {
            completionBlock(@"-404");
        }
    }];
    
    if (downloadProgressBlock)
    {
        [op onDownloadProgressChanged:downloadProgressBlock];
    }
    
    [engine enqueueOperation:op];
    return op;
}

+ (MKNetworkOperation *)postDataResponsePath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                onCompletion:(void (^)(id data))completionBlock
{
    
    return [self postDataResponsePath:path
                               params:params
                           networkHUD:NetworkHUDLockScreenAndMsg
                         onCompletion:completionBlock];
}

+ (MKNetworkOperation *)postDataResponsePath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                isBackground:(BOOL)isBackground
                                onCompletion:(void (^)(id data))completionBlock
{
    return [self postDataResponsePath:path
                               params:params
                           networkHUD:isBackground?NetworkHUDBackground:NetworkHUDLockScreenAndMsg
                         onCompletion:completionBlock];
}

+ (void)encryptForSomeFields:(NSMutableDictionary *)dic
{
    // 需要MD5+RSA加密的字段
    NSSet *const encryptWithMD5_RSAFields = [NSSet setWithObjects:@"password", nil];
    // 只需要RSA加密的字段
    NSSet *const encryptWithRSAFields = [NSSet setWithObjects:@"phone",@"userId",@"activityId",@"psaKey",@"activityUserId",nil];
    
    NSArray *allKeys = dic.allKeys;
    for (NSString *key in allKeys) {
        if ([encryptWithMD5_RSAFields containsObject:key]) {
            NSString *oldObject = [dic objectForKey:key];
            if (oldObject) {
                if ([oldObject isKindOfClass:[NSNumber class]]) {
                    oldObject = [NSString stringWithFormat:@"%@",oldObject];
                }
                NSString *rsaString =  [[RSA shareInstance] encryptWithString:[DataHelper getMd5_32Bit_String:oldObject uppercase:YES]];
                [dic setValue:rsaString forKey:key];
            }
        } else {
            if ([encryptWithRSAFields containsObject:key]) {
                NSString *oldObject = [dic objectForKey:key];
                if (oldObject) {
                    if ([oldObject isKindOfClass:[NSNumber class]]) {
                        oldObject = [NSString stringWithFormat:@"%@",oldObject];
                    }
                    NSString *rsaString =  [[RSA shareInstance] encryptWithString:oldObject];
                    [dic setValue:rsaString forKey:key];
                }
            }
        }
    }
}

+ (MKNetworkOperation *)postDataResponsePath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                  networkHUD:(NetworkHUD)networkHUD
                                onCompletion:(void (^)(id data))completionBlock
{
    if (networkHUD > 2 && networkHUD < 6)
    {
        [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:kHUDTime enabled:YES message:kNetworkWaitting];
    }
    
    // 加密相关字段
    [self encryptForSomeFields:params];
    
    DLog(@"\n<<-----------请求-------------------\n Url == %@\n Param == %@\n DicStyle == %@\n------------------------------->>", path, [params jsonEncodedKeyValueString], params);
    //    DLog(@"URL = http://%@/%@ %@",kServerHost,path, params);
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kServerHost];
    
    MKNetworkOperation *op = [engine operationWithPath:path
                                                params:params
                                            httpMethod:@"POST"
                                                   ssl:NO];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSDictionary * response = [operation responseJSON];
        //        DLog(@"\n\nHTTPStatusCode %d\n\n", operation.HTTPStatusCode);
        //        DLog(@"response==%@",[operation responseString]);
        DLog(@"\n<<-----------返回--------------------\n Url == %@\n Res == %@\n DicStyle == %@\n------------------------------->>", path, [operation responseString], response);
        
        [[self class] handleResponse:response networkHUD:networkHUD];
        if (completionBlock)
        {
            completionBlock(response);
        }
    }errorHandler:^(MKNetworkOperation* completedOperation, NSError *error){
        NSDictionary *dic = [self getErrorDictionary];
        [[self class] handleResponse:dic networkHUD:networkHUD];
        if (completionBlock)
        {
            completionBlock(dic);
        }
    }];
    
    [engine enqueueOperation:op];
    return op;
}

+ (MKNetworkOperation *)postDataResponsePath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                  networkHUD:(NetworkHUD)networkHUD
                                      target:(id)target
                                onCompletion:(void (^)(id data))completionBlock
{
    // 添加锁屏不锁导航栏的操作
    if (target && (networkHUD == NetworkHUDLockScreenButNavWithError || networkHUD == NetworkHUDLockScreenButNavWithMsg) && [target isKindOfClass:[UIViewController class]]) {
        [HUDManager showHUDWithMessage:kNetworkWaitting onTarget:((UIViewController *)target).view];
    }
    
    MKNetworkOperation *networkOperation = [self postDataResponsePath:path
                                                               params:params
                                                           networkHUD:networkHUD
                                                         onCompletion:completionBlock];
    
    if (target && [target respondsToSelector:@selector(addNet:)])
    {
        [target performSelector:@selector(addNet:) withObject:networkOperation];
    }
    
    return networkOperation;
}

+ (void)postDataResponsePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
                     success:(void (^)(id data))success
{
    [self postDataResponsePath:path params:params networkHUD:networkHUD target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success)
        {
            success(model);
        }
    }];
}

+ (void)handleResponse:(NSDictionary *)response networkHUD:(NetworkHUD)networkHUD
{
    NSString *message = [response objectForKey:@"msg"];
    int code = [[response objectForKey:@"flag"] intValue];
    
    if (networkHUD > 2)
    {
        [HUDManager hiddenHUD];
    }
    
    switch (networkHUD)
    {
        case NetworkHUDBackground:
            break;
        case NetworkHUDMsg:
        {
            if (![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                if (code != 1)
                {
                    [iToast alertWithTitle:message];
                }
                else
                {
                    [iToast alertWithTitle:message];
                }
            }
        }
            break;
        case NetworkHUDError:
        {
            if (code != 1 && ![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                [iToast alertWithTitle:message];
            }
        }
            break;
        case NetworkHUDLockScreen:
        {
            [HUDManager hiddenHUD];
        }
            break;
        case NetworkHUDLockScreenAndMsg:
        {
            if (![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                if (code < 1)
                {
                    [iToast alertWithTitle:message];
                }
                else
                {
                    [iToast alertWithTitle:message];
                }
            }
            else
            {
                [HUDManager hiddenHUD];
            }
        }
            break;
        case NetworkHUDLockScreenAndError:
        {
            if (code != 1 && ![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                [iToast alertWithTitle:message];
            }
            else
            {
                [HUDManager hiddenHUD];
            }
        }
            break;
        case NetworkHUDLockScreenButNavWithMsg:
        {
            if (![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                if (code != 1)
                {
                    [iToast alertWithTitle:message];
                }
                else
                {
                    [iToast alertWithTitle:message];
                }
            }
            else
            {
                [HUDManager hiddenHUD];
            }
            
        }
            break;
        case NetworkHUDLockScreenButNavWithError:
        {
            if (code != 1 && ![message isKindOfClass:[NSNull class]] && ![NSString isNull:message])
            {
                [iToast alertWithTitle:message];
            }
            else
            {
                [HUDManager hiddenHUD];
            }
        }
            break;
        default:
            break;
    }
}

+ (NSDictionary *)getErrorDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInteger:-404], @"flag",
            @"网络异常，请检查网络",@"msg",
            nil];
}

@end
