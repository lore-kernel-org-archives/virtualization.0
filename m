Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625B15E5BA
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701995; cv=none; b=fovV0I1XsWjBp2hA2EjDxR3t43rJzxWGxIbPdVe8IEGMw8FUlS7iu08og9f3uV8yoNQ4mNJYn7xFCv/r5CwaSzLdA5WTDDMb+6jSlANq0v5izJbNOWuI+gzXpOpJrC3mt9K0U2iG0Wpbg35At316lPT9JUP6hcs/+39SDX9rZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701995; c=relaxed/simple;
	bh=zbFFKMoWV9YDK1H6JXFw5l76E2ahK5uMTZABAfu2qCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/Iqa19vth/UPx3UOHNe6G7nEewVQr9x7lU0m7K+Qj35B2J92kzXYFYr5dVqzFjfSJmLxPLSI8qjLTv1p48PXFMLgb5e8jHyE4SLvjNjaOwg1HXDm328iBJMcArnKdyjDX/XPAUFpSNcHXTend9Nuh0af7fLwWwYyqcCROQ974M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v/v/gKo8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v/v/gKo8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso815839e87.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720701989; x=1721306789; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKRQOoysHCdQAz+N3M2bYaT8bIS7VRqiSifDNP4QJTg=;
        b=v/v/gKo8qdNqk+wjk5PaMdzjU2N0TDYg3nMNAuYTTY4cjWiwurmytFBtrsZ1Muswep
         sxnH4h0X6nJjkyYdx/kjnJ0f42r1Vc3chuUVlm6ALyGTCz9EuBoSGsyiE9IFMPlJF0ds
         itlkZedcdgMjqaWiwPBdKsC1s+tcI2FnDyFuiO40GzDCRUcP/2hpjcVQ8ULwOFNvIEGY
         MBnnJuxXM1yUkqURnSCpD/3wiT/5Q89LXCK1OLQnfRY31Z1C5yI7PBBMHa38hZfRthCP
         1N7NNLsJxkFZmTNkAdCEv3+lZZv96I3fuY0HyONMFauyrKVsZgvtmB4w/e4wp2YXq3Lg
         c8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701989; x=1721306789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKRQOoysHCdQAz+N3M2bYaT8bIS7VRqiSifDNP4QJTg=;
        b=LJXvZ1OsQuDWNDGQleZXpsDygOa4LelJHZBExgFnkv33UYSu/nZvWdhC0bSLBDNmz3
         BzHu6ZDbacvnkuT/zzvt4wsNOmvSIYB9Li5mK/K09i2ENZNJFxSurhe4p839aQ0kgbnS
         U1k5eiwRIPcKirC22dXt0aMgPUkg9XX8NLHOsp77wVH+mjMgi8zhMzJ2L3QZY5YxbBvh
         Va7mFlXR0y0zsmyYiFuyE6EIw8ufbpD10HTEW2fSps7gJJ2gt8bydjsmamsFsNfnny9d
         AwH8FsUWOTXMwbB4iXnHJVsUTAHot3kZfTUVqsSoeLX782wHfAnB4AIvdkPq+wBLFVEX
         bGfA==
X-Gm-Message-State: AOJu0Yz0EzVPUF/I+HPYTT/np2HUvfvVv36HXs5yGKUxfeZA3UfbrUiU
	XdsiZCew7Li+ycoIWtQGzQdSGpMjVINcykXO46ZQ6YL1EUiEI/Kf2CMuOk1zBBoj0unpT9egnXc
	v
X-Google-Smtp-Source: AGHT+IHS5oH8NdYjJjmJv17pyrOxU7NFQBn3tmpM55R3s3mCq0t8oYLmi+WyXRVRdznpNw7kdElBdA==
X-Received: by 2002:a05:6512:3190:b0:52e:7542:f469 with SMTP id 2adb3069b0e04-52eb9759439mr7840002e87.0.1720701988465;
        Thu, 11 Jul 2024 05:46:28 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1668sm285662295e9.1.2024.07.11.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:46:27 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:46:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <Zo_UIkFBKfFaYnWb@nanopsycho.orion>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
 <20240710073925-mutt-send-email-mst@kernel.org>
 <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
 <20240710090418-mutt-send-email-mst@kernel.org>
 <Zo-TkaptSJKWCvR0@nanopsycho.orion>
 <20240711041915-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711041915-mutt-send-email-mst@kernel.org>

