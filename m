Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6806C433E6
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:12:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD3E64DAF
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD3E64DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DEC01868D2;
	Tue,  2 Feb 2021 23:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPifxZwvRv4h; Tue,  2 Feb 2021 23:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E377184E66;
	Tue,  2 Feb 2021 23:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3B07C0FA7;
	Tue,  2 Feb 2021 23:12:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD78C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 533DD85359
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wl3nb1tzAUt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2867285085
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612307520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p990RZMi8C61rNselXGUhwIY4CsNl6vMdGACytrGF44=;
 b=IxxOvpDvWKHf52hs2fWvV15gMWpcGgsYtKsOoMDQAv5tYcb2Pd7tXMiB9zTGSCgE0lVnyd
 bKZXbsmyKlloVOYphCTRBIBeZdInRlY3z50NBX1P2kMAiSpqXK4DKref0mclBakORUwRJ+
 pXTkY68HNpzUnZsV+FBTsCCs8Z1ww0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-AO9-o3vSPhGHDQfRsD-xMw-1; Tue, 02 Feb 2021 18:11:58 -0500
X-MC-Unique: AO9-o3vSPhGHDQfRsD-xMw-1
Received: by mail-wm1-f70.google.com with SMTP id u15so509076wmj.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 15:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p990RZMi8C61rNselXGUhwIY4CsNl6vMdGACytrGF44=;
 b=pQcoiwpYOkktgkCG3Qty9UNpakxVhBLkzDTCj5TxSQtcIOlMnI34P2leN4LBzanQ2T
 WzU2oUhKzJq22UTnfihoLpwH4FrApjY8b5Xj+gi7WjkXDQXlNxdaJGi0Un66Fy1Q8sYL
 lgkYvUd0xExrEAAlTnrDRCx36ewbDZAJfhCQ79WrcZGfMyhNYTuKjuIUwGFlPiU3vo/L
 cpaxEQmixNZALR3Gj45stonE/3LD3YJyAmn2zo+RTp56kWgQecJGWgd+/cE3x8IggjV8
 EnwGYTGl9Tc+u8pjAmNDWVhNGWFLWbA6By64bykUEd2YhKPn4mB946lWeH0h5yx5bxLr
 Fu/g==
X-Gm-Message-State: AOAM533vfUkTKji81newYjdF8jGU+WjAN5BxQJMXS7JBN21+AY9ElJAO
 vGjsc6RAaNpkhQWBiy7KmTky/+uChJ+ArUiJPY5ZNjDE/WykZsTrvbtoAT7kTwlf9oAL5488Ugu
 zH35QmNXU6sn1cdo+U1n2jyW9lqUZWoc+u0hNeEjksQ==
X-Received: by 2002:a1c:6602:: with SMTP id a2mr272108wmc.74.1612307517584;
 Tue, 02 Feb 2021 15:11:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5PAplDAsbPdIMbTXF8udNdAvRTiXJ/fkDLcpjYpRjHB4MQwPRwuGC1G/4OqNgJfEKU8YTzw==
X-Received: by 2002:a1c:6602:: with SMTP id a2mr272088wmc.74.1612307517225;
 Tue, 02 Feb 2021 15:11:57 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id n15sm212671wrx.2.2021.02.02.15.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 15:11:56 -0800 (PST)
