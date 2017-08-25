#include "exception_helper.h"
#include "mlog.h"
/**
 * 捕获异常并返回异常对象，没异常时返回NULL
 */
jthrowable checkException(JNIEnv* env, jboolean clear){
	jthrowable ex = env->ExceptionOccurred();
	if(ex != NULL){
		if(clear)
			env->ExceptionClear();
		return ex;
	}
	return NULL;
}

/**
 * 捕获异常并抛出该异常
 */
void checkAndThrowException(JNIEnv* env){
	jthrowable ex = env->ExceptionOccurred();
	if(ex != NULL){
		env->ExceptionClear();
		env->Throw(ex);
		env->DeleteLocalRef(ex);
	}
}

/**
 * 检查当前的obj是否依旧有效，如果有效则释放
 */
void releaseLocalObjRef(JNIEnv* env, void* obj){
	if(*(jobject*)obj != NULL){
		env->DeleteLocalRef(*(jobject*)obj);
		*(jobject*)obj = NULL;
	}
}

/**
 * 取int的绝对值
 */
jint iabs(jint value){
	if(value < 0) return -value;
	return value;
}

/**
 * 取long的绝对值
 */
jlong labs(jlong value){
	if(value < 0) return -value;
		return value;
}

/**
 * 取float的绝对值
 */
jfloat fabs(jfloat value){
	if(value < 0) return -value;
		return value;
}

/**
 * 取double的绝对值
 */
jdouble dabs(jdouble value){
	if(value < 0) return -value;
		return value;
}

jobject newObjectWithCheckException(JNIEnv* env, const char* className){
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, "<init>", "()V");
	jthrowable j_ex = checkException(env, JNI_TRUE);
	jobject obj = NULL;
	if(j_ex == NULL){
		obj = env->NewObject(clazz, methodId);
	}else{
		env->DeleteLocalRef(j_ex);
	}
	env->DeleteLocalRef(clazz);
	return obj;
}

jobject newObject(JNIEnv* env, const char* className, const char* sig, ...){
	va_list args;
	va_start(args, sig);
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, "<init>", sig);
	jobject obj = env->NewObjectV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jobject callObjectMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return NULL;
	}
	va_start(args, sig);
	jobject obj = env->CallObjectMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jobject callNonvirtualObjectMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return NULL;
	}
	va_start(args, sig);
	jobject obj = env->CallNonvirtualObjectMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jobject callStaticObjectMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return NULL;
	}
	va_start(args, sig);
	jobject obj = env->CallStaticObjectMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

void callVoidMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	va_start(args, sig);
	env->CallVoidMethodV(invokeObj, methodId, args);
	va_end(args);
}

void callNonvirtualVoidMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	va_list args;
	va_start(args, sig);
	env->CallNonvirtualVoidMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
}

void callStaticVoidMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	va_start(args, sig);
	env->CallStaticVoidMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
}

jchar callCharMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jchar obj = env->CallCharMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jchar callNonvirtualCharMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jchar obj = env->CallNonvirtualCharMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jchar callStaticCharMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jchar obj = env->CallStaticCharMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jshort callShortMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jshort obj = env->CallShortMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jshort callNonvirtualShortMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jshort obj = env->CallNonvirtualShortMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jshort callStaticShortMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jshort obj = env->CallStaticShortMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jint callIntMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jint obj = env->CallIntMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jint callNonvirtualIntMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jint obj = env->CallNonvirtualIntMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jint callStaticIntMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jint obj = env->CallStaticIntMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jlong callLongMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jlong obj = env->CallLongMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jlong callNonvirtualLongMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jlong obj = env->CallNonvirtualLongMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jlong callStaticLongMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jlong obj = env->CallStaticLongMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jfloat callFloatMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jfloat obj = env->CallFloatMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jfloat callNonvirtualFloatMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jfloat obj = env->CallNonvirtualFloatMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jfloat callStaticFloatMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jfloat obj = env->CallStaticFloatMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jdouble callDoubleMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jdouble obj = env->CallDoubleMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jdouble callNonvirtualDoubleMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jdouble obj = env->CallNonvirtualDoubleMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jdouble callStaticDoubleMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jdouble obj = env->CallStaticDoubleMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jbyte callByteMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jbyte obj = env->CallByteMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jbyte callNonvirtualByteMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jbyte obj = env->CallNonvirtualByteMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jbyte callStaticByteMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jbyte obj = env->CallStaticByteMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


jboolean callBooleanMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jmethodID methodId = getMethodID(env, className, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jboolean obj = env->CallBooleanMethodV(invokeObj, methodId, args);
	va_end(args);
	return obj;
}

