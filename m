Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB46D2F5
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102640; cv=none; b=heu56VMByBFUp+jtjDAQKowWOsVN1OAIjENu74SMDW6T9Ar1X7L59amPyBwosVSYwVVODH4Je7J7jMB91aWH/GC75rcQdspOirKO9l+aeAL3LG36f5AWe8dwyPTVm+IVVfnfI0wKkFAddFkMWvdTqaNbqunq4lYlwHhMDRZVr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102640; c=relaxed/simple;
	bh=DSDX5hv6yoeY6e+Xi11CbEqUZCJzVrl+rObFzBpDvuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fws+ZjhTs4RwoRS1tKPvkZ/cvdIjYw+LjqbPf+x5OaTSeYZCNhdQbHXoLsQwgMc3MbNvIE6mhOuoFqWyLnm3NXehuIkDDQJnSYL7igApixP/wG7BrIyfY/47pHHH1CC2NW14Gw0Sa1QN+INMBq7mdhps703BwB9ZctsXPKPkeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2FEtJ9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2FEtJ9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720102638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81XTVaymHFatVkkbiUiUOKMTnPrWY3swIrzw2bNW2WY=;
	b=I2FEtJ9ozzIlCISXR8+zLTK3dOy73scHPW40BqzCQCW4Fm0w76r/IdO98nN91ajyLEddpH
	Tkh/VIqNdmPofkI7DkGkL5hZTrnWB5SYNdB/Yu/etm+4Na9r69dbydhi9z49qFEBJC2wjZ
	GKMFpzpqBUTmmb/gvpm8k+p7QY66RM0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-QQ0FSWz1OySLX-3AhSZfQA-1; Thu, 04 Jul 2024 10:17:16 -0400
X-MC-Unique: QQ0FSWz1OySLX-3AhSZfQA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee87d500caso7537051fa.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102635; x=1720707435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81XTVaymHFatVkkbiUiUOKMTnPrWY3swIrzw2bNW2WY=;
        b=BOo5zE8WtT920qDOqu2KwwDiCDWTHw3NEXgYSe3V9Bph6zHnKgh2DezuEp2IwBbhgM
         xptNVNXcVWmn3fkZBMiMMFd1wJgq9IwM3xZvvXsW1JyRLIjvBCeuey1hwz3rAyvXdCe2
         BsqmoQO8uBrcy1JwSiBW/mSTxB9+lvq+QX8AxxSYW8lky2tlA8goQKWarIZQwrBRBJgm
         ObC2IJ7jd40fvKPyxlNPl8Jr4z5ONaDJo7s2ivww0CvQkHm4bKSfT3K+VyrB6bs66X0u
         HLm5SNBVOBnoIFBJMq22GydghH/npjGI7ZLZETjCtI0Zzop5cVUHzJyUrm5pA0RxFJKN
         VT7Q==
X-Gm-Message-State: AOJu0YwD4H3/41DOJClvbT6Vet+37QpayTX8ov1CA8sfNlCJVqt5TcDc
	4kXA0E292CmHvFpezAolpuNsEGV+P+1C44xeLmKYpjwkmeiqtzrZxHgVvt7m37B6alG44vYH0iv
	eU1pZoguLIowiqc1v0PZZcaYkJPelBBHqnTpO0hQ6+OKksItV2z2F6KL/a9QqEeS8
X-Received: by 2002:a2e:a6a3:0:b0:2ec:58e8:d7a8 with SMTP id 38308e7fff4ca-2ee8eda0135mr11005261fa.28.1720102635468;
        Thu, 04 Jul 2024 07:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENG5TxKjmiF+n/mnKJcqF6J5K5B/rogvXWNKF9dTua+EozP8c3wO8hEBX0Bav6cuEupp3TIQ==
