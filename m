Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA8281532;
	Sat,  8 Aug 2026 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151958; cv=none; b=AJP7cAtSQIn3vh5DdargHlMROzZapnoRQA0h3aervcOLZx1uHZ6/43wZway/bB+3glrPYzKyCaS6iRnMWzDcHdZ7HoQ5iJrdtQC6LujhxsH07w/xbflTKubkPxGhFW0OhH9qjZiapzUU4OL5+sHww7hcRyOkfjDCOaT7wla43Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151958; c=relaxed/simple;
	bh=i7/GPv0zwtNRHmtbqpbp+cRuAUyXry6ImUnI8sVbomk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGWAzzidBa9xcuyI9dl3GNjUFFJ2Cwg5tBGYBCvRRuKW3WIjVGXDkxFJSt3R6TnvHcZXKTkx1i84vC3aM+mQAZbCfv7la7L1oyT6QHHR/8QhvsJDJOkZ8rruMgxNiAFCZUjfCknuZxCZyB8EMnArMRUUJ9uBZVPEYoEpts7A4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1XJ1AHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1XJ1AHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB261F000E9;
	Sat,  8 Aug 2026 01:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151957;
	bh=en2inzUc+Bz/LksaPJcN/DhNmRyA0fDxj7oEZ5Gmly0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n1XJ1AHIdMdj4w2zMKMJV6yYsrlrYHdOPWi4I54j3E12dyfWMlB/2szMM1pUYS9dY
	 ERQI6bHBgwHfGr9d9D4PPH2/jBRv80M7hd9UD3ypScVGCxRPvpklxX/bvJbZAxAObe
	 HDXUX7Mykl/t9GAwOkCOGEqiEMLKWpeS96tRsgKvjA187pjzgO1szkG/mB8jZfyuhx
	 KQ+M/drB3tGtbu0/P2Uhnnu7c4Ge7YKn5YINWXIm5c5LZAPsyfN9kC47IKqX1jKL5F
	 pjvgv4yc4uGvubPS2/TfdYPbk/0wo9xVyLRALXa/bOJryDNc7eb1Z72E/FcXNeZBhh
	 hflkWmjNy4kPg==
Date: Fri, 7 Aug 2026 18:19:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Message-ID: <20260807181916.63395d4f@kernel.org>
In-Reply-To: <20260804073654.1293243-1-xiongweimin@kylinos.cn>
References: <20260804073654.1293243-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 15:36:54 +0800 Xiong Weimin wrote:
> The ethtool RSS and RXHASH paths update the driver's cached RSS state
> before committing the change to the device.  If the control virtqueue
> command fails, the cached hash types, key or indirection table can then
> report a configuration that the device did not accept.
> 
> Preserve the previous local state around RSS/hash control commands and
> restore it when the device update fails, while propagating the error to
> the caller.

I guess.. saving the data and then copying it back doesn't seem super
clean but I guess since we DMA directly from the info struct..

Michael, Jason, looks okay? 

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c..ccd96315a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4295,6 +4295,7 @@ static int virtnet_set_hashflow(struct net_device *dev,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	u32 old_hashtypes = vi->rss_hash_types_saved;
>  	u32 new_hashtypes = vi->rss_hash_types_saved;
>  	bool is_disable = info->data & RXH_DISCARD;
>  	bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
> @@ -4350,9 +4351,13 @@ static int virtnet_set_hashflow(struct net_device *dev,
>  	if (new_hashtypes != vi->rss_hash_types_saved) {
>  		vi->rss_hash_types_saved = new_hashtypes;
>  		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
> -		if (vi->dev->features & NETIF_F_RXHASH)
> -			if (!virtnet_commit_rss_command(vi))
> +		if (vi->dev->features & NETIF_F_RXHASH) {
> +			if (!virtnet_commit_rss_command(vi)) {
> +				vi->rss_hash_types_saved = old_hashtypes;
> +				vi->rss_hdr->hash_types = cpu_to_le32(old_hashtypes);
>  				return -EINVAL;
> +			}
> +		}
>  	}
>  
>  	return 0;
> @@ -5546,6 +5551,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtio_net_rss_config_hdr *old_rss_hdr = NULL;
> +	u8 old_rss_key[NETDEV_RSS_KEY_LEN];
>  	bool update = false;
>  	int i;
>  
> @@ -5553,14 +5560,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
>  
> -	if (rxfh->indir) {
> -		if (!vi->has_rss)
> -			return -EOPNOTSUPP;
> -
> -		for (i = 0; i < vi->rss_indir_table_size; ++i)
> -			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
> -		update = true;
> -	}
> +	if (rxfh->indir && !vi->has_rss)
> +		return -EOPNOTSUPP;
>  
>  	if (rxfh->key) {
>  		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
> @@ -5569,13 +5570,36 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  		 */
>  		if (!vi->has_rss && !vi->has_rss_hash_report)
>  			return -EOPNOTSUPP;
> +	}
> +
> +	if (rxfh->indir) {
> +		old_rss_hdr = kmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
> +				      GFP_KERNEL);
> +		if (!old_rss_hdr)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < vi->rss_indir_table_size; ++i)
> +			vi->rss_hdr->indirection_table[i] =
> +				cpu_to_le16(rxfh->indir[i]);
> +		update = true;
> +	}
>  
> +	if (rxfh->key) {
> +		memcpy(old_rss_key, vi->rss_hash_key_data, vi->rss_key_size);
>  		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
>  		update = true;
>  	}
>  
> -	if (update)
> -		virtnet_commit_rss_command(vi);
> +	if (update && !virtnet_commit_rss_command(vi)) {
> +		if (old_rss_hdr)
> +			memcpy(vi->rss_hdr, old_rss_hdr, virtnet_rss_hdr_size(vi));
> +		if (rxfh->key)
> +			memcpy(vi->rss_hash_key_data, old_rss_key, vi->rss_key_size);
> +		kfree(old_rss_hdr);
> +		return -EINVAL;
> +	}
> +
> +	kfree(old_rss_hdr);
>  
>  	return 0;
>  }
> @@ -6171,13 +6195,17 @@ static int virtnet_set_features(struct net_device *dev,
>  	}
>  
>  	if ((dev->features ^ features) & NETIF_F_RXHASH) {
> +		__le32 hash_types = vi->rss_hdr->hash_types;
> +
>  		if (features & NETIF_F_RXHASH)
>  			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>  		else
>  			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
>  
> -		if (!virtnet_commit_rss_command(vi))
> +		if (!virtnet_commit_rss_command(vi)) {
> +			vi->rss_hdr->hash_types = hash_types;
>  			return -EINVAL;
> +		}
>  	}
>  
>  	return 0;

