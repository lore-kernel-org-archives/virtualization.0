Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E26C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:45:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43A56522B
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43A56522B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D18F430F0;
	Tue,  9 Mar 2021 16:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MkGXlmf_-hY; Tue,  9 Mar 2021 16:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 181AA42FC7;
	Tue,  9 Mar 2021 16:45:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3D05C000A;
	Tue,  9 Mar 2021 16:45:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BDE4C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C7498343E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hn_6VrHS0410
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 479B5834F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615308300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0t5dSOlFZ6XJHB7xTjhGoaH0EPo/Mqai/3gxv2Ga2jc=;
 b=cxOr21H8Vy40xBo4g3CQQekJlAaJ63OPWLSzTALX+EwvxM7X+EmKBD1pti6afXLWshHr2G
 eUGae2TLv+De+UCXhMt9L+lSPKiu4TCXDzCV6EtWOENaHNP5wHZ09AIqp7Mwg6ARXG1rOk
 T2gc8WsctiwZTxr15Jf7w28EdcLzyyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-cRVvMA0ZNPadYfBcRXoqNA-1; Tue, 09 Mar 2021 11:44:58 -0500
X-MC-Unique: cRVvMA0ZNPadYfBcRXoqNA-1
Received: by mail-wm1-f70.google.com with SMTP id n25so1402875wmk.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 08:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0t5dSOlFZ6XJHB7xTjhGoaH0EPo/Mqai/3gxv2Ga2jc=;
 b=B5TdCLpWF9oXshAdH+M3/6ADtjWjuiPc6ofgkH3UCouF0ktrPQcyfon5hKfQZgo767
 WkknB8kVPfVbHXuZy2zun6vfTM9toXofofRO5Mf7qaYwJhwSYKaeYHjOlRxMvARISvgh
 VTZscdgh0SkGUjJaTGtA/rJMszdRl1eZUD0RaZxA1ifGpyT53KFq/fb4hkcOfCWDUp+l
 o6NAAmd2BR5oiKviejmlCBYyjt7umfGfglbq5GtnSfZul3yvkQAD6YREP6WQbLu8Uau7
 epDWmnGh/xfX6F3jIPPGfhkaX/31ldfd8hwmfJL4g5DWpLe0LXMbrk8zz0T6bcN68OtO
 o6AA==
X-Gm-Message-State: AOAM531HCkYMX1kOr2626lK8V9XW5QIxPQHbIVsZGb4B44HWQ+BllMme
 1krNSPu5q8Ig2VBCcEo6aSl7X+sDZdV9SfcG8An8FCkq0PL85jnha+jVHn/6F3LX/OBpGK+o3bd
 m952YhFaImhvK9av0lGuZkz3aI7/ghjDWUxsDB3zqzQ==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr5108451wmc.65.1615308297062; 
 Tue, 09 Mar 2021 08:44:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaqBkJU5ukKyHbtDYPpJxO5IR9Tsn2DLBviTKoOgJV4g2zus/4Snqc/QDe8GnDpiZGk0yIQQ==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr5108433wmc.65.1615308296873; 
 Tue, 09 Mar 2021 08:44:56 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id u3sm24780940wrt.82.2021.03.09.08.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 08:44:56 -0800 (PST)
