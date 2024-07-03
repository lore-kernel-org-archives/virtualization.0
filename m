Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674BE142649
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011789; cv=none; b=jMWAgwLF8+3Ik5AR/CagL2fwbBH5UEXWEjcvDLrRwSN/sAFewbOMorR2wRbIdF9O6Gn49osSRBIQcYVUA3qSZKV7G4GMh6zJHIE7YffTcMRS20UAeutqHbWIxwMDF0ietcu7IMkGp+Jxih3yafYwGr+hP8KUWzH4NnN2cND7/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011789; c=relaxed/simple;
	bh=52uy1r5gjdtWkPAS3X/fLr4PGgOEAHN/Y4kFfmFq2Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E14O0xgwu6XgfferoaR9l6c6EXFZjU0g+xd66Uret5y0DBkNrl08I13L1nphVbe9vnx1f69T1/YeEKnXj233LlKIMldvD2XSPEVGLDLDMeq+2kIY/lChl5Zw/pHQYjhaoT2v78OZUcX9dVvqbzo59fAqhIdpTcuOQpnIYbF3qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgSInA6e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgSInA6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720011786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbJKPApE6vu7lVIAHso4TgUhK7l6e1/KyzE8eorlQ3Y=;
	b=FgSInA6eFo3erk83K0GQzinO8i7H+pwir3cWTVBmOtSP/TVuXfUv1Sm3JwdylOymBERAUo
	EfpbFqyeU5Y8d0LeUyRutvn8n5KABKg1R1VjVq7FmztOPGXdpaM9Mql2Lpz9bOdgnBR0id
	bxWw/UcJCUdUabBK1M9Tbo546FqvLDk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-592GzTBqMDW01n16_EdJPg-1; Wed, 03 Jul 2024 09:03:05 -0400
X-MC-Unique: 592GzTBqMDW01n16_EdJPg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee87546e5eso5077781fa.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 06:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011783; x=1720616583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbJKPApE6vu7lVIAHso4TgUhK7l6e1/KyzE8eorlQ3Y=;
        b=qiTVlU8k3C0T9jOPtMDBkB7VDHeD7NGQIM7wrBCM8Hyq3xPdP3g6wkLENY8PGz/rST
         FQINazae2ZNTDlO966n044h2Hn6+FoUt+dwrzX+Qexjwkv6VFKo43QFWZLs5GJNtwQjc
         VxuI40YJpG5JRVZLtxcSIkm1VEgc9AqOrGE1Yo8nqg3eZaEc4V7/4uAKJuz5IAaaLOGk
         WrT9WNBv7IY9INmZ9lyNerNt4pjEBNE3b5caszmpOOAsVU/eVKzKCmesCDpEzH0w6OUY
         5p86MQw3kTbdleVXZrk6EcBUrD5hF9qPDYAHWHI6eviEbmj+XTxefhjsl2GswhMNhsaA
         N/dw==
X-Gm-Message-State: AOJu0YyfirdAKhTWYRf5GdLqwEVisPtjua2ShKy/f63HrpzgrsqJVwMe
	8YZ70pcq4YNCakrXT87sj/+l+7mXcXguNxiSsS8cYZQcMrunyUmOaog9h1uNMINlULyvqQg4BMh
	RK30+hjqHC+cIHxLE1z9AchS8OFzjZT1TXkFG3UjlqjCVQHKmWGVAFVhupyAb99tvlSaIodRs
X-Received: by 2002:a2e:96c6:0:b0:2ec:5933:a624 with SMTP id 38308e7fff4ca-2ee5e380907mr71295081fa.25.1720011783104;
        Wed, 03 Jul 2024 06:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcRgqsrfHNIhKYRfV5zeXkQ11b3MvS4GfzI/eSJNWjPGOXKNitStwlTwRmD30Nx/Bta4QVoQ==
X-Received: by 2002:a2e:96c6:0:b0:2ec:5933:a624 with SMTP id 38308e7fff4ca-2ee5e380907mr71294601fa.25.1720011782316;
        Wed, 03 Jul 2024 06:03:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bcbsm239016545e9.35.2024.07.03.06.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:03:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:02:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 04/19] virtio: introduce virtio_queue_info struct
 and find_vqs_info() config op
Message-ID: <20240703085123-mutt-send-email-mst@kernel.org>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703123913.969202-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240703123913.969202-5-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 02:38:58PM +0200, Jiri Pirko wrote:
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
>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 82a1d798b2f1..21029afeede1 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -18,6 +18,16 @@ struct virtio_shm_region {
>  
>  typedef void vq_callback_t(struct virtqueue *);
>  
> +struct virtio_queue_info {

I'd do virtio_queue_info -> virtqueue_info

linux$ git grep virtqueue_|wc -l
734
linux$ git grep virtio_queue_|wc -l
7



> +	const char *name; /* mainly for debugging, may be NULL for vq

Capital M pls.
vq -> a virtqueue

> +			   * unused by driver.
> +			   */
> +	vq_callback_t *callback; /* May be NULL for vq that do

do -> does

> +				  * not need a callback.
> +				  */


        /*
         * Use this style for comments
	 * which do not fit on one line, please.
         */
	int and_the_code_comes_here_afterwards;



	
> +	bool ctx;
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

See, here you actually said "virtqueue info"

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
> +			     struct virtio_queue_info vqs_info[],
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
> +			 struct virtio_queue_info vqs_info[],
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
> +	struct virtio_queue_info *vqs_info;
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

