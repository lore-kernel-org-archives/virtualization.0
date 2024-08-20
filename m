Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED41AD9D9
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184723; cv=none; b=rHXonCILF3G/i7uWNPMogNaztF4ffD3sv9WVO0f5al+i7Vr9PErEQXH6Ihxgf4W9X8LqFwS1nR/4kY+qomHj5gbL0BgoqVDBP89XpEQQv38J4oDx6Fk2uJo6EuLumM6tBLFsinaUD8UnakA+svTIiclLnRyk0S3FeeRGa6qmJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184723; c=relaxed/simple;
	bh=Qdb48a2spoj1Z2CL+Rgu8TqheK3+EqdNCApffkuRdoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uj8GgEv3t/044wYYS1WHlr+mdOLqv9USr5wIJaBpcEJF9cZJlNxahAtE1wwYnW+Vl4tnIn/M1Wu+z0jDV9aloYQyqNDg1E4fYGduHSUg5xKg0cGbmRBJH9J82CFKiznWGdCYQ9tgji7DuddkmeJZIQEqm0kwgXD5cgVP/ncjuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgedWkPN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgedWkPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724184720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68TuSUMbg5Dtwr1fZHwgjM6dvF8jw7J+Ngw4TY1BJGE=;
	b=GgedWkPNVdXGQfkj+zKdZN8Knp/VR28YCXKjttpPylB2wYcNqGJ3nPJHy8qFgsRGx1OmB5
	qLG2EwekOG8QHX3Ca5gtS0JgsyvuJ4udM4ASvir9qNVAVyeuRoMz4R6oUQwEa/XZNjtnqF
	rvx8WKGTaYS92xJ7hSNVIDniqposvek=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-eVD5lg_JPmGzTd_SaABLHg-1; Tue, 20 Aug 2024 16:11:58 -0400
X-MC-Unique: eVD5lg_JPmGzTd_SaABLHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3719ce5627eso2468352f8f.1
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 13:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184717; x=1724789517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68TuSUMbg5Dtwr1fZHwgjM6dvF8jw7J+Ngw4TY1BJGE=;
        b=swjeu8wZx+hP/dxdAn1Eu7DLsDJkXBTBfMf9A69YkHJGNwhlOb8ZJklkRNSZNNEabP
         tDQMNK9D0dByYE6PYZiDUobV/xVTVP23sQQJTZxCdGxmCGi8M5Yh5s4vrRVjmuZeFoNZ
         i/xO0gfMjNSuJHmdXmPaO/yFMvY49fifLuIltsmINJPcAz81nn2hdCHkiybnUa0Bx5qA
         Ny1sST64XsmxXYRQMXZ606/hXkEe4Dbf8unFare1zko9j/L7WsCrpfssAoYyxknGhJh0
         IvPvy8hSyZcNhJbXotiwVCJzpxVXjGr5GM/N1DVrxx5BAoeGZ2ikKhFHzppVtlWrVDbc
         hCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfqxsx6NUlmmZaW3/+Q+H9JBxdsaTteax9pv3lQT4YZDEYTAZ7WP8bRjzhmikh/LGI6p0DNY1cNzEVFPPrvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIKinh1NzPrUwlZFDLu9PxBKJoSUpdvLU8CtZdQEv8NtLOVOhK
	DkruzhqQcmMmnzsrdFbzZg2NK7Zk0M5FYzomvy49W/pTeMtwbbvKi6fdy4fyyCmb/PNGd5gZms3
	CNStzOO9xsZYzsYZz2vYudue8htFkRpofolrlonf5+uiMZ3fwY7pmxRI5z0VUU5cA
X-Received: by 2002:a5d:6a4a:0:b0:36b:aa9d:785c with SMTP id ffacd0b85a97d-372fd73101dmr62291f8f.52.1724184717396;
        Tue, 20 Aug 2024 13:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrTnPNJF+mrNURdrMjwXWN0UKounUGVPZsd/QtxDOJIR5LFamNYfLw6y/JpG/4uzIXVf0sQ==
X-Received: by 2002:a5d:6a4a:0:b0:36b:aa9d:785c with SMTP id ffacd0b85a97d-372fd73101dmr62270f8f.52.1724184716513;
        Tue, 20 Aug 2024 13:11:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984967dsm13918330f8f.34.2024.08.20.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:11:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:11:52 -0400
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
Message-ID: <20240820160920-mutt-send-email-mst@kernel.org>
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

From API POV, I don't like it that virtnet_rq_alloc relies on
the caller to invoke skb_page_frag_refill.
It's better to pass in the length to refill.

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

