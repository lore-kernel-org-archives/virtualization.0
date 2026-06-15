Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA81A683A
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492396; cv=none; b=rn7gl1HrbP/IAYZaZJrLZ2SvmVVX0Atww+radon/mhFPmeWQ2/y7XjZEJYzKaWAosLoz5K1nkjjiBvzyCf7JDSfGnxFt0zUpErTd2Km5jdl1vKs7c0Xmbar8NTemS/KT5hiG/d2xLYFSnsQgwVl5tQJvzlQe/qkqjcKO6enQGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492396; c=relaxed/simple;
	bh=57yKZQz0buXNFzXkhUqk+nu0gQIuDjIWbyAXCJFgNMg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=GJN7+6hf/JwflW98MJ0X2J4C6fP+pCcsJdxVu9uFx8/G035kC4fuISGMg+QM5613vFLvxD7ZfCQCvV3xJs7BdNvt1OuqiCbhHuomAvHwodekcLaEStvXNWdQDa9jWB7JMc02awAF2kxAyEXeEQAaqBqVVCxXR2Dv7uP6aINcil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i+3MDgXc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i+3MDgXc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781492389; h=Message-ID:Subject:Date:From:To;
	bh=Hs9gJmaIt2CsoVnPgGPaU+fHX1gP7oID7IO1t/2Ii+o=;
	b=i+3MDgXcu7D9CtgePdbfrNuTg00XC/XNEFjyKLgsGxWlGKo0hZvL1wYsbfzCP8+D94QEM8T+YL1PHdKPDCCH3sxcSpTQQtjPpDoDwFE0VhmPi6WFrlbBNPP8i6it6iWdDZw/ZS3/dYtJ5OEQcv4N8HIJyBwTWdSvw5u05tpIA00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4ooTfR_1781492387;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4ooTfR_1781492387 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 10:59:48 +0800
Message-ID: <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Mon, 15 Jun 2026 10:48:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: menglong8.dong@gmail.com
Cc: mst@redhat.com,
 jasowang@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 minhquangbui99@gmail.com,
 kerneljasonxing@gmail.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 eperezma@redhat.com
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 11 Jun 2026 10:56:43 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dongml2@chinatelecom.cn>
>
> During packet receiving in virtio-net, the rq can be empty, which means
> "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> can be empty too, which means we can't allocate anything from
> xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
>
> However, if the user clean all the data in rx ring and fill the
> "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> napi will never be scheduled: the rx ring is empty, which means we will
> never receive a packet to trigger the further recv fill. The rx ring is
> empty now, so the user will not check the flag too.
>
> Fix this by set the XDP_RING_NEED_WAKEUP flag before
> xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
>
> Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> rq->vq.
>
> Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..4b5b3fa62008 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  				   struct xsk_buff_pool *pool, gfp_t gfp)
>  {
>  	struct xdp_buff **xsk_buffs;
> +	bool need_wakeup;
>  	dma_addr_t addr;
>  	int err = 0;
>  	u32 len, i;
>  	int num;
>
> +	need_wakeup = xsk_uses_need_wakeup(pool);
>  	xsk_buffs = rq->xsk_buffs;
>
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */
> +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> +		xsk_set_rx_need_wakeup(pool);

Is Condition A here too strict? We should trigger the wakeup under a wider range
of scenarios.

> +
>  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>  	if (!num) {
> -		if (xsk_uses_need_wakeup(pool)) {
> +		if (need_wakeup) {
>  			xsk_set_rx_need_wakeup(pool);
>  			/* Return 0 instead of -ENOMEM so that NAPI is
>  			 * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  		}
>
>  		return -ENOMEM;
> -	} else {
> -		xsk_clear_rx_need_wakeup(pool);
>  	}
>
>  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  			goto err;
>  	}
>
> +	if (need_wakeup) {
> +		if (rq->vq->num_free)
> +			/* We have free buffers, so we'd better wake up the
> +			 * rx napi as soon as possible.
> +			 */
> +			xsk_set_rx_need_wakeup(pool);

Is the purpose of waking up RX NAPI to invoke try_fill_recv? However,
virtnet_poll does not call try_fill_recv directly. it is done
conditionally.

Thanks.


> +		else
> +			xsk_clear_rx_need_wakeup(pool);
> +	}
> +
>  	return num;
>
>  err:
> --
> 2.54.0
>
