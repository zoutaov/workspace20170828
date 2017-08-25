#.class public Lcom/test/testshell/OrginalApplication;

# direct methods

.method static constructor <clinit>()V

    .locals 1

    .prologue

    const-string v0, "secidea"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void

.end method.super Landroid/app/Application;

# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method





