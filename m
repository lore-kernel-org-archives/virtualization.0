Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E281C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23B6E40144;
	Wed,  8 Dec 2021 03:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYKpKGnquEpr; Wed,  8 Dec 2021 03:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83818400C7;
	Wed,  8 Dec 2021 03:53:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 565EAC001E;
	Wed,  8 Dec 2021 03:53:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE744C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 889F34039D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xPX-XkQZaR-T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:53:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF33940399
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638935612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOGUSg+aOJCzmwo8dIHGYiLzdHu5aPtq0xbe2hxL/jw=;
 b=bHn6th3SicYnGK1jRP0D6Ekq8mQmS474PMr10ypIn9qAqihjU0r8dG5B2Rtfa7aLoEgr66
 K5xAC6WbLNF3qMIrycZuitjRP77jf7AnwZoXUrGnN6YDyKnINDiZQrtA7rETIcsy5ElJTJ
 Aoc9Y9O80hgpNGk9cjjGKLI3qjtJPpE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-CpDg1bGfNK-IUWyDi9DEcA-1; Tue, 07 Dec 2021 22:53:31 -0500
X-MC-Unique: CpDg1bGfNK-IUWyDi9DEcA-1
Received: by mail-lf1-f71.google.com with SMTP id
 h40-20020a0565123ca800b00402514d959fso516992lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOGUSg+aOJCzmwo8dIHGYiLzdHu5aPtq0xbe2hxL/jw=;
 b=Gy6GH2Xr2soPhNVaszX2SHT2/e2Ccts78ZJ2v0wjP6r9ezpeZ3cTkYhdHs/0iaGvq5
 uEy8xfPO36zdb+bedZ5nPsAokWYQVUPSaCJItvusTrqVWpsTHqwOziNtiSpn+NzAjZC+
 d4hGe20q0+QHOaSe+1fRP0r1ooumXRsI0p+V6AwlKszGXPik27+hJWSkxw570APyTOPP
 vbIOBm5LsxSHHiO8MynrS5UXrQHNA1VlBLixnK+BvTkXfTnmjgO9QWdcQaFhTA6m87OB
 TiIWQ/UNHB5RsZsbq7Cd96S85caFLJizfqHnuEE8vkgPg7x/6iAMme6A+Veg+qq3YqXC
 DXeQ==
X-Gm-Message-State: AOAM532ywXvn71LD5St85dkDj4M/XzJEVB7bCdqi8Tp48A72Se9uQdaR
 e2RSt42dY1Zc/NHUvwbObuA0GscQF7pJM1+EhCLBAVc/Ihr4rIC8JqA4/7GKtdYz3HvfN31kZ+M
 jG6KjKpzxlAAkl26dLhv0hZJLbcqiIYvZX9GJD3y/SIhCfyk9J/j4mLNhYQ==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr46061094ljp.362.1638935609737; 
 Tue, 07 Dec 2021 19:53:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyACXL2rAFfitX0Ba+iD2y3UF6mlxX8D2gIkPvQFQZkJF8vr+lb+hfF2tdc/G5JogOC5NszDfyyJkiSYaSp0M=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr46061072ljp.362.1638935609452; 
 Tue, 07 Dec 2021 19:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-6-michael.christie@oracle.com>
In-Reply-To: <20211207024510.23292-6-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:53:18 +0800
Message-ID: <CACGkMEu20xRvunwv=h-rWhRcnmmn4rDPqp1uMKMSBrZrtixu9w@mail.gmail.com>
Subject: Re: [PATCH 5/7] vhost_vsock: simplify vhost_vsock_flush()
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> From: Andrey Ryabinin <arbn@yandex-team.com>
>
> vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
> before vhost_work_dev_flush(&vsock->dev). This seems pointless
> as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
> in a row doesn't do anything useful, one is just enough.
>
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vsock.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 2339587bcd31..1f38160b249d 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -703,11 +703,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
>  static void vhost_vsock_flush(struct vhost_vsock *vsock)
>  {
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> -               if (vsock->vqs[i].handle_kick)
> -                       vhost_work_dev_flush(vsock->vqs[i].poll.dev);
>         vhost_work_dev_flush(&vsock->dev);
>  }

Is this better to be consistent with vhost-net so that we can simply
remove the vhost_vsock_flush() wrapper here.

Thanks

>
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
