Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30631158DAE
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685465; cv=none; b=WQdVVpIQvMswxfHnBQnwnJx/PAAo1i7MuLQeNccQdYeiSZf1XvAvs9GmuagczZDmJ3U2LvDp8ffEP+LJXbsth7voP7hwHYfQekANEPE8KdQMqaC77S43U8u8su1UQWBJk1v77ZgAgnIHKIHnYXCw8ZFO3s7H4uBC22yWwEV5s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685465; c=relaxed/simple;
	bh=nAWH+kqovGyLzHOA4tYUSNTDuQGHcfZnaJKc0XwAgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naNRiT/DYNoqWfbqWLoDp2oDtgpMqD0IUDNLm+FsxHGXrBm0MEkbwtx/JM4rIVM36jWeV0uG8Y5t/9/AN9Z42xUC+h00l3greoy3m+RXAdCEqNSSWlTdbgeasMpuD3r1NP8FICbOOtWDnPU/oCMMc1I8SFrLJlBkhAv1lVGJfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SVOmnhkP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SVOmnhkP"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so7509631fa.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720685460; x=1721290260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ECIVSyBZeD5Sr44m029+DyqMzD5KxWWXnVzF5mUsh8=;
        b=SVOmnhkPg20yz5eHiByVQUfuhbBLgIcAqvKXWWiwSjSgkkyLxWLvpunpX+JtHgdyuL
         QlUIpSD5dWhmx9wwAazGG4TCTgUBrsXRML9MGXHtsiA1nVsadkg1IHDwLhp9HYJGN8UM
         YCu6PRma+Tq6Is/F0G1DyJhoXNIhOHMY9f9PpUw2N4bvE6HAXFqtIhmUPVTEWa7EkGad
         cR2ibgwPoLr9H/4643tGUXLdFaULKsuUQnUahSZWx30xnon/T+o8UAZZ9te1n9dDVHqm
         reSazbqVcGJM3lbH8ne/NBRJ8CJAeoYF5MW59dXnYXGQkT9No108pQR4zfzPMKHW7J15
         IauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685460; x=1721290260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ECIVSyBZeD5Sr44m029+DyqMzD5KxWWXnVzF5mUsh8=;
        b=LlcmzyDte3owp1ZUisiCSFpZ6aClHG3GZ42DK9ggMd7mC/aKsKAicL1g7YkcMwZctq
         18d/+1yeUGvHamgd9b3fhZDNDA+AI6BDFVYNivLAp06+Q2dQHxJPIZyv4W9pN9J2GBzo
         JgzhEiL52aOoVhrL8B17YahBAT3UWSeKL/3XsMiPqVHWwGBxfD4rsKDyKEWS6347/CIY
         h+FzLVMnRWNsx7zIPkzexBp353vXpDF5t9yzytiCcFu+qSVEDG1fGws3zDjtLkGHrJ0A
         Sr3FPQQufL5q+DGdD+5v8JRC13QjEeW4CDU6GyGJdsPjfbhWV3b8pV89L0sAAdd4DJhB
         2Njw==
X-Gm-Message-State: AOJu0YwEir2m3J0ulVzWZMRqakIJtURtp8MNraDSINFiMTfQtjKlaxgM
	8mChDnGfRpBKeaMpjyNqRot+2vmtvHO9BYkDPsogtYASrYvJiUc0GDTyWSjhvWM=
X-Google-Smtp-Source: AGHT+IEzp42ox2embjz5mqBO9hbK+nGxZ/NOOBUgoiQCAL8pcwdZbz03MmWsw/oHpMA/87ymv5OefA==
X-Received: by 2002:a19:a414:0:b0:52d:582e:8093 with SMTP id 2adb3069b0e04-52eb9995541mr3725657e87.23.1720685459885;
        Thu, 11 Jul 2024 01:10:59 -0700 (PDT)
