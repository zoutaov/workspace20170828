.class public Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;
.super Lcom/my089/activity/base/BaseActivity;


# instance fields
.field private A:Ljava/lang/String;

.field private B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

.field private C:Lcom/my089/dialog/CenterDialog;

.field private final r:Ljava/lang/String;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/TextView;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/widget/TextView;

.field private z:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/my089/activity/base/BaseActivity;-><init>()V

    const-class v0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->r:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->A:Ljava/lang/String;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    return-void
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->s:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;Lcom/my089/dialog/CenterDialog;)Lcom/my089/dialog/CenterDialog;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    return-object p1
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;)Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    return-object p1
.end method

.method static synthetic b(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->t:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic c(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->u:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic d(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->v:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic e(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->w:Landroid/widget/TextView;

    return-object v0
.end method

.method private e()V
    .locals 4

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    const-string v1, "bid_id"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/my089/newnet/Request;

    invoke-static {}, Lcom/my089/url/Urls;->getAccountZhaiquanTransferDetails()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/my089/newnet/Request$RequestMethod;->POST:Lcom/my089/newnet/Request$RequestMethod;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    invoke-direct {v0, v1, v2, v3}, Lcom/my089/newnet/Request;-><init>(Ljava/lang/String;Lcom/my089/newnet/Request$RequestMethod;Ljava/util/HashMap;)V

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$1;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$1;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)V

    const-class v2, Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    invoke-virtual {v1, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$1;->a(Ljava/lang/Class;)Lcom/my089/newnet/callback/AbstractCallBack;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/newnet/Request;->a(Lcom/my089/newnet/callback/ICallBack;)V

    invoke-virtual {v0, p0}, Lcom/my089/newnet/Request;->b(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic f(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->x:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic g(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->r:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic h(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic i(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic j(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p()V

    return-void
.end method

.method private n()V
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    goto :goto_0
.end method

.method private o()V
    .locals 6

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->n()V

    new-instance v0, Lcom/my089/dialog/CenterDialog;

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$2;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$2;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)V

    new-instance v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$3;

    invoke-direct {v2, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$3;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)V

    invoke-direct {v0, p0, v1, v2}, Lcom/my089/dialog/CenterDialog;-><init>(Landroid/content/Context;Lcom/my089/interfaces/DialogOnClickListener;Lcom/my089/interfaces/DialogOnDismissListener;)V

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    const v2, 0x7f080521

    invoke-virtual {p0, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f080152

    invoke-virtual {p0, v3}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f08047c

    invoke-virtual {p0, v4}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v5, 0x7f080260

    invoke-virtual {p0, v5}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {v0 .. v5}, Lcom/my089/dialog/CenterDialog;->a(Landroid/app/Dialog;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->C:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->show()V

    return-void
.end method

.method private p()V
    .locals 4

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    const-string v1, "bid_id"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    const-string v1, "note"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/my089/newnet/Request;

    invoke-static {}, Lcom/my089/url/Urls;->getAccountZhaiquanTransferCancel()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/my089/newnet/Request$RequestMethod;->POST:Lcom/my089/newnet/Request$RequestMethod;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->p:Ljava/util/HashMap;

    invoke-direct {v0, v1, v2, v3}, Lcom/my089/newnet/Request;-><init>(Ljava/lang/String;Lcom/my089/newnet/Request$RequestMethod;Ljava/util/HashMap;)V

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$4;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$4;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;)V

    const-class v2, Lcom/my089/newnet/result/AccountZhaiquanTransferCancelEntity;

    invoke-virtual {v1, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity$4;->a(Ljava/lang/Class;)Lcom/my089/newnet/callback/AbstractCallBack;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/newnet/Request;->a(Lcom/my089/newnet/callback/ICallBack;)V

    invoke-virtual {v0, p0}, Lcom/my089/newnet/Request;->b(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 2

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->m:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->m:Landroid/widget/TextView;

    const v1, 0x7f080150

    invoke-virtual {p0, v1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method public a(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->c()V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected b()V
    .locals 1

    const v0, 0x7f0f01ce

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->s:Landroid/widget/TextView;

    const v0, 0x7f0f01cf

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->t:Landroid/widget/TextView;

    const v0, 0x7f0f01d0

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->u:Landroid/widget/TextView;

    const v0, 0x7f0f01d1

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->v:Landroid/widget/TextView;

    const v0, 0x7f0f01d2

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->w:Landroid/widget/TextView;

    const v0, 0x7f0f01d3

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->x:Landroid/widget/TextView;

    const v0, 0x7f0f01d4

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->y:Landroid/widget/TextView;

    const v0, 0x7f0f01d5

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->z:Landroid/widget/Button;

    return-void
.end method

.method protected c()V
    .locals 1

    invoke-static {}, Lcom/my089/utils/ActivityManager;->a()Lcom/my089/utils/ActivityManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/my089/utils/ActivityManager;->b(Landroid/app/Activity;)V

    return-void
.end method

.method protected onClickView(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "bundle_key_account_zhaiquan_transfer_details_type"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "bundle_key_account_zhaiquan_transfer_details"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    invoke-static {}, Lcom/my089/utils/ActivitySkip;->a()Lcom/my089/utils/ActivitySkip;

    move-result-object v1

    const-class v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferDetailsActivity;

    invoke-virtual {v1, p0, v2, v0}, Lcom/my089/utils/ActivitySkip;->a(Landroid/content/Context;Ljava/lang/Class;Landroid/os/Bundle;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->r:Ljava/lang/String;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    const-string v4, "onClickView"

    invoke-virtual {v3, v4, v0}, Lcom/my089/utils/Logger;->a(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lcom/my089/utils/Logger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_1
    :try_start_1
    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->o()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x7f0f01d4
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    :try_start_0
    invoke-super {p0, p1}, Lcom/my089/activity/base/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    invoke-static {}, Lcom/my089/utils/ActivityManager;->a()Lcom/my089/utils/ActivityManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/my089/utils/ActivityManager;->a(Landroid/app/Activity;)V

    invoke-static {p0}, Lcom/my089/utils/Functions;->a(Landroid/content/Context;)Lcom/my089/MyApplication;

    move-result-object v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->h:Landroid/os/Bundle;

    const-string v2, "bundle_key_account_zhaiquan_bid_id"

    const-string v3, ""

    invoke-virtual {v0, v1, v2, v3}, Lcom/my089/MyApplication;->a(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->A:Ljava/lang/String;

    const v0, 0x7f04006b

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->setContentView(I)V

    invoke-super {p0, p0}, Lcom/my089/activity/base/BaseActivity;->b(Lcom/my089/activity/base/BaseActivity;)V

    invoke-super {p0, p0}, Lcom/my089/activity/base/BaseActivity;->a(Lcom/my089/activity/base/BaseActivity;)V

    invoke-super {p0}, Lcom/my089/activity/base/BaseActivity;->f()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->z:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->e()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->r:Ljava/lang/String;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferCancelActivity;->a:Lcom/my089/utils/Logger;

    const-string v4, "onCreate"

    invoke-virtual {v3, v4, v0}, Lcom/my089/utils/Logger;->a(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lcom/my089/utils/Logger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
