Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2045180040
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616827; cv=none; b=FtsmiAb93kp5/fQjbxxn+xDYUun/yp/bdtnPSPzDzxNyD0znVrQb50zTwVZ85s4lMiQe433WPCxO1YWXMd9g3R7sxuop+IES9shj+8+HUAY2nH8b86ft/BY8XaXjITp2K9SsJ+0wy22Her+j3ntE91/JIpQfa0oL+ROywwX7xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616827; c=relaxed/simple;
	bh=Fdv3wTFYAq0dKqXieM2MucV/mogyNF/ka3K9MKgpY0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lt6TK0uVK8apYF9O1ESGiZfWtI1LZH0gvBBO6u916gTI5/DU5M4nTAUW/RNGA48bmX7r7qtW8VY3M+Gph79MIku6iYO/VlkFKNqQEZaqMaDAINFdzUKWDM9BfhLK+L5OwZCyN/WH9g8w+jWUZ/oZTM7+DNvRpN4yWV0i29BMU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLUgARM5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLUgARM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720616825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6+D+CYnCBbJ2EnRdD9U54tUHriM+r7K0S9Ki/wHQYo=;
	b=iLUgARM5JioP5m59mQXdj4a9Emrdysfqh1g7K/4wqjbJCI90UuvAKjjKvXHQzhAPUgqR48
	XHvuKyIRX8GK3hhjXpr19llbg7mkH50KBN5RorHNl4cavGLNuFcFcEG9Fmp/c8A6+zMyO7
	Pvq0ZtU9k7o0GbnMgL+YfY8e0f+VO54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-yPrN_J9HPiuuCI6YCvXnlQ-1; Wed, 10 Jul 2024 09:07:03 -0400
X-MC-Unique: yPrN_J9HPiuuCI6YCvXnlQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426724679f0so4372445e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720616822; x=1721221622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6+D+CYnCBbJ2EnRdD9U54tUHriM+r7K0S9Ki/wHQYo=;
        b=fYN+upGhMBJr/E148wWg7kjpNd5WtZrz3Y711CzZQip+Su0GL8bEwOAsC6szkd7Gkc
         QZxCQQUd0LXcO5YuNOuuem+aO9sA+KgAYboWbSvnd5p+ME1aY6p0ql0QNvRnSQ0mITAo
         BCC8BNEbG5fEnTw2Fv3hLZzxzqXUkOBQoO6p16WWoyAOy1TX3187AB6l06/Xjfb0VnsZ
         FKbCmiHGcdjSCZqrtahylxbhSH33mK6BbbapcnGq/UAQYPcA6HCvczOgXtrX6PhUwvy/
         cpNSO5PopqEM+AzyJPaqdfyP7Saofd3zqJzLp9MytsG1ogEGlY6dawYDCWm27RY5wqsH
         Ne/g==
X-Gm-Message-State: AOJu0YyfZd6uqKWrVPHCq13qBq6B13xJ11GdT8k3ei6e1nkZp3or0gTd
	yhjlYVqN9roWuXyAqMMDJvmCumPiIX4OTKPmr/bYhimula2mDKk16e21A/g56wLMvNoXlfCuA55
	5Six4ReRjZYfgX6unYlV7PF65yGPeyTD7G44kvRLL86tvBn+KVe5nEIaEYEuBviQG
X-Received: by 2002:a05:600c:4341:b0:426:676a:c4d1 with SMTP id 5b1f17b1804b1-426722d4a36mr45381155e9.8.1720616822324;
        Wed, 10 Jul 2024 06:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5IEmZi3dkkNrEHPawTMbrIqprHR0hejbw1JoMB4c4xCsuo4ddH4nEsJW/Iy8+wqTRAr8aQA==
X-Received: by 2002:a05:600c:4341:b0:426:676a:c4d1 with SMTP id 5b1f17b1804b1-426722d4a36mr45380735e9.8.1720616821690;
        Wed, 10 Jul 2024 06:07:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f10ebsm81325095e9.16.2024.07.10.06.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:07:00 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:06:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <20240710090418-mutt-send-email-mst@kernel.org>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
 <20240710073925-mutt-send-email-mst@kernel.org>
 <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 03:03:33PM +0200, Jiri Pirko wrote:
