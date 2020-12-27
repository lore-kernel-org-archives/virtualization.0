Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C847C433DB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 09:39:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0739207AB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0739207AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 30ACA204D7;
	Sun, 27 Dec 2020 09:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D9rWWxrHMQMo; Sun, 27 Dec 2020 09:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 101E620020;
	Sun, 27 Dec 2020 09:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E67D1C1787;
	Sun, 27 Dec 2020 09:39:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5381BC0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 09:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2993F204D2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 09:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNQugyEytffl
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 09:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C72B120020
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609061993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDEqYZRZclqBhMldoq9bY6xgs7Lh4HmudHFX/7CD63k=;
 b=Xg0MTzu0OkTDG5MebEuND3HUhiKzJm2dbqYEV65q9qPzVpqwR/wCVNecYOze8pAMYGHXK6
 +zhdVtaPO3HCmT2zKAWB6rKdDL9FEyDBLHcPpMltlcT08PPFUvHo7qyf1WulkzKEv77zIJ
 7GigvMtouHmXmmW83EOClh5q886nlQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-P0f9_okhMkKGZHBvD0jtVg-1; Sun, 27 Dec 2020 04:39:51 -0500
X-MC-Unique: P0f9_okhMkKGZHBvD0jtVg-1
Received: by mail-wm1-f70.google.com with SMTP id k67so5385246wmk.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 01:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SDEqYZRZclqBhMldoq9bY6xgs7Lh4HmudHFX/7CD63k=;
 b=sCakmhdTI7i0Q/8uYuKsHPF6RhoviaVA2xpGOsfj6bvMZPtVHPN+tb9YR/jifSqBNm
 +YBs/L7Py96AMEUVrqPUg/POPaODjaIwdx4RaIVANiVxDcRa7DcgNQaVE+UutkjVdplR
 /98CQcV1boR48C7XayurEf/ttbf5MUDpqe0+Qc8gT9hYFjofywZl/SVGOyEgXynZS7Fl
 nhqTc82LMfoXx+Y2CFvW/cl8Ofp1DEvGVVdStjN4rd7Mm/0ntlvhr128UeGaNeidM38Z
 7MFQSJ/tFEkJ3QJDaM4nySHCgr9QkSZ0ejIYD3WKFEqpkTdGq3q5tCOI2xESC6YKRE8B
 6h1w==
X-Gm-Message-State: AOAM5315iKGfhCWOTiK1uPSjqd0Qu78VpaUCjdL4wd2xdHDg4n1gQWxA
 7H5y+C4lhNHiUf4jR81keLWr4q2KIGcXaZnJfhtqFNwNJ3LhAXQJWDoPzV7RIkWzZyaLbiuz8W5
 WDm2ikHsrO+WUIBHIXFU4qy9ZumqtvpRDBGNTVKoOfw==
X-Received: by 2002:a1c:7d88:: with SMTP id
 y130mr15488444wmc.158.1609061990188; 
 Sun, 27 Dec 2020 01:39:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyGtuwxz5HGvWvcbVAvqWIfomIkgczDaTC3a9t3mqTRPR8mdFVT51IpWw97J793o5pGcfjMQ==
X-Received: by 2002:a1c:7d88:: with SMTP id
 y130mr15488419wmc.158.1609061989905; 
 Sun, 27 Dec 2020 01:39:49 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id j7sm14708444wmb.40.2020.12.27.01.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 01:39:48 -0800 (PST)
Date: Sun, 27 Dec 2020 04:39:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net] tun: fix return value when the number of iovs
 exceeds MAX_SKB_FRAGS
Message-ID: <20201227043940-mutt-send-email-mst@kernel.org>
References: <1608810533-8308-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1608810533-8308-1-git-send-email-wangyunjian@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 jerry.lilijun@huawei.com, virtualization@lists.linux-foundation.org,
 xudingke@huawei.com, brian.huangbin@huawei.com, chenchanghu@huawei.com
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

On Thu, Dec 24, 2020 at 07:48:53PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently the tun_napi_alloc_frags() function returns -ENOMEM when the
> number of iovs exceeds MAX_SKB_FRAGS + 1. However this is inappropriate,
> we should use -EMSGSIZE instead of -ENOMEM.
> 
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 2dc1988a8973..15c6dd7fb04c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1365,7 +1365,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
>  	int i;
>  
>  	if (it->nr_segs > MAX_SKB_FRAGS + 1)
> -		return ERR_PTR(-ENOMEM);
> +		return ERR_PTR(-EMSGSIZE);
>  
>  	local_bh_disable();
>  	skb = napi_get_frags(&tfile->napi);
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
