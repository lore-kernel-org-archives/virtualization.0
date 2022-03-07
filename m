Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7FCC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 22:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AAF881366;
	Mon,  7 Mar 2022 22:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTzx-qmVPJuU; Mon,  7 Mar 2022 22:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EEE3D81346;
	Mon,  7 Mar 2022 22:18:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE274C0012;
	Mon,  7 Mar 2022 22:18:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C04BC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A11081366
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZcysKep_IVe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5126181346
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646691482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFnTaI43lavXr0zuCkHA2ZcyUcWqspn6tFseaLpKUCE=;
 b=jI8rsE0dVuztYUBZAiGb5jX/970D2Suda8Kbc61nYw0E1b0x48ZU1qNALumJsnUs6lsZXI
 1lyu4wncOQX0ONy1nyD7MWdBJ5beNoSXcU0HZ130PuGdyDbaJqp+CUh8rGqb7kNS2xVkK9
 hXiTluGMcZSEILW+S3qMFuz1mvE1zsk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-7YYYMGN0NCuWx5ASDfj7Xw-1; Mon, 07 Mar 2022 17:18:00 -0500
X-MC-Unique: 7YYYMGN0NCuWx5ASDfj7Xw-1
Received: by mail-ed1-f69.google.com with SMTP id
 s7-20020a508dc7000000b0040f29ccd65aso9431147edh.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 14:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iFnTaI43lavXr0zuCkHA2ZcyUcWqspn6tFseaLpKUCE=;
 b=AbJKmokGHI94stmlvWANsw8Xvk3MzCHdyELEnYrqY7q4efLGANpOm5Mz8+S5xPXB0y
 JQJa36f3ke1e/CeY6BWq3+EkjUmIUGBS4649DMvgFgDYRV4S4oBuD5gV6HNWC56LO43R
 3OjoBxMcw6Slb47lSEyn5stKhurIG8ShOa+G2+FQY5XiP7MHWhHpxIdkt0IeG7o1OYS4
 bdWYEYDzsl7ApmoCFncJDE6A9mrxNQWxBPcU/3DO5AxsEvuVZPN//gWZIVt7GLQPkKo5
 WJ12JgL0SQwp9cgdTLkiM1hvUp0b4gxcHqgiV7dV06fHSoEVcdOmBiRFRWqm9WcLpEyd
 B0UA==
X-Gm-Message-State: AOAM533HUea4XWM1MSILUZZHeGt9xaFdAD6Szrrpodnc6WOlSt/ohFYd
 iDSMtsDtIrrUImH9xUuGPt3tmByYxr5bAw1ZiEZOs72zYIbXStOGM4DwUQ1DNKy5Rae/GHnw3BJ
 pAKTiu2MAX1qmUwBe+rjPs/j6jU3aZIhKG5mhK4bMTg==
X-Received: by 2002:a17:907:3e9a:b0:6db:b5e:676c with SMTP id
 hs26-20020a1709073e9a00b006db0b5e676cmr8489729ejc.314.1646691479807; 
 Mon, 07 Mar 2022 14:17:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDeGEIDmtuFmkZLr82drLK9sutEnJoYFwl22WhDCUdWElmN9EcTUW1/sSRnLfyl48w2KixZw==
X-Received: by 2002:a17:907:3e9a:b0:6db:b5e:676c with SMTP id
 hs26-20020a1709073e9a00b006db0b5e676cmr8489720ejc.314.1646691479562; 
 Mon, 07 Mar 2022 14:17:59 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 s14-20020aa7cb0e000000b00410bf015567sm6554353edt.92.2022.03.07.14.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 14:17:58 -0800 (PST)
Date: Mon, 7 Mar 2022 17:17:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v6 06/26] virtio_ring: packed: extrace the logic of
 creating vring
Message-ID: <20220307171629-mutt-send-email-mst@kernel.org>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
 <20220224081102.80224-7-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220224081102.80224-7-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
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

On Thu, Feb 24, 2022 at 04:10:42PM +0800, Xuan Zhuo wrote:
> Separate the logic of packed to create vring queue.
> 
> For the convenience of passing parameters, add a structure
> vring_packed.
> 
> This feature is required for subsequent virtuqueue reset vring.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Subject has a typo.
Besides:

