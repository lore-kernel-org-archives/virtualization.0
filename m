Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907837;
	b=u5yuyGQ9chxeYXYadkbViMQir/o62urr75RhBbo5dnWKzPsXWSoI6SKsH+4cEvDaAXj0
	 //p07YGKzoyUU3Vc6E/oNdHXDMzu63FQHwwkdZcukvBVjw+/v0qWTzXl3mOD9NWv6n91p
	 YHs2pb8gsfxMYExd64jzaVKIj3fazA92Bs2H6ymxiQBgjjZ9zl9Upvqk+H7tHSGuuwG+s
	 53DxxpapMERNdllEQemSpg1sPxN6+kNKhkXq5USVxToXk2AIMX2QisTYYffD80nTZBawi
	 3CCeT9jMfSh/43caSd1P1N3SkKsxA6FfwG7Gf4opg7GdHhC+yJScsty+WHIg6T/6HTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907837;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
	b=SY2TJwXh37gxlekEhXmzpLVjGR6CDbgmRI37Y9iUODpNwdFK1Qf4zO1Cpw3VWR8DmiS4
	 czbvqWkpWZ1yEnmUeSPAEa6WBF0gYn/qvYvpdrB846AzY9DkgJ9QocVMNHwslt08CKfoU
	 eVL4Dp5TAr4/tUPCXZlaunW920kttlxzbyxqlFd97Z3McuMekqaKw1kUnfGKOfh99qy/d
	 tyJfCtXGmvkFmsZIiW0L0t7ckA4auDoYiwcyX8I5JHhGrJa768Zb/RcK1jMvHgVyFgJO6
	 PM8Oi07pF/JJk9A3aJsbFFdhOv8l/M2tFHsEbVR4YI2vxMs8nzpahpmBwmhWJafwMWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JdMbjpEe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DE606EA6E
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4DE606EA6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JdMbjpEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793907836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
	b=JdMbjpEeFGp06B7FmesOEy0l1xkvVuTAiiPu4rxCXYJKhZc/IylkFrpXUP0f6061FSZMpG
	aYagx/bdde3ijvBHsOfC0ZApWTr3iLPtUq6Sbsfn4MeaY5fQ3MiTNv/fe1AqSR4yjceWTX
	2Wc5RR1ivpJTlmWkZytuYzAEXCGSkww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-eLwSgpbONYiiFShUzCjKpw-1; Thu, 05 Nov 2026 14:43:52 -0500
X-MC-Unique: eLwSgpbONYiiFShUzCjKpw-1
X-Mimecast-MFC-AGG-ID: eLwSgpbONYiiFShUzCjKpw_1793907831
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso18177235e9.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 11:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907831; x=1794512631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
        b=0iO+fGC2+4hGsFj8ENydmQRndfnocd9R7MiSgIwzvQBfsLZw2oKdZ4i5EjbnljUOce
         7Mq35IbtG+/J5cmCMWMxzZbf2tvxMctvNA8jUsLomg0ru/e41iD99jC46rZbBlC9MqWo
         OSPcj+E5tLp2IzKS3hc1eTBbgP8hKF/zgYpZHcG+P1Q+GcM0wrH2I3j/JdOW4sesx7O5
         70HdqR0GWtiYh6YPeFqfvNkUliEOzqwXssnPXrQKs8dhiSuk8RJ8+vkAFYjtMVOnVIET
         aRUBswdvLuEPSYfVvrSH+TpeD9zIs9N/B4GSmC46JcwbeNuXE84bhCajE82PYJBx+IxU
         WHqA==
X-Forwarded-Encrypted: i=1; AKwUvByHXprpFRDVesM+oJODtvQ/M45HzKmwncGjVAnKAoAtgbaEXolQFI9/XtLI3MYHcbKg06GMoTE4H9Lm0BK7Rg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9fB4HJLd4wiNkMmM1029YjOMusISzcbWSIfMHLuTSWFTRP7A26
	8dkEAk6ThNoY6xm9Kk3ewMLFEqm0co2eVrlpIEdtKOelMcfPv3uefCT+9Cc0fMYZXx08DP0PVo9
	BHFHwmK8uOAllRTUORw485e5bEvPHWG22E/tHZE2W6F5yHfcN7EeowRiP8t3LhaR3geFGJltP7G
	X3
