Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC24FCDB47E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 319AA40979;
	Thu, 12 Oct 2023 09:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 319AA40979
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ne5qx6cJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uj4tBFb99aIa; Thu, 12 Oct 2023 09:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38065405FA;
	Thu, 12 Oct 2023 09:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38065405FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0553DC0071;
	Thu, 12 Oct 2023 09:16:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 528BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1912040996
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1912040996
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ne5qx6cJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQaxi8Ede0bb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:16:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6DC7408BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6DC7408BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697102159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4eIreTvOrPbXoRX8kLZoDSLvSMGfzMrvC2GtND0F9cA=;
 b=Ne5qx6cJsBNHKMzQeTWtxxeXW+EqVWd4EkzUlLaKRorIPK8Feg9examl69LVFVlTw88inC
 HCwFbSZUtsCJb+5bjrR+v5ABfd/nyeB5kS6z8T3Af78AVQCZJQuLrgflwHekPFOCSpkkle
 pZ8r7rH9xw7DwEbAlO6Bbddbw/6McEA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-W8mx8wtSPkSCEierixTZbA-1; Thu, 12 Oct 2023 05:15:58 -0400
X-MC-Unique: W8mx8wtSPkSCEierixTZbA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-327b5f2235aso550648f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697102157; x=1697706957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eIreTvOrPbXoRX8kLZoDSLvSMGfzMrvC2GtND0F9cA=;
 b=WMSxj35k4DCTBlgU18H6tnuDoN29EfzBidPEm9vL89S5DgAhLNU5UTfdRkAuiE1sBx
 SDksgPzhwdC3KyY4idIiAP5RnP7mmk2GMhsS+i9fihCb3JpEu7p8lcSkGnO2iaIR7PxR
 aVKP2aBM68ahWGrjOpiMJSyTfnjJ3wQHrlFLsInNcaIV5fu4D+Kgr8GZJCbGb8GeeZF8
 b224jfGdiQorv+3RTfeB3js6prPlwJwpEEIz/nDOXBZRWGRFYU/dLpvIxvHudAZ+FPso
 sZYSlAF4KUjvRqdodEcQ/yddKND/NZBLixGHrPl4wJoLzs17QCZZJiMscWynL/BrZjsG
 jA4g==
X-Gm-Message-State: AOJu0YwRf+Gj0l1C2vzzjj9MHLTlW+rC/bDCsSmcr7Gl1HeBQLwDAL4Z
 AJu0hP35wATex/kvcBhljIHmKViQegi5ipvzuTm7YxFXYR9y5s1EsijCRVsXPeszmqdYwocTR/j
 sH0WQ/nFj0l+waVZ8IqfyVHETHOkPSvhGZoLR+T2y4w==
X-Received: by 2002:a05:6000:790:b0:32c:af13:9084 with SMTP id
 bu16-20020a056000079000b0032caf139084mr5909609wrb.22.1697102157227; 
 Thu, 12 Oct 2023 02:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7rlxuZwEbkVYUGkhTv9pQBj6vyLGx+IlgJ2DB/HwhEWz42oWGHfUHsA+i3qGbwFoJtnbzXA==
X-Received: by 2002:a05:6000:790:b0:32c:af13:9084 with SMTP id
 bu16-20020a056000079000b0032caf139084mr5909588wrb.22.1697102156824; 
 Thu, 12 Oct 2023 02:15:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a7bc7d3000000b0040641a9d49bsm18663377wmk.17.2023.10.12.02.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:15:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:15:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <20231012051416-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> virtqueue_set_dma_premapped() adds a new parameter to disable the
> virtqueue premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c     |  2 +-
>  drivers/virtio/virtio_ring.c | 11 ++++++++---
>  include/linux/virtio.h       |  2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fe7f314d65c9..6b5f47ebf9b2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  		return;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
>  			continue;
>  
>  		vi->rq[i].do_dma = true;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..b3ded56722f4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * 0: success.
>   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
>   */
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u32 num;
> @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  		return -EINVAL;
>  	}
>  
> -	vq->premapped = true;
> -	vq->do_unmap = false;
> +	if (mode) {
> +		vq->premapped = true;
> +		vq->do_unmap = false;
> +	} else {
> +		vq->premapped = false;
> +		vq->do_unmap = vq->use_dma_api;
> +	}
>  
>  	END_USE(vq);
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 4cc614a38376..1cf7b004348b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
>  
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>  
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
>  
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);

Wait a sec I thought we never change premapped. If you make this
dynamic don't you need a bunch of locking?
Or maybe queue is empty when you change this?
If yes pls add a bunch of BUG_ON checks to make sure this is not misused.


> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
