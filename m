Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D62D0620
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490945; cv=none; b=V3aihxm+bk3n3hOgtB8Mw6A81g/dpcUAbJ5qame8cnZXxrxWuboaYI0/jGBZF+hfZerBcJUAAczFR3APkoeoyrfA+UdOa6TMzpFNVipjI+Nd9xBuxh1JiPTrdwjh0A/PgQz+bEaY4G9G1C5SdTxi87HkcKlVkZCDyljPNiwVLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490945; c=relaxed/simple;
	bh=aHOEkzJA7O99geYKwgD7vfUEqI5TGA6J+xW3/dqC7jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EA0/m8uUk7kJ9k9QzSE/paIKlF+zsqrMr+4N9OKzySkl0GUF5/gzpnCl6vR7OF9X6vsK+hnSsqiB0AeYgULR+kAmPwbVwItprOA33v1V+S86kBRjgOs/GzFYUxmB5dA2KUZ0RcaDMI67dUvpjvar5qsSKXofq3j+IUJrZz1MjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbUYkrMr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbUYkrMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA2L9oyJbyVq83RbEtZfV+vSBPTFArfNal5zWUCe3Zg=;
	b=EbUYkrMrz0RwPuqRT2+y80F4wjIGzRJ3mGtl9+M+78JNqV10YLGpjwm4RrKc3IzvxXGR+r
	l2y6txaYgJn8TtItO/4qv3DVJ5614Dh+vZmphKmHlMUU6dwyC2xKu1yr+aJd19EEkPC5jC
	gQaLM9LONihnmc+WrVcbteZV9CWe4to=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-IFZTNVVePTScRAJHHCQvbA-1; Sun, 21 Sep 2025 17:42:15 -0400
X-MC-Unique: IFZTNVVePTScRAJHHCQvbA-1
X-Mimecast-MFC-AGG-ID: IFZTNVVePTScRAJHHCQvbA_1758490935
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f93db57449so473012f8f.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490934; x=1759095734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA2L9oyJbyVq83RbEtZfV+vSBPTFArfNal5zWUCe3Zg=;
        b=jQThHl3sNOP1m1i7OUeqyfYt1K4KRttmY4PemQnTr/3TKu02pQuwmMfx7tP2chd+Y2
         tZZe2fo4fE+Nv0WbWdTAp9NsTnukdwmG6o3YZE2ZQbEbQrq3lK7xPR8O+Rh84NPNgF9i
         VZSlIi90FKtVPskOUpP99/DWm9Y5OPKHaxpM8eUU0KR3BEv2oskYsOzfkZ+TDOiid9RJ
         mxgDNqNyy7fLrhwv4Hc6+8W+5lGn/wqdoeRH6hgE2B1kSDPQzKeAlw+Q7ts25DC4n8kE
         eT5Q3UdRfPoDY8uZtNQbGE51jdfIak4M8DOglfbBriUpDBwo578LdqTqWis74yQT3iEU
         2opg==
X-Forwarded-Encrypted: i=1; AJvYcCVNE12FbPKt203jW8OxAqJWQxB+gAkW5hnA5nLtGhl8L2cwoeS4GQRqj61dNvXIp9NVrsVU/WgM3yz6D6FTSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2wwXmRUyFJF4tw59+RcvTUXo6gOJr3+iZm/UpxuHZ/NB6C5YG
	2rTzKU5CUYjeTPwrChtLI2wuinWVGX6a3AULq7+6qrcHRkfGNx4ym8Q2MrKyOpKZERzI3XWEefM
	csSOiVeDk2ZMoTkyu1iGAphsSh7wUp1lLQB3tVTI6XJecCWUAEDGbwz7QYQwpUu1YUTgb3JztS0
	pi
X-Gm-Gg: ASbGncu+jMu3sdTZfB99y+VqwCWiQSskz9SOnRiNPbmmBoQfYobLt3GLdA5pEbCqlOi
	RMAouDVqWrcWItpp8FowNhdUQyCakJjYLM6W7+elGCkqqLkhtg0np5JGAn6Ao4TxTZ6zoapdL+Q
	cQnNZGRuiLVlbmJx8laLvqsDwOkTtNwYBcXOdS1d8riWxX/FvLjERv1efM3Dr29d7ye0pBfmsDO
	S4hHPfIawKON2pIo+fXi0mibFVAavHHL9GaTM1bWbztE+sBHv6XJPeQZSepgNmajDbEK3UR+uAz
	HMyVeoOAqQ82MGT/SH8qPENqHWZRwYq3GeQ=
X-Received: by 2002:a05:6000:186f:b0:3e5:6dbd:2114 with SMTP id ffacd0b85a97d-3ee875101c4mr9729688f8f.59.1758490934378;
        Sun, 21 Sep 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOf6Xd/ib6Qk5AuxiP/gcSHWrjecYFCzIwGgc4RUQ/GENU+tpLMM4iOB1+zibgYBEvPDrkSw==
X-Received: by 2002:a05:6000:186f:b0:3e5:6dbd:2114 with SMTP id ffacd0b85a97d-3ee875101c4mr9729679f8f.59.1758490933990;
        Sun, 21 Sep 2025 14:42:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm17183107f8f.3.2025.09.21.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:42:13 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:42:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250921174203-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-2-jasowang@redhat.com>
 <20250921165434-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250921165434-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cspok9SWyGUH5H6uc25ZL17m_L8O4Lq5vbFZkdA7gEA_1758490935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 04:55:10PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 13, 2025 at 01:48:23PM +0800, Jason Wang wrote:
> > This patch consities virtqueue point for DMA helpers.
> 
> constifies the virtqueue pointer

note that i fixed it for now

> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
> >  include/linux/virtio.h       | 12 ++++++------
> >  2 files changed, 19 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index f5062061c408..103bad8cffff 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >   *
> >   * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> >   */
> > -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
> > +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
> >  					  size_t size,
> >  					  enum dma_data_direction dir,
> >  					  unsigned long attrs)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api) {
> >  		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
> > @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
> >   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> >   *
> >   */
> > -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> > +				      dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return;
> > @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
> >   *
> >   * Returns 0 means dma valid. Other means invalid dma address.
> >   */
> > -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> > +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return 0;
> > @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
> >   *
> >   * return bool
> >   */
> > -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> > +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return false;
> > @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> >   * the DMA address really needs to be synchronized
> >   *
> >   */
> > -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> > +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
> >  					     dma_addr_t addr,
> >  					     unsigned long offset, size_t size,
> >  					     enum dma_data_direction dir)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  	struct device *dev = vring_dma_dev(vq);
> >  
> >  	if (!vq->use_dma_api)
> > @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> >   * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> >   * the DMA address really needs to be synchronized
> >   */
> > -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> > +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
> >  						dma_addr_t addr,
> >  						unsigned long offset, size_t size,
> >  						enum dma_data_direction dir)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  	struct device *dev = vring_dma_dev(vq);
> >  
> >  	if (!vq->use_dma_api)
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 8b745ce0cf5f..cf8def717dfd 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
> >  	module_driver(__virtio_driver, register_virtio_driver, \
> >  			unregister_virtio_driver)
> >  
> > -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
> > +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
> >  					  enum dma_data_direction dir, unsigned long attrs);
> > -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs);
> > -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> > +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
> >  
> > -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> > -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> > +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
> > +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
> >  					     unsigned long offset, size_t size,
> >  					     enum dma_data_direction dir);
> > -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
> >  						unsigned long offset, size_t size,
> >  						enum dma_data_direction dir);
> >  
> > -- 
> > 2.31.1

