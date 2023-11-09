Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56D1D546
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCj/3aw3"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 917B5415E7
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 12:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 917B5415E7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bCj/3aw3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KWuCvuICckq
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 12:06:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD23A415C9
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 12:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD23A415C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699531583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HczSlh6k8idx0RX4fYohX/UOTD9Fux3MDTZW+Rddgqc=;
	b=bCj/3aw3VmEPr0MhxE/BxjR1tErAoNWabW7vv6a6x1mEOHPWYQURR273XyLnLSCjsYasl5
	BPdABoOH3JITMjLL7b9z11rJ+1TKRyaqcqnjwMGqn9chnk7MgfVCTG1hS3Y5PQpzbotFW8
	Qe0JMfzVQUzA6+lyS/1vKwwnEK3k+ss=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-tyl9XNN1PN6YBugVseMfUw-1; Thu, 09 Nov 2023 07:06:22 -0500
X-MC-Unique: tyl9XNN1PN6YBugVseMfUw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9e27cc6dbf0so61813766b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 04:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531580; x=1700136380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HczSlh6k8idx0RX4fYohX/UOTD9Fux3MDTZW+Rddgqc=;
        b=WZ3mfhH24ft7eWUJgjXo9kcZvjFYkEYFU/mXpkd89pnacZ6Yxhd2uqVa3sJaz0TOD6
         vTnxGLgCxy4nPui7kfDkbn0IpqqNXFQe0vlsXqCfsSGChHVWuF1nvO5iAc1wuq6iJcra
         NLLwaKMTkgojbnf+u4cyefy4qcYYPs1WPhkDB6f1F5tMu8laIlH2MznWk34qMA0Vbhob
         7GydAsMy6o3h/3a7xUD73M05NRw4JvwMGV/Id2fkYymjcEzU75DdPkLVrksDQYAt8WLE
         /DAm7BUyGmegI1CxONbhXSa2X8o+tgsTplj/cxGvjba+ZOPgqaFvd6sJyxlHbKJVy33i
         GJdA==
X-Gm-Message-State: AOJu0YwAyU0qxgzTUzXGo4LY2skw6EHdN1tutXsJ5IkMg7LaAljxyYNj
	cMw8YVMPSbZRFfOaU3MdOFxP2Zufdqc08YMsGwvBavDI/9d/rHAH3I9DUw+m7N06Nsi3VYYZN5Z
	spztGgbAyixy71R3Xlg7gRzsHlT9M1Lken1Tg0SJAaUuUGNSVJw==
X-Received: by 2002:a17:907:944d:b0:9df:e39d:e0ed with SMTP id dl13-20020a170907944d00b009dfe39de0edmr3980261ejc.24.1699531580650;
        Thu, 09 Nov 2023 04:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3c9N8uienSCMFMaSNgRUsN1RMqRrgawzGF8dpQ3zGGTRC3h7IvBxqjNXqZRtJc9Uth6kwTw==
X-Received: by 2002:a17:907:944d:b0:9df:e39d:e0ed with SMTP id dl13-20020a170907944d00b009dfe39de0edmr3980236ejc.24.1699531580310;
        Thu, 09 Nov 2023 04:06:20 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709065ad900b009ae587ce128sm2447121ejs.216.2023.11.09.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:06:19 -0800 (PST)
Date: Thu, 9 Nov 2023 07:06:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net] virtio_net: fix missing dma unmap for resize
Message-ID: <20231109070359-mutt-send-email-mst@kernel.org>
References: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2023 at 04:18:32PM +0800, Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
> 
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
> 
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
> 
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
> 
> If we do such script, we will make the system OOM.
> 
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d16f592c2061..6423a3a007ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -408,6 +408,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void virtnet_rq_free_buf(struct virtnet_info *vi,
> +				struct receive_queue *rq, void *buf)
> +{
> +	if (vi->mergeable_rx_bufs)
> +		put_page(virt_to_head_page(buf));
> +	else if (vi->big_packets)
> +		give_pages(rq, buf);
> +	else
> +		put_page(virt_to_head_page(buf));
> +}
> +

>  static void enable_delayed_refill(struct virtnet_info *vi)
>  {
>  	spin_lock_bh(&vi->refill_lock);
> @@ -634,17 +645,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	return buf;
>  }
>  
> -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> -{
> -	void *buf;
> -
> -	buf = virtqueue_detach_unused_buf(rq->vq);
> -	if (buf && rq->do_dma)
> -		virtnet_rq_unmap(rq, buf, 0);
> -
> -	return buf;
> -}
> -
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  {
>  	struct virtnet_rq_dma *dma;
> @@ -1764,7 +1764,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
>  		DEV_STATS_INC(dev, rx_length_errors);
> -		virtnet_rq_free_unused_buf(rq->vq, buf);
> +		virtnet_rq_free_buf(vi, rq, buf);
>  		return;
>  	}
>  
> @@ -4034,14 +4034,15 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
> +	struct receive_queue *rq;
>  	int i = vq2rxq(vq);
>  
> -	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> -	else if (vi->big_packets)
> -		give_pages(&vi->rq[i], buf);
> -	else
> -		put_page(virt_to_head_page(buf));
> +	rq = &vi->rq[i];
> +
> +	if (rq->do_dma)
> +		virtnet_rq_unmap(rq, buf, 0);
> +
> +	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  

So we have virtnet_rq_free_buf which sounds like it should free any
buf, and we have virtnet_rq_free_unused_buf which is only for unused.
Or so it would seem from names but this is not true.
Better function names?

>  static void free_unused_bufs(struct virtnet_info *vi)
> @@ -4057,10 +4058,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		struct receive_queue *rq = &vi->rq[i];
> +		struct virtqueue *vq = vi->rq[i].vq;
>  
> -		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> -			virtnet_rq_free_unused_buf(rq->vq, buf);
> +		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> +			virtnet_rq_free_unused_buf(vq, buf);
>  		cond_resched();
>  	}
>  }
> -- 
> 2.32.0.3.g01195cf9f

