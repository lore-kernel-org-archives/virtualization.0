Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37292765E8
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488066; cv=none; b=hUu9N+k/AFPGeqq7QtpXj/4ShvQZnRAeb3bhErDQeIaa5PhRFJZKmBgP23J645MhR0c45m/bXbLJYauFJ1W/EjfJhMYxaWu97gJzwHvpajf65qamBnIydP/eTbLdgOLtq/SNNZJzW6HwkbV7CFR43203JBgifPhOTmfrFQZXzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488066; c=relaxed/simple;
	bh=uW9UwUN7CZ4teKHcfAn18eLt3QqmBZWjrgXXTqGYGdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B4VC9oPi+wUi7ULsRr8WFDrVitH/fDkFbOUJDZuMwzAX2cKXoM+fkqjoeO6wuLrqufojF8Ge/6YqwLznHEWchdtbjInwANpnuI8VEJjDE70eMz1wcOTdvDcEkyovmUnCh+j1GrQonbNuAxA+OntF2bQaSe2hY0v7XaQ/iR/bkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQz+m9SE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQz+m9SE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xBq188AXBSuVVCyB2PFVSgR4xlxI1tenZeY+L8GcOIc=;
	b=aQz+m9SEh/mPHDgRnXLi60K9MsRCtayGGaOqsq5UzJopaq59+WgNYrIpCREXfOkzpSjW0t
	Gdj9Vbop8kdMty3lc3GTCyfC4EXZGnppfwAbufZppU5a5mRl2GM1h1T4uFijvFxor0jBag
	BVX0CzufejFbKHVr+0grS73Oh3nRp4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-RYNxI78aNSGWa7YGiqgxjQ-1; Sun, 21 Sep 2025 16:54:21 -0400
X-MC-Unique: RYNxI78aNSGWa7YGiqgxjQ-1
X-Mimecast-MFC-AGG-ID: RYNxI78aNSGWa7YGiqgxjQ_1758488060
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so324811f8f.3
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488060; x=1759092860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBq188AXBSuVVCyB2PFVSgR4xlxI1tenZeY+L8GcOIc=;
        b=EvVgu0u5KXyRw2JBn+CzcZeb/JUDi6FENdwLJ58DqihVrjyH7a/M74tGodBG8OvNQG
         IgjZVAvkaAEyrXxQ5ts076PSzUktSpVGjxff43GI453LS+BlGNV6En2DXF05JocLl7KT
         17iP9YKcufgV7Y8WgLcs5qrxsbCEoLzMKHEaMMvTtAZsX1MKeWBm2r6ZNqn/4mRTGugS
         OV1N6TDpA1Y8t92LG6UJU5SxpvdumCrRyIKM8TstZgVlUXCsWraDSk5bbKOInr6EmMvR
         whMZO3k4cVyWDsapTx3qTpIvYdIOCISQJX7VRoa5Hbdr0p9GhEm8HIa3UDF6zTK/nKLZ
         dKrA==
X-Forwarded-Encrypted: i=1; AJvYcCU7HLKXQ5swqy8TVt00weMeKl7NFFD9wNbox0ax8rfHrO0u6fs+TiOkjlO+2ydEjyj7R7ZxWSTsoqOx1Ui+Og==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS9lH6pdzmXARLBeREXJadwyug17XYWhwCoE9HiIAht0ABKjjM
	BP0X6VidsifTtD9K1j6004bf/JyYoJQyS5tobeYiWvzeiOI1OhHV/in8maAvnKFnPZHr2Bzze4K
	vfWWCj9OGoXQAG8s/yEEbuZe2MLL++BGnO9E9MwzM2YXAUBTXkPWyjYuz5Cymn4m4NCHE
X-Gm-Gg: ASbGncsYVJDqPKeb3xBi2yY/DTnSuVCz1WpOB84DKG9n+lulFoQvt4IAWof817N29DY
	1BV5AYGErRjWLRArobuaTJ8xGglAyv/YjKsME1PiRfDov1DNQ0ZEO70f1K/H0T1teRQhnlunScx
	1miclkrpFzcg0UBxAqGwgE1QecPwB11/Z3bwTF6k+vY1LvAbuoN2Op8ZZFDvqshACMp8bUhkmOh
	vJ189MN6CUa3FwNf2dVlNQ7CXMSdcACmOvUU+xwdTCmQvZPQ5Qe+RBgpLB7uyGlzGg12hhdn7fW
	mfawJiS1VGZ4qPuuAm5TghGsypuMII2wz9c=
X-Received: by 2002:a05:6000:144c:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ee7c5529e2mr9183492f8f.2.1758488060206;
        Sun, 21 Sep 2025 13:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVmqrSeyTyn+vNrblxaFs736hmj/tx3H63IBTr5ZBghyBT0dYb4dU98Nl7befn9KTzwvrdBg==
X-Received: by 2002:a05:6000:144c:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ee7c5529e2mr9183484f8f.2.1758488059818;
        Sun, 21 Sep 2025 13:54:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm17127896f8f.31.2025.09.21.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:54:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:54:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Message-ID: <20250921165408-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-6-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250813054831.25865-6-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bjovqOyM9EBgon0-evScbKU7qOL6sAlYuDBK--QWvUc_1758488060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2025 at 01:48:27PM +0800, Jason Wang wrote:
> Following patch will introduce virtio map opreations which means the

operations

> address is not necessarily used for DMA. Let's rename the dma_handle
> to map_handle first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fb1d407d5f1b..94b2a8f3acc2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>  
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> -			       dma_addr_t *dma_handle, gfp_t flag,
> +			       dma_addr_t *map_handle, gfp_t flag,
>  			       union vring_mapping_token *mapping_token)
>  {
>  	if (vring_use_map_api(vdev)) {
>  		return dma_alloc_coherent(mapping_token->dma_dev, size,
> -					  dma_handle, flag);
> +					  map_handle, flag);
>  	} else {
>  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
>  
>  		if (queue) {
>  			phys_addr_t phys_addr = virt_to_phys(queue);
> -			*dma_handle = (dma_addr_t)phys_addr;
> +			*map_handle = (dma_addr_t)phys_addr;
>  
>  			/*
>  			 * Sanity check: make sure we dind't truncate
> @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			 * warning and abort if we end up with an
>  			 * unrepresentable address.
>  			 */
> -			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> +			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
>  				free_pages_exact(queue, PAGE_ALIGN(size));
>  				return NULL;
>  			}
> @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  }
>  
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> -			     void *queue, dma_addr_t dma_handle,
> +			     void *queue, dma_addr_t map_handle,
>  			     union vring_mapping_token *mapping_token)
>  {
>  	if (vring_use_map_api(vdev))
> -		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
> +		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
>  	else
>  		free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> -- 
> 2.31.1

