Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D661A4F1B
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091181; cv=none; b=UiuS2Y2NHWwEgXGyn1xw6G5VNB6+tvQ9i9NhZZDXWwzoRQIadIiEaoTv+WPqoc6XL5SSjIh1rt+YtSFaZuQsf+kpXGMgQSAGAqj4KkDFSYqXvSJ71rVTNGgOyQ3eIJR5mvM6CgNGKpI9vCv+7m/jRAV30yJSvDRxVBhG3rRU178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091181; c=relaxed/simple;
	bh=0DYiddLvftA+NT22gaUlsw9/TiRBG5l1OqE/jTecrBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZAb2sxrFAJQIK99NWoi0zNT2CjxYWNztir6TS7E9oWPnsNJzPmDDjoOlyMgjVE1tFfBx/Tj6Un1Br/eYkhS9Zvai8UA3vkAtrGlhb9EFAyznA9cIUXq7GLOJfZbraGbbMCYDUpn+EOc9RlJV5czJwTSoRAXR6/srDO9aGGIvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=J9YwL84i; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="J9YwL84i"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3679f806223so256297f8f.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720091176; x=1720695976; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttx1T5rAWiy7720+7iSGIW4LpWj9PTSrgsDJvpGosPo=;
        b=J9YwL84isEVqCglAZcsqOUF89HLKZTiCryIbJptGZ4Or9QXV4lD635jo/coXKuRMjx
         /MPtqEBWCzK9sTq/OqnmEGj359WzQLHmE0BkfMj1CVOzsQkMKGR1y3J68mudGUKRX9zR
         KrVTJugyhCJjVE4bQYUjFLGKWjgbqPkLqwNjjMgxa4QekLDlENm7fPvNZXAM3/r1cdlg
         Eft23cSPbJIeaYSKWZne5Uo9bV/SiVxBSAi/K0YUxOnER5i1r7wwjJtsLmtP4beQhX4X
         u1kzbkIrF8AxBDYag8u3pHe6e0UW96OfJgvfs+hrfk5mb/rGrzMFOMb5tM2t4rtwfIkt
         NAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091176; x=1720695976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttx1T5rAWiy7720+7iSGIW4LpWj9PTSrgsDJvpGosPo=;
        b=sWVH/Zs4FYzX3p4foFaf3aw7iov+vBoXb6wopKhmiECXFTEThU6XYHxKVXrFDc7d8y
         DHtftVwkG7JQ3mTYLAYWwpcrrAoGuMEhtVYyWQ3nWEGsWzRzutboLFAFdye5jzjxo53b
         9/8rH4gbvKGqZ6HYY+kKe5SI4MbSuFW1T1lEOvVApdI9DpDcI/T4NX8LTl3qAqj7snRQ
         ou75CB7AkzzW7+BHnJYtV2NMX+OJ4RSSv4js5TOjKgEBO8fKy+SxVtEyUftZVG7QlhbW
         TToMoz5oFNm8PV+r5uDWILhZGiPcVTCQTovAJSOkaraVq7e8Y+Q79+UqgRZfKz/t5Wht
         DWVw==
X-Gm-Message-State: AOJu0Yw4BAwzJvlPP3k70fdOqcErv23cRGHLzNiGvmyPwEdR2p7P4Cir
	ttHaU0rJ7C2x2VlPiyKIIh2S/CcCIg5GI7szfF/MCU6ipgbT6xHfX4fwA38FK/g=
X-Google-Smtp-Source: AGHT+IE4qSptSg6sUD9usEIrKsgRnzEQNgXKIaycZ7rXfsuwFszNgLtBx810E/FWN9uKTTFxmIoO6g==
X-Received: by 2002:a5d:44c9:0:b0:367:938f:550 with SMTP id ffacd0b85a97d-3679f75c689mr1107827f8f.25.1720091176345;
        Thu, 04 Jul 2024 04:06:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5d5sm20481035e9.30.2024.07.04.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:06:15 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:06:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <ZoaCJJCUN_h743uV@nanopsycho.orion>
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
>
>	/* Never
>	 * like this
>	 */


How about to properly document the struct instead like this:
/**
 * struct virtqueue_info - info for a virtqueue passed to find_vqs()
 * @name: mainly for debugging, NULL for a virtqueue
 *        unused by the driver
 * @callback: NULL for a virtqueue that does not need a callback
 * @ctx: true to allow to maintain extra context per virtqueue
 */
struct virtqueue_info {
        const char *name;
        vq_callback_t *callback;
        bool ctx;
};



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
>	const char *name;
>
>and similarly for the callback.
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