X-Gm-Gg: AYBFou0X1CY8PA5FY77aR9gwRdBVfn6Tja86Pg+CXPqbg8L8bQxbA25GLE5w7etaeQI
	8ncSTK29uG45pXHzv7xRhV4BZwjTShu95XXbDwskCtBSaTovAexguF9XhitHvFZacgJf+nKleFr
	kKcyWi+DvsP4asW4Rm63yA0ACwwrBcH4VARJAlcNbMEft2l7HdSRr/O1J/9kdSf5HoOJ07MZSCH
	7uNNoMLaGSIuDm4Mv+hrUhoGpeVh2R73IMuAPUvbuxEOaRjadyw7kjfpVnkDiS/ux224nuCgZ/m
	CQRlyp2my/EiMElM5nYcOrB1nseVuCMOP57FhgpA+dpAynQsIydUkmZuaFeQlEwOqduOW+0/ChM
	7R+p589/Q1uM0qdfsKuYN0QiJhn4KE0MWSgSpIfZfAQ==
X-Received: by 2002:a05:600c:19cf:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4b6dff85599mr2217225e9.33.1793907830784;
        Thu, 05 Nov 2026 11:43:50 -0800 (PST)
X-Received: by 2002:a05:600c:19cf:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4b6dff85599mr2216835e9.33.1793907830232;
        Thu, 05 Nov 2026 11:43:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527fed5bsm206845465e9.3.2026.11.05.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:43:49 -0800 (PST)
Date: Thu, 5 Nov 2026 14:43:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>, virtualization@lists.linux.dev,
	linux-um@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: return an error pointer from
 vring_create_virtqueue()