X-Received: by 2002:a2e:a6a3:0:b0:2ec:58e8:d7a8 with SMTP id 38308e7fff4ca-2ee8eda0135mr11004671fa.28.1720102634090;
        Thu, 04 Jul 2024 07:17:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36799a54215sm2284375f8f.68.2024.07.04.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:17:13 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:17:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info
 struct and find_vqs_info() config op
Message-ID: <20240704101659-mutt-send-email-mst@kernel.org>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <20240704064350.1097716-5-jiri@resnulli.us>
 <20240704034225-mutt-send-email-mst@kernel.org>
 <ZoaCJJCUN_h743uV@nanopsycho.orion>
 <20240704072548-mutt-send-email-mst@kernel.org>
 <Zoac0faVqLm_JYv7@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zoac0faVqLm_JYv7@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 03:00:01PM +0200, Jiri Pirko wrote:
> Thu, Jul 04, 2024 at 01:28:03PM CEST, mst@redhat.com wrote:
> >On Thu, Jul 04, 2024 at 01:06:12PM +0200, Jiri Pirko wrote:
> >> Thu, Jul 04, 2024 at 09:47:09AM CEST, mst@redhat.com wrote:
> >> >On Thu, Jul 04, 2024 at 08:43:35AM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> Introduce a structure virtio_queue_info to carry name, callback and ctx
> >> >> together. In order to allow config implementations to accept config op
> >> >> with array of virtio_queue_info structures, introduce a new
> >> >> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
> >> >> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
> >> >> at the and of this patchset.
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> ---
> >> >> v1->v2:
> >> >> - fixed comments for struct virtqueue_info
> >> >> - s/virtio_queue_info/virtqueue_info/
> >> >> ---
> >> >>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
> >> >>  1 file changed, 48 insertions(+), 3 deletions(-)
> >> >> 
> >> >> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> >> index 82a1d798b2f1..9b975c2830f6 100644
> >> >> --- a/include/linux/virtio_config.h
> >> >> +++ b/include/linux/virtio_config.h
> >> >> @@ -18,6 +18,16 @@ struct virtio_shm_region {
> >> >>  
> >> >>  typedef void vq_callback_t(struct virtqueue *);
> >> >>  
> >> >> +struct virtqueue_info {
> >> >> +	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
> >> >> +			   * unused by driver.
> >> >> +			   */
> >> >> +	vq_callback_t *callback; /* May be NULL for vq that does
> >> >> +				  * not need a callback.
> >> >> +				  */
> >> >> +	bool ctx;
> >> >
> >> >
> >> >	/*
> >> >	 * Always
> >> >	 * like this
> >> >	 * outside of netdev code
> >> >	 * and it comes before the code being documented
> >> >	 */
> >> >
> >> >	/* Never
> >> >	 * like this
> >> >	 */
> >> 
> >> 
> >> How about to properly document the struct instead like this:
> >> /**
> >>  * struct virtqueue_info - info for a virtqueue passed to find_vqs()
> >>  * @name: mainly for debugging, NULL for a virtqueue
> >>  *        unused by the driver
> >>  * @callback: NULL for a virtqueue that does not need a callback
> >>  * @ctx: true to allow to maintain extra context per virtqueue
> >>  */
> >> struct virtqueue_info {
> >>         const char *name;
> >>         vq_callback_t *callback;
> >>         bool ctx;
> >> };
> >
> >Sure. And actually include the explanation what the fields are then?
> >@name: virtqueue description
> >@callback: a callback to invoke on a used buffer notification
> 
> Okay, how about:
> 
> /**
>  * struct virtqueue_info - Info for a virtqueue passed to find_vqs().
>  * @name: virtqueue description. Used mainly for debugging, NULL for
>  *        a virtqueue unused by the driver.
>  * @callback: A callback to invoke on a used buffer notification.
>  *            NULL for a virtqueue that does not need a callback.
>  * @ctx: A flag to indicate to maintain an extra context per virtqueue.
>  */
> struct virtqueue_info {
>         const char *name;
>         vq_callback_t *callback;
>         bool ctx;
> };
> 
> 
> ?


Looks good to me.

> 
> 
> >
> >
> >> 
> >> 
> >> >
> >> >
> >> >Also "may be null" is a bit confusing - it has to be null
> >> >for such a vq.
> >> >
> >> >Thus:
> >> >
> >> >	/*
> >> >	 * name: mainly for debugging, NULL for a virtqueue
> >> >         * unused by the driver.
> >> >	 */
> >> >	const char *name;
> >> >
> >> >and similarly for the callback.
> >> >
> >> >
> >> >
> >> >> +};
> >> >> +
> >> >>  /**
> >> >>   * struct virtio_config_ops - operations for configuring a virtio device
> >> >>   * Note: Do not assume that a transport implements all of the operations
> >> >> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
> >> >>   *	names: array of virtqueue names (mainly for debugging)
> >> >>   *		include a NULL entry for vqs unused by driver
> >> >>   *	Returns 0 on success or error status
> >> >> + * @find_vqs_info: find virtqueues and instantiate them.
> >> >> + *	vdev: the virtio_device
> >> >> + *	nvqs: the number of virtqueues to find
> >> >> + *	vqs: on success, includes new virtqueues
> >> >> + *	vqs_info: array of virtqueue info structures
> >> >> + *	Returns 0 on success or error status
> >> >>   * @del_vqs: free virtqueues found by find_vqs().
> >> >>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> >> >>   *      The function guarantees that all memory operations on the
> >> >> @@ -109,6 +125,10 @@ struct virtio_config_ops {
> >> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >> >>  			const char * const names[], const bool *ctx,
> >> >>  			struct irq_affinity *desc);
> >> >> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
> >> >> +			     struct virtqueue *vqs[],
> >> >> +			     struct virtqueue_info vqs_info[],
> >> >> +			     struct irq_affinity *desc);
> >> >>  	void (*del_vqs)(struct virtio_device *);
> >> >>  	void (*synchronize_cbs)(struct virtio_device *);
> >> >>  	u64 (*get_features)(struct virtio_device *vdev);
> >> >> @@ -117,7 +137,7 @@ struct virtio_config_ops {
> >> >>  	int (*set_vq_affinity)(struct virtqueue *vq,
> >> >>  			       const struct cpumask *cpu_mask);
> >> >>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
> >> >> -			int index);
> >> >> +						 int index);
> >> >>  	bool (*get_shm_region)(struct virtio_device *vdev,
> >> >>  			       struct virtio_shm_region *region, u8 id);
> >> >>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
> >> >> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
> >> >>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
> >> >>  }
> >> >>  
> >> >> +static inline
> >> >> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
> >> >> +			 struct virtqueue *vqs[],
> >> >> +			 struct virtqueue_info vqs_info[],
> >> >> +			 struct irq_affinity *desc)
> >> >> +{
> >> >> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> >> >> +}
> >> >> +
> >> >>  static inline
> >> >>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
> >> >>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >> >>  			const char * const names[], const bool *ctx,
> >> >>  			struct irq_affinity *desc)
> >> >>  {
> >> >> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
> >> >> -				      desc);
> >> >> +	struct virtqueue_info *vqs_info;
> >> >> +	int err, i;
> >> >> +
> >> >> +	if (!vdev->config->find_vqs_info)
> >> >> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
> >> >> +					      names, ctx, desc);
> >> >> +
> >> >> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
> >> >> +	if (!vqs_info)
> >> >> +		return -ENOMEM;
> >> >> +	for (i = 0; i < nvqs; i++) {
> >> >> +		vqs_info[i].name = names[i];
> >> >> +		vqs_info[i].callback = callbacks[i];
> >> >> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
> >> >> +	}
> >> >> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
> >> >> +	kfree(vqs_info);
> >> >> +	return err;
> >> >>  }
> >> >>  
> >> >>  static inline
> >> >> -- 
> >> >> 2.45.2
> >> >
> >