jboolean callNonvirtualBooleanMethod(JNIEnv* env, jboolean checkException, jobject invokeObj, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jboolean obj = env->CallNonvirtualBooleanMethodV(invokeObj, clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}

jboolean callStaticBooleanMethod(JNIEnv* env, jboolean checkException, const char* className, const char* methodName, const char* sig, ...){
	va_list args;
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetStaticMethodID(clazz, methodName, sig);
	if(methodId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	va_start(args, sig);
	jboolean obj = env->CallStaticBooleanMethodV(clazz, methodId, args);
	env->DeleteLocalRef(clazz);
	va_end(args);
	return obj;
}


/**
 * 获取jmethodId
 */
jmethodID getMethodID(JNIEnv* env, const char* className, const char* methodName, const char* sig){
	jclass clazz = env->FindClass(className);
	jmethodID methodId = env->GetMethodID(clazz, methodName, sig);
	env->DeleteLocalRef(clazz);
	return methodId;
}


jobject getObjectField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return NULL;
	}
	return env->GetObjectField(invokeObj, fieldId);
}

void setObjectField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jobject param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetObjectField(invokeObj, fieldId, param);
}


jobject getStaticObjectField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return NULL;
	}
	jobject obj = env->GetStaticObjectField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticObjectField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jobject param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticObjectField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  char  **************************/
jchar getCharField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetCharField(invokeObj, fieldId);
}

void setCharField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jchar param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetCharField(invokeObj, fieldId, param);
}


jchar getStaticCharField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jchar obj = env->GetStaticCharField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticCharField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jchar param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticCharField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  short  **************************/
jshort getShortField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetShortField(invokeObj, fieldId);
}

void setShortField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jshort param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetShortField(invokeObj, fieldId, param);
}


jshort getStaticShortField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jshort obj = env->GetStaticShortField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticShortField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jshort param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticShortField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  int  **************************/
jint getIntField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetIntField(invokeObj, fieldId);
}

void setIntField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jint param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetIntField(invokeObj, fieldId, param);
}


jint getStaticIntField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jint obj = env->GetStaticIntField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticIntField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jint param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticIntField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  long  **************************/
jlong getLongField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetLongField(invokeObj, fieldId);
}

void setLongField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jlong param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetLongField(invokeObj, fieldId, param);
}


jlong getStaticLongField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jlong obj = env->GetStaticLongField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticLongField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jlong param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticLongField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  float  **************************/
jfloat getFloatField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetFloatField(invokeObj, fieldId);
}

void setFloatField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jfloat param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetFloatField(invokeObj, fieldId, param);
}


jfloat getStaticFloatField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jfloat obj = env->GetStaticFloatField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticFloatField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jfloat param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticFloatField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  double  **************************/
jdouble getDoubleField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetDoubleField(invokeObj, fieldId);
}

void setDoubleField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jdouble param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetDoubleField(invokeObj, fieldId, param);
}


jdouble getStaticDoubleField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jdouble obj = env->GetStaticDoubleField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticDoubleField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jdouble param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticDoubleField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  byte  **************************/
jbyte getByteField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetByteField(invokeObj, fieldId);
}

void setByteField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jbyte param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetByteField(invokeObj, fieldId, param);
}


jbyte getStaticByteField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jbyte obj = env->GetStaticByteField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticByteField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jbyte param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticByteField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/***********************  boolean  **************************/
jboolean getBooleanField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	return env->GetBooleanField(invokeObj, fieldId);
}

void setBooleanField(JNIEnv* env, jobject invokeObj, const char* className, const char* fieldName, const char* sig, jboolean param, jboolean checkException){
	jfieldID fieldId = getFieldID(env, className, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetBooleanField(invokeObj, fieldId, param);
}


jboolean getStaticBooleanField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return 0;
	}
	jboolean obj = env->GetStaticBooleanField(clazz, fieldId);
	env->DeleteLocalRef(clazz);
	return obj;
}


void setStaticBooleanField(JNIEnv* env, const char* className, const char* fieldName, const char* sig, jboolean param, jboolean checkException){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetStaticFieldID(clazz, fieldName, sig);
	if(fieldId == 0 && checkException == JNI_TRUE){
		checkAndThrowException(env);
		return ;
	}
	env->SetStaticBooleanField(clazz, fieldId, param);
	env->DeleteLocalRef(clazz);
}

/**
 * 获取jmethodId
 */
jfieldID getFieldID(JNIEnv* env, const char* className, const char* fieldName, const char* sig){
	jclass clazz = env->FindClass(className);
	jfieldID fieldId = env->GetFieldID(clazz, fieldName, sig);
	env->DeleteLocalRef(clazz);
	return fieldId;
}
