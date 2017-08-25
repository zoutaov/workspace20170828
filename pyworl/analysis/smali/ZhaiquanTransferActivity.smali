.class public Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;
.super Lcom/my089/activity/base/BaseActivity;

# interfaces
.implements Lcom/my089/widgets/spinner/SpinnerDialog$OnSpinnerDialogListener;


# instance fields
.field private A:Ljava/lang/String;

.field private B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

.field private C:Landroid/widget/EditText;

.field private D:Landroid/widget/TextView;

.field private E:Lcom/my089/dialog/CenterDialog;

.field private F:Lcom/my089/dialog/CenterDialog;

.field private G:Lcom/my089/dialog/CenterDialog;

.field private final r:Ljava/lang/String;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/TextView;

.field private u:Landroid/widget/EditText;

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

    const-class v0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->A:Ljava/lang/String;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    iput-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    return-void
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Lcom/my089/dialog/CenterDialog;)Lcom/my089/dialog/CenterDialog;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    return-object p1
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;)Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    return-object p1
.end method

.method static synthetic a(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a(Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "bid_id"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "dp_rate"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/my089/newnet/Request;

    invoke-static {}, Lcom/my089/url/Urls;->getAccountZhaiquanTransferGetMaturityYieldRate()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/my089/newnet/Request$RequestMethod;->POST:Lcom/my089/newnet/Request$RequestMethod;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-direct {v0, v1, v2, v3}, Lcom/my089/newnet/Request;-><init>(Ljava/lang/String;Lcom/my089/newnet/Request$RequestMethod;Ljava/util/HashMap;)V

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$3;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$3;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    const-class v2, Lcom/my089/newnet/result/AccountZhaiquanTransferGetYieldrateEntity;

    invoke-virtual {v1, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$3;->a(Ljava/lang/Class;)Lcom/my089/newnet/callback/AbstractCallBack;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/newnet/Request;->a(Lcom/my089/newnet/callback/ICallBack;)V

    invoke-virtual {v0, p0}, Lcom/my089/newnet/Request;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic b(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Lcom/my089/dialog/CenterDialog;)Lcom/my089/dialog/CenterDialog;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    return-object p1
.end method

.method static synthetic b(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->q()V

    return-void
.end method

.method static synthetic b(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->d(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic c(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;Lcom/my089/dialog/CenterDialog;)Lcom/my089/dialog/CenterDialog;
    .locals 0

    iput-object p1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    return-object p1
.end method

.method static synthetic c(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic d(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private d(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "bid_id"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "dp_rate"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v2, "total_amount"

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "dealpwd"

    const/16 v2, 0x20

    invoke-static {p1, v2}, Lcom/my089/utils/MD5;->a(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/my089/newnet/Request;

    invoke-static {}, Lcom/my089/url/Urls;->getAccountZhaiquanTransferOk()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/my089/newnet/Request$RequestMethod;->POST:Lcom/my089/newnet/Request$RequestMethod;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-direct {v0, v1, v2, v3}, Lcom/my089/newnet/Request;-><init>(Ljava/lang/String;Lcom/my089/newnet/Request$RequestMethod;Ljava/util/HashMap;)V

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$4;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$4;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    const-class v2, Lcom/my089/newnet/result/AccountZhaiquanTransferOk;

    invoke-virtual {v1, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$4;->a(Ljava/lang/Class;)Lcom/my089/newnet/callback/AbstractCallBack;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/newnet/Request;->a(Lcom/my089/newnet/callback/ICallBack;)V

    invoke-virtual {v0, p0}, Lcom/my089/newnet/Request;->b(Landroid/content/Context;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    invoke-virtual {v0}, Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;->getTotal_amount_int()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static synthetic e(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private e()V
    .locals 4

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    const-string v1, "bid_id"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/my089/newnet/Request;

    invoke-static {}, Lcom/my089/url/Urls;->getAccountZhaiquanTransferDetails()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/my089/newnet/Request$RequestMethod;->POST:Lcom/my089/newnet/Request$RequestMethod;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p:Ljava/util/HashMap;

    invoke-direct {v0, v1, v2, v3}, Lcom/my089/newnet/Request;-><init>(Ljava/lang/String;Lcom/my089/newnet/Request$RequestMethod;Ljava/util/HashMap;)V

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$2;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$2;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    const-class v2, Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    invoke-virtual {v1, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$2;->a(Ljava/lang/Class;)Lcom/my089/newnet/callback/AbstractCallBack;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/newnet/Request;->a(Lcom/my089/newnet/callback/ICallBack;)V

    invoke-virtual {v0, p0}, Lcom/my089/newnet/Request;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic f(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->s:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic g(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->t:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic h(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->v:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic i(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->w:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic j(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->x:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic k(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic l(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic m(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic n(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private n()V
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    goto :goto_0
.end method

.method static synthetic o(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->D:Landroid/widget/TextView;

    return-object v0
.end method

.method private o()V
    .locals 6

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->n()V

    new-instance v0, Lcom/my089/dialog/CenterDialog;

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$5;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$5;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    new-instance v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$6;

    invoke-direct {v2, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$6;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    invoke-direct {v0, p0, v1, v2}, Lcom/my089/dialog/CenterDialog;-><init>(Landroid/content/Context;Lcom/my089/interfaces/DialogOnClickListener;Lcom/my089/interfaces/DialogOnDismissListener;)V

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    const v2, 0x7f080521

    invoke-virtual {p0, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f08017d

    invoke-virtual {p0, v3}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f0803da

    invoke-virtual {p0, v4}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual/range {v0 .. v5}, Lcom/my089/dialog/CenterDialog;->a(Landroid/app/Dialog;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->E:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->show()V

    return-void
.end method

.method static synthetic p(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private p()V
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    goto :goto_0
.end method

.method static synthetic q(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private q()V
    .locals 6

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->p()V

    new-instance v0, Lcom/my089/dialog/CenterDialog;

    new-instance v1, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$7;

    invoke-direct {v1, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$7;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    new-instance v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$8;

    invoke-direct {v2, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$8;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    invoke-direct {v0, p0, v1, v2}, Lcom/my089/dialog/CenterDialog;-><init>(Landroid/content/Context;Lcom/my089/interfaces/DialogOnClickListener;Lcom/my089/interfaces/DialogOnDismissListener;)V

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/my089/dialog/CenterDialog;->a(Z)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    const v2, 0x7f080521

    invoke-virtual {p0, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f08016e

    invoke-virtual {p0, v3}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f0803da

    invoke-virtual {p0, v4}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual/range {v0 .. v5}, Lcom/my089/dialog/CenterDialog;->a(Landroid/app/Dialog;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->F:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->show()V

    return-void
.end method

.method private r()V
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    goto :goto_0
.end method

.method static synthetic r(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r()V

    return-void
.end method

.method static synthetic s(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method private s()V
    .locals 6

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/my089/utils/StringUtils;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p0}, Lcom/my089/utils/Functions;->a(Landroid/content/Context;)Lcom/my089/MyApplication;

    move-result-object v0

    const v1, 0x7f080170

    invoke-virtual {p0, v1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/MyApplication;->e(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    invoke-static {v0}, Lcom/my089/utils/MatchUtil;->f(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Lcom/my089/utils/Functions;->a(Landroid/content/Context;)Lcom/my089/MyApplication;

    move-result-object v0

    const v1, 0x7f08016f

    invoke-virtual {p0, v1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/my089/MyApplication;->e(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f04006e

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    const v0, 0x7f0f01ea

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->C:Landroid/widget/EditText;

    const v0, 0x7f0f01eb

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->D:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->D:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r()V

    new-instance v0, Lcom/my089/dialog/CenterDialog;

    new-instance v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$9;

    invoke-direct {v2, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$9;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    new-instance v3, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$10;

    invoke-direct {v3, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$10;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    invoke-direct {v0, p0, v2, v3}, Lcom/my089/dialog/CenterDialog;-><init>(Landroid/content/Context;Lcom/my089/interfaces/DialogOnClickListener;Lcom/my089/interfaces/DialogOnDismissListener;)V

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0, v1}, Lcom/my089/dialog/CenterDialog;->a(Landroid/view/View;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    const v2, 0x7f08018f

    invoke-virtual {p0, v2}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    const v4, 0x7f080260

    invoke-virtual {p0, v4}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v5, 0x7f08047c

    invoke-virtual {p0, v5}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {v0 .. v5}, Lcom/my089/dialog/CenterDialog;->a(Landroid/app/Dialog;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->b()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->G:Lcom/my089/dialog/CenterDialog;

    invoke-virtual {v0}, Lcom/my089/dialog/CenterDialog;->show()V

    invoke-static {p0}, Lcom/my089/utils/Functions;->b(Landroid/app/Activity;)V

    goto/16 :goto_0
.end method

.method static synthetic t(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic u(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic v(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic w(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Landroid/widget/EditText;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->C:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic x(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method

.method static synthetic y(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)Lcom/my089/utils/Logger;
    .locals 1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    return-object v0
.end method


# virtual methods
.method protected a()V
    .locals 2

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->m:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->m:Landroid/widget/TextView;

    const v1, 0x7f08014f

    invoke-virtual {p0, v1}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->n:Landroid/widget/ImageView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->n:Landroid/widget/ImageView;

    const v1, 0x7f030156

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->n:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method public a(ILcom/my089/widgets/spinner/SpinnerEntity;Lcom/my089/widgets/spinner/SpinnerActionStatus;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    invoke-virtual {p2}, Lcom/my089/widgets/spinner/SpinnerEntity;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r:Ljava/lang/String;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    const-string v4, "selectDialogClick"

    invoke-virtual {v3, v4, v0}, Lcom/my089/utils/Logger;->a(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lcom/my089/utils/Logger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public a(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->c()V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected b()V
    .locals 1

    new-instance v0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$1;

    invoke-direct {v0, p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity$1;-><init>(Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;)V

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->g:Landroid/text/TextWatcher;

    const v0, 0x7f0f01c2

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->s:Landroid/widget/TextView;

    const v0, 0x7f0f01c3

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->t:Landroid/widget/TextView;

    const v0, 0x7f0f01c4

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    const v0, 0x7f0f01c6

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->v:Landroid/widget/TextView;

    const v0, 0x7f0f01c8

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->w:Landroid/widget/TextView;

    const v0, 0x7f0f01ca

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->x:Landroid/widget/TextView;

    const v0, 0x7f0f01cc

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->y:Landroid/widget/TextView;

    const v0, 0x7f0f01cd

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->z:Landroid/widget/Button;

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->b:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    invoke-static {p0}, Lcom/my089/utils/Functions;->b(Landroid/app/Activity;)V

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

    sparse-switch v0, :sswitch_data_0

    :goto_0
    return-void

    :sswitch_0
    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->o()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r:Ljava/lang/String;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    const-string v4, "onClickView"

    invoke-virtual {v3, v4, v0}, Lcom/my089/utils/Logger;->a(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lcom/my089/utils/Logger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    :try_start_1
    invoke-virtual {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->j()V

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->e()V

    goto :goto_0

    :sswitch_2
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "bundle_key_account_zhaiquan_transfer_details_type"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v1, "bundle_key_account_zhaiquan_transfer_details"

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->B:Lcom/my089/newnet/result/AccountZhaiquanTransferDetailsEntity;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    invoke-static {}, Lcom/my089/utils/ActivitySkip;->a()Lcom/my089/utils/ActivitySkip;

    move-result-object v1

    const-class v2, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferDetailsActivity;

    invoke-virtual {v1, p0, v2, v0}, Lcom/my089/utils/ActivitySkip;->a(Landroid/content/Context;Ljava/lang/Class;Landroid/os/Bundle;)V

    goto :goto_0

    :sswitch_3
    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->s()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x7f0f01cc -> :sswitch_2
        0x7f0f01cd -> :sswitch_3
        0x7f0f0556 -> :sswitch_0
        0x7f0f069a -> :sswitch_1
    .end sparse-switch
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

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->h:Landroid/os/Bundle;

    const-string v2, "bundle_key_account_zhaiquan_bid_id"

    const-string v3, ""

    invoke-virtual {v0, v1, v2, v3}, Lcom/my089/MyApplication;->a(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->A:Ljava/lang/String;

    const v0, 0x7f04006a

    invoke-virtual {p0, v0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->setContentView(I)V

    invoke-super {p0}, Lcom/my089/activity/base/BaseActivity;->h()V

    invoke-super {p0, p0}, Lcom/my089/activity/base/BaseActivity;->b(Lcom/my089/activity/base/BaseActivity;)V

    invoke-super {p0, p0}, Lcom/my089/activity/base/BaseActivity;->a(Lcom/my089/activity/base/BaseActivity;)V

    invoke-super {p0}, Lcom/my089/activity/base/BaseActivity;->f()V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->u:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->g:Landroid/text/TextWatcher;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->z:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->e()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    iget-object v2, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->r:Ljava/lang/String;

    iget-object v3, p0, Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity;->a:Lcom/my089/utils/Logger;

    const-string v4, "onCreate"

    invoke-virtual {v3, v4, v0}, Lcom/my089/utils/Logger;->a(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lcom/my089/utils/Logger;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
