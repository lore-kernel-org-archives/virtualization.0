Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BFEC433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 16:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 217AF416C5;
	Fri,  4 Mar 2022 16:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnkI14w5inKU; Fri,  4 Mar 2022 16:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFC79416B5;
	Fri,  4 Mar 2022 16:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85655C0012;
	Fri,  4 Mar 2022 16:38:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1338CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2D34841AC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wumEaMUuf4Ug
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:38:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F2A0841B0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646411903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EPRGQE/0v4vpBDuxKxWtHT4mXa5VDUCWuXpciIweIM=;
 b=B1dHfb5lcSUXuRq3RGGJF7EJAVqrKAY4qPWG/OSDlHRtoJzI/aVEUoD5nq58lrRtWqnMlQ
 /97kBmCp8YCV/C0bpJuCazOKN3oS1NQv9byAhQL6ZYV9yeXov05h1vtnDYIXpth8arKXxA
 f3kh9IkTfM6P7mCLeaiiTKA6AHRITDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-wVHv9wuINBOH-1sWiABzhQ-1; Fri, 04 Mar 2022 11:38:22 -0500
X-MC-Unique: wVHv9wuINBOH-1sWiABzhQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 e6-20020a5d4e86000000b001f045d4a962so3356160wru.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 08:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6EPRGQE/0v4vpBDuxKxWtHT4mXa5VDUCWuXpciIweIM=;
 b=pdPEcDircdUfUFUOuoT0M5GpiBRyLBLvwbcI8mgaZ2MOSMPKMpL4cVb3g5kVfFJCKl
 VU+6DlwUCPeSaUeQbLEafCILmzl7RhIU+O5pCcsAeNTk6SrIj0dVJHtu5NYgWaQNu3bU
 1uix2LhhWGUcWDL04wtK7XucDRVT3dOOmKFWa8YzM8YoKPb0/vIkBihun9wkIuKVtzKA
 tBHL+ygnh9fSgAGqGfQvdqorEqU7IDhZOD6xGmoTOY3WMu6xTvsoyF4B7lB5kGax0PFW
 QX99CGWrr5DJNA0+NOrJlB9zAo0zssblqyVWpeG2r7ineyT8Lv6G+IKtDzM+CWyMH3x6
 4xww==
X-Gm-Message-State: AOAM531Z4PrVHoLO65S5hXcAc1xlldQAO9FoOsN1sWmPWqqgBwwIrEHP
 SqYeq4ZHz3A7jkCQZdhFuwQ6mUcvUya+GA7ny1qvMiqvI2TIUlw1fdx5ZzE73FHOHcYO+0d9ixP
 DJVgsbV8sAzSFO49avdgnBQLaQwEPDcNy3HhZgAYkoA==
X-Received: by 2002:a5d:4ccc:0:b0:1f0:d0d7:3239 with SMTP id
 c12-20020a5d4ccc000000b001f0d0d73239mr2290170wrt.137.1646411900372; 
 Fri, 04 Mar 2022 08:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfLvl3TD7vPXLKPydZXT7gU3bFx7qvbxDxEGWlF41piBEtxcGWoo0f2y7oLmHBQVDBL5m8Qw==
X-Received: by 2002:a5d:4ccc:0:b0:1f0:d0d7:3239 with SMTP id
 c12-20020a5d4ccc000000b001f0d0d73239mr2290148wrt.137.1646411900072; 
 Fri, 04 Mar 2022 08:38:20 -0800 (PST)
Received: from redhat.com ([2.52.16.157]) by smtp.gmail.com with ESMTPSA id
 m128-20020a1ca386000000b003898b148bf0sm460195wme.20.2022.03.04.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 08:38:19 -0800 (PST)
Date: Fri, 4 Mar 2022 11:38:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 9/9] virtio_net: xdp xmit use virtio dma api
Message-ID: <20220304113316-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220224110402.108161-10-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220224110402.108161-10-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 24, 2022 at 07:04:02PM +0800, Xuan Zhuo wrote:
> XDP xmit uses virtio dma api for DMA operations. No longer let virtio
> core manage DMA address.
> 
> To record the DMA address, allocate a space in the xdp_frame headroom to
> store the DMA address.
> 
> Introduce virtnet_return_xdp_frame() to release the xdp frame and
> complete the dma unmap operation.

This commit suffers from the same issue as most other commits
in this series: log just repeats what patch is doing without
adding motivation.

So with this patch applied, what happened exactly? Did something
previously broken start working now?
This is what we want in the commit log, first of all.

Thanks!

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a801ea40908f..0efbf7992a95 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -321,6 +321,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void virtnet_return_xdp_frame(struct send_queue *sq,
> +				     struct xdp_frame *frame)
> +{
> +	struct virtnet_info *vi = sq->vq->vdev->priv;
> +	dma_addr_t *p_addr, addr;
> +
> +	p_addr = frame->data - sizeof(*p_addr);
> +	addr = *p_addr;
> +
> +	virtio_dma_unmap(&vi->vdev->dev, addr, frame->len, DMA_TO_DEVICE);
> +
> +	xdp_return_frame(frame);
> +}
> +
>  static void virtqueue_napi_schedule(struct napi_struct *napi,
>  				    struct virtqueue *vq)
>  {
> @@ -504,9 +518,11 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  				   struct xdp_frame *xdpf)
>  {
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct device *dev = &vi->vdev->dev;
> +	dma_addr_t addr, *p_addr;
>  	int err;
>  
> -	if (unlikely(xdpf->headroom < vi->hdr_len))
> +	if (unlikely(xdpf->headroom < vi->hdr_len + sizeof(addr)))
>  		return -EOVERFLOW;
>  
>  	/* Make room for virtqueue hdr (also change xdpf->headroom?) */
> @@ -516,10 +532,21 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  	memset(hdr, 0, vi->hdr_len);
>  	xdpf->len   += vi->hdr_len;
>  
> -	sg_init_one(sq->sg, xdpf->data, xdpf->len);
> +	p_addr = xdpf->data - sizeof(addr);
> +
> +	addr = virtio_dma_map(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
> +
> +	if (virtio_dma_mapping_error(dev, addr))
> +		return -ENOMEM;
> +
> +	*p_addr = addr;
> +
> +	sg_init_table(sq->sg, 1);
> +	sq->sg->dma_address = addr;
> +	sq->sg->length = xdpf->len;
>  
> -	err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdp_to_ptr(xdpf),
> -				   GFP_ATOMIC);
> +	err = virtqueue_add_outbuf_premapped(sq->vq, sq->sg, 1,
> +					     xdp_to_ptr(xdpf), GFP_ATOMIC);
>  	if (unlikely(err))
>  		return -ENOSPC; /* Caller handle free/refcnt */
>  
> @@ -600,7 +627,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>  
>  			bytes += frame->len;
> -			xdp_return_frame(frame);
> +			virtnet_return_xdp_frame(sq, frame);
>  		} else {
>  			struct sk_buff *skb = ptr;
>  
> @@ -1486,7 +1513,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>  
>  			bytes += frame->len;
> -			xdp_return_frame(frame);
> +			virtnet_return_xdp_frame(sq, frame);
>  		}
>  		packets++;
>  	}
> @@ -2815,7 +2842,8 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  			if (!is_xdp_frame(buf))
>  				dev_kfree_skb(buf);
>  			else
> -				xdp_return_frame(ptr_to_xdp(buf));
> +				virtnet_return_xdp_frame(vi->sq + i,
> +							 ptr_to_xdp(buf));
>  		}
>  	}
>  
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
