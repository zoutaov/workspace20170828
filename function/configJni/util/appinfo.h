#ifndef _APP_INFO_H
#define _APP_INFO_H

#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <ctime>
#include <netdb.h>
#include <pthread.h>
#include <string.h>
#include "mlog.h"

void getAppInfo(JNIEnv* env, jobject thizz);

#endif
