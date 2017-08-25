#include "register_helper.h"
#include "exception_helper.h"
#include "antidebug.h"
#include "mlog.h"


extern "C" {void _init(void){}}

//System.loadLibrary过程中会自动调用JNI_OnLoad，在此进行动态注册
/**
 * 每个类调用JNI_OnLoad时调用
 * jvm：JavaVM指针
 * className：注册的类名
 * gMethods：注册的方法table
 */
//jint My_OnLoad(JavaVM *jvm, const char* className, JNINativeMethod gMethods[]) {
jint My_OnLoad(JavaVM *jvm){
    JNIEnv *env = NULL;
    jint result = JNI_FALSE;
    //调试检测
    //int value =checkDebug();
    if(checkDebug() == -1)
    {
        return result;
    }
    //获取env指针
    if (jvm->GetEnv((void**) &env, JNI_VERSION_1_6) != JNI_OK) {
        return result;
    }
    if (env == NULL) {
        return result;
    }

    registerNativeMethodFunctions(env);

    //成功
    result = JNI_VERSION_1_6;
    return result;
}

