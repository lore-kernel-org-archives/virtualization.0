Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0784BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D87340579;
	Wed, 23 Feb 2022 02:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pf3eP6NPTVvy; Wed, 23 Feb 2022 02:09:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A05640260;
	Wed, 23 Feb 2022 02:09:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5175AC0021;
	Wed, 23 Feb 2022 02:09:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA35C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28B8C40495
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y7mP-L2Ztxnu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:09:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EB6240493
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645582158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9LkpmwRUB9s3DzzklqywD2GBEtiMiXthflpW97NS2M=;
 b=eWyH4UyQbNgh3HGIBNzKjBIRpS9OD98j+5Q6oOwfEI1W9ycTh5D55gGaO8HQCwHVOP26PN
 YNzOTL5GyrZW7fceOiaMQvrXeLzr63uNyjGaGSFjltBdUdfIUmpSOA9QqEABVJ1ElCr9WH
 +dC3bqSJwNp0huX8hYhKTL951P8evag=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-onRE0xA2OMmI8WHkDANKeA-1; Tue, 22 Feb 2022 21:09:16 -0500
X-MC-Unique: onRE0xA2OMmI8WHkDANKeA-1
Received: by mail-lj1-f197.google.com with SMTP id
 x7-20020a2e9c87000000b002463977afe4so4674513lji.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W9LkpmwRUB9s3DzzklqywD2GBEtiMiXthflpW97NS2M=;
 b=JmLmH/lyQxlWydVdn/wn19rqY8Y9GB0svCC+4NSeiMVQQpbk/jmHY4ctnPTktAb9Jf
 3PbGiLNaah1uGWDQStjDTfw+SEbWRDtYc9xaCBOV9uiKYnYrz0NSodvs6AMSE4GpNzdq
 o4ATGTiWYYYGvVk2JGdBfiPyznnJ64kq4gmcr8jOEtSa/DeX+Nwxbs3UlH46LF1Cclfd
 bDRnjN/h/1LuzpkwL73TpzmYGCw4liqWLAOB0CMEqGE4Qhu60E2QTBhmY9otPvuLaah5
 xeQFtcaBc0rJNTlOnwZeCrpMvipq+y8oLgUlRg6FHtv5SQxZvyjmUghkZve5/qSCNnGz
 eHpg==
X-Gm-Message-State: AOAM530FswKBcm54xoM3M0kCwvbBRXPVlGvpRamPOjSh2wi+PqAaB+d3
 7F91It9YChwcWT02kZBX4OpwOmNzpOyLLiksDVqdxcSjLFWQDiY4KBCRKO70S+WEMudwbmy5aC2
 JWqR6AoFZgukMfHDWQv4aEH7BdL56x6ax1/7huw8lluCF69yZI0OdPgdY2A==
X-Received: by 2002:ac2:4da1:0:b0:438:74be:5a88 with SMTP id
 h1-20020ac24da1000000b0043874be5a88mr17748778lfe.210.1645582155183; 
 Tue, 22 Feb 2022 18:09:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWVsv8Sx14FGPZdp4dBv1csb/D6luqE37ndqXaLZ0eJ0z4lL/rN+eJyDfku6eJ6K+YiTb9ktJZ9PM21p2/UQY=
X-Received: by 2002:ac2:4da1:0:b0:438:74be:5a88 with SMTP id
 h1-20020ac24da1000000b0043874be5a88mr17748759lfe.210.1645582154950; Tue, 22
 Feb 2022 18:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20220222094742.16359-1-sgarzare@redhat.com>
In-Reply-To: <20220222094742.16359-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 10:09:03 +0800
Message-ID: <CACGkMEtN_YO1Avi79bMyaCqLHMMpDaPvh1oVQPEMRYky_Zbugg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: syzbot <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com>,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Anirudh Rayabharam <mail@anirudhrb.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Feb 22, 2022 at 5:47 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
> ownership. It expects current->mm to be valid.
>
> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
> the user has not done close(), so when we are in do_exit(). In this
> case current->mm is invalid and we're releasing the device, so we
> should clean it anyway.
>
> Let's check the owner only when vhost_vsock_stop() is called
> by an ioctl.
>
> When invoked from release we can not fail so we don't check return
> code of vhost_vsock_stop(). We need to stop vsock even if it's not
> the owner.
>
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v2:
> - initialized `ret` in vhost_vsock_stop [Dan]
> - added comment about vhost_vsock_stop() calling in the code and an explanation
>   in the commit message [MST]
>
> v1: https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarzare@redhat.com
> ---
>  drivers/vhost/vsock.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index d6ca1c7ad513..37f0b4274113 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>         return ret;
>  }
>
> -static int vhost_vsock_stop(struct vhost_vsock *vsock)
> +static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>  {
>         size_t i;
> -       int ret;
> +       int ret = 0;
>
>         mutex_lock(&vsock->dev.mutex);
>
> -       ret = vhost_dev_check_owner(&vsock->dev);
> -       if (ret)
> -               goto err;
> +       if (check_owner) {
> +               ret = vhost_dev_check_owner(&vsock->dev);
> +               if (ret)
> +                       goto err;
> +       }
>
>         for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>                 struct vhost_virtqueue *vq = &vsock->vqs[i];
> @@ -753,7 +755,12 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>          * inefficient.  Room for improvement here. */
>         vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
>
> -       vhost_vsock_stop(vsock);
> +       /* Don't check the owner, because we are in the release path, so we
> +        * need to stop the vsock device in any case.
> +        * vhost_vsock_stop() can not fail in this case, so we don't need to
> +        * check the return code.
> +        */
> +       vhost_vsock_stop(vsock, false);
>         vhost_vsock_flush(vsock);
>         vhost_dev_stop(&vsock->dev);
>
> @@ -868,7 +875,7 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>                 if (start)
>                         return vhost_vsock_start(vsock);
>                 else
> -                       return vhost_vsock_stop(vsock);
> +                       return vhost_vsock_stop(vsock, true);
>         case VHOST_GET_FEATURES:
>                 features = VHOST_VSOCK_FEATURES;
>                 if (copy_to_user(argp, &features, sizeof(features)))
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
