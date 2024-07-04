Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983221AB513
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092493; cv=none; b=uMG0yOR3jSWuS+s70pDcvLCYSVWflgWDKT1f0cNTNRGSqhRzzPRjMdS1hnAmSSMq3PKmwrw86jhi3HO+JU2b4QeS2mDtvHXWoNYmfHBxosUYRCTE5XcgMrXSn5ptswDim8K2l5H4MDyYjDeXNHaVIyxuArCd0y/Rwyza9qOLGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092493; c=relaxed/simple;
	bh=u/SJOTrd14x2vLNvFNyp8CD03eHVDktOR0mkhFk2uxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MjBWpqAhB2kDGxYKc2hDmDqKrC1rSQaGfI/76acoXoCbLnHI11WBH3H/cXoGIa7z5VplIsfJQ4B1RwD1bCZnFTKn5EE3l1ipB3Uk7/RslXKULcUGUDY8Tp71UswCf5EqrqMDZgKdf1Ep4soGj8DflNiuKX5mE86L0zdb9sanrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XImuPELj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XImuPELj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720092490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OrqET4gZ6Qw9M6wTYmNWpXKhT+PnWvgaUDD6JJgfKE=;
	b=XImuPELj2A7ATBt6lR6W+HmkpF6pPY1upnzr9RVBm2KHjWJWCZk5DRta11mjzYwYsk4k/j
	D/+gTy1Ks7s2+HNjVNqW5Tux05A8aqI99qS7LTpByAyGJ0WV8UnSckrCyGP/XpzSrbadsw
	mkWElnvpUTXjUSTbVUOsjdEJpdDHaD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-cjdAN2JPOm-A2ZeOJC5jvg-1; Thu, 04 Jul 2024 07:28:08 -0400
X-MC-Unique: cjdAN2JPOm-A2ZeOJC5jvg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367987e6ebcso460041f8f.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 04:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092487; x=1720697287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OrqET4gZ6Qw9M6wTYmNWpXKhT+PnWvgaUDD6JJgfKE=;
        b=NgJg91DwLPdx7asfIUSE/ns2Dg8vwDpwXTnXex++g2cocIKYx51EhXigjNODxropZn
         vemysuXcXJ109lw5khPG63eh8uhquOOEjHSEUcoA8qcs+U9ef8JE1AdK7hcAPuw+kgH7
         LGefSDnLDUitsiJSXtuG91aRPZXdpFsfDKz4Nrkm1fe3ht5qxdEVP/NfvCk6jsUmGiA0
         wMgWn9XYnDMT1GYDJPoralSHC+gIImPrDG4KrFOzY+M6H7b3xrGMEoICkzYeOeZQDRLK
         DvpBenHPH00W1EQ+TvnZTu5K6hN9d9gldHZuxLZZTCjZot3vxfKjR5XJFNp0fjORYFeE
         Rngg==
X-Gm-Message-State: AOJu0YxN4LA04AnODeoCTLecFE8E/+vc/7eYDSVvAldmPdMz5K3bD4UD
	+COSTPetcEk1pSezeBMg2/1Dlt2ut3Ytd2yNw+FyhxCZMkLDKjrg64SyZOE/qBDmwI8DQGZxrls
	/pYK+N3EjK08sTnTcLlOhNQOobq9TyRuVlpChaiALuGH3vXjhuPTfASGq9CPe3puH
X-Received: by 2002:a05:6000:124c:b0:367:9718:5792 with SMTP id ffacd0b85a97d-3679dd29597mr964177f8f.18.1720092487639;
        Thu, 04 Jul 2024 04:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2VBikROYKRL/mF6QNvyWEzFBNTX69+XH+q40qk5O9HC7KRSOX7N+u201/VOOnm4k2p5kREA==
X-Received: by 2002:a05:6000:124c:b0:367:9718:5792 with SMTP id ffacd0b85a97d-3679dd29597mr964154f8f.18.1720092487004;
        Thu, 04 Jul 2024 04:28:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2519a4sm20945075e9.35.2024.07.04.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:28:06 -0700 (PDT)
Date: Thu, 4 Jul 2024 07:28:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <20240704072548-mutt-send-email-mst@kernel.org>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-5-jiri@resnulli.us>
 <20240704034225-mutt-send-email-mst@kernel.org>
 <ZoaCJJCUN_h743uV@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZoaCJJCUN_h743uV@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 01:06:12PM +0200, Jiri Pirko wrote:
