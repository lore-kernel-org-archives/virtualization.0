Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149C1A2555
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086186; cv=none; b=l2Ngzu3sX2N3qyZ4TXt8DZFAVWfw6IzVbjxBrCr9K5OJ/M8tdGjh2itJhRzy+SglEkFWwYPdCS47/dHf9WFmrWqw+M+dQbFFBdmuMRIou5Ldgx45nOGKwH2cUvxs1nssYM4Vuik/u/EgRaTXqDQtRiVHbHwhuTPZiJpBFPyikcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086186; c=relaxed/simple;
	bh=BUriZPsUVbhLATzAmI0PjxunmyADKeXgU84CGi3jAmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0497N2CSTvixIJI8nB2GaQihqyMU6efoddqpPg1zoIRFrHsPpTSr8tS98Sh5Ln2wsAZn6QtkwhxQsyHz7rLwgk9MfnwYaGoXlVkQklLcxDIhwAv5NYievcHH17PmrZDox53fK2NFf9r4KjMRZUYdxZF5h9uJIOky+jf0gVCC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SUWnqR0u; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SUWnqR0u"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42564316479so2527515e9.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720086181; x=1720690981; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaEvD8qcU1ZnSG7I84a4WlGeJNpP1dihxcMT9PIpY8Y=;
        b=SUWnqR0uwKgr1ap3+A5mAtuWUfhnY5anQqeFHPDPfoDSEK5+KdwaAX9HV2tntsw5/q
         Xw2c8RjWjV/IczqzkEUlBznvNIR3EygVDEoTW6adYuqyvkXVnU6HEXFOm65QaXAkHeIJ
         QYjcHpoA+8leb9k32TeunTldVtI9HiVsIIAXXoIoP010LKj/fiwQhHt/eMvhluIiHFKx
         rujBX5QOe9s/bZKQVM+e2FSaB/DfTjNhj/egic6Tt+sSW9kSbPJ6hHoe3pOhmbgiKrhA
         PUlakxpUSWDzDa7b0ZPQjWluCBS+656l+UidbJ5ewjbjvdeGcEil//3r+Dfnw3rWQrFQ
         UNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086181; x=1720690981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaEvD8qcU1ZnSG7I84a4WlGeJNpP1dihxcMT9PIpY8Y=;
        b=wGk6SsNwU/Ji0F8BfLvQqAG/vcoUmGONNeV1zMpK9Uqr90U4Mwu+I730KO1QYNvncZ
         L8LRG1hVm6/27f032PPHMsgq181xv65uy70iZpfjzNOcQG4u1uEPYUKN0jndSmAzjJ4k
         qIoBpgkwmNgA8aeRxvFnGzPFd4nFKsLrE5OxJYFJtVcUq8Qj0m4THnXkEia925fXTpeU
         Mmo2ZsXrGyFPrjrSyuI2Uw7eVmftSNQuxJF5DOx/22DkZZ8CoOkzC3hsVsyjSQZU+NHs
         K5/Nv7j7SpmIHSgr0oUoVHYG61+bKoi9Jn61Zo5Gu7UiGovOCQl4bAarz6Bdq1EAh+ui
         YhZQ==
X-Gm-Message-State: AOJu0YxbzOeV/jFusFsUdp1gGp38Oh4lr6RcX9t3WmJS14MFVEskIT3d
	Qs8f/MIIflEXfq5F73H6EZ9b4khnPPbmVWZIN21uJAd+Nosszfu/a6YDDuhIQZg=
X-Google-Smtp-Source: AGHT+IHuoUTRBAX7yCQuos76mosjsd/ZK/qD45nQt7/eIbrPD0auMJqWZKU6Z6LcKYLRexfG44pnmQ==
X-Received: by 2002:a7b:cd95:0:b0:426:4186:efae with SMTP id 5b1f17b1804b1-4264a3d1d13mr9723645e9.14.1720086180722;
        Thu, 04 Jul 2024 02:43:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28327fsm16620075e9.39.2024.07.04.02.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:43:00 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:42:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <ZoZuoOoqMoLAMm3N@nanopsycho.orion>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-5-jiri@resnulli.us>
 <20240704034225-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704034225-mutt-send-email-mst@kernel.org>

