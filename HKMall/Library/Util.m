//
//  Util.m
//  HKMember
//
//  Created by hua on 14-4-23.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "Util.h"

@implementation Util

+(NSString *)limitRCLabelLength:(NSUInteger)limitLength string:(NSString *)str
{
    NSString *text=[NSString stringWithFormat:@"%@",str];
    
    //解析表情
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";//表情的正则表达式
    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
    
    
    NSMutableArray *allStrArray=[[NSMutableArray alloc] initWithCapacity:2];
    NSDictionary *dic;
    
    if ([array_emoji count]) {

        for (int i=0; i<[array_emoji count]; i++) {
            NSString *emojiStr=[array_emoji objectAtIndex:i];
            
            NSRange range = [text rangeOfString:emojiStr];
            NSString *itemStr=[text substringToIndex:range.location];
            
            
            dic=[NSDictionary dictionaryWithObjectsAndKeys:itemStr,@"text",@"word",@"type", nil];
            [allStrArray addObject:dic];
            
            
            dic=[NSDictionary dictionaryWithObjectsAndKeys:emojiStr,@"text",@"emoji",@"type", nil];
            [allStrArray addObject:dic];
            
            text=[text substringFromIndex:range.location+emojiStr.length];
            
            if (i==array_emoji.count-1) {
                dic=[NSDictionary dictionaryWithObjectsAndKeys:text,@"text",@"word",@"type", nil];
                [allStrArray addObject:dic];
                
            }
        }
        
    } else {
    
        dic=[NSDictionary dictionaryWithObjectsAndKeys:text,@"text",@"word",@"type", nil];
        [allStrArray addObject:dic];
    
    }
    
    
    NSInteger allLength=0;
    
    NSMutableString *finalStr=[NSMutableString stringWithCapacity:1];
    
    for (NSDictionary *itemDic in allStrArray) {
        
        NSString *dicText=[itemDic objectForKey:@"text"];
        NSString *dicType=[itemDic objectForKey:@"type"];
        
        
        if ([dicType isEqualToString:@"emoji"]) {
            allLength++;
            [finalStr appendString:dicText];
            
            if (allLength>=limitLength) {
                [finalStr appendString:@"..."];
                break;
            }
            
            
        } else {
            
            for(NSUInteger i = 0; i < dicText.length; i++) {
                unichar uc = [dicText characterAtIndex: i];
                allLength += isascii(uc) ? 1 : 2;
                
                [finalStr appendString:[dicText substringWithRange:NSMakeRange(i, 1)]];
                
                if (allLength>=limitLength) {
                    [finalStr appendString:@"..."];
                    break;
                }
            }
            
        }
        
    }
    
    return finalStr;
    
}


//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return !canChange;
}

//保留2位小数
+(double)getTwoDecimalsDoubleValue:(double)number
{
 return round(number * 100.0)/100.0;
}


+(NSString *)getConcealPhoneNumber:(NSString *)phoneNum
{
    NSString *phoneStr=phoneNum;
    if (phoneStr!=nil) {
        //修改by chenli - 这里不用判断手机号是否有效
        if (phoneStr.length > 7) {
             phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
    }
    return phoneStr;
}

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length{
    
    if (text==nil) {
        return text;
    }
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    if (asciiLength<length) { //文字长度小于限制长度
        return text;
        
    } else {
        
        __block NSMutableString * finalStr = [NSMutableString stringWithString:text];
        
        [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
//             DLog(@"substring:%@ substringRange:%@  enclosingRange:%@",substring,NSStringFromRange(substringRange),NSStringFromRange(enclosingRange));
             
             if (substringRange.location<=location+1) {
                 NSString *temp=[text substringToIndex:substringRange.location];
                 finalStr=[NSMutableString stringWithString:temp];
                 *stop=YES;
             }
             
         }];

        return finalStr;
    }
}


+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}


//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    if (toBeString.length > kMaxLength) {
        textField.text = [toBeString substringToIndex:kMaxLength];
    }
    
}

//用于限制UITextView的输入中英文限制
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textview markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textview positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    if (toBeString.length > kMaxLength) {
        textview.text = [toBeString substringToIndex:kMaxLength];
    }
    
}

//获得应用版本号
+(NSString *)getApplicationVersion
{
    //application version (use short version preferentially)
    NSString *applicationVersion=nil;
    applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ([applicationVersion length] == 0)
    {
        applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    return applicationVersion;
}

//是否是纯数字 add卜增彦2014.11.11 不好用
+ (BOOL)isNumText:(NSString *)str
{
    NSString * regex        = @"(/^[0-9]*$/)";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    

}

//是否是纯数字 add卜增彦2014.11.11
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
