Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7A139587
	for <virtualization@lists.linux.dev>; Sun,  8 Sep 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824444; cv=none; b=hac8QN3ONaCX0Th13QWrLlrIVKo0nLZFZ/P9Cq+EAC+Ea3Xfb0Ra415i6+0J0ex45iqWaVA629VX/p29PI14iMIrj3xtOjQKd0w5f9OgRt6+zFgvyPZTudMctd865Kc3nVcNN3JvRXZxd1WMxCNToN/JOr2zuYdb2lyrZVJrFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824444; c=relaxed/simple;
	bh=U+nN3E1s6vUZvmNioTaYSXQCx1nQu47fLqE9xX6Xutg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gec80ttbP1Io7w0ahDQ3q99+x+Qdxgt3D7y8T2Pot+S3PRofiQ5Fra2l7+GBvOyeEMAB2KExh11b/bWfkk+em8MNWh3SlnN4Ka3l+e2Abna/f4mrO8NIlVE3CEQvXzjKnMUC803+rjGJjkzGa8l4saxJpT3xQlRu4B7fHmP8OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgvMWb99; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgvMWb99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725824442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xH+iRr4Jv3/HG+2A0joozYOEglclsfOIN30PzjLMvdI=;
	b=GgvMWb992+FcDEzVu1tEaBPqum/5WCpvxmbLKm1YiMcbMXd2b68JBy2dUpcT46gZMg6zQP
	QP+Y0sI0BN6zXDVaH9TTh5VbU75s6INEhGGUqrfbcPvqo4azUAKZu63BB8OMy3MXKBQnqn
	ZCCtSDcCG0mEK0TXYBL3BaPi0shTWJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-HHKGlaRFPMGDGhcScMR5-A-1; Sun, 08 Sep 2024 15:40:40 -0400
X-MC-Unique: HHKGlaRFPMGDGhcScMR5-A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb374f0cdso2944555e9.0
        for <virtualization@lists.linux.dev>; Sun, 08 Sep 2024 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725824439; x=1726429239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH+iRr4Jv3/HG+2A0joozYOEglclsfOIN30PzjLMvdI=;
        b=dspwTlZyixk6F6ts3SCt52K/5ekkC9dq4TQKLAiS0oFqDMH6QIq51w+8EfP2boJHwZ
         KkhvMuL1NO2V4vOUgvHfDQQeJiK7O3ZK6Tvm90//ePAF8YxULKKUAWCIAWLnXyTTJmyS
         zxosURtF80LzBJKFBAEqJ1RcO1T6tbCF69oNGmvjwrwDDep0BecWZfp6HX0tkPEFig3E
         eplG9RsLN+NsIDpyGqimljIBdxjNbeXNFE20Or87WBLwHAzOBajsf5UUTzA10epPlVQV
         B9Yt1gaeoQA1F4MsEFqwSufEgvtVh9shW5YKsFztOMTXxvNBDTBme6hQVMFFE5POM1DQ
         8v+w==
X-Forwarded-Encrypted: i=1; AJvYcCVDJvNIWLIYD1m7NtzNjoPhzpBCfz57npAlSgcN8naYD9govVUUjNu1wBXCgM0HnZUp9ZgCsUlB5O0JuqJKMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAZRp6NVJzw9erREpnuUrWmBHpD3RfUWAjHA4GQ3I4vfbEp2Fa
	FlOcMPrAcitMkvhfjqkv6ClM7uAQ88W5WFUmJknxTIxaYAHlitwEllyFAL+4SEEhnUtoQLodJgK
	JdVHwRpP4yR/Osc2zZ7T0zebYxGNOIqlHOiLxgDJpO0rqS99lTAVXsc5GgTN+sleu
X-Received: by 2002:a05:600c:1d15:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42c95a5f971mr93118935e9.0.1725824439554;
        Sun, 08 Sep 2024 12:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHOz7cQatdno19/cbSkBNtm4eTHBagKro7YBoMXi0+DetATEzfS2VZvuZtLxKjiCr8GSSkGg==
X-Received: by 2002:a05:600c:1d15:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42c95a5f971mr93118765e9.0.1725824438134;
        Sun, 08 Sep 2024 12:40:38 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c2845sm85328365e9.3.2024.09.08.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:40:37 -0700 (PDT)
Date: Sun, 8 Sep 2024 15:40:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240908153930-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> leads to regression on VM with the sysctl value of:
> 
> - net.core.high_order_alloc_disable=1
> 
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> the first buffer of the frag is affected.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


BTW why isn't it needed if we revert f9dac92ba908?

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  	void *buf, *head;
>  	dma_addr_t addr;
>  
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>  	head = page_address(alloc_frag->page);
>  
>  	dma = head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;
> +
>  	buf = virtnet_rq_alloc(rq, len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +		return -ENOMEM;
> +
> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> +		len -= sizeof(struct virtnet_rq_dma);
> +
>  	buf = virtnet_rq_alloc(rq, len + room, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> -- 
> 2.32.0.3.g01195cf9f

