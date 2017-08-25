#ifndef _ANTIDEBUG
#define _ANTIDEBUG

#include <stdio.h>
#include <sys/ptrace.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <android/log.h>
#include <sys/syscall.h>
#include <sys/inotify.h>
#include <pthread.h>
#include <sys/prctl.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>
#include <sys/queue.h>
#include <sys/select.h>
#include <stdio.h>
#include <stdlib.h>

//   extern void readStatus() __attribute__((__annotate__(("fla"))));

// extern void AntiDebug() __attribute__((__annotate__(("bcf"))));

// extern void CalcTime(int, int) __attribute__((__annotate__(("sub"))));

// void safe_attach(pid_t pid) __attribute__((__annotate__(("sub"))));

// void handle_events() __attribute__((__annotate__(("flag"))));

// int checkDebugger() __attribute__((__annotate__(("bcf"))));

// void checkAndroidServer() __attribute__((__annotate__(("bcf"))));

// void runInotify() __attribute__((__annotate__(("sub"))));

// void* anti_ptrace(void* arg) __attribute__((__annotate__(("bcf"))));

// // void checkDebug();
// //  return 1 is ok  return -1 should kill thread & process
// int checkDebug () __attribute__((__annotate__(("bcf"))));
  extern void readStatus();

extern void AntiDebug() ;

extern void CalcTime(int, int) ;

void safe_attach(pid_t pid) ;

void handle_events() ;

int checkDebugger() ;

void checkAndroidServer() ;

void runInotify() ;

void* anti_ptrace(void* arg) ;

// void checkDebug();
//  return 1 is ok  return -1 should kill thread & process
int checkDebug () ;
#endif