Thu, Jul 11, 2024 at 10:19:42AM CEST, mst@redhat.com wrote:
>On Thu, Jul 11, 2024 at 10:10:57AM +0200, Jiri Pirko wrote:
>> Wed, Jul 10, 2024 at 03:06:57PM CEST, mst@redhat.com wrote:
>> >On Wed, Jul 10, 2024 at 03:03:33PM +0200, Jiri Pirko wrote:
>> >> Wed, Jul 10, 2024 at 01:47:22PM CEST, mst@redhat.com wrote:
>> >> >On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> Currently, the code waits in a busy loop on every admin virtqueue issued
>> >> >> command to get a reply. That prevents callers from issuing multiple
>> >> >> commands in parallel.
>> >> >> 
>> >> >> To overcome this limitation, introduce a virtqueue event callback for
>> >> >> admin virtqueue. For every issued command, use completion mechanism
>> >> >> to wait on a reply. In the event callback, trigger the completion
>> >> >> is done for every incoming reply.
>> >> >> 
>> >> >> Alongside with that, introduce a spin lock to protect the admin
>> >> >> virtqueue operations.
>> >> >> 
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> ---
>> >> >> v1->v2:
>> >> >> - rebased on top of newly added patches
>> >> >> - rebased on top of changes in previous patches (vq info, vqs[])
>> >> >> - removed WARN_ON_ONCE() when calling virtqueue_kick()
>> >> >> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
>> >> >> - added vp_modern_avq_cleanup() implementation to handle surprise
>> >> >>   removal case
>> >> >> ---
>> >> >>  drivers/virtio/virtio_pci_common.c | 13 ++++--
>> >> >>  drivers/virtio/virtio_pci_common.h |  3 ++
>> >> >>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
>> >> >>  include/linux/virtio.h             |  3 ++
>> >> >>  4 files changed, 77 insertions(+), 16 deletions(-)
>> >> >> 
>> >> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> >> >> index 267643bb1cd5..c44d8ba00c02 100644
>> >> >> --- a/drivers/virtio/virtio_pci_common.c
>> >> >> +++ b/drivers/virtio/virtio_pci_common.c
>> >> >> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>> >> >>  			if (vqi->name && vqi->callback)
>> >> >>  				++nvectors;
>> >> >>  		}
>> >> >> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
>> >> >> +			++nvectors;
>> >> >>  	} else {
>> >> >>  		/* Second best: one for change, shared for all vqs. */
>> >> >>  		nvectors = 2;
>> >> >> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>> >> >>  	if (!avq_num)
>> >> >>  		return 0;
>> >> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> >> >> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
>> >> >> -				 true, &allocated_vectors, vector_policy,
>> >> >> -				 &vp_dev->admin_vq.info);
>> >> >> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
>> >> >> +				 avq->name, false, true, &allocated_vectors,
>> >> >> +				 vector_policy, &vp_dev->admin_vq.info);
>> >> >>  	if (IS_ERR(vq)) {
>> >> >>  		err = PTR_ERR(vq);
>> >> >>  		goto error_find;
>> >> >> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>> >> >>  	if (!avq_num)
>> >> >>  		return 0;
>> >> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> >> >> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
>> >> >> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
>> >> >> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
>> >> >> +			 false, VIRTIO_MSI_NO_VECTOR,
>> >> >> +			 &vp_dev->admin_vq.info);
>> >> >>  	if (IS_ERR(vq)) {
>> >> >>  		err = PTR_ERR(vq);
>> >> >>  		goto out_del_vqs;
>> >> >> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>> >> >> index de59bb06ec3c..90df381fbbcf 100644
>> >> >> --- a/drivers/virtio/virtio_pci_common.h
>> >> >> +++ b/drivers/virtio/virtio_pci_common.h
>> >> >> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
>> >> >>  	struct virtio_pci_vq_info *info;
>> >> >>  	/* serializing admin commands execution. */
>> >> >>  	struct mutex cmd_lock;
>> >> >> +	/* Protects virtqueue access. */
>> >> >> +	spinlock_t lock;
>> >> >>  	u64 supported_cmds;
>> >> >>  	/* Name of the admin queue: avq.$vq_index. */
>> >> >>  	char name[10];
>> >> >> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>> >> >>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>> >> >>  #endif
>> >> >>  
>> >> >> +void vp_modern_avq_done(struct virtqueue *vq);
>> >> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> >> >>  			     struct virtio_admin_cmd *cmd);
>> >> >>  
>> >> >> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> >> >> index 0fd344d1eaf9..608df3263df1 100644
>> >> >> --- a/drivers/virtio/virtio_pci_modern.c
>> >> >> +++ b/drivers/virtio/virtio_pci_modern.c
>> >> >> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>> >> >>  	return index == vp_dev->admin_vq.vq_index;
>> >> >>  }
>> >> >>  
>> >> >> +void vp_modern_avq_done(struct virtqueue *vq)
>> >> >> +{
>> >> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>> >> >> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>> >> >> +	struct virtio_admin_cmd *cmd;
>> >> >> +	unsigned long flags;
>> >> >> +	unsigned int len;
>> >> >> +
>> >> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> >> >> +	do {
>> >> >> +		virtqueue_disable_cb(vq);
>> >> >> +		while ((cmd = virtqueue_get_buf(vq, &len)))
>> >> >> +			complete(&cmd->completion);
>> >> >> +	} while (!virtqueue_enable_cb(vq));
>> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> >> +}
>> >> >> +
>> >> >>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >> >>  				    u16 opcode,
>> >> >>  				    struct scatterlist **sgs,
>> >> >> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >> >>  				    struct virtio_admin_cmd *cmd)
>> >> >>  {
>> >> >>  	struct virtqueue *vq;
>> >> >> -	int ret, len;
>> >> >> +	unsigned long flags;
>> >> >> +	int ret;
>> >> >>  
>> >> >>  	vq = admin_vq->info->vq;
>> >> >>  	if (!vq)
>> >> >> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >> >>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>> >> >>  		return -EOPNOTSUPP;
>> >> >>  
>> >> >> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> >> >> -	if (ret < 0)
>> >> >> -		return -EIO;
>> >> >> +	init_completion(&cmd->completion);
>> >> >>  
>> >> >> -	if (unlikely(!virtqueue_kick(vq)))
>> >> >> +again:
>> >> >> +	if (virtqueue_is_broken(vq))
>> >> >>  		return -EIO;
>> >> >>  
>> >> >> -	while (!virtqueue_get_buf(vq, &len) &&
>> >> >> -	       !virtqueue_is_broken(vq))
>> >> >> -		cpu_relax();
>> >> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> >> >> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> >> >> +	if (ret < 0) {
>> >> >> +		if (ret == -ENOSPC) {
>> >> >> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> >> +			cpu_relax();
>> >> >> +			goto again;
>> >> >> +		}
>> >> >> +		goto unlock_err;
>> >> >> +	}
>> >> >> +	if (!virtqueue_kick(vq))
>> >> >> +		goto unlock_err;
>> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> >>  
>> >> >> -	if (virtqueue_is_broken(vq))
>> >> >> -		return -EIO;
>> >> >> +	wait_for_completion(&cmd->completion);
>> >> >>  
>> >> >> -	return 0;
>> >> >> +	return cmd->ret;
>> >> >> +
>> >> >> +unlock_err:
>> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> >> +	return -EIO;
>> >> >>  }
>> >> >>  
>> >> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> >> >> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
>> >> >>  	virtio_pci_admin_cmd_list_init(vdev);
>> >> >>  }
>> >> >>  
>> >> >> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>> >> >> +{
>> >> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> >> >> +	struct virtio_admin_cmd *cmd;
>> >> >> +	struct virtqueue *vq;
>> >> >> +
>> >> >> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>> >> >> +		return;
>> >> >> +
>> >> >> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
>> >> >> +	if (!vq)
>> >> >> +		return;
>> >> >> +
>> >> >> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
>> >> >> +		cmd->ret = -EIO;
>> >> >> +		complete(&cmd->completion);
>> >> >> +	}
>> >> >> +}
>> >> >> +
>> >> >
>> >> >
>> >> >I think surprise removal is still broken with this.
>> >> 
>> >> Why do you think so? I will drain the remaining buffers from the queue
>> >> and complete them all. What's missing?
>> >
>> >You have this:
>> >
>> >> >> +  wait_for_completion(&cmd->completion);
>> >
>> >if surprise removal triggers after you submitted command
>> >but before it was used, no callback triggers and so no
>> >completion either.
>> 
>> Well. In that case
>> 
>> virtio_pci_remove()
>>  -> unregister_virtio_device()
>>   -> device_unregister()
>>    -> virtnet_remove()
>>     -> remove_vq_common()
>>      -> virtio_reset_device()
>>       -> vp_reset()
>>        -> vp_modern_avq_cleanup()
>> which goes over these cmds and does complete
>> them all. See vp_modern_avq_cleanup() above.
>> 
>> What am I missing?
>
>Oh, you are right. Won't work for cvq but that's
>a separate issue.

True, for cvq, this will need to be handled in:
remove_vq_common(), similar to free_unused_bufs()


>
>
>> 
>> >
>> >
>> >> 
>> >> >You need to add a callback and signal the completion.
>> >> 
>> >> Callback to what?
>> >
>> >for example, remove callback can signal completion.
>> >
>> >
>> >> 
>> >> 
>> >> 
>> >> >
>> >> >-- 
>> >> >MST
>> >> >
>> >
>