> Wed, Jul 10, 2024 at 01:47:22PM CEST, mst@redhat.com wrote:
> >On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Currently, the code waits in a busy loop on every admin virtqueue issued
> >> command to get a reply. That prevents callers from issuing multiple
> >> commands in parallel.
> >> 
> >> To overcome this limitation, introduce a virtqueue event callback for
> >> admin virtqueue. For every issued command, use completion mechanism
> >> to wait on a reply. In the event callback, trigger the completion
> >> is done for every incoming reply.
> >> 
> >> Alongside with that, introduce a spin lock to protect the admin
> >> virtqueue operations.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - rebased on top of newly added patches
> >> - rebased on top of changes in previous patches (vq info, vqs[])
> >> - removed WARN_ON_ONCE() when calling virtqueue_kick()
> >> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
> >> - added vp_modern_avq_cleanup() implementation to handle surprise
> >>   removal case
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 13 ++++--
> >>  drivers/virtio/virtio_pci_common.h |  3 ++
> >>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
> >>  include/linux/virtio.h             |  3 ++
> >>  4 files changed, 77 insertions(+), 16 deletions(-)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index 267643bb1cd5..c44d8ba00c02 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >>  			if (vqi->name && vqi->callback)
> >>  				++nvectors;
> >>  		}
> >> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
> >> +			++nvectors;
> >>  	} else {
> >>  		/* Second best: one for change, shared for all vqs. */
> >>  		nvectors = 2;
> >> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >>  	if (!avq_num)
> >>  		return 0;
> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> >> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
> >> -				 true, &allocated_vectors, vector_policy,
> >> -				 &vp_dev->admin_vq.info);
> >> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
> >> +				 avq->name, false, true, &allocated_vectors,
> >> +				 vector_policy, &vp_dev->admin_vq.info);
> >>  	if (IS_ERR(vq)) {
> >>  		err = PTR_ERR(vq);
> >>  		goto error_find;
> >> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >>  	if (!avq_num)
> >>  		return 0;
> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> >> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
> >> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
> >> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
> >> +			 false, VIRTIO_MSI_NO_VECTOR,
> >> +			 &vp_dev->admin_vq.info);
> >>  	if (IS_ERR(vq)) {
> >>  		err = PTR_ERR(vq);
> >>  		goto out_del_vqs;
> >> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> >> index de59bb06ec3c..90df381fbbcf 100644
> >> --- a/drivers/virtio/virtio_pci_common.h
> >> +++ b/drivers/virtio/virtio_pci_common.h
> >> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
> >>  	struct virtio_pci_vq_info *info;
> >>  	/* serializing admin commands execution. */
> >>  	struct mutex cmd_lock;
> >> +	/* Protects virtqueue access. */
> >> +	spinlock_t lock;
> >>  	u64 supported_cmds;
> >>  	/* Name of the admin queue: avq.$vq_index. */
> >>  	char name[10];
> >> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
> >>  #define VIRTIO_ADMIN_CMD_BITMAP 0
> >>  #endif
> >>  
> >> +void vp_modern_avq_done(struct virtqueue *vq);
> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> >>  			     struct virtio_admin_cmd *cmd);
> >>  
> >> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> >> index 0fd344d1eaf9..608df3263df1 100644
> >> --- a/drivers/virtio/virtio_pci_modern.c
> >> +++ b/drivers/virtio/virtio_pci_modern.c
> >> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
> >>  	return index == vp_dev->admin_vq.vq_index;
> >>  }
> >>  
> >> +void vp_modern_avq_done(struct virtqueue *vq)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> >> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> >> +	struct virtio_admin_cmd *cmd;
> >> +	unsigned long flags;
> >> +	unsigned int len;
> >> +
> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
> >> +	do {
> >> +		virtqueue_disable_cb(vq);
> >> +		while ((cmd = virtqueue_get_buf(vq, &len)))
> >> +			complete(&cmd->completion);
> >> +	} while (!virtqueue_enable_cb(vq));
> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> +}
> >> +
> >>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >>  				    u16 opcode,
> >>  				    struct scatterlist **sgs,
> >> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >>  				    struct virtio_admin_cmd *cmd)
> >>  {
> >>  	struct virtqueue *vq;
> >> -	int ret, len;
> >> +	unsigned long flags;
> >> +	int ret;
> >>  
> >>  	vq = admin_vq->info->vq;
> >>  	if (!vq)
> >> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
> >>  		return -EOPNOTSUPP;
> >>  
> >> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> >> -	if (ret < 0)
> >> -		return -EIO;
> >> +	init_completion(&cmd->completion);
> >>  
> >> -	if (unlikely(!virtqueue_kick(vq)))
> >> +again:
> >> +	if (virtqueue_is_broken(vq))
> >>  		return -EIO;
> >>  
> >> -	while (!virtqueue_get_buf(vq, &len) &&
> >> -	       !virtqueue_is_broken(vq))
> >> -		cpu_relax();
> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
> >> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> >> +	if (ret < 0) {
> >> +		if (ret == -ENOSPC) {
> >> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> +			cpu_relax();
> >> +			goto again;
> >> +		}
> >> +		goto unlock_err;
> >> +	}
> >> +	if (!virtqueue_kick(vq))
> >> +		goto unlock_err;
> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >>  
> >> -	if (virtqueue_is_broken(vq))
> >> -		return -EIO;
> >> +	wait_for_completion(&cmd->completion);
> >>  
> >> -	return 0;
> >> +	return cmd->ret;
> >> +
> >> +unlock_err:
> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> +	return -EIO;
> >>  }
> >>  
> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> >> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
> >>  	virtio_pci_admin_cmd_list_init(vdev);
> >>  }
> >>  
> >> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	struct virtio_admin_cmd *cmd;
> >> +	struct virtqueue *vq;
> >> +
> >> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> >> +		return;
> >> +
> >> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
> >> +	if (!vq)
> >> +		return;
> >> +
> >> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
> >> +		cmd->ret = -EIO;
> >> +		complete(&cmd->completion);
> >> +	}
> >> +}
> >> +
> >
> >
> >I think surprise removal is still broken with this.
> 
> Why do you think so? I will drain the remaining buffers from the queue
> and complete them all. What's missing?

You have this:

> >> +  wait_for_completion(&cmd->completion);

if surprise removal triggers after you submitted command
but before it was used, no callback triggers and so no
completion either.


> 
> >You need to add a callback and signal the completion.
> 
> Callback to what?

for example, remove callback can signal completion.


> 
> 
> 
> >
> >-- 
> >MST
> >

