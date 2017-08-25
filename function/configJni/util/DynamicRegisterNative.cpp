#include "register_helper.h"
#include "other_class.h"
#include <jni.h>
#include "aes.h"
#include "mlog.h"

template <class T>
int getMethodNumber(T& array)  //使用模板定义一个函数getArrayLen,该函数将返回数组array的长度
{
	
  return (sizeof(array) / sizeof(array[0]));
}
static int registerNativeMethods(JNIEnv *env, const char* className, JNINativeMethod *gMethods, int numMethods)
{  jclass clazz;

    clazz = env->FindClass(className);
    if(clazz == NULL ){ return JNI_FALSE; }

    if(env->RegisterNatives(clazz,gMethods,numMethods)<0){ return JNI_FALSE; }
    env->DeleteLocalRef(clazz);

    return JNI_TRUE;
}

static const char* gClassNameac673dd79e67d1945fb89d0ba5919006f ="com/secidea/imaf/MainActivity";
static JNINativeMethod gMethodac673dd79e67d1945fb89d0ba5919006f[] = {{"onCreate","(Landroid/os/Bundle;)V", (void*)ac673dd79e67d1945fb89d0ba5919006f }};

int registerNativeMethodFunctions(JNIEnv* env){
if(registerNativeMethods(env, gClassNameac673dd79e67d1945fb89d0ba5919006f, gMethodac673dd79e67d1945fb89d0ba5919006f, getMethodNumber(gMethodac673dd79e67d1945fb89d0ba5919006f) ) == JNI_FALSE) 
{ 
return JNI_ERR; 

}

return JNI_OK;
}
