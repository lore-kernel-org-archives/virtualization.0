Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36A3D965
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0BFeuCx"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19FEF43662
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 14:45:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19FEF43662
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T0BFeuCx
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZCYPzRQ_Mtg
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 14:45:27 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA10A404FE
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 14:45:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA10A404FE
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67ef18444ecso41139036d6.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703083525; x=1703688325; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00hWthZLZR4bx/F9jEFUNl/uLb7wDcknN2yFH2/3Afo=;
        b=T0BFeuCxLIChHsZFD4bcEdjuJPqriLSMo2Qb9/STriqAoLjQNbp8Ow3ooOCF9axjFm
         yCIQep0dFi9QWPogoRv5whEJTXgTT/u59KNeBNINNKmA2e4llht2k3XW7qxZm9TDTjA7
         QTMhtEGQLUbthde+AJGh5u1b0czSvKmmaTCUFgTXiZen9Feh1a8nyoRdW9XMZo14Qjvu
         s75t1+GM2mTK/7njtrIiepqRqe61Hva48kSuwAq/YyoBcxBmqetgi/c+Zw5fPspZU3/f
         keZZcsDpvhJe0TMZp4XxwZcC34UcP2RIaYBQC6TV2AtRiZfv6hR5zLMfxk+7RvyxwU+m
         2C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083525; x=1703688325;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00hWthZLZR4bx/F9jEFUNl/uLb7wDcknN2yFH2/3Afo=;
        b=GwzDIzkTTG828+B7e3jd5ZRtKvq/hY1gr3xzknFlR4ODy3mE1BYWAKjmho5ZNWElLn
         Duco6ejhEmzxU6UXudmhP/HyeUaxt3t8d+jW4qnxz7fJzaZRe5Z0Mbmd9QbC9rqa+sts
         uBjajpNGg4Hf17UnMIjvu2MrBJU3JcD8k8aSgnpjSmjNG6bXOWuHSWANuSjFOwded3od
         oL/DC45ywQ75MpYfs0iDxxfzUkKDBB+Fi79pe+spZHlgWIdGUztFmOAC1ILOyqiRObtd
         e4BliSLrN0MK00tQYrYNy+QaoxtjyXaCvlo/R8tQmQaFM9TLsOz7W4qOnujXY868qijy
         91rg==
X-Gm-Message-State: AOJu0YwphUgwFS/k4tg/TQnmUDjBjEhl7x8b7rAu7/XuNoZNR1m2J/n3
	y99JsLptLm6E7Hptn5MLBcI=
X-Google-Smtp-Source: AGHT+IHv7lb+06r/c9ShUIhRC6qHu+HFbvkuZ1S27Ryc/Xemou3/giVSsr8JKcTU/7LdyInq8/HT0g==
X-Received: by 2002:ad4:5de2:0:b0:67f:276d:a113 with SMTP id jn2-20020ad45de2000000b0067f276da113mr10263563qvb.72.1703083525574;
        Wed, 20 Dec 2023 06:45:25 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id f9-20020a37ad09000000b0077fb3fca44asm887159qkm.95.2023.12.20.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:45:25 -0800 (PST)
Date: Wed, 20 Dec 2023 09:45:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
In-Reply-To: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Heng Qi wrote:
> virtio-net has two ways to switch napi_tx: one is through the
> module parameter, and the other is through coalescing parameter
> settings (provided that the nic status is down).
> 
> Sometimes we face performance regression caused by napi_tx,
> then we need to switch napi_tx when debugging. However, the
> existing methods are a bit troublesome, such as needing to
> reload the driver or turn off the network card. So try to make
> this update.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

The commit does not explain why it is safe to do so.

The tx-napi weights are not really weights: it is a boolean whether
napi is used for transmit cleaning, or whether packets are cleaned
in ndo_start_xmit.

There certainly are some subtle issues with regard to pausing/waking
queues when switching between modes.

Calling napi_enable/napi_disable without bringing down the device is
allowed. The actually napi.weight field is only updated when neither
napi nor ndo_start_xmit is running. So I don't see an immediate issue.


