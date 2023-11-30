Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33573985D
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMC5U3Sh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68AB541BBB
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68AB541BBB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMC5U3Sh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljn_GLlXF-VO
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 09:46:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9640C41BB7
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:46:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9640C41BB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701337568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfGI1qlZAEAF2BhJp3RmJxUya50qDURSNVaHY6y9EXQ=;
	b=CMC5U3ShmI9Sg2GzaDpubXP3ilLl9XEiMNQ2+irL31JmEMEzZe+Am6/MPS2gS9T0PnObOY
	Dh02vxIaAhxV8MHss+NziQ8qeQZAyMMRZHTCShXzc57/0mEQ6er5zHSPdHxi9fe9eeFgy7
	hF3449c+nJF4w4EeBAYp2+zVSc+scyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Y1kvJ43dOS6ZlhjwC0HXgQ-1; Thu, 30 Nov 2023 04:46:05 -0500
X-MC-Unique: Y1kvJ43dOS6ZlhjwC0HXgQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332ee20a3f0so815729f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 01:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337563; x=1701942363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfGI1qlZAEAF2BhJp3RmJxUya50qDURSNVaHY6y9EXQ=;
        b=t4rPqBZU/XalU3/9pejel/yZgsqHrbmudbWskfF7xcmi9bZbh6P+BugDTIh1J00T3H
         2YWPloQhK8Kjj21cwCYSCWTgPS4RbCsAkU2AyQjYdOKl+AL1PRNW/07DY9ceAV66BjAA
         xxbGqvkGBhCS2oD2iEHws9TXF0MZl4Tbvo0XTG96C6s0OeXlarLmNEiWBE2XTSVNZH/p
         RWffgHwiVfJkiXfYY7DQPb6OOWBZoiXyujLmTUysHo2MEGdz/++Gg6zdbfjXnfNW3IFG
         9nbHxhqiWjRXEWWvIU/4cbthv5Ykq3fBEvaEDVgrcCpLrHR19Rp81/9cEzxWstP9v9UZ
         RwIA==
X-Gm-Message-State: AOJu0Yxzj5mbSjMwiNc6yK/T+RCtdMhM+rk10qJScdJ2ldLk57ZTjDeo
	nxhk5rLQSfNEPIVIwrE3Z1X8CWOuM4OOONreVMrXDYAQHhEKkNCVoKATFcOxHfJt9MHlOQ5wGTH
	/AZdjuDdkDPvxH5LAY8Y5MqA1H2yZTysLsAuETw0SzQ==
X-Received: by 2002:adf:f18a:0:b0:333:2003:f8d5 with SMTP id h10-20020adff18a000000b003332003f8d5mr1300584wro.47.1701337563313;
        Thu, 30 Nov 2023 01:46:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ1YqAf91AEdYFb/UmG1d2aec7j4UFFqWCYZRHFF8ZmzzWbiemhO2JFaP7Qe8H76kv8gs1Wg==
X-Received: by 2002:adf:f18a:0:b0:333:2003:f8d5 with SMTP id h10-20020adff18a000000b003332003f8d5mr1300567wro.47.1701337562911;
        Thu, 30 Nov 2023 01:46:02 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id t3-20020adfe443000000b00332fcdafc22sm1036634wrm.70.2023.11.30.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:46:02 -0800 (PST)
Date: Thu, 30 Nov 2023 04:45:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for
 virtqueue
Message-ID: <20231130044512-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 08:30:56PM +0800, Xuan Zhuo wrote:
> These API has been introduced:
> 
> * virtqueue_dma_need_sync
> * virtqueue_dma_sync_single_range_for_cpu
> * virtqueue_dma_sync_single_range_for_device
> 
> These APIs can be used together with the premapped mechanism to sync the
> DMA address.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  8 ++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 916479c9c72c..81ecb29c88f1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>  
> +/**
> + * virtqueue_dma_need_sync - check a dma address needs sync
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + *
> + * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
> + * synchronized
> + *
> + * return bool
> + */
> +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return false;
> +
> +	return dma_need_sync(vring_dma_dev(vq), addr);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> +
> +/**
> + * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: buf size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> + * the DMA address really needs to be synchronized
> + *
> + */
> +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +					     dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct device *dev = vring_dma_dev(vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_sync_single_range_for_cpu(dev, addr, offset, size,
> +				      DMA_BIDIRECTIONAL);
> +}


Why did you use DMA_BIDIRECTIONAL here?
Why is "dir" ignored?


> +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> +
> +/**
> + * virtqueue_dma_sync_single_range_for_device - dma sync for device
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: buf size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> + * the DMA address really needs to be synchronized
> + */
> +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +						dma_addr_t addr,
> +						unsigned long offset, size_t size,
> +						enum dma_data_direction dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct device *dev = vring_dma_dev(vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_sync_single_range_for_device(dev, addr, offset, size,
> +					 DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
> +
>  MODULE_LICENSE("GPL");

same question here.

> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 79e3c74391e0..1311a7fbe675 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs);
>  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +
> +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir);
> +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> +						unsigned long offset, size_t size,
> +						enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.32.0.3.g01195cf9f

