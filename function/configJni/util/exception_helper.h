#include <jni.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#include "aes.h"

#ifndef EXCEPTION_HELPER_H
#define EXCEPTION_HELPER_H

jthrowable checkException(JNIEnv* env, jboolean clear);

void checkAndThrowException(JNIEnv* env);

void releaseLocalObjRef(JNIEnv* env, void* obj);

jint iabs(jint value);

jlong labs(jlong value);

jfloat fabs(jfloat value);

jdouble dabs(jdouble value);

jobject newObjectWithCheckException(JNIEnv* env, const char* className);

jobject newObject(JNIEnv* env, const char* className, const char* sig, ...);

jobject callObjectMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jobject callNonvirtualObjectMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jobject callStaticObjectMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

void callVoidMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

void callNonvirtualVoidMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

void callStaticVoidMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jchar callCharMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jchar callNonvirtualCharMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jchar callStaticCharMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jshort callShortMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jshort callNonvirtualShortMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jshort callStaticShortMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jint callIntMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jint callNonvirtualIntMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jint callStaticIntMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jlong callLongMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jlong callNonvirtualLongMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jlong callStaticLongMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jfloat callFloatMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jfloat callNonvirtualFloatMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jfloat callStaticFloatMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jdouble callDoubleMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jdouble callNonvirtualDoubleMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jdouble callStaticDoubleMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jbyte callByteMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jbyte callNonvirtualByteMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jbyte callStaticByteMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jboolean callBooleanMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jboolean callNonvirtualBooleanMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...);

jboolean callStaticBooleanMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...);

jmethodID getMethodID(JNIEnv* env, const char* className, const char* methodName, const char* sig);

jobject getObjectField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setObjectField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jobject param, jboolean checkException);

jobject getStaticObjectField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticObjectField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jobject param, jboolean checkException);

jchar getCharField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setCharField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jchar param, jboolean checkException);

jchar getStaticCharField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticCharField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jchar param, jboolean checkException);

jshort getShortField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setShortField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jshort param, jboolean checkException);

jshort getStaticShortField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticShortField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jshort param, jboolean checkException);

jint getIntField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setIntField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jint param, jboolean checkException);

jint getStaticIntField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticIntField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jint param, jboolean checkException);

jlong getLongField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setLongField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jlong param, jboolean checkException);

jlong getStaticLongField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticLongField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jlong param, jboolean checkException);

jfloat getFloatField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setFloatField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jfloat param, jboolean checkException);

jfloat getStaticFloatField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticFloatField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jfloat param, jboolean checkException);

jdouble getDoubleField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setDoubleField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jdouble param, jboolean checkException);

jdouble getStaticDoubleField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticDoubleField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jdouble param, jboolean checkException);

jbyte getByteField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setByteField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jbyte param, jboolean checkException);

jbyte getStaticByteField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticByteField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jbyte param, jboolean checkException);

jboolean getBooleanField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setBooleanField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean param, jboolean checkException);

jboolean getStaticBooleanField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException);

void setStaticBooleanField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean param, jboolean checkException);

jfieldID getFieldID(JNIEnv* env, const char* className, const char* fieldName, const char* sig);

#endif
