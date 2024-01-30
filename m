Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC36D1A8
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627827; cv=none; b=Cnygats12IJiUtuySWRiFhAztLGh3ncxCBGw5S69S95pm9LbxWN0IGGWohSe8t/22+KyETruEnopOK1PkRI19OersYw6a3VEznniOXUbR13KRSk86nCQsSBOGdUrE29x31NyYYmf3v5ra10bOwF9QKlyqr+HMhDI4ro2XKM/Vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627827; c=relaxed/simple;
	bh=oBDBDDM2ZeXfB3x+4Y0EF7XZ6s9ga2JRC1WufWdZV/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzQ0XP2S8KAKWbOnlP0oLlXhqv9FxFXEca3f4bnrJ1oAJU5aRJ6XR8R7/tfMhkcKaIu2H6jn+7DBT92g6cvZ8NlxpZvgd+jKpJxo4eNWWXs+AFMbOTIsygl4XtkaYEOicY3TNhQc7ZujbwvNtJM4smolHOPxSTgX/Dxnird3CiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZkZGZRQ7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZkZGZRQ7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706627822; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RRQctVTAEb/sCyj0hDI9F/Ci+YcS4C7areI81tVA8WE=;
	b=ZkZGZRQ7Y+haHcD3dhKfoqRVzHvECCsBajzkN2rSu77i87UGC9ESxtMkuaE+MpzLagEj0IJ2YU+XPt9bYaXmumbG4US519yKexl6brRZxpRVy/jzlUBByADK6vxYVjnHzP2eytE9PEo9a8zVe49njjR2YMpfVC8yWMSkEXeqXwY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W.gXTgS_1706627820;
Received: from 30.120.159.82(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W.gXTgS_1706627820)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 23:17:01 +0800
Message-ID: <081f6d4c-bc44-4afe-ba51-d7c14966a536@linux.alibaba.com>
Date: Tue, 30 Jan 2024 23:16:59 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, abeni@redhat.com, Parav Pandit <parav@nvidia.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240130142521.18593-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/30 下午10:25, Daniel Jurgens 写道:
> Add a tx queue stop and wake counters, they are useful for debugging.
>
> 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> 	...
> 	tx_queue_1_tx_stop: 16726
> 	tx_queue_1_tx_wake: 16726
> 	...
> 	tx_queue_8_tx_stop: 1500110
> 	tx_queue_8_tx_wake: 1500110
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3cb8aa193884..7e3c31ceaf7e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
>   	u64_stats_t xdp_tx_drops;
>   	u64_stats_t kicks;
>   	u64_stats_t tx_timeouts;
> +	u64_stats_t tx_stop;
> +	u64_stats_t tx_wake;
>   };

Hi Daniel!

tx_stop/wake only counts the status in the I/O path.
Do the status of virtnet_config_changed_work and virtnet_tx_resize need 
to be counted?

Thanks,
Heng

>   
>   struct virtnet_rq_stats {
> @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
>   	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
>   	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
>   	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
>   };
>   
>   static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> @@ -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>   	 */
>   	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>   		netif_stop_subqueue(dev, qnum);
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		u64_stats_inc(&sq->stats.tx_stop);
> +		u64_stats_update_end(&sq->stats.syncp);
>   		if (use_napi) {
>   			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>   				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -851,6 +858,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>   			free_old_xmit_skbs(sq, false);
>   			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>   				netif_start_subqueue(dev, qnum);
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
>   				virtqueue_disable_cb(sq->vq);
>   			}
>   		}
> @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>   			free_old_xmit_skbs(sq, true);
>   		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>   
> -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +			if (netif_tx_queue_stopped(txq)) {
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
> +			}
>   			netif_tx_wake_queue(txq);
> +		}
>   
>   		__netif_tx_unlock(txq);
>   	}
> @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>   	virtqueue_disable_cb(sq->vq);
>   	free_old_xmit_skbs(sq, true);
>   
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +		if (netif_tx_queue_stopped(txq)) {
> +			u64_stats_update_begin(&sq->stats.syncp);
> +			u64_stats_inc(&sq->stats.tx_wake);
> +			u64_stats_update_end(&sq->stats.syncp);
> +		}
>   		netif_tx_wake_queue(txq);
> +	}
>   
>   	opaque = virtqueue_enable_cb_prepare(sq->vq);
>   