> Thu, Jul 04, 2024 at 09:47:09AM CEST, mst@redhat.com wrote:
> >On Thu, Jul 04, 2024 at 08:43:35AM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Introduce a structure virtio_queue_info to carry name, callback and ctx
> >> together. In order to allow config implementations to accept config op
> >> with array of virtio_queue_info structures, introduce a new
> >> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
> >> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
> >> at the and of this patchset.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - fixed comments for struct virtqueue_info
> >> - s/virtio_queue_info/virtqueue_info/
> >> ---
> >>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
> >>  1 file changed, 48 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> index 82a1d798b2f1..9b975c2830f6 100644
> >> --- a/include/linux/virtio_config.h
> >> +++ b/include/linux/virtio_config.h
> >> @@ -18,6 +18,16 @@ struct virtio_shm_region {
> >>  
> >>  typedef void vq_callback_t(struct virtqueue *);
> >>  
> >> +struct virtqueue_info {
> >> +	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
> >> +			   * unused by driver.
> >> +			   */
> >> +	vq_callback_t *callback; /* May be NULL for vq that does
> >> +				  * not need a callback.
> >> +				  */
> >> +	bool ctx;
> >
> >
> >	/*
> >	 * Always
> >	 * like this
> >	 * outside of netdev code
> >	 * and it comes before the code being documented
> >	 */
> >
> >	/* Never
> >	 * like this
> >	 */
> 
> 
> How about to properly document the struct instead like this:
> /**
>  * struct virtqueue_info - info for a virtqueue passed to find_vqs()
>  * @name: mainly for debugging, NULL for a virtqueue
>  *        unused by the driver
>  * @callback: NULL for a virtqueue that does not need a callback
>  * @ctx: true to allow to maintain extra context per virtqueue
>  */
> struct virtqueue_info {
>         const char *name;
>         vq_callback_t *callback;
>         bool ctx;
> };

Sure. And actually include the explanation what the fields are then?
@name: virtqueue description
@callback: a callback to invoke on a used buffer notification


> 
> 
> >
> >
> >Also "may be null" is a bit confusing - it has to be null
> >for such a vq.
> >
> >Thus:
> >
> >	/*
> >	 * name: mainly for debugging, NULL for a virtqueue
> >         * unused by the driver.
> >	 */
> >	const char *name;
> >
> >and similarly for the callback.
> >
> >
> >
> >> +};
> >> +
> >>  /**
> >>   * struct virtio_config_ops - operations for configuring a virtio device
> >>   * Note: Do not assume that a transport implements all of the operations
> >> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
> >>   *	names: array of virtqueue names (mainly for debugging)
> >>   *		include a NULL entry for vqs unused by driver
> >>   *	Returns 0 on success or error status
> >> + * @find_vqs_info: find virtqueues and instantiate them.
> >> + *	vdev: the virtio_device
> >> + *	nvqs: the number of virtqueues to find
> >> + *	vqs: on success, includes new virtqueues
> >> + *	vqs_info: array of virtqueue info structures
> >> + *	Returns 0 on success or error status
> >>   * @del_vqs: free virtqueues found by find_vqs().
> >>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> >>   *      The function guarantees that all memory operations on the
> >> @@ -109,6 +125,10 @@ struct virtio_config_ops {
> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >>  			const char * const names[], const bool *ctx,
> >>  			struct irq_affinity *desc);
> >> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
> >> +			     struct virtqueue *vqs[],
> >> +			     struct virtqueue_info vqs_info[],
> >> +			     struct irq_affinity *desc);
> >>  	void (*del_vqs)(struct virtio_device *);
> >>  	void (*synchronize_cbs)(struct virtio_device *);
> >>  	u64 (*get_features)(struct virtio_device *vdev);
> >> @@ -117,7 +137,7 @@ struct virtio_config_ops {
> >>  	int (*set_vq_affinity)(struct virtqueue *vq,
> >>  			       const struct cpumask *cpu_mask);
> >>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
> >> -			int index);
> >> +						 int index);
> >>  	bool (*get_shm_region)(struct virtio_device *vdev,
> >>  			       struct virtio_shm_region *region, u8 id);
> >>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
> >> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
> >>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
> >>  }
> >>  
> >> +static inline
> >> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
> >> +			 struct virtqueue *vqs[],
> >> +			 struct virtqueue_info vqs_info[],
> >> +			 struct irq_affinity *desc)
> >> +{
> >> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> >> +}
> >> +
> >>  static inline
> >>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >>  			const char * const names[], const bool *ctx,
> >>  			struct irq_affinity *desc)
> >>  {
> >> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
> >> -				      desc);
> >> +	struct virtqueue_info *vqs_info;
> >> +	int err, i;
> >> +
> >> +	if (!vdev->config->find_vqs_info)
> >> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
> >> +					      names, ctx, desc);
> >> +
> >> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
> >> +	if (!vqs_info)
> >> +		return -ENOMEM;
> >> +	for (i = 0; i < nvqs; i++) {
> >> +		vqs_info[i].name = names[i];
> >> +		vqs_info[i].callback = callbacks[i];
> >> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
> >> +	}
> >> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> >> +	kfree(vqs_info);
> >> +	return err;
> >>  }
> >>  
> >>  static inline
> >> -- 
> >> 2.45.2
> >

