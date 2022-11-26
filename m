Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70333C43217
	for <virtualization@archiver.kernel.org>; Sat, 26 Nov 2022 23:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC07B81DE8;
	Sat, 26 Nov 2022 23:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC07B81DE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNJbGEej
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGdXWzCCNxoi; Sat, 26 Nov 2022 23:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FECD81DCB;
	Sat, 26 Nov 2022 23:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FECD81DCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FF25C0032;
	Sat, 26 Nov 2022 23:22:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1420C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Nov 2022 23:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DB9B405D7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Nov 2022 23:22:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DB9B405D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNJbGEej
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dgn_lVmgJvId
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Nov 2022 23:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77D354011C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77D354011C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Nov 2022 23:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669504937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcuOqDLUG//aDYIiQVtJ0uGG3AUcLGhed3fAsyj+39Y=;
 b=jNJbGEejckBcCjZdMPn3G2+AOAy/FHSqc0PQgPMUoF5XXJB+PV9JpESDVSlM187oBdFaO9
 CqXEimIfiAGGQICv7mKwMJt6NFL7BLnWh+1IITeJoe4eXtmgo83ZftVsoADJ4V+/HRGyrs
 qN7Xnl51FoT9yQNSgBp2kmmpRURnwtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-WoDxO1QsPgyFPu_EKNA-Ig-1; Sat, 26 Nov 2022 18:22:15 -0500
X-MC-Unique: WoDxO1QsPgyFPu_EKNA-Ig-1
Received: by mail-wm1-f72.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso6337362wms.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Nov 2022 15:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcuOqDLUG//aDYIiQVtJ0uGG3AUcLGhed3fAsyj+39Y=;
 b=F4Bs61LaECBDM5g9bdC/JaelCf6hGpJma+fiMlvdx5fivYAyiXUxAakCXJzqmjYcqM
 7Ne6vTo8HNmUKQvFKrZ9dKkNcOIcC6nuLd/qF/CMa31ycPHHoeDgTKCw4FqzGEl2N8mY
 +ZRNrclShO5wT52yEk+13qpturkmwqcQyuhEwiyDfcuRjiAE8irlUMMdxQzE63HvQbrl
 +JYW4Nk14Ki0acNBoUXFtlt2jXkvXKtqgXzvcU6acC07mcB4pvUqj1q8WkJ647fC+m5g
 XCCQJNu77UKouSvntQ4fSFGMoQsV8/78z7kAYEJBTts4nsvBmpBcFk2hQqRe2KQtqvxo
 TdCw==
X-Gm-Message-State: ANoB5plWr2VIL0BmujRBv1MmWsFlBSAHt6WgvPgbPAYMFRXGYPM1CXdA
 Wf79PPiFey+2RiGRLsCKeez8UO17OJ58N2FrQu67GuTCUvfAXaBSMQGlYzwG7iMAnN2q0H3WLaE
 SIrN00Os48BWX6vOlHLOpGNQKjVmvN1H/B1vCju5GRw==
X-Received: by 2002:adf:e7c7:0:b0:241:ca33:a188 with SMTP id
 e7-20020adfe7c7000000b00241ca33a188mr17403400wrn.559.1669504934271; 
 Sat, 26 Nov 2022 15:22:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6AGVUQP9IX9nrjgocQ9WJdTNyBicSL0dD2H1r/aRWNPERU9L8fNUx9OHN+C8Tdl1ndMAYlCg==
X-Received: by 2002:adf:e7c7:0:b0:241:ca33:a188 with SMTP id
 e7-20020adfe7c7000000b00241ca33a188mr17403389wrn.559.1669504934050; 
 Sat, 26 Nov 2022 15:22:14 -0800 (PST)
Received: from redhat.com ([2.52.135.58]) by smtp.gmail.com with ESMTPSA id
 q10-20020a05600c46ca00b003c6bd91caa5sm11044655wmo.17.2022.11.26.15.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Nov 2022 15:22:13 -0800 (PST)
Date: Sat, 26 Nov 2022 18:22:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <20221126181822-mutt-send-email-mst@kernel.org>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Guanjun <guanjun@linux.alibaba.com>, error27@gmail.com,
 harshit.m.mogalapalli@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
> As 'dev->vq_num' is user-controlled data, if user tries to allocate
> memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
> creates a stack trace and messes up dmesg with a warning.
> 
> Call trace:
> -> vduse_ioctl
> --> vduse_create_dev
> 'config->vq_num' is user data as it comes from ioctl, which is
> assigned to 'dev->vq_num'.
> 
> Add __GFP_NOWARN in order to avoid too large allocation warning.
> This is detected by static analysis using smatch.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..5e9546b16165 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->config_size = config->config_size;
>  	dev->vq_align = config->vq_align;
>  	dev->vq_num = config->vq_num;
> -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
> +			   GFP_KERNEL | __GFP_NOWARN);
>  	if (!dev->vqs)
>  		goto err_vqs;

This is insufficient - the real source of the problem is that
vq_num is not validated.
The thing to do is to validate config and limit vq_num to 0xffff;


> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