> ---
>  drivers/virtio/virtio_ring.c | 121 ++++++++++++++++++++++++++---------
>  1 file changed, 92 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dc6313b79305..41864c5e665f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -92,6 +92,18 @@ struct vring_split {
>  	struct vring vring;
>  };
>  
> +struct vring_packed {
> +	u32 num;
> +	struct vring_packed_desc *ring;
> +	struct vring_packed_desc_event *driver;
> +	struct vring_packed_desc_event *device;
> +	dma_addr_t ring_dma_addr;
> +	dma_addr_t driver_event_dma_addr;
> +	dma_addr_t device_event_dma_addr;
> +	size_t ring_size_in_bytes;
> +	size_t event_size_in_bytes;
> +};
> +
>  struct vring_virtqueue {
>  	struct virtqueue vq;
>  
> @@ -1683,45 +1695,101 @@ static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *v
>  	return desc_extra;
>  }
>  
> -static struct virtqueue *vring_create_virtqueue_packed(
> -	unsigned int index,
> -	unsigned int num,
> -	unsigned int vring_align,
> -	struct virtio_device *vdev,
> -	bool weak_barriers,
> -	bool may_reduce_num,
> -	bool context,
> -	bool (*notify)(struct virtqueue *),
> -	void (*callback)(struct virtqueue *),
> -	const char *name)
> +static void vring_free_vring_packed(struct vring_packed *vring,
> +				    struct virtio_device *vdev)
> +{
> +	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> +	struct vring_packed_desc_event *driver, *device;
> +	size_t ring_size_in_bytes, event_size_in_bytes;
> +	struct vring_packed_desc *ring;
> +
> +	ring                  = vring->ring;
> +	driver                = vring->driver;
> +	device                = vring->device;
> +	ring_dma_addr         = vring->ring_size_in_bytes;
> +	event_size_in_bytes   = vring->event_size_in_bytes;
> +	ring_dma_addr         = vring->ring_dma_addr;
> +	driver_event_dma_addr = vring->driver_event_dma_addr;
> +	device_event_dma_addr = vring->device_event_dma_addr;
> +
> +	if (device)
> +		vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> +
> +	if (driver)
> +		vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> +
> +	if (ring)
> +		vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);

ring_size_in_bytes is uninitialized here.

Which begs the question how was this tested patchset generally and
this patch in particular.
Please add note on tested configurations and tests run to the patchset.

> +}
> +
> +static int vring_create_vring_packed(struct vring_packed *vring,
> +				    struct virtio_device *vdev,
> +				    u32 num)
>  {
> -	struct vring_virtqueue *vq;
>  	struct vring_packed_desc *ring;
>  	struct vring_packed_desc_event *driver, *device;
>  	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>  	size_t ring_size_in_bytes, event_size_in_bytes;
>  
> +	memset(vring, 0, sizeof(*vring));
> +
>  	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
>  
>  	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
>  				 &ring_dma_addr,
>  				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>  	if (!ring)
> -		goto err_ring;
> +		goto err;
> +
> +	vring->num = num;
> +	vring->ring = ring;
> +	vring->ring_size_in_bytes = ring_size_in_bytes;
> +	vring->ring_dma_addr = ring_dma_addr;
>  
>  	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
> +	vring->event_size_in_bytes = event_size_in_bytes;
>  
>  	driver = vring_alloc_queue(vdev, event_size_in_bytes,
>  				   &driver_event_dma_addr,
>  				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>  	if (!driver)
> -		goto err_driver;
> +		goto err;
> +
> +	vring->driver = driver;
> +	vring->driver_event_dma_addr = driver_event_dma_addr;
>  
>  	device = vring_alloc_queue(vdev, event_size_in_bytes,
>  				   &device_event_dma_addr,
>  				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>  	if (!device)
> -		goto err_device;
> +		goto err;
> +
> +	vring->device = device;
> +	vring->device_event_dma_addr = device_event_dma_addr;
> +	return 0;
> +
> +err:
> +	vring_free_vring_packed(vring, vdev);
> +	return -ENOMEM;
> +}
> +
> +static struct virtqueue *vring_create_virtqueue_packed(
> +	unsigned int index,
> +	unsigned int num,
> +	unsigned int vring_align,
> +	struct virtio_device *vdev,
> +	bool weak_barriers,
> +	bool may_reduce_num,
> +	bool context,
> +	bool (*notify)(struct virtqueue *),
> +	void (*callback)(struct virtqueue *),
> +	const char *name)
> +{
> +	struct vring_virtqueue *vq;
> +	struct vring_packed vring;
> +
> +	if (vring_create_vring_packed(&vring, vdev, num))
> +		goto err_vq;
>  
>  	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>  	if (!vq)
> @@ -1753,17 +1821,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
>  
> -	vq->packed.ring_dma_addr = ring_dma_addr;
> -	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
> -	vq->packed.device_event_dma_addr = device_event_dma_addr;
> +	vq->packed.ring_dma_addr = vring.ring_dma_addr;
> +	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
> +	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
>  
> -	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
> -	vq->packed.event_size_in_bytes = event_size_in_bytes;
> +	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
> +	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
>  
>  	vq->packed.vring.num = num;
> -	vq->packed.vring.desc = ring;
> -	vq->packed.vring.driver = driver;
> -	vq->packed.vring.device = device;
> +	vq->packed.vring.desc = vring.ring;
> +	vq->packed.vring.driver = vring.driver;
> +	vq->packed.vring.device = vring.device;
>  
>  	vq->packed.next_avail_idx = 0;
>  	vq->packed.avail_wrap_counter = 1;
> @@ -1804,12 +1872,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  err_desc_state:
>  	kfree(vq);
>  err_vq:
> -	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> -err_device:
> -	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> -err_driver:
> -	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> -err_ring:
> +	vring_free_vring_packed(&vring, vdev);
>  	return NULL;
>  }
>  
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