Message-ID: <20261105144316-mutt-send-email-mst@kernel.org>
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U1kjQirS_7Vnq8A0uhQ8bW86Qoy6WJYPH6S5HAgNQL0_1793907831
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2026 at 08:34:25PM +0100, Stjepan Poljak wrote:
> vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
> on any failure, so the error returned from vring_alloc_queue_split()
> is lost and turned into -ENOMEM. This is especially misleading if
> vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
> queue size is not a power of two):
> 
>   virtio_blk virtio0: Bad virtqueue length 100
>   virtio_blk virtio0: probe with driver virtio_blk failed with error -12
> 
> So the error points whoever debugs it at an allocation failure that
> never happened.
> 
> Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
> or vring_alloc_queue_packed(), or -ENOMEM when allocating the
> virtqueue itself fails. Make the callers, virtio_pci (modern and
> legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
> with IS_ERR() and pass the error on. The error path in virtio_ccw
> deletes a non-NULL vq, so clear vq there before taking it.
> 
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

not how you ae supposed to attribute LLM use.

> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>


> ---
> Tested on x86_64 with a virtio-mmio virtio-blk device offering a
> 100-entry queue: the probe now fails with -22 instead of -12, and a
> 128-entry queue probes as before. The other transports are only
> compile-tested (x86_64, ARCH=um, s390 with clang, W=1).
> 
> No Fixes: tag, since the error has been -ENOMEM since 2010 and nothing
> regressed.
> 
> This conflicts trivially with patch 07/12 of Alexander Graf's "virtio:
> support devices that own their virtqueue memory" v2:
> https://lore.kernel.org/virtualization/20260818211425.91009-1-graf@amazon.com/
> ---
>  arch/um/drivers/virtio_uml.c       |  4 ++--
>  drivers/s390/virtio/virtio_ccw.c   |  5 +++--
>  drivers/virtio/virtio_mmio.c       |  4 ++--
>  drivers/virtio/virtio_pci_legacy.c |  4 ++--
>  drivers/virtio/virtio_pci_modern.c |  4 ++--
>  drivers/virtio/virtio_ring.c       | 12 +++++++-----
>  drivers/virtio/virtio_vdpa.c       |  4 ++--
>  include/linux/virtio_ring.h        |  6 +++++-
>  8 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 881c34098a74..8b645523277f 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -984,8 +984,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>  
>  	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
>  				    ctx, vu_notify, callback, info->name);
> -	if (!vq) {
> -		rc = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		rc = PTR_ERR(vq);
>  		goto error_create;
>  	}
>  	vq->priv = info;
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 552d77998012..c5a30f0a2bc2 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -590,10 +590,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  				    vdev, true, may_reduce, ctx,
>  				    notify, callback, name);
>  
> -	if (!vq) {
> +	if (IS_ERR(vq)) {
>  		/* For now, we fail if we can't get the requested size. */
>  		dev_warn(&vcdev->cdev->dev, "no vq\n");
> -		err = -ENOMEM;
> +		err = PTR_ERR(vq);
> +		vq = NULL;
>  		goto out_err;
>  	}
>  
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e2ec0ec01d67..c403a025006e 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -396,8 +396,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  	/* Create the vring */
>  	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
>  				 true, true, ctx, notify, callback, name);
> -	if (!vq) {
> -		err = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		err = PTR_ERR(vq);
>  		goto error_new_virtqueue;
>  	}
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 8115aa39e01e..9d94fffff344 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -130,8 +130,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
>  				    true, false, ctx,
>  				    vp_notify, callback, name);
> -	if (!vq)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(vq))
> +		return vq;
>  
>  	vq->num_max = num;
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 922e2df027de..28ccb2130e27 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -720,8 +720,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				    SMP_CACHE_BYTES, &vp_dev->vdev,
>  				    true, true, ctx,
>  				    notify, callback, name);
> -	if (!vq)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(vq))
> +		return vq;
>  
>  	vq->num_max = num;
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..6dd4a7651bde 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1421,13 +1421,13 @@ static struct virtqueue *vring_create_virtqueue_split(
>  	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
>  				      may_reduce_num, map);
>  	if (err)
> -		return NULL;
> +		return ERR_PTR(err);
>  
>  	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				   context, notify, callback, name, map);
>  	if (!vq) {
>  		vring_free_split(&vring_split, vdev, map);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	to_vvq(vq)->we_own_ring = true;
> @@ -2671,15 +2671,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  {
>  	struct vring_virtqueue_packed vring_packed = {};
>  	struct virtqueue *vq;
> +	int err;
>  
> -	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
> -		return NULL;
> +	err = vring_alloc_queue_packed(&vring_packed, vdev, num, map);
> +	if (err)
> +		return ERR_PTR(err);
>  
>  	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
>  					context, notify, callback, name, map);
>  	if (!vq) {
>  		vring_free_packed(&vring_packed, vdev, map);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	to_vvq(vq)->we_own_ring = true;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f9559b6b2e0b..c1b6134b2267 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -208,8 +208,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
>  					true, may_reduce_num, ctx,
>  					notify, callback, name, map);
> -	if (!vq) {
> -		err = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		err = PTR_ERR(vq);
>  		goto error_new_virtqueue;
>  	}
>  
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index c97a12c1cda3..c808ca7e8d58 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -66,6 +66,9 @@ struct device;
>   * may_reduce_num is set, then this may allocate a smaller ring than
>   * expected.  The caller should query virtqueue_get_vring_size to learn
>   * the actual size of the ring.
> + *
> + * Returns the virtqueue or an ERR_PTR() on failure: -EINVAL if num is
> + * not a valid ring size, -ENOMEM if the ring could not be allocated.
>   */
>  struct virtqueue *vring_create_virtqueue(unsigned int index,
>  					 unsigned int num,
> @@ -80,7 +83,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
>  
>  /*
>   * Creates a virtqueue and allocates the descriptor ring with per
> - * virtqueue mapping operations.
> + * virtqueue mapping operations.  Returns the virtqueue or an ERR_PTR()
> + * on failure, like vring_create_virtqueue().
>   */
>  struct virtqueue *vring_create_virtqueue_map(unsigned int index,
>  					     unsigned int num,
> 
> base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
> -- 
> 2.53.0

