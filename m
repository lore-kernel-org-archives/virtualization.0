Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F1A9FB0
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772243572; cv=none; b=hYzm2oefypm6dbq1DAlgJNlCryQG0R9zu4Fzg9qwRh2Je3X0jvX0lC3tQkyHQzzx1TSvhAC/n+ALiGQTGupIk5kdxglL0sakEXAgUq2n/JyJw+kXb4JkjDeqErt5RMSa1fBh923gxEG0VKidIqECra+jPALrs5BY4Sv8kDae+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772243572; c=relaxed/simple;
	bh=B2YeU3WjsCqsveIQvxStrCLJ4S5p9Q/sC2ikaUwYSI0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jNH46CQaehQRvKz3BVPSz9YlAQLRS4/qpOxd37S+yE+J6+mtFZNlosgnahXe1idht5PrzMM492P8MS0OmZCdBH2MlXW4ZRL5NWA23vba81xgS8Y4FAkB8NNLMvxu2y5Yju3o7gQD65opWIN+nNZrgZvQXOvxbeByOootjUnQUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sexU8DDT; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sexU8DDT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772243567; h=Message-ID:Subject:Date:From:To;
	bh=W8d6Bh+HP5EteTq+o9ULWf8DeN2EtdjRgF0wir3dN90=;
	b=sexU8DDTo0zqcgyxJhhmmHjhZgfbUwXRVB3C3hz72LKKeGbncCD5a52SPjBnX4fgxORtgl2XoRN1w0pbC0VymFVXTwz9txUDvlcu4a3beCA5IdQY2Z3SWXJlBqoW8Ry4P0/M84VoCv35jTEQQ+1mZRoTlmrz6KcdhjcV2J/5LvE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WzvnDMh_1772243566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 28 Feb 2026 09:52:46 +0800
Message-ID: <1772243553.11669-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
Date: Sat, 28 Feb 2026 09:52:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 netdev@vger.kernel.org
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
In-Reply-To: <20260227150949.13089-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 27 Feb 2026 22:09:49 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..494acc904b2c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  	xsk_buffs = rq->xsk_buffs;
>
>  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> -	if (!num)
> +	if (!num) {
> +		if (xsk_uses_need_wakeup(pool)) {
> +			xsk_set_rx_need_wakeup(pool);
> +			/* Return 0 instead of -ENOMEM so that NAPI is
> +			 * descheduled.
> +			 */
> +			return 0;
> +		}
> +
>  		return -ENOMEM;
> +	} else {
> +		xsk_clear_rx_need_wakeup(pool);
> +	}
>
>  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>
> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	return sent;
>  }
>
> -static void xsk_wakeup(struct send_queue *sq)
> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>  {
> -	if (napi_if_scheduled_mark_missed(&sq->napi))
> +	if (napi_if_scheduled_mark_missed(napi))
>  		return;
>
>  	local_bh_disable();
> -	virtqueue_napi_schedule(&sq->napi, sq->vq);
> +	virtqueue_napi_schedule(napi, vq);
>  	local_bh_enable();
>  }
>
>  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	struct send_queue *sq;
> +	struct napi_struct *napi;
> +	struct virtqueue *vq;
>
>  	if (!netif_running(dev))
>  		return -ENETDOWN;
> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  	if (qid >= vi->curr_queue_pairs)
>  		return -EINVAL;
>
> -	sq = &vi->sq[qid];
> +	if (flag == XDP_WAKEUP_TX) {
> +		struct send_queue *sq = &vi->sq[qid];
> +
> +		napi = &sq->napi;
> +		vq = sq->vq;
> +	} else {
> +		struct receive_queue *rq = &vi->rq[qid];
> +
> +		napi = &rq->napi;
> +		vq = rq->vq;
> +	}
>
> -	xsk_wakeup(sq);
> +	xsk_wakeup(napi, vq);
>  	return 0;
>  }
>
> @@ -1623,7 +1645,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
>  	 * wakeup the tx napi to consume the xsk tx queue, because the tx
>  	 * interrupt may not be triggered.
>  	 */
> -	xsk_wakeup(sq);
> +	xsk_wakeup(&sq->napi, sq->vq);
>  }
>
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> --
> 2.43.0
>
