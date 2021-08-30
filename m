Return-Path: <SRS0=/Kss=NV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE0C432BE
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:10:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4475460FA0
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4475460FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04EE2400EE;
	Mon, 30 Aug 2021 21:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imLD3NbWiKYN; Mon, 30 Aug 2021 21:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F44D400DD;
	Mon, 30 Aug 2021 21:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5206CC0010;
	Mon, 30 Aug 2021 21:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4F88C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B854F80E4E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ncQAzWJ05feO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:10:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 202A680E2F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630357820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+618f6pIQ7QqyteZqRd+k8qoLUdo13s2E6E3MFo9/Y=;
 b=NBR8UifYubAHdJHB6EXmwlNxVjMKQkQZHD9XJ4wYjvp0rHMxjAfTQAP+yKJxE8Kef9PY0b
 8GCuFiWuzaNiheprjcJtK9VlQ/5X/JVkmc0cRFo9DLZIOa0UOOKY6BAo2A6IldcOsNYMP9
 plvRgjplpqeNTciVM+R113TksoBGH2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-8xd2eTK-PuiMmVfXvtoe8A-1; Mon, 30 Aug 2021 17:10:19 -0400
X-MC-Unique: 8xd2eTK-PuiMmVfXvtoe8A-1
Received: by mail-wm1-f69.google.com with SMTP id
 f17-20020a05600c155100b002f05f30ff03so259228wmg.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H+618f6pIQ7QqyteZqRd+k8qoLUdo13s2E6E3MFo9/Y=;
 b=Oqj6DW0CmooZSZcWA+a9SQ5lbIDBet0/HLhsm68z/kcCGwcqONFzeuikxLJRKIBrth
 TObIWhPAs2PyjFGoyxbAfJBd6Yabt6Ht8kD93yz4pSBfuz5BLA/TpDQb8cQaT8Hp7tLD
 VRt9Ct53vnJLr3FJxU6KIrbwm5CioqXaI4lqw/RSi5aR9KWaWktN3a74xYzStnP+ttRq
 L6nzrGighaQAx3I2SwcJQRl42KiSlKf+KJUNVdtIzf6V5qRpT3hcn2YfWzCHpgDmpKZP
 iiNAi2m1BTub8rSfpCh8F7CsMxzsAj03yKFG2k6jP4GXToqsKr6Dv206GFQDIpUNjFyT
 JMsA==
X-Gm-Message-State: AOAM530TQ2GGHl58CEsANT/C5N5RHbp3oxOb77TjOH1L35CRWWAGDt73
 vBnNgo6oR/DBbkMFphp4fVQwdUJe0yPKeEDcYQK7MPdxdL4Wbha+YTw80IdGT0RuR0aDOIbjDOA
 BSyv8XXCT2LwpYsyrEcNPRI5MMCUSiBDQyRa9ypb7tw==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr933898wma.94.1630357817835;
 Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCALB10bxh63E5WvwArTBCCDlGaCHtgsikTuncNYNnIlBrCWXTlsk5nCq4LlIE12ZJaPWdQQ==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr933890wma.94.1630357817655;
 Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id g138sm601124wmg.34.2021.08.30.14.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
Date: Mon, 30 Aug 2021 17:10:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] virtio_net: reduce raw_smp_processor_id() calling in
 virtnet_xdp_get_sq
Message-ID: <20210830170837-mutt-send-email-mst@kernel.org>
References: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
In-Reply-To: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Aug 26, 2021 at 04:21:35PM +0800, Li RongQing wrote:
> smp_processor_id()/raw* will be called once each when not
> more queues in virtnet_xdp_get_sq() which is called in
> non-preemptible context, so it's safe to call the function
> smp_processor_id() once.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

commit log should probably explain why it's a good idea
to replace raw_smp_processor_id with smp_processor_id
in the case of curr_queue_pairs <= nr_cpu_ids.

> ---
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2e42210a6503..2a7b368c1da2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -528,19 +528,20 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>   * functions to perfectly solve these three problems at the same time.
>   */
>  #define virtnet_xdp_get_sq(vi) ({                                       \
> +	int cpu = smp_processor_id();                                   \
>  	struct netdev_queue *txq;                                       \
>  	typeof(vi) v = (vi);                                            \
>  	unsigned int qp;                                                \
>  									\
>  	if (v->curr_queue_pairs > nr_cpu_ids) {                         \
>  		qp = v->curr_queue_pairs - v->xdp_queue_pairs;          \
> -		qp += smp_processor_id();                               \
> +		qp += cpu;                                              \
>  		txq = netdev_get_tx_queue(v->dev, qp);                  \
>  		__netif_tx_acquire(txq);                                \
>  	} else {                                                        \
> -		qp = smp_processor_id() % v->curr_queue_pairs;          \
> +		qp = cpu % v->curr_queue_pairs;                         \
>  		txq = netdev_get_tx_queue(v->dev, qp);                  \
> -		__netif_tx_lock(txq, raw_smp_processor_id());           \
> +		__netif_tx_lock(txq, cpu);                              \
>  	}                                                               \
>  	v->sq + qp;                                                     \
>  })
> -- 
> 2.33.0.69.gc420321.dirty
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
