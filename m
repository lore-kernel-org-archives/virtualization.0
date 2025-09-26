Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91E158545
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900329; cv=none; b=hGDx6uH9rRU9A73KOM1Im1Gi3A7FmMElw/VnthgEuSJNeryhQpy438oDZb62fv+pjrT5VXVgB3El9jd6pUwNE2H05RGutnbQENWE0aVwakzQBriVFfVEQ2XOkWsDKAJg1/S21ecIA0YsQ92Xo9z8PA7/e16fVrmV6MgdSzQrRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900329; c=relaxed/simple;
	bh=vwq2kB7ZSJ+7IH/lYjKPJUtUPlf/BcjFXmuTEHrBiic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qKIC+yNiHYzQgFC9TBuObC50ZNvgwuO0OC0oFimaA0R1uSm/sIo/ywkgk4TE4+L/9pi2LKyircYUrvxzhpxGNfVkFz8Wd7RB5RZ3gPAq4aT+ylgRO/nmlfnuYqubD4LK6LKtLn0lKPLG/k7FSqVYjYWMjuyhUpDQ65YhrY2UpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDJOSXBl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDJOSXBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758900325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuRr9iXRJx/mSZCQqSBqXVnSnojtp0S9MzTPMtIju9o=;
	b=YDJOSXBlHBZfUJyWfSvM6SmiWWTnUMr3grOhtukt5i6qYvYLQo7yduXApL5E7CakZIay2U
	QdaGwMfC0kGb+U8lrz85eQ3vX1FNUhbrKC+GNLFh/3QqKWKAhe+xR75NwBq/DwsbJ0RyVm
	RbM7gmQ1v7WlghwCPAG2YC+eVTGMnQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-ElWoyFRvPi646yTg3IG3yA-1; Fri, 26 Sep 2025 11:25:24 -0400
X-MC-Unique: ElWoyFRvPi646yTg3IG3yA-1
X-Mimecast-MFC-AGG-ID: ElWoyFRvPi646yTg3IG3yA_1758900323
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso13894125e9.0
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900322; x=1759505122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuRr9iXRJx/mSZCQqSBqXVnSnojtp0S9MzTPMtIju9o=;
        b=CNR/phR3A0SHjERXqSTY/6pRDoN1ENERCP4RCAMxRxqlJ4mpijvuGzFgFH97AqRaNv
         waLQopkLJCy2xpKJ6rUZqoq6VWw/52yDe+qMGqnY0vpLR9JVYnpMVuyX9uV/0Yv9f2Hk
         zqd9A7i8qIGLqQXgi80kFC68SBEYT01CEMu3RYJC6rTdDAhId5/51xXmoUO+J/mHG417
         xANmRoTFJPIUdwW0vJWkcL3zp9GAHJl+kLYy13mu34TGHuXlG9so9tkDlsaCEqI41yKG
         6h8Wrnn2YFArm2lwwXFAHZy8iSactgnVITicGcMzFpNrQwaTvL6IsDbFJWeRsH8xfezv
         NOzA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOO7uMHv36fT0io2Nn03FItg21B11QNXqaBEtmT2U3FRwjou6UQpKHvXKDViT+Bh3G61kVrswr+XoGDV2iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgcJUN/lK6SsSiRD5ftpYjnouvmlqBqTbeVnrNXa60vmnVoi/V
	H/h1X/Drzxw82C9FTiFGPCNdaC7klAllOZkD/zSnArkCa6UJYZm+1T8dM3UWdYxXw8YOYahJy7K
	MyzAnD7wHnJsxcFolLkdt7t0vkMnfqYkDKkCEC0DcUHbThANlsnpdeRpqV3CnE2J26rxKWP2XEe
	N4
