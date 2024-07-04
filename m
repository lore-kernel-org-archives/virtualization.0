Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE71A3BDA
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098022; cv=none; b=oqMVsrVakjnkrnLMqO50GY357QTu+0XYFDzABVFhTA1gHras9yuaTGmUIqwO2PXE2BjJ9FZ+0ZZ4nslkWg6FnjEOOrL0l/zy5Jrds2v4iBu6tcOvTihlOBX8s2cSRVtGQPx1/JGow3WVfCZR0vO8tb8ocfxlKI7RG8Az5N+0p4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098022; c=relaxed/simple;
	bh=aY1keunjH6EBDH3ZuAs7AvzsEQHFYTp3ej6tPGYcIZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhlDHvFRcUnGF4GQ1fcYV8cFalcKi+wLDGgjYOiRELKmP8lbhtgLCa8AJIKMho3inayYJKoB/nGdMzKddljCXPnDlWe2BHKOnzXlgtYkQIsSg6JjhgVcR5SwB5j7RBJLw/txBVPMi1T/7pe4OFJII8xWO9J6revXnfIJ95NkT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=llTwTDey; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="llTwTDey"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58bac81f341so752090a12.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720098007; x=1720702807; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kgfs3b0BEX8ObVjsfh/r5Z2jgLQ71poFmX9NhVbcmQ=;
        b=llTwTDeyyD8cIvkCc/eR6DEQF2Us+KRq7gpZZ5+NUvpEch77sZhu/asCYRLquT4205
         zYAtSwXyDoN3GmQGHx/lX6OwwcKaZP8xA6kvc+IRyjeFRxuRDQmsqGhnjmGgeug3rKxg
         7jF9nrvPzTG2MJawGCaNp59X1Zf2T9EpJV0j5XKBYpWLqNvaUm0Ac7kwyJsyNp5QMeZ4
         6XrlZ93na5KRZSxKZNsuRZjU6QPxCcKFbB9VP5egNz+VU4JFv3VkVz4YJsK3ybkDr2QC
         mGR1Y8gI4GedZunt7TJ6JxO0oV61CFR7pfECUj9tfSLP06AbBRDCq5VdGNJTJF8rKDPv
         0t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098007; x=1720702807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kgfs3b0BEX8ObVjsfh/r5Z2jgLQ71poFmX9NhVbcmQ=;
        b=QaHNmfxbeVpIwtkipomD3PiBgCFEQ+aGQ0sXG2agvV7Y48dCOHUipwzOApbVmLRR7J
         pKFopI5cx3YINpP8WBA/NjmUtDTIrWJZiVtCVJluFmxPoQWP25dgERAqUSMM24kqoJ9K
         0knRmUQJy1oo461/9WO6hcHM4yaaj57ZlE0FwDbk9O2L7roWbK1d8AcIrAfrrt76z0XO
         4/u7drYygg/QzRJg+UTRFbddhgOc57vJUnl9AmGEaeFLrkNAXwnLVmXrKVYpKGC9oLjo
         KiFFV57ndHJXFgW1d31uhyOFiNq6QRi+0mIyDHuqOCF7Qi3q/tHBPSIqHAiQwBTtfull
         TVLA==
X-Gm-Message-State: AOJu0YyFQr734q2rO+0gmlFt5yz1k/4ClbYyPKUiMydh9MG0+W2oBVME
	dW/1ESxuLQy/Fe9pN6MrDifA5a159wQUmn0xRTEmyoEZSB8bjf0CAk9XFPm+hS4=
X-Google-Smtp-Source: AGHT+IFxVm3mbRy9XhZW/UrkQ7ZcrcuzwMQWy+FX1rO36VztveEIQAVF7xhEo7BVaEdwUb4c/yhOXw==
X-Received: by 2002:a17:907:97c8:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a77ba46095emr152674866b.9.1720098006721;
        Thu, 04 Jul 2024 06:00:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1846esm596138866b.38.2024.07.04.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:00:06 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:00:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <Zoac0faVqLm_JYv7@nanopsycho.orion>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-5-jiri@resnulli.us>
 <20240704034225-mutt-send-email-mst@kernel.org>
 <ZoaCJJCUN_h743uV@nanopsycho.orion>
 <20240704072548-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704072548-mutt-send-email-mst@kernel.org>

