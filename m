Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD550A68
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831388; cv=none; b=UKtGbhVoEAym+xvz1glNzaQ9v/fyWE0Fr2/GnSHSxKgNl/0yzgcQeNX/e+edNxbzanYNl5pawo6YvsDlz0SnEZIsqAJXLQQWrb6R2feKO4/qjsT/7ycuw+xRwfW8YfoKd0SbV7vimYZ9l8miVSSnmxL+KMLXmDd/L3D899uUQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831388; c=relaxed/simple;
	bh=MMNDdC5RKN1Jdxg0goD3LGsnBX12WLniZFP71v5jPEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P+aCvZcJP5jMqZfHniYKWaF+VUiGdpIH4sxTFBzsw39x2chDboFVwcQI97ywewTx29FJongsJKzpDPaz9yPjAm0U8KUSS+r3l4dFoIXSu3fqQm6JwNPvLb8Jx/T7nzW5i82WyWBE2XZ28DuF6DuiWfEWoSkS84O+QGJROZPEslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoOQA3bG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoOQA3bG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3hVsJSeXW6ttPj94G8nlW1QMrOta7lnbJSX5K4JEfc4=;
	b=hoOQA3bGkwoY8bFTXhjHxyLjU7jrpBhh+1lZb1WzdvW2vVg1lgBDz9BOY+/n5TUO/WB1me
	9rW/Z0I5W91cZJ1IJuylQkm6gM6RxZpIjOrokyi/GE4kJr0aua+dhFC4kBujXWHETXJW00
	uwDmCtDXZI5RpCIFnNOn7QkMHlipGsQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Yeu-F8gFMaWhyuHbo33q7g-1; Tue, 19 Mar 2024 02:56:24 -0400
X-MC-Unique: Yeu-F8gFMaWhyuHbo33q7g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a45acc7f07cso274983166b.2
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831383; x=1711436183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hVsJSeXW6ttPj94G8nlW1QMrOta7lnbJSX5K4JEfc4=;
        b=WeC+lgUYYP5IpXKYqcI6sYmfFcDEX1iyHesJl+BnLdYxIay/1VHNoWfuF91KYGcWyY
         kKOx/oxoAbtVFEkb4fsUUpFYDFzUP6bevySzCDiJp6vGnF3LnSuOYtViW7JsbbrskfqE
         3iQ2P6f1zYT9meZ4VNfYtOUz4VDA/wZa5HwL/wpeBxwESFvjwtudrihOV2yfg/SP0aE4
         DOtbXU/5+uXlsh8xEEtg3jLhRirsJFJAy/TjEZ3ZIkukdERcyvSc/NOo/J8+FVTKAy+O
         v0WUkDDBnfEakpX3bLhPkzJUjpZ2bFjKmfNivR41GFhuJ7/VlShgNTc1dCLj5g9IV8hq
         dwvQ==
X-Gm-Message-State: AOJu0YyyZksL3HxFEN56ut9PMB/5VugFiSGk6cmGJfK/6RUt5sUZqsfm
	RYpIxSzk/KH4dFdlfrGIXg2PmmRpmqKaH1sEWG87a5N3AxJQcVyjF3QJ3S3P/D1e/m+TejQosc0
	YBGIS+ubGiTK7yfMDjT+UdI2gT5jmtdR0Gq3ezDlntGSS4uTiADlGTnhze/5iSwMZ
X-Received: by 2002:a17:906:99d3:b0:a46:749b:58a with SMTP id s19-20020a17090699d300b00a46749b058amr12654578ejn.57.1710831383100;
        Mon, 18 Mar 2024 23:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Iy7NEy2w3rYZ2F97NJp5jJndLlxOUvKjmk8Y3QviM0tYf8x1pYlI0Ftrw741vWnUgfxNYw==
X-Received: by 2002:a17:906:99d3:b0:a46:749b:58a with SMTP id s19-20020a17090699d300b00a46749b058amr12654569ejn.57.1710831382678;
        Mon, 18 Mar 2024 23:56:22 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id k6-20020a1709062a4600b00a46a2779475sm3696377eje.101.2024.03.18.23.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:56:22 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:56:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost v4 00/10] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240319025515-mutt-send-email-mst@kernel.org>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 11:35:47AM +0800, Xuan Zhuo wrote:
> As discussed:
> 
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> 
> If the virtio is premapped mode, the driver should manage the dma info by self.
> So the virtio core should not store the dma info. We can release the memory used
> to store the dma info.
> 
> For virtio-net xmit queue, if the virtio-net maintains the dma info,
> the virtio-net must allocate too much memory(19 * queue_size for per-queue), so
> we do not plan to make the virtio-net to maintain the dma info by default. The
> virtio-net xmit queue only maintain the dma info when premapped mode is enable
> (such as AF_XDP is enable).

This landed when merge window was open already so I'm deferring this
to the next merge window, just to be safe. Jason can you review please?

> So this patch set try to do:
> 
> 1. make the virtio core to do not store the dma info
>     - But if the desc_extra has not dma info, we face a new question,
>       it is hard to get the dma info of the desc with indirect flag.
>       For split mode, that is easy from desc, but for the packed mode,
>       it is hard to get the dma info from the desc. And hardening
>       the dma unmap is safe, we should store the dma info of indirect
>       descs when the virtio core does not store the bufer dma info.
> 
>       So I introduce the "structure the indirect desc table" to
>       allocate space to store dma info of the desc table.
> 
>         +struct vring_split_desc_indir {
>         +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
>         +       u32 len;                        /* Descriptor Array length. */
>         +       u32 num;
>         +       struct vring_desc desc[];
>         +};
> 
>       The follow patches to this:
>          * virtio_ring: packed: structure the indirect desc table
>          * virtio_ring: split: structure the indirect desc table
> 
>     - On the other side, in the umap handle, we mix the indirect descs with
>       other descs. That make things too complex. I found if we we distinguish
>       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> 
>       The follow patches do this.
>          * virtio_ring: packed: remove double check of the unmap ops
>          * virtio_ring: split: structure the indirect desc table
> 
> 2. make the virtio core to enable premapped mode by find_vqs() params
>     - Because the find_vqs() will try to allocate memory for the dma info.
>       If we set the premapped mode after find_vqs() and release the
>       dma info, that is odd.
> 
> 
> Please review.
> 
> Thanks
> 
> v4:
>     1. virtio-net xmit queue does not enable premapped mode by default
> 
> v3:
>     1. fix the conflict with the vp_modern_create_avq().
> 
> v2:
>     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2 addr + len pairs.
>     2. introduce virtnet_sq_free_stats for __free_old_xmit
> 
> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
> 
> Xuan Zhuo (10):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: virtqueue_set_dma_premapped support disable
> 
>  drivers/net/virtio_net.c      |  57 +++--
>  drivers/virtio/virtio_ring.c  | 436 +++++++++++++++++++++-------------
>  include/linux/virtio.h        |   3 +-
>  include/linux/virtio_config.h |  17 +-
>  4 files changed, 307 insertions(+), 206 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