Received: from localhost ([37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f1138sm107131405e9.19.2024.07.11.01.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:10:59 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:10:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <Zo-TkaptSJKWCvR0@nanopsycho.orion>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
 <20240710073925-mutt-send-email-mst@kernel.org>
 <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
 <20240710090418-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710090418-mutt-send-email-mst@kernel.org>

Wed, Jul 10, 2024 at 03:06:57PM CEST, mst@redhat.com wrote:
>On Wed, Jul 10, 2024 at 03:03:33PM +0200, Jiri Pirko wrote:
>> Wed, Jul 10, 2024 at 01:47:22PM CEST, mst@redhat.com wrote:
>> >On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Currently, the code waits in a busy loop on every admin virtqueue issued
>> >> command to get a reply. That prevents callers from issuing multiple
>> >> commands in parallel.
>> >> 
>> >> To overcome this limitation, introduce a virtqueue event callback for
>> >> admin virtqueue. For every issued command, use completion mechanism
>> >> to wait on a reply. In the event callback, trigger the completion
>> >> is done for every incoming reply.
>> >> 
>> >> Alongside with that, introduce a spin lock to protect the admin
>> >> virtqueue operations.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >> v1->v2:
>> >> - rebased on top of newly added patches
>> >> - rebased on top of changes in previous patches (vq info, vqs[])
>> >> - removed WARN_ON_ONCE() when calling virtqueue_kick()
>> >> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
>> >> - added vp_modern_avq_cleanup() implementation to handle surprise
>> >>   removal case
>> >> ---
>> >>  drivers/virtio/virtio_pci_common.c | 13 ++++--
>> >>  drivers/virtio/virtio_pci_common.h |  3 ++
>> >>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
>> >>  include/linux/virtio.h             |  3 ++
>> >>  4 files changed, 77 insertions(+), 16 deletions(-)
>> >> 
>> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> >> index 267643bb1cd5..c44d8ba00c02 100644
>> >> --- a/drivers/virtio/virtio_pci_common.c
>> >> +++ b/drivers/virtio/virtio_pci_common.c
>> >> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>> >>  			if (vqi->name && vqi->callback)
>> >>  				++nvectors;
>> >>  		}
>> >> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
>> >> +			++nvectors;
>> >>  	} else {
>> >>  		/* Second best: one for change, shared for all vqs. */
>> >>  		nvectors = 2;
>> >> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>> >>  	if (!avq_num)
>> >>  		return 0;
>> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> >> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
>> >> -				 true, &allocated_vectors, vector_policy,
>> >> -				 &vp_dev->admin_vq.info);
>> >> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
>> >> +				 avq->name, false, true, &allocated_vectors,
>> >> +				 vector_policy, &vp_dev->admin_vq.info);
>> >>  	if (IS_ERR(vq)) {
>> >>  		err = PTR_ERR(vq);
>> >>  		goto error_find;
>> >> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>> >>  	if (!avq_num)
>> >>  		return 0;
>> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> >> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
>> >> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
>> >> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
>> >> +			 false, VIRTIO_MSI_NO_VECTOR,
>> >> +			 &vp_dev->admin_vq.info);
>> >>  	if (IS_ERR(vq)) {
>> >>  		err = PTR_ERR(vq);
>> >>  		goto out_del_vqs;
>> >> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>> >> index de59bb06ec3c..90df381fbbcf 100644
>> >> --- a/drivers/virtio/virtio_pci_common.h
>> >> +++ b/drivers/virtio/virtio_pci_common.h
>> >> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
>> >>  	struct virtio_pci_vq_info *info;
>> >>  	/* serializing admin commands execution. */
>> >>  	struct mutex cmd_lock;
>> >> +	/* Protects virtqueue access. */
>> >> +	spinlock_t lock;
>> >>  	u64 supported_cmds;
>> >>  	/* Name of the admin queue: avq.$vq_index. */
>> >>  	char name[10];
>> >> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>> >>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>> >>  #endif
>> >>  
>> >> +void vp_modern_avq_done(struct virtqueue *vq);
>> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> >>  			     struct virtio_admin_cmd *cmd);
>> >>  
>> >> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> >> index 0fd344d1eaf9..608df3263df1 100644
>> >> --- a/drivers/virtio/virtio_pci_modern.c
>> >> +++ b/drivers/virtio/virtio_pci_modern.c
>> >> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>> >>  	return index == vp_dev->admin_vq.vq_index;
>> >>  }
>> >>  
>> >> +void vp_modern_avq_done(struct virtqueue *vq)
>> >> +{
>> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>> >> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>> >> +	struct virtio_admin_cmd *cmd;
>> >> +	unsigned long flags;
>> >> +	unsigned int len;
>> >> +
>> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> >> +	do {
>> >> +		virtqueue_disable_cb(vq);
>> >> +		while ((cmd = virtqueue_get_buf(vq, &len)))
>> >> +			complete(&cmd->completion);
>> >> +	} while (!virtqueue_enable_cb(vq));
>> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> +}
>> >> +
>> >>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >>  				    u16 opcode,
>> >>  				    struct scatterlist **sgs,
>> >> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >>  				    struct virtio_admin_cmd *cmd)
>> >>  {
>> >>  	struct virtqueue *vq;
>> >> -	int ret, len;
>> >> +	unsigned long flags;
>> >> +	int ret;
>> >>  
>> >>  	vq = admin_vq->info->vq;
>> >>  	if (!vq)
>> >> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>> >>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>> >>  		return -EOPNOTSUPP;
>> >>  
>> >> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> >> -	if (ret < 0)
>> >> -		return -EIO;
>> >> +	init_completion(&cmd->completion);
>> >>  
>> >> -	if (unlikely(!virtqueue_kick(vq)))
>> >> +again:
>> >> +	if (virtqueue_is_broken(vq))
>> >>  		return -EIO;
>> >>  
>> >> -	while (!virtqueue_get_buf(vq, &len) &&
>> >> -	       !virtqueue_is_broken(vq))
>> >> -		cpu_relax();
>> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> >> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> >> +	if (ret < 0) {
>> >> +		if (ret == -ENOSPC) {
>> >> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> +			cpu_relax();
>> >> +			goto again;
>> >> +		}
>> >> +		goto unlock_err;
>> >> +	}
>> >> +	if (!virtqueue_kick(vq))
>> >> +		goto unlock_err;
>> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >>  
>> >> -	if (virtqueue_is_broken(vq))
>> >> -		return -EIO;
>> >> +	wait_for_completion(&cmd->completion);
>> >>  
>> >> -	return 0;
>> >> +	return cmd->ret;
>> >> +
>> >> +unlock_err:
>> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> >> +	return -EIO;
>> >>  }
>> >>  
>> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> >> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
>> >>  	virtio_pci_admin_cmd_list_init(vdev);
>> >>  }
>> >>  
>> >> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>> >> +{
>> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> >> +	struct virtio_admin_cmd *cmd;
>> >> +	struct virtqueue *vq;
>> >> +
>> >> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>> >> +		return;
>> >> +
>> >> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
>> >> +	if (!vq)
>> >> +		return;
>> >> +
>> >> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
>> >> +		cmd->ret = -EIO;
>> >> +		complete(&cmd->completion);
>> >> +	}
>> >> +}
>> >> +
>> >
>> >
>> >I think surprise removal is still broken with this.
>> 
>> Why do you think so? I will drain the remaining buffers from the queue
>> and complete them all. What's missing?
>
>You have this:
>
>> >> +  wait_for_completion(&cmd->completion);
>
>if surprise removal triggers after you submitted command
>but before it was used, no callback triggers and so no
>completion either.

Well. In that case

virtio_pci_remove()
 -> unregister_virtio_device()
  -> device_unregister()
   -> virtnet_remove()
    -> remove_vq_common()
     -> virtio_reset_device()
      -> vp_reset()
       -> vp_modern_avq_cleanup()
which goes over these cmds and does complete
them all. See vp_modern_avq_cleanup() above.

What am I missing?


>
>
>> 
>> >You need to add a callback and signal the completion.
>> 
>> Callback to what?
>
>for example, remove callback can signal completion.
>
>
>> 
>> 
>> 
>> >
>> >-- 
>> >MST
>> >
>
