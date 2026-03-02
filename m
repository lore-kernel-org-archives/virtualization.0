Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7953563EB
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477599; cv=none; b=fxl+GhIswqVhpcTvy5Zyv4hdlwtarFv/ly1GJdl6/hGYegwkUfAmX0tsNeItXLuQDFtGkbAk/Jo6eokJQoFTbwotQZXGTw8rw41gqTaitJxWk3bCHrqfeatv2C3IBczJbO2hcfopfgrLvfDGMzmU9CV1bXaukInD934+EOknP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477599; c=relaxed/simple;
	bh=rGb+d3eXV4/WG6UZVYz2+NJz33h47kbcneDn0cpgFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LMspKxVCDs8Gd/wwSQPsy5s1Nz/IsrSVAtGedZ2fWyWznoOyDSy1OI+jmBLdw2M2Hg6oZCLxK3eKGXU0OfsG20BfLK7N7M3bEyg/abCSRqhHgnFl3Oagc4RM0XGST7U6DWeU7sYCSvwfhZBAk7IpqYUv+uX0G2BzfTkMHsXkTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYlpcGOy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYlpcGOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772477597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5Qbo2pQOAmuJWNlaaVNuPWK+hvBjNdcsVen+Csw5XQ=;
	b=JYlpcGOyeRpIsWxi0m2HIWClmnVyTt9Vd+wF8ceZVvBsXfqVRVJAoEG8iWS823muYPHjPN
	FKaKvc2mFPQkztd78nRgVW5JBQdX4nL28BiFjsJgjL6yajw83i1W8l8AKhHiE447if9B43
	3PCR4LJfdBpTIxSjGEZ+M/JLnfB5apQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-LeJ8Y87XN9S74vco-PKfgw-1; Mon, 02 Mar 2026 13:53:13 -0500
X-MC-Unique: LeJ8Y87XN9S74vco-PKfgw-1
X-Mimecast-MFC-AGG-ID: LeJ8Y87XN9S74vco-PKfgw_1772477592
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836cf00787so53812055e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 10:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477592; x=1773082392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Qbo2pQOAmuJWNlaaVNuPWK+hvBjNdcsVen+Csw5XQ=;
        b=HRnzZNBAg8qjwDZguvJhD4C0vBctlbvsp7Zx62gZ8YrtJNwav2hpQCB3ucHTZMD3am
         WF9hkIeHAomyvWLhvVW4o2yQD9KsgI9bqItebOQHZYXnJnJp/xzgJzIP7hy15i01q6XT
         LpPzQdFGXr5U5dTMSuvz09xUfGXc+t6hp4yGafS3kRZuGkcfNNPipojOSgv/JFKGxTin
         ybMKwqVum33rCdtIGVNHqjB65gXWhW6xig7HWxiVtMhZLocGZ8QhpjjiUSIDHI5YSkXZ
         iFmhnuZanQoGKeA4qtX7IxpGAA18WkDcs5gEhl5uUZWK3SdJQJ/9oFMLR1UfgKc8kFPv
         n3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVtxaneBIYK+vUw2fVHlRcoreAS8uWn0bo523Tc7BoAqqCL65No/Jb2Pm2xHKY65+dTVi9SCYoK2j6mE7E+Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcLzmMZu9kSroqBNKrJh+fCYpXitALLUfGtf69zY93nMybJQRq
	yyBxtuUx6KULHcqmTfQsukCSGepjdBtcKj3nWgJFR5PoK2ynccL1q7bF6YuW/3qm3UevqltyeqW
	mNVHEzr+Wf/PO9pKV3gd5kkcBdWfC99UIZql36xE4FmeAafjevBdukxkrYIYrU7YWpU+k
X-Gm-Gg: ATEYQzxePmZGcCCrPMamJW0X+M1/MiFJRZSWtRuqoJ2CrDqS0IArYKL1SGMEEYU0I5/
	45ePJm0jdoUPRlszo2B2VXF5zUO2LNDMtq0/ChYmCiu93J+r/hUlD6FEY7BZHgXSlgIflbEtZVs
	rfVQNpAJZvs6xGdmjXmQNs0XuK1CG4/OeAFRFoyCoPEAWFjfLhN56/94DVxVqGa6D23lLlSZQej
	BiMTFEGUTNZl6CoEbNRFs8IT0uk5+KXMxzHY/gcnxQt40UYG3vCfjiWtCBKGeBBvbnJtyjDkU5M
	A/0cJVPG+hb271SCskF/TMFxZnhc3DfRKZV2lzjT1SxfIW6DQdx3kWX2wkJHAymVJFOW2W4zhAe
	uiMvjzSs2RcLfzum1c/3vQYnaZW39Jmw0tNexFlhMadqd7w==
X-Received: by 2002:a05:600c:820c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483c9937b2dmr210988995e9.15.1772477592332;
        Mon, 02 Mar 2026 10:53:12 -0800 (PST)
X-Received: by 2002:a05:600c:820c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483c9937b2dmr210988605e9.15.1772477591814;
        Mon, 02 Mar 2026 10:53:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b44207sm315022535e9.7.2026.03.02.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:53:11 -0800 (PST)
Date: Mon, 2 Mar 2026 13:53:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
Message-ID: <20260302135032-mutt-send-email-mst@kernel.org>
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260302164158.4394-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YKvlMbU4Az5FGin9OQRxOCpLLr8wvpHYZ7JL2Xpv9Bs_1772477592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2026 at 11:41:58PM +0700, Bui Quang Minh wrote:
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Fix the flag check in virtnet_xsk_wakeup
> - Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..3614002fc87c 100644
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

With this change, try_fill_recv() can return true even though zero RX
buffers were posted in need_wakeup mode, which contradicts its
documentation ("Returns false if we couldn't fill entirely (OOM)").

Methinks we need to at least update the comment near try_fill_recv.



> +		}
> +
>  		return -ENOMEM;
> +	} else {
> +		xsk_clear_rx_need_wakeup(pool);
> +	}
>  
>  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>  
> @@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
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
>  
>  	if (!netif_running(dev))
>  		return -ENETDOWN;
> @@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  	if (qid >= vi->curr_queue_pairs)
>  		return -EINVAL;
>  
> -	sq = &vi->sq[qid];
> +	if (flag & XDP_WAKEUP_TX) {
> +		struct send_queue *sq = &vi->sq[qid];
> +
> +		xsk_wakeup(&sq->napi, sq->vq);
> +	}
> +
> +	if (flag & XDP_WAKEUP_RX) {
> +		struct receive_queue *rq = &vi->rq[qid];
> +
> +		xsk_wakeup(&rq->napi, rq->vq);
> +	}
>  
> -	xsk_wakeup(sq);
>  	return 0;
>  }
>  
> @@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
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