Date: Tue, 2 Feb 2021 18:11:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210202180807-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
MIME-Version: 1.0
In-Reply-To: <20210129002136.70865-1-weiwan@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> With the implementation of napi-tx in virtio driver, we clean tx
> descriptors from rx napi handler, for the purpose of reducing tx
> complete interrupts. But this could introduce a race where tx complete
> interrupt has been raised, but the handler found there is no work to do
> because we have done the work in the previous rx interrupt handler.
> This could lead to the following warning msg:
> [ 3588.010778] irq 38: nobody cared (try booting with the
> "irqpoll" option)
> [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> 5.3.0-19-generic #20~18.04.2-Ubuntu
> [ 3588.017940] Call Trace:
> [ 3588.017942]  <IRQ>
> [ 3588.017951]  dump_stack+0x63/0x85
> [ 3588.017953]  __report_bad_irq+0x35/0xc0
> [ 3588.017955]  note_interrupt+0x24b/0x2a0
> [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> [ 3588.017957]  handle_irq_event+0x3b/0x60
> [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> [ 3588.017961]  handle_irq+0x20/0x30
> [ 3588.017964]  do_IRQ+0x50/0xe0
> [ 3588.017966]  common_interrupt+0xf/0xf
> [ 3588.017966]  </IRQ>
> [ 3588.017989] handlers:
> [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> [ 3588.025099] Disabling IRQ #38
> 
> This patch adds a new param to struct vring_virtqueue, and we set it for
> tx virtqueues if napi-tx is enabled, to suppress the warning in such
> case.
> 
> Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> Reported-by: Rick Jones <jonesrick@google.com>
> Signed-off-by: Wei Wang <weiwan@google.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>


This description does not make sense to me.

irq X: nobody cared
only triggers after an interrupt is unhandled repeatedly.

So something causes a storm of useless tx interrupts here.

Let's find out what it was please. What you are doing is
just preventing linux from complaining.



> ---
>  drivers/net/virtio_net.c     | 19 ++++++++++++++-----
>  drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 508408fbe78f..e9a3f30864e8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1303,13 +1303,22 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>  		return;
>  	}
>  
> +	/* With napi_tx enabled, free_old_xmit_skbs() could be called from
> +	 * rx napi handler. Set work_steal to suppress bad irq warning for
> +	 * IRQ_NONE case from tx complete interrupt handler.
> +	 */
> +	virtqueue_set_work_steal(vq, true);
> +
>  	return virtnet_napi_enable(vq, napi);
>  }
>  
> -static void virtnet_napi_tx_disable(struct napi_struct *napi)
> +static void virtnet_napi_tx_disable(struct virtqueue *vq,
> +				    struct napi_struct *napi)
>  {
> -	if (napi->weight)
> +	if (napi->weight) {
>  		napi_disable(napi);
> +		virtqueue_set_work_steal(vq, false);
> +	}
>  }
>  
>  static void refill_work(struct work_struct *work)
> @@ -1835,7 +1844,7 @@ static int virtnet_close(struct net_device *dev)
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
>  		napi_disable(&vi->rq[i].napi);
> -		virtnet_napi_tx_disable(&vi->sq[i].napi);
> +		virtnet_napi_tx_disable(vi->sq[i].vq, &vi->sq[i].napi);
>  	}
>  
>  	return 0;
> @@ -2315,7 +2324,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	if (netif_running(vi->dev)) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
>  			napi_disable(&vi->rq[i].napi);
> -			virtnet_napi_tx_disable(&vi->sq[i].napi);
> +			virtnet_napi_tx_disable(vi->sq[i].vq, &vi->sq[i].napi);
>  		}
>  	}
>  }
> @@ -2440,7 +2449,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (netif_running(dev)) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
>  			napi_disable(&vi->rq[i].napi);
> -			virtnet_napi_tx_disable(&vi->sq[i].napi);
> +			virtnet_napi_tx_disable(vi->sq[i].vq, &vi->sq[i].napi);
>  		}
>  	}
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..f7c5d697c302 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -105,6 +105,9 @@ struct vring_virtqueue {
>  	/* Host publishes avail event idx */
>  	bool event;
>  
> +	/* Tx side napi work could be done from rx side. */
> +	bool work_steal;
> +
>  	/* Head of free buffer list. */
>  	unsigned int free_head;
>  	/* Number we've added since last sync. */
> @@ -1604,6 +1607,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
> +	vq->work_steal = false;
>  	vq->last_used_idx = 0;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
> @@ -2038,6 +2042,9 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  
>  	if (!more_used(vq)) {
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
> +		if (vq->work_steal)
> +			return IRQ_HANDLED;
> +
>  		return IRQ_NONE;
>  	}
>  
> @@ -2082,6 +2089,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
> +	vq->work_steal = false;
>  	vq->last_used_idx = 0;
>  	vq->num_added = 0;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
> @@ -2266,6 +2274,14 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>  
> +void virtqueue_set_work_steal(struct virtqueue *_vq, bool val)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	vq->work_steal = val;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_work_steal);
> +
>  /*
>   * This should prevent the device from being used, allowing drivers to
>   * recover.  You may need to grab appropriate locks to flush.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 55ea329fe72a..091c30f21ff9 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -84,6 +84,8 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>  
>  bool virtqueue_is_broken(struct virtqueue *vq);
>  
> +void virtqueue_set_work_steal(struct virtqueue *vq, bool val);
> +
>  const struct vring *virtqueue_get_vring(struct virtqueue *vq);
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>  dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> -- 
> 2.30.0.365.g02bc693789-goog
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
