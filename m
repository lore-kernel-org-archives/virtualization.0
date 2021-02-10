Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F3EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:40:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1C464EE1
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1C464EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 720796F576
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6piEUMP7V-Z for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 21:40:54 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 96F9F6F57C; Wed, 10 Feb 2021 21:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15DDB6F516;
	Wed, 10 Feb 2021 21:40:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5880C0891;
	Wed, 10 Feb 2021 21:40:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C3EC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16EA487274
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMIn+psejMQe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0047587275
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612993247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hi2X5jnGRi7KT3vlKkAdXUsSwPyG3HDv963BA62z9vA=;
 b=eJL7ugOUp7s+KcTQpPwggPLWMJSnIA9yHBlEjQTw+UalyYlDocjgMzYnnEUsak4m9LZcnQ
 haYBadVrPfo0skkUNK6Uwq8gSqiwuoQl7MAZzd8tpGyMxaLA9MdUJFRc++VOfgxadNMIzr
 bp+BwA3AbQfrsoQ3MIttuKBr/PGVl4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-gKIENTXiMwCD7oGMII5Ivg-1; Wed, 10 Feb 2021 16:40:46 -0500
X-MC-Unique: gKIENTXiMwCD7oGMII5Ivg-1
Received: by mail-wm1-f71.google.com with SMTP id n17so1543085wmk.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 13:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hi2X5jnGRi7KT3vlKkAdXUsSwPyG3HDv963BA62z9vA=;
 b=lf3lj/xsKQY1pJvSXf9YdCMK7/QjyVnvU4cezBvDrxI7Fe/AS8qyWIrFu1sUWARf6K
 c93939iinnDOaHHW7cTMjSctOVUrOUBk/1KPKjzUUdy007H+vbgTN6PxcYQh92bKqdYH
 mD7kswXiPybHccKQq0ZAq57pvqEc1g5M89Yz6tfE+X+JXz+e2g2S5NUkJ9E/QV5bXfgR
 vmnPSil/WbjC0F9zYgMq6BXw0at/oybdGDMJqvyP4kGPnKHBRU2FIzc2PXGfdKFsLC0W
 3mB/GoAyuUMJO3JFuGwLRYUJKG9/lev7GEzZD/lmhTZZZepg9vs8bNDHCfhN3O+p+KS+
 FMkA==
X-Gm-Message-State: AOAM5319QhSLoB5ttTuZF/cyzmfOY/+WYLXzWSObZH5pONjfQxNfZgfT
 kmNxrYF8AE4pc2i+D5y7xmRFSFRBueWUFWydOP4D/TOiB5K9g3H87mpYf8dffVfwyO4hp+9zlww
 kMLYzOBIk80WWjAO8g4nC+xWeO+9ikGDYlAluyTd6wg==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr1050590wmb.69.1612993245120;
 Wed, 10 Feb 2021 13:40:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEZ8liZuKYUAcB0H7NMYB9jERfv/Iy/eLiiOFihgo+hWnxXSocQL+S/PQhfhUBwNqqpOQigQ==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr1050574wmb.69.1612993244940;
 Wed, 10 Feb 2021 13:40:44 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id j185sm5103692wma.1.2021.02.10.13.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 13:40:44 -0800 (PST)
Date: Wed, 10 Feb 2021 16:40:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH netdev] virtio-net: support XDP_TX when not more queues
Message-ID: <20210210163945-mutt-send-email-mst@kernel.org>
References: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, dust.li@linux.alibaba.com,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jan 13, 2021 at 04:08:57PM +0800, Xuan Zhuo wrote:
> The number of queues implemented by many virtio backends is limited,
> especially some machines have a large number of CPUs. In this case, it
> is often impossible to allocate a separate queue for XDP_TX.
> 
> This patch allows XDP_TX to run by reuse the existing SQ with
> __netif_tx_lock() hold when there are not enough queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

I'd like to get some advice on whether this is ok from some
XDP experts - previously my understanding was that it is
preferable to disable XDP for such devices than
use locks on XDP fast path.

> ---
>  drivers/net/virtio_net.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba8e637..7a3b2a7 100644
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
> @@ -481,14 +484,34 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  	return 0;
>  }
>  
> -static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
> +static struct send_queue *virtnet_get_xdp_sq(struct virtnet_info *vi)
>  {
>  	unsigned int qp;
> +	struct netdev_queue *txq;
> +
> +	if (vi->curr_queue_pairs > nr_cpu_ids) {
> +		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
> +	} else {
> +		qp = smp_processor_id() % vi->curr_queue_pairs;
> +		txq = netdev_get_tx_queue(vi->dev, qp);
> +		__netif_tx_lock(txq, raw_smp_processor_id());
> +	}
>  
> -	qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
>  	return &vi->sq[qp];
>  }
>  
> +static void virtnet_put_xdp_sq(struct virtnet_info *vi)
> +{
> +	unsigned int qp;
> +	struct netdev_queue *txq;
> +
> +	if (vi->curr_queue_pairs <= nr_cpu_ids) {
> +		qp = smp_processor_id() % vi->curr_queue_pairs;
> +		txq = netdev_get_tx_queue(vi->dev, qp);
> +		__netif_tx_unlock(txq);
> +	}
> +}
> +
>  static int virtnet_xdp_xmit(struct net_device *dev,
>  			    int n, struct xdp_frame **frames, u32 flags)
>  {
> @@ -512,7 +535,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	if (!xdp_prog)
>  		return -ENXIO;
>  
> -	sq = virtnet_xdp_sq(vi);
> +	sq = virtnet_get_xdp_sq(vi);
>  
>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
>  		ret = -EINVAL;
> @@ -560,12 +583,13 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	sq->stats.kicks += kicks;
>  	u64_stats_update_end(&sq->stats.syncp);
>  
> +	virtnet_put_xdp_sq(vi);
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
> @@ -1457,12 +1481,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		xdp_do_flush();
>  
>  	if (xdp_xmit & VIRTIO_XDP_TX) {
> -		sq = virtnet_xdp_sq(vi);
> +		sq = virtnet_get_xdp_sq(vi);
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			sq->stats.kicks++;
>  			u64_stats_update_end(&sq->stats.syncp);
>  		}
> +		virtnet_put_xdp_sq(vi);
>  	}
>  
>  	return received;
> @@ -2416,12 +2441,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		xdp_qp = nr_cpu_ids;
>  
>  	/* XDP requires extra queues for XDP_TX */
> -	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> -		NL_SET_ERR_MSG_MOD(extack, "Too few free TX rings available");
> -		netdev_warn(dev, "request %i queues but max is %i\n",
> -			    curr_qp + xdp_qp, vi->max_queue_pairs);
> -		return -ENOMEM;
> -	}
> +	if (curr_qp + xdp_qp > vi->max_queue_pairs)
> +		xdp_qp = 0;
>  
>  	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
>  	if (!prog && !old_prog)
> @@ -2453,12 +2474,14 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
>  	vi->xdp_queue_pairs = xdp_qp;
>  
> +	vi->xdp_enabled = false;
>  	if (prog) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
>  			if (i == 0 && !old_prog)
>  				virtnet_clear_guest_offloads(vi);
>  		}
> +		vi->xdp_enabled = true;
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> @@ -2526,7 +2549,7 @@ static int virtnet_set_features(struct net_device *dev,
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