Date: Tue, 9 Mar 2021 11:44:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 net-next] virtio-net: support XDP when not more queues
Message-ID: <20210309114315-mutt-send-email-mst@kernel.org>
References: <1615193536-112130-1-git-send-email-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1615193536-112130-1-git-send-email-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Mon, Mar 08, 2021 at 04:52:16PM +0800, Xuan Zhuo wrote:
> The number of queues implemented by many virtio backends is limited,
> especially some machines have a large number of CPUs. In this case, it
> is often impossible to allocate a separate queue for
> XDP_TX/XDP_REDIRECT, then xdp cannot be loaded to work, even xdp does
> not use the XDP_TX/XDP_REDIRECT.
> 
> This patch allows XDP_TX/XDP_REDIRECT to run by reuse the existing SQ
> with __netif_tx_lock() hold when there are not enough queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
> v7: 1. use macros to implement get/put
>     2. remove 'flag'. (suggested by Jason Wang)
> 
> v6: 1. use __netif_tx_acquire()/__netif_tx_release(). (suggested by Jason Wang)
>     2. add note for why not lock. (suggested by Jason Wang)
>     3. Use variable 'flag' to record with or without locked.  It is not safe to
>        use curr_queue_pairs in "virtnet_put_xdp_sq", because it may changed after
>        "virtnet_get_xdp_sq".
> 
> v5: change subject from 'support XDP_TX when not more queues'
> 
> v4: make sparse happy
>     suggested by Jakub Kicinski
> 
> v3: add warning when no more queues
>     suggested by Jesper Dangaard Brouer
> 
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba8e637..5ce40ec 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -195,6 +195,9 @@ struct virtnet_info {
>  	/* # of XDP queue pairs currently used by the driver */
>  	u16 xdp_queue_pairs;
> 
> +	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
> +	bool xdp_enabled;
> +
>  	/* I like... big packets and I cannot lie! */
>  	bool big_packets;
> 
> @@ -481,12 +484,34 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  	return 0;
>  }
> 
> -static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
> -{
> -	unsigned int qp;
> -
> -	qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
> -	return &vi->sq[qp];
> +/* when vi->curr_queue_pairs > nr_cpu_ids, the txq/sq is only used for xdp tx on
> + * the current cpu, so it does not need to be locked.
> + */

pls also explain why these are macros not inline functions in the
comment.



> +#define virtnet_xdp_get_sq(vi) ({                                         \
> +	struct netdev_queue *txq;                                         \
> +	typeof(vi) v = (vi);                                              \
> +	unsigned int qp;                                                  \


empty line here after variable definitions.

same elsewhere

> +	if (v->curr_queue_pairs > nr_cpu_ids) {                           \
> +		qp = v->curr_queue_pairs - v->xdp_queue_pairs;            \
> +		qp += smp_processor_id();                                 \
> +		txq = netdev_get_tx_queue(v->dev, qp);                    \
> +		__netif_tx_acquire(txq);                                  \
> +	} else {                                                          \
> +		qp = smp_processor_id() % v->curr_queue_pairs;            \
> +		txq = netdev_get_tx_queue(v->dev, qp);                    \
> +		__netif_tx_lock(txq, raw_smp_processor_id());             \
> +	}                                                                 \
> +	v->sq + qp;                                                       \
> +})
> +
> +#define virtnet_xdp_put_sq(vi, q) {                                       \
> +	struct netdev_queue *txq;                                         \
> +	typeof(vi) v = (vi);                                              \
> +	txq = netdev_get_tx_queue(v->dev, (q) - v->sq);                   \
> +	if (v->curr_queue_pairs > nr_cpu_ids)                             \
> +		__netif_tx_release(txq);                                  \
> +	else                                                              \
> +		__netif_tx_unlock(txq);                                   \
>  }


>  static int virtnet_xdp_xmit(struct net_device *dev,
> @@ -512,7 +537,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	if (!xdp_prog)
>  		return -ENXIO;
> 
> -	sq = virtnet_xdp_sq(vi);
> +	sq = virtnet_xdp_get_sq(vi);
> 
>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
>  		ret = -EINVAL;
> @@ -560,12 +585,13 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	sq->stats.kicks += kicks;
>  	u64_stats_update_end(&sq->stats.syncp);
> 
> +	virtnet_xdp_put_sq(vi, sq);
>  	return ret;
>  }
> 
>  static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>  {
> -	return vi->xdp_queue_pairs ? VIRTIO_XDP_HEADROOM : 0;
> +	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
>  }
> 
>  /* We copy the packet for XDP in the following cases:
> @@ -1457,12 +1483,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		xdp_do_flush();
> 
>  	if (xdp_xmit & VIRTIO_XDP_TX) {
> -		sq = virtnet_xdp_sq(vi);
> +		sq = virtnet_xdp_get_sq(vi);
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			sq->stats.kicks++;
>  			u64_stats_update_end(&sq->stats.syncp);
>  		}
> +		virtnet_xdp_put_sq(vi, sq);
>  	}
> 
>  	return received;
> @@ -2417,10 +2444,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> 
>  	/* XDP requires extra queues for XDP_TX */
>  	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> -		NL_SET_ERR_MSG_MOD(extack, "Too few free TX rings available");
> -		netdev_warn(dev, "request %i queues but max is %i\n",
> +		netdev_warn(dev, "XDP request %i queues but max is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx mode.\n",
>  			    curr_qp + xdp_qp, vi->max_queue_pairs);
> -		return -ENOMEM;
> +		xdp_qp = 0;
>  	}
> 
>  	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
> @@ -2454,11 +2480,14 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	vi->xdp_queue_pairs = xdp_qp;
> 
>  	if (prog) {
> +		vi->xdp_enabled = true;
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
>  			if (i == 0 && !old_prog)
>  				virtnet_clear_guest_offloads(vi);
>  		}
> +	} else {
> +		vi->xdp_enabled = false;
>  	}
> 
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> @@ -2526,7 +2555,7 @@ static int virtnet_set_features(struct net_device *dev,
>  	int err;
> 
>  	if ((dev->features ^ features) & NETIF_F_LRO) {
> -		if (vi->xdp_queue_pairs)
> +		if (vi->xdp_enabled)
>  			return -EBUSY;
> 
>  		if (features & NETIF_F_LRO)
> --
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
