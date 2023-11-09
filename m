Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CF1078F
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwB+GFEH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C53E60AAF
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 08:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C53E60AAF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwB+GFEH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sN6xqXhLi9qv
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 08:15:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB5DE6114C
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 08:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB5DE6114C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699517710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1MZTY0O2dPelAjqmuHM1qmWRJLOj+88Y5VWEtfM7Q0=;
	b=bwB+GFEHJs4Ur0Nmr+mg89BsvUdaCv1/kSeNsQVAael20/9FIfVWAmCcVux7xoERQp3dGz
	SPigGHUj6usTEA8I7xjRHvFWmshCvTE2HnqrpANTXQopV/vxgm/9UNUdH0JjtU86n3bjtg
	LpgNvmqoX7XdjamUf15ntUQUwgAW6KM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-uKkAvbi6MrO45UGiSH6n9w-1; Thu, 09 Nov 2023 03:15:09 -0500
X-MC-Unique: uKkAvbi6MrO45UGiSH6n9w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e31708ad72so47027166b.3
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 00:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517708; x=1700122508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1MZTY0O2dPelAjqmuHM1qmWRJLOj+88Y5VWEtfM7Q0=;
        b=wVg6vzdrIdHUPmxqHPH+mjqPaXzlK1I97PVW7aVpr2KldWpGHl0ydhAPzZ5oyETJkn
         /I/OPmXp+14okMY1UYRh5smsEYKEY9BDd2sDWpP0ysDNGqUMsYkiE5yF0OUirWJH+BDh
         Spnp7JmO8JKZLXzUG6gvVzDDkMmMmcAUfE3GBq0QPFcRhMZq2UtvVaR+ZGuQ4a8v7llb
         Pp33rKp+xxF7ebse6TOEpn/TaHxKc+3ENGXFMQrr0aAcYt5DfgwD8R3d2aJkHsWoeIbP
         NczFGu7PFjSTrAnUVVbzMLwCU10q/u4ht5/yaqa6QU+a534KX97aiuGzBHBz8N9GL3VZ
         ycSA==
X-Gm-Message-State: AOJu0YxfF4+yH9nnxDg4/FCVU2W1rdUc9Ic7UgbG7JutP+BD//vyjWFW
	z5h9VVbViRRWjQmldJZNw4GLT9TEoypTpbaFlXZ1Q6XZMjDSEw/NWpzHtK9xi7LQ61Js8gFiS1j
	suyPno5MNQAJVMcBDxlryz34ZwgjzesUtxtelyFoRQA==
X-Received: by 2002:a17:907:72d2:b0:9e0:5d5c:aa6d with SMTP id du18-20020a17090772d200b009e05d5caa6dmr3638446ejc.20.1699517708287;
        Thu, 09 Nov 2023 00:15:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpU3MhXZeWVJ99B6VMP356iL5x2p0xFm35pSCHy/HUi/fikXGBhzSPC6P7WxyGEaa1jJuIJg==
X-Received: by 2002:a17:907:72d2:b0:9e0:5d5c:aa6d with SMTP id du18-20020a17090772d200b009e05d5caa6dmr3638421ejc.20.1699517707967;
        Thu, 09 Nov 2023 00:15:07 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id lg5-20020a170906f88500b00992b2c55c67sm2216420ejb.156.2023.11.09.00.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:15:07 -0800 (PST)
Date: Thu, 9 Nov 2023 03:15:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 17/21] virtio_net: xsk: rx: skip dma unmap
 when rq is bind with AF_XDP
Message-ID: <20231109031347-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2023 at 11:12:23AM +0800, Xuan Zhuo wrote:
> When rq is bound with AF_XDP, the buffer dma is managed
> by the AF_XDP APIs. So the buffer got from the virtio core should
> skip the dma unmap operation.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


I don't get it - is this like a bugfix?
And why do we need our own flag and checks?
Doesn't virtio core DTRT?

> ---
>  drivers/net/virtio/main.c       | 8 +++++---
>  drivers/net/virtio/virtio_net.h | 3 +++
>  drivers/net/virtio/xsk.c        | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 15943a22e17d..a318b2533b94 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
>  	void *buf;
>  
>  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf && rq->do_dma)
> +	if (buf && rq->do_dma_unmap)
>  		virtnet_rq_unmap(rq, buf, *len);
>  
>  	return buf;
> @@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
>  
>  		/* disable for big mode */
>  		if (vi->mergeable_rx_bufs || !vi->big_packets) {
> -			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
>  				vi->rq[i].do_dma = true;
> +				vi->rq[i].do_dma_unmap = true;
> +			}
>  		}
>  	}
>  }
> @@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
>  
>  	rq = &vi->rq[i];
>  
> -	if (rq->do_dma)
> +	if (rq->do_dma_unmap)
>  		virtnet_rq_unmap(rq, buf, 0);
>  
>  	virtnet_rq_free_buf(vi, rq, buf);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index 1242785e311e..2005d0cd22e2 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -135,6 +135,9 @@ struct virtnet_rq {
>  	/* Do dma by self */
>  	bool do_dma;
>  
> +	/* Do dma unmap after getting buf from virtio core. */
> +	bool do_dma_unmap;
> +
>  	struct {
>  		struct xsk_buff_pool *pool;
>  
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index e737c3353212..b09c473c29fb 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
>  		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
>  
>  	rq->xsk.pool = pool;
> +	rq->do_dma_unmap = !pool;
>  
>  	virtnet_rx_resume(vi, rq);
>  
> -- 
> 2.32.0.3.g01195cf9f