X-Gm-Gg: ASbGncvseoToyN/cINxSSX6kfA0BsohFk/f2xTq3w7V8h2n7wv9eyCXs2iDVxwKp606
	9ZMuypcnOPbgbw9tAmD+875XZTATh3c1ESm7KxhHeCQleqOplvqvT1lGoeIAaMqlY1qWVzmf2MX
	13BsC+oS9Su2VPR7k9lR1Iq1U9G7EhCxLM3S+g35narqTp+5RM8Q2LrvSjxptEPrlnUWzL3xfsR
	LeCfpDVIUJIr2Brrtk1LrIxpgATj3gUmWKmzBQLI0PIc1LKsjE4svSPV+5r6KGbbwj/V8YO3/kW
	jc8qPX5dHPAkioEVxzXmnL1x6Iv4IoRdeN8=
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr71947825e9.0.1758900321965;
        Fri, 26 Sep 2025 08:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMarPUqJd7OXtq4im/YungD3qS4PcLxBOwLmLgrRNu6H4DmaEDdZLhHC9IV35WUI0YAW1rQg==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr71947435e9.0.1758900321295;
        Fri, 26 Sep 2025 08:25:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e330d1d2fsm39996915e9.3.2025.09.26.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:25:20 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:25:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
Message-ID: <20250926112445-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-6-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250926101432.2251301-6-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YAWFbQKNCcXEG-MVdaNX2zgm8U3IWbjAv7rEsDw_mm4_1758900323
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio Pérez wrote:
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
> 
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).
> * Properly set domain bounce size to divide equally between nas (Jason).
> * Exclude "padding" member from the only >V1 members in
>   vduse_dev_request.
> 
> v4:
> * Divide each domain bounce size between the device bounce size (Jason).
> * revert unneeded addr = NULL assignment (Jason)
> * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
>   return; } (Jason)
> * Change a bad multiline comment, using @ caracter instead of * (Jason).
> * Consider config->nas == 0 as a fail (Jason).
> 
> v3:
> * Get the vduse domain through the vduse_as in the map functions
>   (Jason).
> * Squash with the patch creating the vduse_as struct (Jason).
> * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
>   (Jason)
> 
> v2:
> * Convert the use of mutex to rwlock.
> 
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
> 
> RFC v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 335 ++++++++++++++++++++---------
>  include/uapi/linux/vduse.h         |  53 ++++-
>  2 files changed, 288 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 3ce70e6524d5..731de08bb692 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -42,6 +42,7 @@
>  
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
>  #define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -87,7 +88,14 @@ struct vduse_umem {
>  	struct mm_struct *mm;
>  };
>  
> +struct vduse_as {
> +	struct vduse_iova_domain *domain;
> +	struct vduse_umem *umem;
> +	struct mutex mem_lock;
> +};
> +
>  struct vduse_vq_group {
> +	struct vduse_as *as;
>  	struct vduse_dev *dev;
>  };
>  
> @@ -95,7 +103,7 @@ struct vduse_dev {
>  	struct vduse_vdpa *vdev;
>  	struct device *dev;
>  	struct vduse_virtqueue **vqs;
> -	struct vduse_iova_domain *domain;
> +	struct vduse_as *as;
>  	char *name;
>  	struct mutex lock;
>  	spinlock_t msg_lock;
> @@ -123,9 +131,8 @@ struct vduse_dev {
>  	u32 vq_num;
>  	u32 vq_align;
>  	u32 ngroups;
> -	struct vduse_umem *umem;
> +	u32 nas;
>  	struct vduse_vq_group *groups;
> -	struct mutex mem_lock;
>  	unsigned int bounce_size;
>  	rwlock_t domain_lock;
>  };
> @@ -315,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
>  	return vduse_dev_msg_sync(dev, &msg);
>  }
>  
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>  				  u64 start, u64 last)
>  {
>  	struct vduse_dev_msg msg = { 0 };
> @@ -324,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
>  		return -EINVAL;
>  
>  	msg.req.type = VDUSE_UPDATE_IOTLB;
> -	msg.req.iova.start = start;
> -	msg.req.iova.last = last;
> +	if (dev->api_version < VDUSE_API_VERSION_1) {
> +		msg.req.iova.start = start;
> +		msg.req.iova.last = last;
> +	} else {
> +		msg.req.iova_v2.start = start;
> +		msg.req.iova_v2.last = last;
> +		msg.req.iova_v2.asid = asid;
> +	}
>  
>  	return vduse_dev_msg_sync(dev, &msg);
>  }
> @@ -437,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
>  	return mask;
>  }
>  
> +/* Force set the asid to a vq group without a message to the VDUSE device */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> +				       unsigned int group, unsigned int asid)
> +{
> +	write_lock(&dev->domain_lock);
> +	dev->groups[group].as = &dev->as[asid];
> +	write_unlock(&dev->domain_lock);
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>  	int i;
> -	struct vduse_iova_domain *domain = dev->domain;
>  
>  	/* The coherent mappings are handled in vduse_dev_free_coherent() */
> -	if (domain && domain->bounce_map)
> -		vduse_domain_reset_bounce_map(domain);
> +	for (i = 0; i < dev->nas; i++) {
> +		struct vduse_iova_domain *domain = dev->as[i].domain;
> +
> +		if (domain && domain->bounce_map)
> +			vduse_domain_reset_bounce_map(domain);
> +	}
> +
> +	for (i = 0; i < dev->ngroups; i++)
> +		vduse_set_group_asid_nomsg(dev, i, 0);
>  
>  	down_write(&dev->rwsem);
>  
> @@ -624,6 +652,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
>  	return ret;
>  }
>  
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
> +				unsigned int asid)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_dev_msg msg = { 0 };
> +	int r;
> +
> +	if (dev->api_version < VDUSE_API_VERSION_1 ||
> +	    group >= dev->ngroups || asid >= dev->nas)
> +		return -EINVAL;
> +
> +	msg.req.type = VDUSE_SET_VQ_GROUP_ASID;
> +	msg.req.vq_group_asid.group = group;
> +	msg.req.vq_group_asid.asid = asid;
> +
> +	r = vduse_dev_msg_sync(dev, &msg);
> +	if (r < 0)
> +		return r;
> +
> +	vduse_set_group_asid_nomsg(dev, group, asid);
> +	return 0;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>  				struct vdpa_vq_state *state)
>  {
> @@ -795,13 +846,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>  	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>  	int ret;
>  
> -	ret = vduse_domain_set_map(dev->domain, iotlb);
> +	ret = vduse_domain_set_map(dev->as[asid].domain, iotlb);
>  	if (ret)
>  		return ret;
>  
> -	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>  	if (ret) {
> -		vduse_domain_clear_map(dev->domain, iotlb);
> +		vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>  		return ret;
>  	}
>  
> @@ -844,6 +895,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>  	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
>  	.reset			= vduse_vdpa_reset,
>  	.set_map		= vduse_vdpa_set_map,
> +	.set_group_asid		= vduse_set_group_asid,
>  	.get_vq_map		= vduse_get_vq_map,
>  	.free			= vduse_vdpa_free,
>  };
> @@ -859,9 +911,10 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
>  		return;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> -
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
>  	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> +	read_unlock(&vdev->domain_lock);
>  }
>  
>  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> @@ -875,9 +928,10 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
>  		return;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> -
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
>  	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> +	read_unlock(&vdev->domain_lock);
>  }
>  
>  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
> @@ -887,14 +941,18 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
>  {
>  	struct vduse_dev *vdev;
>  	struct vduse_iova_domain *domain;
> +	dma_addr_t r;
>  
>  	if (!token.group)
>  		return DMA_MAPPING_ERROR;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
> +	r = vduse_domain_map_page(domain, page, offset, size, dir, attrs);
> +	read_unlock(&vdev->domain_lock);
>  
> -	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
> +	return r;
>  }
>  
>  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
> @@ -908,9 +966,10 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
>  		return;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> -
> -	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
> +	vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> +	read_unlock(&vdev->domain_lock);
>  }
>  
>  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
> @@ -926,14 +985,14 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
>  		return NULL;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
>  	addr = vduse_domain_alloc_coherent(domain, size,
>  					   (dma_addr_t *)&iova, flag);
> -	if (!addr)
> -		return NULL;
> -
> -	*dma_addr = (dma_addr_t)iova;
> +	if (addr)
> +		*dma_addr = (dma_addr_t)iova;
>  
> +	read_unlock(&vdev->domain_lock);
>  	return addr;
>  }
>  
> @@ -948,23 +1007,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
>  		return;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> -
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
>  	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
> +	read_unlock(&vdev->domain_lock);
>  }
>  
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
>  {
>  	struct vduse_dev *vdev;
>  	struct vduse_iova_domain *domain;
> +	size_t bounce_size;
>  
>  	if (!token.group)
>  		return false;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
> +	bounce_size = domain->bounce_size;
> +	read_unlock(&vdev->domain_lock);
>  
> -	return dma_addr < domain->bounce_size;
> +	return dma_addr < bounce_size;
>  }
>  
>  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
> @@ -978,14 +1042,18 @@ static size_t vduse_dev_max_mapping_size(union virtio_map token)
>  {
>  	struct vduse_dev *vdev;
>  	struct vduse_iova_domain *domain;
> +	size_t bounce_size;
>  
>  	if (!token.group)
>  		return 0;
>  
>  	vdev = token.group->dev;
> -	domain = vdev->domain;
> +	read_lock(&vdev->domain_lock);
> +	domain = token.group->as->domain;
> +	bounce_size = domain->bounce_size;
> +	read_unlock(&vdev->domain_lock);
>  
> -	return domain->bounce_size;
> +	return bounce_size;
>  }
>  
>  static const struct virtio_map_ops vduse_map_ops = {
> @@ -1125,39 +1193,40 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>  	return ret;
>  }
>  
> -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
>  				u64 iova, u64 size)
>  {
>  	int ret;
>  
> -	mutex_lock(&dev->mem_lock);
> +	mutex_lock(&dev->as[asid].mem_lock);
>  	ret = -ENOENT;
> -	if (!dev->umem)
> +	if (!dev->as[asid].umem)
>  		goto unlock;
>  
>  	ret = -EINVAL;
> -	if (!dev->domain)
> +	if (!dev->as[asid].domain)
>  		goto unlock;
>  
> -	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
> +	if (dev->as[asid].umem->iova != iova ||
> +	    size != dev->as[asid].domain->bounce_size)
>  		goto unlock;
>  
> -	vduse_domain_remove_user_bounce_pages(dev->domain);
> -	unpin_user_pages_dirty_lock(dev->umem->pages,
> -				    dev->umem->npages, true);
> -	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> -	mmdrop(dev->umem->mm);
> -	vfree(dev->umem->pages);
> -	kfree(dev->umem);
> -	dev->umem = NULL;
> +	vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> +	unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> +				    dev->as[asid].umem->npages, true);
> +	atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->mm->pinned_vm);
> +	mmdrop(dev->as[asid].umem->mm);
> +	vfree(dev->as[asid].umem->pages);
> +	kfree(dev->as[asid].umem);
> +	dev->as[asid].umem = NULL;
>  	ret = 0;
>  unlock:
> -	mutex_unlock(&dev->mem_lock);
> +	mutex_unlock(&dev->as[asid].mem_lock);
>  	return ret;
>  }
>  
>  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> -			      u64 iova, u64 uaddr, u64 size)
> +			      u32 asid, u64 iova, u64 uaddr, u64 size)
>  {
>  	struct page **page_list = NULL;
>  	struct vduse_umem *umem = NULL;
> @@ -1165,14 +1234,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  	unsigned long npages, lock_limit;
>  	int ret;
>  
> -	if (!dev->domain || !dev->domain->bounce_map ||
> -	    size != dev->domain->bounce_size ||
> +	if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map ||
> +	    size != dev->as[asid].domain->bounce_size ||
>  	    iova != 0 || uaddr & ~PAGE_MASK)
>  		return -EINVAL;
>  
> -	mutex_lock(&dev->mem_lock);
> +	mutex_lock(&dev->as[asid].mem_lock);
>  	ret = -EEXIST;
> -	if (dev->umem)
> +	if (dev->as[asid].umem)
>  		goto unlock;
>  
>  	ret = -ENOMEM;
> @@ -1196,7 +1265,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  		goto out;
>  	}
>  
> -	ret = vduse_domain_add_user_bounce_pages(dev->domain,
> +	ret = vduse_domain_add_user_bounce_pages(dev->as[asid].domain,
>  						 page_list, pinned);
>  	if (ret)
>  		goto out;
> @@ -1209,7 +1278,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  	umem->mm = current->mm;
>  	mmgrab(current->mm);
>  
> -	dev->umem = umem;
> +	dev->as[asid].umem = umem;
>  out:
>  	if (ret && pinned > 0)
>  		unpin_user_pages(page_list, pinned);
> @@ -1220,7 +1289,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  		vfree(page_list);
>  		kfree(umem);
>  	}
> -	mutex_unlock(&dev->mem_lock);
> +	mutex_unlock(&dev->as[asid].mem_lock);
>  	return ret;
>  }
>  
> @@ -1252,47 +1321,66 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  
>  	switch (cmd) {
>  	case VDUSE_IOTLB_GET_FD: {
> -		struct vduse_iotlb_entry entry;
> +		struct vduse_iotlb_entry_v2 entry;
>  		struct vhost_iotlb_map *map;
>  		struct vdpa_map_file *map_file;
>  		struct file *f = NULL;
> +		u32 asid;
>  
>  		ret = -EFAULT;
> -		if (copy_from_user(&entry, argp, sizeof(entry)))
> -			break;
> +		if (dev->api_version >= VDUSE_API_VERSION_1) {
> +			if (copy_from_user(&entry, argp, sizeof(entry)))
> +				break;
> +		} else {
> +			entry.asid = 0;
> +			if (copy_from_user(&entry.v1, argp,
> +					   sizeof(entry.v1)))
> +				break;
> +		}
>  
>  		ret = -EINVAL;
> -		if (entry.start > entry.last)
> +		if (entry.v1.start > entry.v1.last)
> +			break;
> +
> +		if (entry.asid >= dev->nas)
>  			break;
>  
>  		read_lock(&dev->domain_lock);
> -		if (!dev->domain) {
> +		asid = array_index_nospec(entry.asid, dev->nas);
> +		if (!dev->as[asid].domain) {
>  			read_unlock(&dev->domain_lock);
>  			break;
>  		}
> -		spin_lock(&dev->domain->iotlb_lock);
> -		map = vhost_iotlb_itree_first(dev->domain->iotlb,
> -					      entry.start, entry.last);
> +		spin_lock(&dev->as[asid].domain->iotlb_lock);
> +		map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
> +					      entry.v1.start, entry.v1.last);
>  		if (map) {
>  			map_file = (struct vdpa_map_file *)map->opaque;
>  			f = get_file(map_file->file);
> -			entry.offset = map_file->offset;
> -			entry.start = map->start;
> -			entry.last = map->last;
> -			entry.perm = map->perm;
> +			entry.v1.offset = map_file->offset;
> +			entry.v1.start = map->start;
> +			entry.v1.last = map->last;
> +			entry.v1.perm = map->perm;
>  		}
> -		spin_unlock(&dev->domain->iotlb_lock);
> +		spin_unlock(&dev->as[asid].domain->iotlb_lock);
>  		read_unlock(&dev->domain_lock);
>  		ret = -EINVAL;
>  		if (!f)
>  			break;
>  
> -		ret = -EFAULT;
> -		if (copy_to_user(argp, &entry, sizeof(entry))) {
> +		if (dev->api_version >= VDUSE_API_VERSION_1)
> +			ret = copy_to_user(argp, &entry,
> +					   sizeof(entry));
> +		else
> +			ret = copy_to_user(argp, &entry.v1,
> +					   sizeof(entry.v1));
> +
> +		if (ret) {
> +			ret = -EFAULT;
>  			fput(f);
>  			break;
>  		}
> -		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
> +		ret = receive_fd(f, NULL, perm_to_file_flags(entry.v1.perm));
>  		fput(f);
>  		break;
>  	}
> @@ -1437,6 +1525,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	}
>  	case VDUSE_IOTLB_REG_UMEM: {
>  		struct vduse_iova_umem umem;
> +		u32 asid;
>  
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
> @@ -1444,17 +1533,21 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  
>  		ret = -EINVAL;
>  		if (!is_mem_zero((const char *)umem.reserved,
> -				 sizeof(umem.reserved)))
> +				 sizeof(umem.reserved)) ||
> +		    (dev->api_version < VDUSE_API_VERSION_1 &&
> +		     umem.asid != 0) || umem.asid >= dev->nas)
>  			break;
>  
>  		write_lock(&dev->domain_lock);
> -		ret = vduse_dev_reg_umem(dev, umem.iova,
> +		asid = array_index_nospec(umem.asid, dev->nas);
> +		ret = vduse_dev_reg_umem(dev, asid, umem.iova,
>  					 umem.uaddr, umem.size);
>  		write_unlock(&dev->domain_lock);
>  		break;
>  	}
>  	case VDUSE_IOTLB_DEREG_UMEM: {
>  		struct vduse_iova_umem umem;
> +		u32 asid;
>  
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
> @@ -1462,10 +1555,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  
>  		ret = -EINVAL;
>  		if (!is_mem_zero((const char *)umem.reserved,
> -				 sizeof(umem.reserved)))
> +				 sizeof(umem.reserved)) ||
> +		    (dev->api_version < VDUSE_API_VERSION_1 &&
> +		     umem.asid != 0) ||
> +		     umem.asid >= dev->nas)
>  			break;
> +
>  		write_lock(&dev->domain_lock);
> -		ret = vduse_dev_dereg_umem(dev, umem.iova,
> +		asid = array_index_nospec(umem.asid, dev->nas);
> +		ret = vduse_dev_dereg_umem(dev, asid, umem.iova,
>  					   umem.size);
>  		write_unlock(&dev->domain_lock);
>  		break;
> @@ -1473,6 +1571,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_GET_INFO: {
>  		struct vduse_iova_info info;
>  		struct vhost_iotlb_map *map;
> +		u32 asid;
>  
>  		ret = -EFAULT;
>  		if (copy_from_user(&info, argp, sizeof(info)))
> @@ -1486,23 +1585,31 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  				 sizeof(info.reserved)))
>  			break;
>  
> +		if (dev->api_version < VDUSE_API_VERSION_1) {
> +			if (info.asid)
> +				break;
> +		} else if (info.asid >= dev->nas)
> +			break;
> +
>  		read_lock(&dev->domain_lock);
> -		if (!dev->domain) {
> +		asid = array_index_nospec(info.asid, dev->nas);
> +		if (!dev->as[asid].domain) {
>  			read_unlock(&dev->domain_lock);
>  			break;
>  		}
> -		spin_lock(&dev->domain->iotlb_lock);
> -		map = vhost_iotlb_itree_first(dev->domain->iotlb,
> +		spin_lock(&dev->as[asid].domain->iotlb_lock);
> +		map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
>  					      info.start, info.last);
>  		if (map) {
>  			info.start = map->start;
>  			info.last = map->last;
>  			info.capability = 0;
> -			if (dev->domain->bounce_map && map->start == 0 &&
> -			    map->last == dev->domain->bounce_size - 1)
> +			if (dev->as[asid].domain->bounce_map &&
> +			    map->start == 0 &&
> +			    map->last == dev->as[asid].domain->bounce_size - 1)
>  				info.capability |= VDUSE_IOVA_CAP_UMEM;
>  		}
> -		spin_unlock(&dev->domain->iotlb_lock);
> +		spin_unlock(&dev->as[asid].domain->iotlb_lock);
>  		read_unlock(&dev->domain_lock);
>  		if (!map)
>  			break;
> @@ -1527,8 +1634,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  	struct vduse_dev *dev = file->private_data;
>  
>  	write_lock(&dev->domain_lock);
> -	if (dev->domain)
> -		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +	for (int i = 0; i < dev->nas; i++)
> +		if (dev->as[i].domain)
> +			vduse_dev_dereg_umem(dev, i, 0,
> +					     dev->as[i].domain->bounce_size);
>  	write_unlock(&dev->domain_lock);
>  	spin_lock(&dev->msg_lock);
>  	/* Make sure the inflight messages can processed after reconncection */
> @@ -1747,7 +1856,6 @@ static struct vduse_dev *vduse_dev_create(void)
>  		return NULL;
>  
>  	mutex_init(&dev->lock);
> -	mutex_init(&dev->mem_lock);
>  	rwlock_init(&dev->domain_lock);
>  	spin_lock_init(&dev->msg_lock);
>  	INIT_LIST_HEAD(&dev->send_list);
> @@ -1798,8 +1906,11 @@ static int vduse_destroy_dev(char *name)
>  	idr_remove(&vduse_idr, dev->minor);
>  	kvfree(dev->config);
>  	vduse_dev_deinit_vqs(dev);
> -	if (dev->domain)
> -		vduse_domain_destroy(dev->domain);
> +	for (int i = 0; i < dev->nas; i++) {
> +		if (dev->as[i].domain)
> +			vduse_domain_destroy(dev->as[i].domain);
> +	}
> +	kfree(dev->as);
>  	kfree(dev->name);
>  	kfree(dev->groups);
>  	vduse_dev_destroy(dev);
> @@ -1846,12 +1957,17 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
>  			 sizeof(config->reserved)))
>  		return false;
>  
> -	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +	if (api_version < VDUSE_API_VERSION_1 &&
> +	    (config->ngroups || config->nas))
>  		return false;
>  
> -	if (api_version >= VDUSE_API_VERSION_1 &&
> -	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> -		return false;
> +	if (api_version >= VDUSE_API_VERSION_1) {
> +		if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS)
> +			return false;
> +
> +		if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> +			return false;
> +	}
>  
>  	if (config->vq_align > PAGE_SIZE)
>  		return false;
> @@ -1916,7 +2032,8 @@ static ssize_t bounce_size_store(struct device *device,
>  
>  	ret = -EPERM;
>  	write_lock(&dev->domain_lock);
> -	if (dev->domain)
> +	/* Assuming that if the first domain is allocated, all are allocated */
> +	if (dev->as[0].domain)
>  		goto unlock;
>  
>  	ret = kstrtouint(buf, 10, &bounce_size);
> @@ -1976,6 +2093,13 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	for (u32 i = 0; i < dev->ngroups; ++i)
>  		dev->groups[i].dev = dev;
>  
> +	dev->nas = (dev->api_version < 1) ? 1 : config->nas;

Is this "< 1" here same as VDUSE_API_VERSION_1 ? Maybe use that then.


> +	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> +	if (!dev->as)
> +		goto err_as;
> +	for (int i = 0; i < dev->nas; i++)
> +		mutex_init(&dev->as[i].mem_lock);
> +
>  	dev->name = kstrdup(config->name, GFP_KERNEL);
>  	if (!dev->name)
>  		goto err_str;
> @@ -2012,6 +2136,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  err_idr:
>  	kfree(dev->name);
>  err_str:
> +	kfree(dev->as);
> +err_as:
>  	kfree(dev->groups);
>  err_vq_groups:
>  	vduse_dev_destroy(dev);
> @@ -2137,7 +2263,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>  				 &vduse_vdpa_config_ops, &vduse_map_ops,
> -				 dev->ngroups, 1, name, true);
> +				 dev->ngroups, dev->nas, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
>  
> @@ -2152,6 +2278,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  			const struct vdpa_dev_set_config *config)
>  {
>  	struct vduse_dev *dev;
> +	size_t domain_bounce_size;
>  	int ret;
>  
>  	mutex_lock(&vduse_lock);
> @@ -2166,11 +2293,21 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  		return ret;
>  
>  	write_lock(&dev->domain_lock);
> -	if (!dev->domain)
> -		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -						  dev->bounce_size);
> +	ret = 0;
> +
> +	domain_bounce_size = dev->bounce_size / dev->nas;
> +	for (int i = 0; i < dev->nas; ++i) {
> +		dev->as[i].domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> +							domain_bounce_size);
> +		if (!dev->as[i].domain) {
> +			ret = -ENOMEM;
> +			for (int j = 0; j < i; ++j)
> +				vduse_domain_destroy(dev->as[j].domain);
> +		}
> +	}
> +
>  	write_unlock(&dev->domain_lock);
> -	if (!dev->domain) {
> +	if (ret == -ENOMEM) {
>  		put_device(&dev->vdev->vdpa.dev);
>  		return -ENOMEM;
>  	}
> @@ -2179,8 +2316,12 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	if (ret) {
>  		put_device(&dev->vdev->vdpa.dev);
>  		write_lock(&dev->domain_lock);
> -		vduse_domain_destroy(dev->domain);
> -		dev->domain = NULL;
> +		for (int i = 0; i < dev->nas; i++) {
> +			if (dev->as[i].domain) {
> +				vduse_domain_destroy(dev->as[i].domain);
> +				dev->as[i].domain = NULL;
> +			}
> +		}
>  		write_unlock(&dev->domain_lock);
>  		return ret;
>  	}
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index a3d51cf6df3a..3d71a3d6593c 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -47,7 +47,8 @@ struct vduse_dev_config {
>  	__u32 vq_num;
>  	__u32 vq_align;
>  	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
> -	__u32 reserved[12];
> +	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
> +	__u32 reserved[11];
>  	__u32 config_size;
>  	__u8 config[];
>  };
> @@ -82,6 +83,18 @@ struct vduse_iotlb_entry {
>  	__u8 perm;
>  };
>  
> +/**
> + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region in an ASID
> + * @v1: the original vduse_iotlb_entry
> + * @asid: address space ID of the IOVA region
> + *
> + * Structure used by VDUSE_IOTLB_GET_FD ioctl to find an overlapped IOVA region.
> + */
> +struct vduse_iotlb_entry_v2 {
> +	struct vduse_iotlb_entry v1;
> +	__u32 asid;
> +};
> +
>  /*
>   * Find the first IOVA region that overlaps with the range [start, last]
>   * and return the corresponding file descriptor. Return -EINVAL means the
> @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
>  	__u16 last_used_idx;
>  };
>  
> +/**
> + * struct vduse_vq_group - virtqueue group
> + * @group: Index of the virtqueue group
> + * @asid: Address space ID of the group
> + */
> +struct vduse_vq_group_asid {
> +	__u32 group;
> +	__u32 asid;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index
> @@ -225,6 +248,7 @@ struct vduse_vq_eventfd {
>   * @uaddr: start address of userspace memory, it must be aligned to page size
>   * @iova: start of the IOVA region
>   * @size: size of the IOVA region
> + * @asid: Address space ID of the IOVA region
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> @@ -234,7 +258,8 @@ struct vduse_iova_umem {
>  	__u64 uaddr;
>  	__u64 iova;
>  	__u64 size;
> -	__u64 reserved[3];
> +	__u32 asid;
> +	__u32 reserved[5];
>  };
>  
>  /* Register userspace memory for IOVA regions */
> @@ -248,6 +273,7 @@ struct vduse_iova_umem {
>   * @start: start of the IOVA region
>   * @last: last of the IOVA region
>   * @capability: capability of the IOVA region
> + * @asid: Address space ID of the IOVA region, only if device API version >= 1
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> @@ -258,7 +284,8 @@ struct vduse_iova_info {
>  	__u64 last;
>  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
>  	__u64 capability;
> -	__u64 reserved[3];
> +	__u32 asid; /* Only if device API version >= 1 */
> +	__u32 reserved[5];
>  };
>  
>  /*
> @@ -280,6 +307,7 @@ enum vduse_req_type {
>  	VDUSE_GET_VQ_STATE,
>  	VDUSE_SET_STATUS,
>  	VDUSE_UPDATE_IOTLB,
> +	VDUSE_SET_VQ_GROUP_ASID,
>  };
>  
>  /**
> @@ -314,6 +342,18 @@ struct vduse_iova_range {
>  	__u64 last;
>  };
>  
> +/**
> + * struct vduse_iova_range - IOVA range [start, last] if API_VERSION >= 1
> + * @start: start of the IOVA range
> + * @last: last of the IOVA range
> + * @asid: address space ID of the IOVA range
> + */
> +struct vduse_iova_range_v2 {
> +	__u64 start;
> +	__u64 last;
> +	__u32 asid;
> +};
> +
>  /**
>   * struct vduse_dev_request - control request
>   * @type: request type
> @@ -322,6 +362,8 @@ struct vduse_iova_range {
>   * @vq_state: virtqueue state, only index field is available
>   * @s: device status
>   * @iova: IOVA range for updating
> + * @iova_v2: IOVA range for updating if API_VERSION >= 1
> + * @vq_group_asid: ASID of a virtqueue group
>   * @padding: padding
>   *
>   * Structure used by read(2) on /dev/vduse/$NAME.
> @@ -334,6 +376,11 @@ struct vduse_dev_request {
>  		struct vduse_vq_state vq_state;
>  		struct vduse_dev_status s;
>  		struct vduse_iova_range iova;
> +		/* Following members but padding exist only if vduse api
> +		 * version >= 1
> +		 */;
> +		struct vduse_iova_range_v2 iova_v2;
> +		struct vduse_vq_group_asid vq_group_asid;
>  		__u32 padding[32];
>  	};
>  };
> -- 
> 2.51.0

