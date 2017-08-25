#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef REGISTER_HELPER_H
#define REGISTER_HELPER_H

int registerNativeMethodFunctions(JNIEnv* env);
jstring getPackageName(JNIEnv *env, jobject thizz);
jint My_OnLoad(JavaVM *jvm) ;

#endif
