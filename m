Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1124C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B04F610CB
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B04F610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2254D60BC7;
	Tue,  7 Sep 2021 09:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWHykah_TjIG; Tue,  7 Sep 2021 09:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C7DD60BA3;
	Tue,  7 Sep 2021 09:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 249A1C0011;
	Tue,  7 Sep 2021 09:06:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6739C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C842E40536
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUUGKUiJqJ-f
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 254DE403F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631005611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AoarMMFjAAFuhEbXWQAnXoDm5tBdzybtqAeK/tkz6ls=;
 b=bjb5UyguqB9nCsxv5UHKGKje3wLZGqWePFpEixmUyYWwqXa7hQS0eSP/Dc3J/tk/7SAwPX
 TgsOnZCM/N70sGHHqZ6+B2nah6KWCUueu/BxtEj7eheiCOU1Q+u5pa5KVGhk7TwaXDG/mo
 uS5xFwViEv2aXFYXx1JLG5UT35HIFGw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-PvAGO__APYe5Jc9uQntsgw-1; Tue, 07 Sep 2021 05:06:48 -0400
X-MC-Unique: PvAGO__APYe5Jc9uQntsgw-1
Received: by mail-lj1-f199.google.com with SMTP id
 c16-20020a2e89d0000000b001d018ef42aaso4469827ljk.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Sep 2021 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AoarMMFjAAFuhEbXWQAnXoDm5tBdzybtqAeK/tkz6ls=;
 b=X3rQtZh43DdJeJQfVLavqklYS4LfUXjPTvizmqZA7v69ilHi3kzq+f8Qa6CluIsnrv
 xAG/mlml/D5ySr+j8Al01PBDxLJP69T4ouePP1KEq3qPxlqy1fV1HJPUEucm7Aaql63v
 GWPqN2A9UNdMlE2w+GBY074ZCKsQh0x7RRXcz5edM6FP1KMTMdIFrYUEAdo/ovyXtaOP
 DHrgBIih6/7BP4aQoN/g2ra2EXNSUKDq7RN5UKMHLENooTM3XpNCCNNHw8EvHSNpbZtz
 OydBvKUn6ZVH5aOAPVU695Mbfk0S9FQgDItikJ+cyed7nOaFjeCjJgx9oWTASqeKjdbR
 lzGw==
X-Gm-Message-State: AOAM533BmskwbEgikI9SZTk6vA2Yn7GmFW2WlgEgHiDVszK3Twzs/0D+
 q2FmEmbWSlAg4po7fy54NXfwsTiO6hIgCBbY2GsUa47nxVlhZbN6RpKBWkTXNy7b90wn67EIitU
 fcWAWL0F2S4dzaic//UqXZLEVY81NaqWcXOyQrgZJl4rL6/bWMfo39Kxnbg==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13880499ljc.277.1631005606417; 
 Tue, 07 Sep 2021 02:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEm+i4T+mdnjA50nS9WOjbAHu2OMjLubqpcwKwXTCbLGnGaWLWifUJq7PrZixyZ7smT5mY1EMNZu4R1wc9mNw=
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13880490ljc.277.1631005606239; 
 Tue, 07 Sep 2021 02:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210907073223.GA18254@kili>
In-Reply-To: <20210907073223.GA18254@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Sep 2021 17:06:35 +0800
Message-ID: <CACGkMEtziWuAF_iTqpL3SmgmM4TuELijMvRGMb0n+y9gpqV_=w@mail.gmail.com>
Subject: Re: [PATCH] vduse: missing error code in vduse_init()
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xie Yongji <xieyongji@bytedance.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kernel-janitors@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Sep 7, 2021 at 3:32 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This should return -ENOMEM if alloc_workqueue() fails.  Currently it
> returns success.
>
> Fixes: b66219796563 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 5c25ff6483ad..fcd7de8dd1f2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1593,8 +1593,10 @@ static int vduse_init(void)
>
>         vduse_irq_wq = alloc_workqueue("vduse-irq",
>                                 WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
> -       if (!vduse_irq_wq)
> +       if (!vduse_irq_wq) {
> +               ret = -ENOMEM;
>                 goto err_wq;
> +       }
>
>         ret = vduse_domain_init();
>         if (ret)
> --
> 2.20.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
