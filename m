Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF8299943
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096324; cv=none; b=O0NwGWCeF5iIh/OfpYhWhcxrgjCzPgIxWHAwfn5MKZ4/LFQ85awkcziF6H4ul4caTnuGM3koU7X238VJMYp/dXa4S/MqFNeysA09Sb6bmcq7/I3ZohzR9IsHIiQXNILdPNrlZJRpN9QgowVCld3B7ki416+Ip7PLaKx1i8LfgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096324; c=relaxed/simple;
	bh=cCnB8SHaTELhBMM2vNSo8nome0XmO9U28qrztuN+eZY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IauDhDDLggwvHx1r3Z5waTVPM+TSQo4MdIlNDIx7s/FDaaMlGwI17ppVRC3dz7avAnka9ntKtfKlXGJ8KcPPbbeHvqZPsMTlvObIFQs4QZiIq7AdUqISDzpjrv70JnYMpZfFADrEv6b/i6j8YZ7dgRsFAdIkWi1Rxt51smg2aBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ao601NLz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ao601NLz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782096314; h=Message-ID:Subject:Date:From:To;
	bh=6l8D54I1qhjeNtbRwIBHC97XmtG0Dd57mu48xVCfLtk=;
	b=ao601NLzqJzGc1Trw1ZMWO38gKe2DME/eUXx9TSYDkOJm+uov86VT17ay0OJHqTVTBxal9GboXxdzSq/9NA7sPpR/cR0KMK+Ub1pB13CsDy0JrfJKDLUzwO31usztxeTiFXo5mX5uqVgx1casWmsHgu+3eV1YRG+qnwTuRtoCP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5GhaeY_1782096312;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X5GhaeY_1782096312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:45:13 +0800
Message-ID: <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 10:40:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 eperezma@redhat.com
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 16 Jun 2026 19:59:12 +0800, Menglong Dong <menglong8.dong@gmail.com> wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
>
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
>
> Race condition is considered for tx path.
>
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")

This is not a bug, so we do not need this.
And you post this to net-next.


> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - remove the confusing comment
>
> v2:
> - add the Fixes tag
> ---
>  drivers/net/virtio_net.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..6e099edef6e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtnet_sq_free_stats stats = {};
>  	struct net_device *dev = vi->dev;
> +	int sent, vring_size;
> +	bool need_wakeup;
>  	u64 kicks = 0;
> -	int sent;
>
>  	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
>  	 * free_old_xmit().
> @@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	if (stats.xsk)
>  		xsk_tx_completed(sq->xsk_pool, stats.xsk);
>
> +	vring_size = virtqueue_get_vring_size(sq->vq);
> +	need_wakeup = xsk_uses_need_wakeup(pool);
> +
> +	if (need_wakeup && vring_size == sq->vq->num_free)
> +		xsk_set_tx_need_wakeup(pool);

You need to comment this.


> +
>  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>
> +	if (need_wakeup) {
> +		if (vring_size == sq->vq->num_free)
> +			/* we can't wake up by ourself, and it should be done
> +			 * by the user.
> +			 */
> +			xsk_set_tx_need_wakeup(pool);
> +		else
> +			/* we can wake up from skb_xmit_done() */
> +			xsk_clear_tx_need_wakeup(pool);
> +	}
> +
>  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>  		check_sq_full_and_disable(vi, vi->dev, sq);


After fixed above comments, you can add:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.


>
> @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	u64_stats_add(&sq->stats.xdp_tx,  sent);
>  	u64_stats_update_end(&sq->stats.syncp);
>
> -	if (xsk_uses_need_wakeup(pool))
> -		xsk_set_tx_need_wakeup(pool);
> -
>  	return sent;
>  }
>
> --
> 2.54.0
>
