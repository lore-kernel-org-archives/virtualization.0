Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DEC433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E4260FC4
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95E4260FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F581401E1;
	Mon,  1 Nov 2021 08:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmR6ixhSXH5s; Mon,  1 Nov 2021 08:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B9074018F;
	Mon,  1 Nov 2021 08:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBF0BC0019;
	Mon,  1 Nov 2021 08:33:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF04EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDB2780B58
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlDoPdrVIJiN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FEF080B3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635755625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=toeYDSFWiKXkiei9uCOEdhzQx66P/uM7vnGVHpw8ifo=;
 b=TL0yGT/1ZWm2cho6AtaqRQtQIi+CJXjPSQMcdvrM4444vXndlnIS5keCTL7xvoYWvqZLYS
 3bZyw+aeDS0nfLr9baj0y8rxej3FyyAQ7Fp4wltWwkD2E1pEwZF/qZBof5NMuDx4GsGOPf
 qfQ4nmd4tuRoiJUbQBylMHYM4YLmMII=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-XfdDPuSGO36jRArpB2KfyQ-1; Mon, 01 Nov 2021 04:33:44 -0400
X-MC-Unique: XfdDPuSGO36jRArpB2KfyQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 d11-20020a50cd4b000000b003da63711a8aso14821072edj.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=toeYDSFWiKXkiei9uCOEdhzQx66P/uM7vnGVHpw8ifo=;
 b=kDDv36XO581Si8UMAAFXqEI2GC1Fm++A+ye4LD+xpz+jSCV4bEhIbfZoVB0PZ5g/N1
 D47kicYRTKeM17/bL9utvG+cm+QvGRvZjLeGVAGkmZ152B7uqlmQ0+mU6tFp7g5jPdOA
 Vy5rFpGue0JSjB36R3TkVi7lMq1MPjnqT30KAnBXU8ns50tyy5SNOYEdAS1ymFN5NODJ
 RnM1Gkd6L7Yjew7qYsIX0sn5NLIU/gKEYhEZiqDaxg2zuUsKtTsWoGmBuF2vK97bYSVL
 jdun/5Hbaivfz6SlHFT80I6NM4C6vrEkBIiz/TBfusc6GhXNO7vYpKD/UwdltZ813tPk
 yMPA==
X-Gm-Message-State: AOAM530ze8QMIkn3dQ8Rmou/6faCInt2lSSFnoZ0AFq/Vn+1pxIIMiLv
 vtlve3JdJSyFcKoj2fhp3KWksnsX5FibOz+bS6AP5I3EIYMFDub8gAzNCCpDxduvvnVUT78o+J2
 QA1I+xMXYMqSJ3lHFrjX3woeZxcHXKB50aKAdbspmSg==
X-Received: by 2002:a17:906:942:: with SMTP id
 j2mr35634474ejd.303.1635755622878; 
 Mon, 01 Nov 2021 01:33:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTzkPQ+eacz/RI1GFZa6zc/IcN7MCLHqRfQeuySwwKpwlSILo0x1E9/oEmkz4/+6j0efB3oA==
X-Received: by 2002:a17:906:942:: with SMTP id
 j2mr35634458ejd.303.1635755622703; 
 Mon, 01 Nov 2021 01:33:42 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id f20sm8849809edf.17.2021.11.01.01.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:33:42 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:33:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 3/3] virtio-net: enable virtio indirect cache
Message-ID: <20211101043229-mutt-send-email-mst@kernel.org>
References: <20211028104919.3393-1-xuanzhuo@linux.alibaba.com>
 <20211028104919.3393-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211028104919.3393-4-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Thu, Oct 28, 2021 at 06:49:19PM +0800, Xuan Zhuo wrote:
> If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> of sgs used for sending packets is greater than 1. We must constantly
> call __kmalloc/kfree to allocate/release desc.
> 
> In the case of extremely fast package delivery, the overhead cannot be
> ignored:
> 
>   27.46%  [kernel]  [k] virtqueue_add
>   16.66%  [kernel]  [k] detach_buf_split
>   16.51%  [kernel]  [k] virtnet_xsk_xmit
>   14.04%  [kernel]  [k] virtqueue_add_outbuf
>    5.18%  [kernel]  [k] __kmalloc
>    4.08%  [kernel]  [k] kfree
>    2.80%  [kernel]  [k] virtqueue_get_buf_ctx
>    2.22%  [kernel]  [k] xsk_tx_peek_desc
>    2.08%  [kernel]  [k] memset_erms
>    0.83%  [kernel]  [k] virtqueue_kick_prepare
>    0.76%  [kernel]  [k] virtnet_xsk_run
>    0.62%  [kernel]  [k] __free_old_xmit_ptr
>    0.60%  [kernel]  [k] vring_map_one_sg
>    0.53%  [kernel]  [k] native_apic_mem_write
>    0.46%  [kernel]  [k] sg_next
>    0.43%  [kernel]  [k] sg_init_table
>    0.41%  [kernel]  [k] kmalloc_slab
> 
> Compared to not using virtio indirect cache, virtio-net can get a 16%
> performance improvement when using indirect desc cache.
> 
> In the test case, the CPU where the package is sent has reached 100%.
> The following are the PPS in two cases:
> 
>     indirect desc cache  | no cache
>     3074658              | 2685132
>     3111866              | 2666118
>     3152527              | 2653632
>     3125867              | 2669820
>     3027147              | 2644464
>     3069211              | 2669777
>     3038522              | 2675645
>     3034507              | 2671302
>     3102257              | 2685504
>     3083712              | 2692800
>     3051771              | 2676928
>     3080684              | 2695040
>     3147816              | 2720876
>     3123887              | 2705492
>     3180963              | 2699520
>     3191579              | 2676480
>     3161670              | 2686272
>     3189768              | 2692588
>     3174272              | 2686692
>     3143434              | 2682416
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4ad25a8b0870..e1ade176ab46 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -31,6 +31,13 @@ module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>  
> +/**
> + * Because virtio desc cache will increase memory overhead, users can turn it
> + * off or select an acceptable value. The maximum value is 2 + MAX_SKB_FRAGS.
> + */

Maybe add code to validate it and cap it at acceptable values then.

> +static u32 virtio_desc_cache_thr = 4;

Wouldn't something like CACHE_LINE_SIZE make more sense here?

> +module_param(virtio_desc_cache_thr, uint, 0644);
> +
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>  #define GOOD_COPY_LEN	128


> @@ -3214,6 +3221,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->curr_queue_pairs = num_online_cpus();
>  	vi->max_queue_pairs = max_queue_pairs;
>  
> +	if (virtio_desc_cache_thr > 2 + MAX_SKB_FRAGS)
> +		virtio_set_desc_cache(vdev, 2 + MAX_SKB_FRAGS);
> +	else
> +		virtio_set_desc_cache(vdev, virtio_desc_cache_thr);
> +
>  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>  	err = init_vqs(vi);
>  	if (err)
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