Thu, Jul 04, 2024 at 01:28:03PM CEST, mst@redhat.com wrote:
>On Thu, Jul 04, 2024 at 01:06:12PM +0200, Jiri Pirko wrote:
>> Thu, Jul 04, 2024 at 09:47:09AM CEST, mst@redhat.com wrote:
>> >On Thu, Jul 04, 2024 at 08:43:35AM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Introduce a structure virtio_queue_info to carry name, callback and ctx
>> >> together. In order to allow config implementations to accept config op
>> >> with array of virtio_queue_info structures, introduce a new
>> >> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
>> >> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
>> >> at the and of this patchset.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >> v1->v2:
>> >> - fixed comments for struct virtqueue_info
>> >> - s/virtio_queue_info/virtqueue_info/
>> >> ---
>> >>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
>> >>  1 file changed, 48 insertions(+), 3 deletions(-)
>> >> 
>> >> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> >> index 82a1d798b2f1..9b975c2830f6 100644
>> >> --- a/include/linux/virtio_config.h
>> >> +++ b/include/linux/virtio_config.h
>> >> @@ -18,6 +18,16 @@ struct virtio_shm_region {
>> >>  
>> >>  typedef void vq_callback_t(struct virtqueue *);
>> >>  
>> >> +struct virtqueue_info {
>> >> +	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
>> >> +			   * unused by driver.
>> >> +			   */
>> >> +	vq_callback_t *callback; /* May be NULL for vq that does
>> >> +				  * not need a callback.
>> >> +				  */
>> >> +	bool ctx;
>> >
>> >
>> >	/*
>> >	 * Always
>> >	 * like this
>> >	 * outside of netdev code
>> >	 * and it comes before the code being documented
>> >	 */
>> >
>> >	/* Never
>> >	 * like this
>> >	 */
>> 
>> 
>> How about to properly document the struct instead like this:
>> /**
>>  * struct virtqueue_info - info for a virtqueue passed to find_vqs()
>>  * @name: mainly for debugging, NULL for a virtqueue
>>  *        unused by the driver
>>  * @callback: NULL for a virtqueue that does not need a callback
>>  * @ctx: true to allow to maintain extra context per virtqueue
>>  */
>> struct virtqueue_info {
>>         const char *name;
>>         vq_callback_t *callback;
>>         bool ctx;
>> };
>
>Sure. And actually include the explanation what the fields are then?
>@name: virtqueue description
>@callback: a callback to invoke on a used buffer notification

Okay, how about:

/**
 * struct virtqueue_info - Info for a virtqueue passed to find_vqs().
 * @name: virtqueue description. Used mainly for debugging, NULL for
 *        a virtqueue unused by the driver.
 * @callback: A callback to invoke on a used buffer notification.
 *            NULL for a virtqueue that does not need a callback.
 * @ctx: A flag to indicate to maintain an extra context per virtqueue.
 */
struct virtqueue_info {
        const char *name;
        vq_callback_t *callback;
        bool ctx;
};


?



>
>
>> 
>> 
>> >
>> >
>> >Also "may be null" is a bit confusing - it has to be null
>> >for such a vq.
>> >
>> >Thus:
>> >
>> >	/*
>> >	 * name: mainly for debugging, NULL for a virtqueue
>> >         * unused by the driver.
>> >	 */
>> >	const char *name;
>> >
>> >and similarly for the callback.
>> >
>> >
>> >
>> >> +};
>> >> +
>> >>  /**
>> >>   * struct virtio_config_ops - operations for configuring a virtio device
>> >>   * Note: Do not assume that a transport implements all of the operations
>> >> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
>> >>   *	names: array of virtqueue names (mainly for debugging)
>> >>   *		include a NULL entry for vqs unused by driver
>> >>   *	Returns 0 on success or error status
>> >> + * @find_vqs_info: find virtqueues and instantiate them.
>> >> + *	vdev: the virtio_device
>> >> + *	nvqs: the number of virtqueues to find
>> >> + *	vqs: on success, includes new virtqueues
>> >> + *	vqs_info: array of virtqueue info structures
>> >> + *	Returns 0 on success or error status
>> >>   * @del_vqs: free virtqueues found by find_vqs().
>> >>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
>> >>   *      The function guarantees that all memory operations on the
>> >> @@ -109,6 +125,10 @@ struct virtio_config_ops {
>> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>> >>  			const char * const names[], const bool *ctx,
>> >>  			struct irq_affinity *desc);
>> >> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
>> >> +			     struct virtqueue *vqs[],
>> >> +			     struct virtqueue_info vqs_info[],
>> >> +			     struct irq_affinity *desc);
>> >>  	void (*del_vqs)(struct virtio_device *);
>> >>  	void (*synchronize_cbs)(struct virtio_device *);
>> >>  	u64 (*get_features)(struct virtio_device *vdev);
>> >> @@ -117,7 +137,7 @@ struct virtio_config_ops {
>> >>  	int (*set_vq_affinity)(struct virtqueue *vq,
>> >>  			       const struct cpumask *cpu_mask);
>> >>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
>> >> -			int index);
>> >> +						 int index);
>> >>  	bool (*get_shm_region)(struct virtio_device *vdev,
>> >>  			       struct virtio_shm_region *region, u8 id);
>> >>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>> >> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>> >>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>> >>  }
>> >>  
>> >> +static inline
>> >> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
>> >> +			 struct virtqueue *vqs[],
>> >> +			 struct virtqueue_info vqs_info[],
>> >> +			 struct irq_affinity *desc)
>> >> +{
>> >> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> >> +}
>> >> +
>> >>  static inline
>> >>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>> >>  			const char * const names[], const bool *ctx,
>> >>  			struct irq_affinity *desc)
>> >>  {
>> >> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
>> >> -				      desc);
>> >> +	struct virtqueue_info *vqs_info;
>> >> +	int err, i;
>> >> +
>> >> +	if (!vdev->config->find_vqs_info)
>> >> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
>> >> +					      names, ctx, desc);
>> >> +
>> >> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
>> >> +	if (!vqs_info)
>> >> +		return -ENOMEM;
>> >> +	for (i = 0; i < nvqs; i++) {
>> >> +		vqs_info[i].name = names[i];
>> >> +		vqs_info[i].callback = callbacks[i];
>> >> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
>> >> +	}
>> >> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> >> +	kfree(vqs_info);
>> >> +	return err;
>> >>  }
>> >>  
>> >>  static inline
>> >> -- 
>> >> 2.45.2
>> >
>
