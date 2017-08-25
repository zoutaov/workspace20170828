LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SHORT_COMMANDS := true

LOCAL_LDLIBS    := -lm -llog 

LOCAL_PROGUARD_ENABLED:= disabled 

LOCAL_MODULE    := secidea1
#-Werror  
LOCAL_CLFAGS  	:=  -fvisibility=hidden -init=my_init  
LOCAL_CPPFLAGS += -std=c++11  -fvisibility=hidden   -mllvm -sobf 
LOCAL_SRC_FILES := util/exception_helper.cpp util/register_helper.cpp util/DynamicRegisterNative.cpp util/antidebug.cpp util/checksign.cpp util/md5.cpp MainActivity_1.cpp

include $(BUILD_SHARED_LIBRARY)
