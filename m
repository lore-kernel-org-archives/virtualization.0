Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CC1822E2
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079241; cv=none; b=iZc8sDNgpNIJKgWJFdo5OABp7qHc26PLJzByKq6vU4wA5qEECZkXvlqJCEsHpyC4aiHfd0BBvZg1MulyD7ffMu/KFJNQB4XUZAN5H384XtUc56LWDZBg2LUuCI4pmI+ENoDjBjXiFYl1VK7ogU/U7VZhS59gv1b4UOs9Rn/SpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079241; c=relaxed/simple;
	bh=HhwyaE6DFadzOwfhFG6khoTSZLfQhMak7Y9ulxjdCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qCgkFfZ4WkYjQQt1T+QF/4TpClxS5HkWo4iMhv2oEgVOBmKlziJakeAMXJXaQJI5F33MS1j3J4wszdPRXcfCcZ8AT2DjcEQIXsr+7iPthJ0iHCwOOEeWL9ZIv+0d7XYzbYO9KhZtiPys0moU/yVrjT5qyKhetafiVs2Sy4CmBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQh92kg8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQh92kg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720079238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8/YAlRCjKuGkNLjkSmBuw+u27+aGTZd4jOvOkV8+AQ=;
	b=WQh92kg8o6igicCacmPOH4daNGlUhpHgGN+u4bAn6kgDyOFBrkUGQFmT3qVQ4u1mmQfhz4
	q6kzQsktMeZpxQItMz7bYxwb1mVmr1bRmDN90ugo0sKeAzwiGBsVC0iRwYRUuyZo2lXBEp
	i3GB6ZD4OOkLVkXqX0jeaAkE4VrhuUM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209--6TAgiMNNy658WR2pYP0oA-1; Thu, 04 Jul 2024 03:47:17 -0400
X-MC-Unique: -6TAgiMNNy658WR2pYP0oA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee87e69b53so4141281fa.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 00:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079235; x=1720684035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8/YAlRCjKuGkNLjkSmBuw+u27+aGTZd4jOvOkV8+AQ=;
        b=m/t+Z0IKLFhe/ASK+QAtwa0vN0vAJqaNM+X1S6cnRoz4aHHGyW75ctjXYO1sgO8pns
         FJhzRhdqJVuDHEKKQWvntj3i8ntE0y9gF0PI7cKySbCWSC6Jp0rN6Phtn0nAgKV0IsQ1
         8+zzRZ6atvcUBUw1wbgllbxsTXLfX/riwrB9XHZk5/CFG8YZskrhfMZg58OZPHZouopI
         2sGjayWRsDbqzpnNOhYHX2DlzP8/vQSGZ8yvZ7HQlZdZcLodB+/Hw07eprMDnsl7EqbJ
         om99E9lsD10lRcF7QBEordlI9fLo/TRYs3eQoE2O2BF++iFhgOCBiBxwm35Gs9fovT5G
         MBKQ==
X-Gm-Message-State: AOJu0Yy20+Av0DdEBro4H5oMowYCbxTghA0d7zdQj6S/ENaM7UcicPdL
	7/HK8JExjsDBUn983ivRDnncSbi9/dyhqPb/rLT4W0EsGjMqryJmlyExsEjQDCKhb9jsWTpva5v
	aLGdm/4mUE7q+WQf5Cg5Z/eP/D5MsVEAp5CmPI/NUGsEumiYrJWUV2rxDd+6Pp5Zh
X-Received: by 2002:a2e:6a18:0:b0:2ed:59af:ecb4 with SMTP id 38308e7fff4ca-2ee8ee0e975mr6260471fa.41.1720079235722;
        Thu, 04 Jul 2024 00:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG10sxyRCTTtEDoPeJO2l1jBFeFjeNumqFXyoML8cnwylVAltccaAuWNUjvQ4Wt+ALP+L+cgA==
X-Received: by 2002:a2e:6a18:0:b0:2ed:59af:ecb4 with SMTP id 38308e7fff4ca-2ee8ee0e975mr6260111fa.41.1720079235023;
        Thu, 04 Jul 2024 00:47:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:82e2:c2d2:c800:4b76:dc98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679f9783d0sm544379f8f.9.2024.07.04.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:47:14 -0700 (PDT)
Date: Thu, 4 Jul 2024 03:47:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <20240704034225-mutt-send-email-mst@kernel.org>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240704064350.1097716-5-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 08:43:35AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce a structure virtio_queue_info to carry name, callback and ctx
> together. In order to allow config implementations to accept config op
> with array of virtio_queue_info structures, introduce a new
> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
> at the and of this patchset.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - fixed comments for struct virtqueue_info
> - s/virtio_queue_info/virtqueue_info/
> ---
>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 82a1d798b2f1..9b975c2830f6 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -18,6 +18,16 @@ struct virtio_shm_region {
>  
>  typedef void vq_callback_t(struct virtqueue *);
>  
> +struct virtqueue_info {
> +	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
> +			   * unused by driver.
> +			   */
> +	vq_callback_t *callback; /* May be NULL for vq that does
> +				  * not need a callback.
> +				  */
> +	bool ctx;


	/*
	 * Always
	 * like this
	 * outside of netdev code
	 * and it comes before the code being documented
	 */

	/* Never
	 * like this
	 */


Also "may be null" is a bit confusing - it has to be null
for such a vq.

Thus:

	/*
	 * name: mainly for debugging, NULL for a virtqueue
         * unused by the driver.
	 */
	const char *name;

and similarly for the callback.



> +};
> +
>  /**
>   * struct virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
>   *	names: array of virtqueue names (mainly for debugging)
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
> + * @find_vqs_info: find virtqueues and instantiate them.
> + *	vdev: the virtio_device
> + *	nvqs: the number of virtqueues to find
> + *	vqs: on success, includes new virtqueues
> + *	vqs_info: array of virtqueue info structures
> + *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
>   *      The function guarantees that all memory operations on the
> @@ -109,6 +125,10 @@ struct virtio_config_ops {
>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
> +			     struct virtqueue *vqs[],
> +			     struct virtqueue_info vqs_info[],
> +			     struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
>  	void (*synchronize_cbs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
> @@ -117,7 +137,7 @@ struct virtio_config_ops {
>  	int (*set_vq_affinity)(struct virtqueue *vq,
>  			       const struct cpumask *cpu_mask);
>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
> -			int index);
> +						 int index);
>  	bool (*get_shm_region)(struct virtio_device *vdev,
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  }
>  
> +static inline
> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
> +			 struct virtqueue *vqs[],
> +			 struct virtqueue_info vqs_info[],
> +			 struct irq_affinity *desc)
> +{
> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> +}
> +
>  static inline
>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc)
>  {
> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
> -				      desc);
> +	struct virtqueue_info *vqs_info;
> +	int err, i;
> +
> +	if (!vdev->config->find_vqs_info)
> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
> +					      names, ctx, desc);
> +
> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
> +	if (!vqs_info)
> +		return -ENOMEM;
> +	for (i = 0; i < nvqs; i++) {
> +		vqs_info[i].name = names[i];
> +		vqs_info[i].callback = callbacks[i];
> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
> +	}
> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> +	kfree(vqs_info);
> +	return err;
>  }
>  
>  static inline
> -- 
> 2.45.2

