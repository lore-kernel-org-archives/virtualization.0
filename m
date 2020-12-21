Return-Path: <SRS0=paXq=FZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C6C433DB
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 23:08:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA89229CA
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 23:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA89229CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B65AB22E8C;
	Mon, 21 Dec 2020 23:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hgAd1isLXeUZ; Mon, 21 Dec 2020 23:08:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4EF2422D24;
	Mon, 21 Dec 2020 23:08:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38700C1825;
	Mon, 21 Dec 2020 23:08:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC70DC0893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 23:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9EE4087329
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 23:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-3pa9UQeMvo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 23:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 72E8C872CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 23:08:33 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id x16so15742927ejj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dfp0aeh95IYaI3WntgsOUL8ePUaBZUTKkfG2ztR0Dg8=;
 b=gjNEIlynThzH0yxjpGAH2/5ztcMfcATo7ZnSsX5g5uq1zBY+naL0Sapke3nBbEwwpQ
 vLehjn6aI86q/DJUCLSWeHd6pbH483Ac5MRlPyACI2WSNWUz+APwtl37BnqxSqNjJtWA
 AXhwoif1EhT4K1UDXx2KVKAAHJTcYi+S67kzJ1E0o/fVlwzFuci25+ymq0IbaO28+ulV
 R/DzVoQmLbLtwWPTPtGpZRaGqXbtBZ3lbvewovu5KVeoKj6AQXXuFTqzXpcA+kutokCC
 IO/vvIAmsI2voC5ytpYrdcIRE7DPuYzOsCThad1jhyvVZKndzbupI1ggOYb4QwgbLAmf
 dnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dfp0aeh95IYaI3WntgsOUL8ePUaBZUTKkfG2ztR0Dg8=;
 b=Xtvs94mQbLH1ueEjUaOYoVmNvshDiRghQV9deApIgNsOHI9HLfGaAHnpgfpRQS990c
 L5kASy975CiU4j1QP9nfWzzYFSwXHY1MtVWNH+eEpxyXNCdFWuRRhT2igNVM7KCSiidp
 1HgdC0/4U5+ZvOrwGR1zwA3Vidiamdo51mnJqa+PDkU+is+pY7T1MtdkKF9BBmDqWLaX
 /qsoU8bqvuqqhw1gTVR8bjo5R53EWLfKvoK78jL2f2a2Bkl0VWpX572Omqm4f2rKHcKv
 KIdnqoAbQxOvmpZzrR7HczzFHXZaZAFgu1XSMFdAXRqDnLgLtkYWbBLnVe5DXlsAZrNt
 /9/w==
X-Gm-Message-State: AOAM5335LWmNwEMLFlnU9Bg3M8+QOzneR0NKF7lOy4XMULrIVK2xmTnk
 bWO3OsNYW0LQVNjGsqx/L0/8iwf0vAY3DH72tks=
X-Google-Smtp-Source: ABdhPJxDMz3qQZBnj6GmuTexP76QmGK6S3OM30XwZUu0QNwDeL0K6D7QLp0JFVQ50AjKgibUkyUxKZsmm6yCAhlDeTQ=
X-Received: by 2002:a17:906:52d9:: with SMTP id
 w25mr17106619ejn.504.1608592111925; 
 Mon, 21 Dec 2020 15:08:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
In-Reply-To: <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 21 Dec 2020 18:07:54 -0500
Message-ID: <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 16, 2020 at 3:20 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently we break the loop and wake up the vhost_worker when
> sendmsg fails. When the worker wakes up again, we'll meet the
> same error.

The patch is based on the assumption that such error cases always
return EAGAIN. Can it not also be ENOMEM, such as from tun_build_skb?

> This will cause high CPU load. To fix this issue,
> we can skip this description by ignoring the error. When we
> exceeds sndbuf, the return value of sendmsg is -EAGAIN. In
> the case we don't skip the description and don't drop packet.

the -> that

here and above: description -> descriptor

Perhaps slightly revise to more explicitly state that

1. in the case of persistent failure (i.e., bad packet), the driver
drops the packet
2. in the case of transient failure (e.g,. memory pressure) the driver
schedules the worker to try again later


> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/vhost/net.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c8784dfafdd7..3d33f3183abe 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -827,16 +827,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>                                 msg.msg_flags &= ~MSG_MORE;
>                 }
>
> -               /* TODO: Check specific error and bomb out unless ENOBUFS? */
>                 err = sock->ops->sendmsg(sock, &msg, len);
> -               if (unlikely(err < 0)) {
> +               if (unlikely(err == -EAGAIN)) {
>                         vhost_discard_vq_desc(vq, 1);
>                         vhost_net_enable_vq(net, vq);
>                         break;
> -               }
> -               if (err != len)
> -                       pr_debug("Truncated TX packet: len %d != %zd\n",
> -                                err, len);
> +               } else if (unlikely(err != len))
> +                       vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);

sending -> send

Even though vq_err is a wrapper around pr_debug, I agree with Michael
that such a change should be a separate patch to net-next, does not
belong in a fix.

More importantly, the error message is now the same for persistent
errors and for truncated packets. But on truncation the packet was
sent, so that is not entirely correct.

>  done:
>                 vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
>                 vq->heads[nvq->done_idx].len = 0;
> @@ -922,7 +919,6 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>                         msg.msg_flags &= ~MSG_MORE;
>                 }
>
> -               /* TODO: Check specific error and bomb out unless ENOBUFS? */
>                 err = sock->ops->sendmsg(sock, &msg, len);
>                 if (unlikely(err < 0)) {
>                         if (zcopy_used) {
> @@ -931,13 +927,14 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>                                 nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>                                         % UIO_MAXIOV;
>                         }
> -                       vhost_discard_vq_desc(vq, 1);
> -                       vhost_net_enable_vq(net, vq);
> -                       break;
> +                       if (err == -EAGAIN) {
> +                               vhost_discard_vq_desc(vq, 1);
> +                               vhost_net_enable_vq(net, vq);
> +                               break;
> +                       }
>                 }
>                 if (err != len)
> -                       pr_debug("Truncated TX packet: "
> -                                " len %d != %zd\n", err, len);
> +                       vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);
>                 if (!zcopy_used)
>                         vhost_add_used_and_signal(&net->dev, vq, head, 0);
>                 else
> --
> 2.23.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