> ---
>  drivers/net/virtio_net.c | 81 ++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 10614e9f7cad..12f8e1f9971c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3559,16 +3559,37 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  	return 0;
>  }
>  
> -static int virtnet_should_update_vq_weight(int dev_flags, int weight,
> -					   int vq_weight, bool *should_update)
> +static void virtnet_switch_napi_tx(struct virtnet_info *vi, u32 qstart,
> +				   u32 qend, u32 tx_frames)
>  {
> -	if (weight ^ vq_weight) {
> -		if (dev_flags & IFF_UP)
> -			return -EBUSY;
> -		*should_update = true;
> -	}
> +	struct net_device *dev = vi->dev;
> +	int new_weight, cur_weight;
> +	struct netdev_queue *txq;
> +	struct send_queue *sq;
>  
> -	return 0;
> +	new_weight = tx_frames ? NAPI_POLL_WEIGHT : 0;
> +	for (; qstart < qend; qstart++) {
> +		sq = &vi->sq[qstart];
> +		cur_weight = sq->napi.weight;
> +		if (!(new_weight ^ cur_weight))
> +			continue;
> +
> +		if (!(dev->flags & IFF_UP)) {
> +			sq->napi.weight = new_weight;
> +			continue;
> +		}
> +
> +		if (cur_weight)
> +			virtnet_napi_tx_disable(&sq->napi);
> +
> +		txq = netdev_get_tx_queue(dev, qstart);
> +		__netif_tx_lock_bh(txq);
> +		sq->napi.weight = new_weight;
> +		__netif_tx_unlock_bh(txq);
> +
> +		if (!cur_weight)
> +			virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> +	}
>  }
>  
>  static int virtnet_set_coalesce(struct net_device *dev,
> @@ -3577,25 +3598,11 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	int ret, queue_number, napi_weight;
> -	bool update_napi = false;
> -
> -	/* Can't change NAPI weight if the link is up */
> -	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
> -		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> -						      vi->sq[queue_number].napi.weight,
> -						      &update_napi);
> -		if (ret)
> -			return ret;
> -
> -		if (update_napi) {
> -			/* All queues that belong to [queue_number, vi->max_queue_pairs] will be
> -			 * updated for the sake of simplicity, which might not be necessary
> -			 */
> -			break;
> -		}
> -	}
> +	int ret;
> +
> +	/* Param tx_frames can be used to switch napi_tx */
> +	virtnet_switch_napi_tx(vi, 0, vi->max_queue_pairs,
> +			       ec->tx_max_coalesced_frames);
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>  		ret = virtnet_send_notf_coal_cmds(vi, ec);
> @@ -3605,11 +3612,6 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (update_napi) {
> -		for (; queue_number < vi->max_queue_pairs; queue_number++)
> -			vi->sq[queue_number].napi.weight = napi_weight;
> -	}
> -
>  	return ret;
>  }
>  
> @@ -3641,19 +3643,13 @@ static int virtnet_set_per_queue_coalesce(struct net_device *dev,
>  					  struct ethtool_coalesce *ec)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	int ret, napi_weight;
> -	bool update_napi = false;
> +	int ret;
>  
>  	if (queue >= vi->max_queue_pairs)
>  		return -EINVAL;
>  
> -	/* Can't change NAPI weight if the link is up */
> -	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> -					      vi->sq[queue].napi.weight,
> -					      &update_napi);
> -	if (ret)
> -		return ret;
> +	/* Param tx_frames can be used to switch napi_tx */
> +	virtnet_switch_napi_tx(vi, queue, queue, ec->tx_max_coalesced_frames);
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>  		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
> @@ -3663,9 +3659,6 @@ static int virtnet_set_per_queue_coalesce(struct net_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (update_napi)
> -		vi->sq[queue].napi.weight = napi_weight;
> -
>  	return 0;
>  }
>  
> -- 
> 2.19.1.6.gb485710b
> 