Thu, Jul 04, 2024 at 09:47:09AM CEST, mst@redhat.com wrote:
>On Thu, Jul 04, 2024 at 08:43:35AM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce a structure virtio_queue_info to carry name, callback and ctx
>> together. In order to allow config implementations to accept config op
>> with array of virtio_queue_info structures, introduce a new
>> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
>> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
>> at the and of this patchset.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - fixed comments for struct virtqueue_info
>> - s/virtio_queue_info/virtqueue_info/
>> ---
>>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 82a1d798b2f1..9b975c2830f6 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -18,6 +18,16 @@ struct virtio_shm_region {
>>  
>>  typedef void vq_callback_t(struct virtqueue *);
>>  
>> +struct virtqueue_info {
>> +	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
>> +			   * unused by driver.
>> +			   */
>> +	vq_callback_t *callback; /* May be NULL for vq that does
>> +				  * not need a callback.
>> +				  */
>> +	bool ctx;
>
>
>	/*
>	 * Always
>	 * like this
>	 * outside of netdev code
>	 * and it comes before the code being documented
>	 */

Ah, yeah.

I wonder howcome checkpatch does not warn.


>
>	/* Never
>	 * like this
>	 */
>
>
>Also "may be null" is a bit confusing - it has to be null
>for such a vq.
>
>Thus:
>
>	/*
>	 * name: mainly for debugging, NULL for a virtqueue
>         * unused by the driver.
>	 */

Okay.


>	const char *name;
>
>and similarly for the callback.

Yes.

Will send v3 later today if there are no more comments.

Thanks!

>
>
>
>> +};
>> +
>>  /**
>>   * struct virtio_config_ops - operations for configuring a virtio device
>>   * Note: Do not assume that a transport implements all of the operations
>> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
>>   *	names: array of virtqueue names (mainly for debugging)
>>   *		include a NULL entry for vqs unused by driver
>>   *	Returns 0 on success or error status
>> + * @find_vqs_info: find virtqueues and instantiate them.
>> + *	vdev: the virtio_device
>> + *	nvqs: the number of virtqueues to find
>> + *	vqs: on success, includes new virtqueues
>> + *	vqs_info: array of virtqueue info structures
>> + *	Returns 0 on success or error status
>>   * @del_vqs: free virtqueues found by find_vqs().
>>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
>>   *      The function guarantees that all memory operations on the
>> @@ -109,6 +125,10 @@ struct virtio_config_ops {
>>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>  			const char * const names[], const bool *ctx,
>>  			struct irq_affinity *desc);
>> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
>> +			     struct virtqueue *vqs[],
>> +			     struct virtqueue_info vqs_info[],
>> +			     struct irq_affinity *desc);
>>  	void (*del_vqs)(struct virtio_device *);
>>  	void (*synchronize_cbs)(struct virtio_device *);
>>  	u64 (*get_features)(struct virtio_device *vdev);
>> @@ -117,7 +137,7 @@ struct virtio_config_ops {
>>  	int (*set_vq_affinity)(struct virtqueue *vq,
>>  			       const struct cpumask *cpu_mask);
>>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
>> -			int index);
>> +						 int index);
>>  	bool (*get_shm_region)(struct virtio_device *vdev,
>>  			       struct virtio_shm_region *region, u8 id);
>>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>>  }
>>  
>> +static inline
>> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
>> +			 struct virtqueue *vqs[],
>> +			 struct virtqueue_info vqs_info[],
>> +			 struct irq_affinity *desc)
>> +{
>> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> +}
>> +
>>  static inline
>>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>  			const char * const names[], const bool *ctx,
>>  			struct irq_affinity *desc)
>>  {
>> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
>> -				      desc);
>> +	struct virtqueue_info *vqs_info;
>> +	int err, i;
>> +
>> +	if (!vdev->config->find_vqs_info)
>> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
>> +					      names, ctx, desc);
>> +
>> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
>> +	if (!vqs_info)
>> +		return -ENOMEM;
>> +	for (i = 0; i < nvqs; i++) {
>> +		vqs_info[i].name = names[i];
>> +		vqs_info[i].callback = callbacks[i];
>> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
>> +	}
>> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> +	kfree(vqs_info);
>> +	return err;
>>  }
>>  
>>  static inline
>> -- 
>> 2.45.2
>
