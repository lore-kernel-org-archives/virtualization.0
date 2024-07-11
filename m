Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461F1509BC
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685994; cv=none; b=nNcT40doVFJ3AfJHGEYsYwfB2/eSomSfZyTXKVvO1P/jS2NG6qwoDUzWCdT62T/wlY+wi0KE2/qoL5lHXyjF6CMgx1NnovOi9zxOEjhxR3KNOOAfL8ErRTVZkoD+JmGng8Z3V6Q7iFA8ytTRJh0yLXZss3dmig2/+7Anp/8k/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685994; c=relaxed/simple;
	bh=JYS3rm9PJs+ddzNuwszjCGH0wCNYlYk41K0faU4Xft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bmxMX820Z3PeuvsSwbnZC3Ey+rjYTOOknpwE2UZpNzps+JxQTyw6ne6tkq8Swffme3zaDkTYwh2VIiV+SK9tN0I7UBs8h2NFNrd/56t2bdSWidEf8nLydUufRnnRqSC3VMy1I/2RS/0vFfvqdCdWxX3WrJTzdoc1lRNdRKnVmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLRabs5R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLRabs5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720685991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrEvhQLv8KXyUhlZO4yzvGhk4blFE2/RmRXblaaW2w=;
	b=hLRabs5RxE6lCsGn1toI5JCtt4vb+lovsKZrNK37pWc5PurTIEu+r3exW8v9T6TIv81hPr
	YIp8j0AtTtecS+iWY8Wnek+WArCrYxMGqF1N6EN0btLPmHsQNsIi6FxVCy5vfbMX7YRG4U
	26S0zhp+9urqMOd4Cr4Dk7oNkgTPt8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-j0exKeYdO42kMUvrvfNLQA-1; Thu, 11 Jul 2024 04:19:50 -0400
X-MC-Unique: j0exKeYdO42kMUvrvfNLQA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58d6fdee657so641755a12.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 01:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685988; x=1721290788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXrEvhQLv8KXyUhlZO4yzvGhk4blFE2/RmRXblaaW2w=;
        b=pRTZ3YE9ELfRGkxlTW1IqlUpTOO77eHvZS878Ey5CEoilkQg7naUrcHqn9Wlj5SzkU
         mptdccXTZB8L9vW0ghJ35tQrm/2idLL9L6vKoqMXL4YPU+iHT1ApLxP78+msD8d1+JQe
         tMmmFVOgE+eblAkPo66dcAK1Y2ff33NpkyED5tlY7y9qd02wBHGcAADorI1yidELDifg
         2YDoR+g6eD1rWu07quS0fAccagaXOf+Dw5mL9HORh/INhZdVIeswCt7nvgzttXuPkZN+
         l4Ru5TPA8jEOw8UC2w06f2omPh7wjzth+MY4O7UDGgyByl/WbyrB5dmyjq+ffvZdcZhK
         BM+A==
X-Gm-Message-State: AOJu0Yyz9KFEzgMzDHYnmNFVoioJYlCNI2axKCnWa9h1aUBFwqwACrBU
	LcnpsfpD1SlMu+I+hmlo2N3kLEkmbdY3776g6MiOlxeds2ywInMVjEa/yqr/bsnuFAoBy2sX/Sk
	Qn/Ejo02jCc5UatA3XvYdSwgn9FdkDUZ/UaxjWWsbncqlr5w60IvZUHnATRFWRZr0PBLRGdf/
X-Received: by 2002:a50:fa8c:0:b0:57c:70b0:d541 with SMTP id 4fb4d7f45d1cf-594bb674a9amr4873517a12.20.1720685987962;
        Thu, 11 Jul 2024 01:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ClF2Ru0JzPFsAiMv517hkVK9djAVBE3M7TZycZhLGQqe6RQH1lJf9Y5SteOHApNZtofscA==
X-Received: by 2002:a50:fa8c:0:b0:57c:70b0:d541 with SMTP id 4fb4d7f45d1cf-594bb674a9amr4873485a12.20.1720685987178;
        Thu, 11 Jul 2024 01:19:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:d026:14ac:61b9:dd29:b060])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e81e9sm3191127a12.52.2024.07.11.01.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:19:46 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:19:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <20240711041915-mutt-send-email-mst@kernel.org>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
 <20240710073925-mutt-send-email-mst@kernel.org>
 <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
 <20240710090418-mutt-send-email-mst@kernel.org>
 <Zo-TkaptSJKWCvR0@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zo-TkaptSJKWCvR0@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2024 at 10:10:57AM +0200, Jiri Pirko wrote:
> Wed, Jul 10, 2024 at 03:06:57PM CEST, mst@redhat.com wrote:
> >On Wed, Jul 10, 2024 at 03:03:33PM +0200, Jiri Pirko wrote:
> >> Wed, Jul 10, 2024 at 01:47:22PM CEST, mst@redhat.com wrote:
> >> >On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> Currently, the code waits in a busy loop on every admin virtqueue issued
> >> >> command to get a reply. That prevents callers from issuing multiple
> >> >> commands in parallel.
> >> >> 
> >> >> To overcome this limitation, introduce a virtqueue event callback for
> >> >> admin virtqueue. For every issued command, use completion mechanism
> >> >> to wait on a reply. In the event callback, trigger the completion
> >> >> is done for every incoming reply.
> >> >> 
> >> >> Alongside with that, introduce a spin lock to protect the admin
> >> >> virtqueue operations.
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> ---
> >> >> v1->v2:
> >> >> - rebased on top of newly added patches
> >> >> - rebased on top of changes in previous patches (vq info, vqs[])
> >> >> - removed WARN_ON_ONCE() when calling virtqueue_kick()
> >> >> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
> >> >> - added vp_modern_avq_cleanup() implementation to handle surprise
> >> >>   removal case
> >> >> ---
> >> >>  drivers/virtio/virtio_pci_common.c | 13 ++++--
> >> >>  drivers/virtio/virtio_pci_common.h |  3 ++
> >> >>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
> >> >>  include/linux/virtio.h             |  3 ++
> >> >>  4 files changed, 77 insertions(+), 16 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> >> index 267643bb1cd5..c44d8ba00c02 100644
> >> >> --- a/drivers/virtio/virtio_pci_common.c
> >> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> >> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >> >>  			if (vqi->name && vqi->callback)
> >> >>  				++nvectors;
> >> >>  		}
> >> >> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
> >> >> +			++nvectors;
> >> >>  	} else {
> >> >>  		/* Second best: one for change, shared for all vqs. */
> >> >>  		nvectors = 2;
> >> >> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >> >>  	if (!avq_num)
> >> >>  		return 0;
> >> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> >> >> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
> >> >> -				 true, &allocated_vectors, vector_policy,
> >> >> -				 &vp_dev->admin_vq.info);
> >> >> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
> >> >> +				 avq->name, false, true, &allocated_vectors,
> >> >> +				 vector_policy, &vp_dev->admin_vq.info);
> >> >>  	if (IS_ERR(vq)) {
> >> >>  		err = PTR_ERR(vq);
> >> >>  		goto error_find;
> >> >> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >> >>  	if (!avq_num)
> >> >>  		return 0;
> >> >>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> >> >> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
> >> >> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
> >> >> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
> >> >> +			 false, VIRTIO_MSI_NO_VECTOR,
> >> >> +			 &vp_dev->admin_vq.info);
> >> >>  	if (IS_ERR(vq)) {
> >> >>  		err = PTR_ERR(vq);
> >> >>  		goto out_del_vqs;
> >> >> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> >> >> index de59bb06ec3c..90df381fbbcf 100644
> >> >> --- a/drivers/virtio/virtio_pci_common.h
> >> >> +++ b/drivers/virtio/virtio_pci_common.h
> >> >> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
> >> >>  	struct virtio_pci_vq_info *info;
> >> >>  	/* serializing admin commands execution. */
> >> >>  	struct mutex cmd_lock;
> >> >> +	/* Protects virtqueue access. */
> >> >> +	spinlock_t lock;
> >> >>  	u64 supported_cmds;
> >> >>  	/* Name of the admin queue: avq.$vq_index. */
> >> >>  	char name[10];
> >> >> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
> >> >>  #define VIRTIO_ADMIN_CMD_BITMAP 0
> >> >>  #endif
> >> >>  
> >> >> +void vp_modern_avq_done(struct virtqueue *vq);
> >> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> >> >>  			     struct virtio_admin_cmd *cmd);
> >> >>  
> >> >> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> >> >> index 0fd344d1eaf9..608df3263df1 100644
> >> >> --- a/drivers/virtio/virtio_pci_modern.c
> >> >> +++ b/drivers/virtio/virtio_pci_modern.c
> >> >> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
> >> >>  	return index == vp_dev->admin_vq.vq_index;
> >> >>  }
> >> >>  
> >> >> +void vp_modern_avq_done(struct virtqueue *vq)
> >> >> +{
> >> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> >> >> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> >> >> +	struct virtio_admin_cmd *cmd;
> >> >> +	unsigned long flags;
> >> >> +	unsigned int len;
> >> >> +
> >> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
> >> >> +	do {
> >> >> +		virtqueue_disable_cb(vq);
> >> >> +		while ((cmd = virtqueue_get_buf(vq, &len)))
> >> >> +			complete(&cmd->completion);
> >> >> +	} while (!virtqueue_enable_cb(vq));
> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> >> +}
> >> >> +
> >> >>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >> >>  				    u16 opcode,
> >> >>  				    struct scatterlist **sgs,
> >> >> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >> >>  				    struct virtio_admin_cmd *cmd)
> >> >>  {
> >> >>  	struct virtqueue *vq;
> >> >> -	int ret, len;
> >> >> +	unsigned long flags;
> >> >> +	int ret;
> >> >>  
> >> >>  	vq = admin_vq->info->vq;
> >> >>  	if (!vq)
> >> >> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >> >>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
> >> >>  		return -EOPNOTSUPP;
> >> >>  
> >> >> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> >> >> -	if (ret < 0)
> >> >> -		return -EIO;
> >> >> +	init_completion(&cmd->completion);
> >> >>  
> >> >> -	if (unlikely(!virtqueue_kick(vq)))
> >> >> +again:
> >> >> +	if (virtqueue_is_broken(vq))
> >> >>  		return -EIO;
> >> >>  
> >> >> -	while (!virtqueue_get_buf(vq, &len) &&
> >> >> -	       !virtqueue_is_broken(vq))
> >> >> -		cpu_relax();
> >> >> +	spin_lock_irqsave(&admin_vq->lock, flags);
> >> >> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> >> >> +	if (ret < 0) {
> >> >> +		if (ret == -ENOSPC) {
> >> >> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> >> +			cpu_relax();
> >> >> +			goto again;
> >> >> +		}
> >> >> +		goto unlock_err;
> >> >> +	}
> >> >> +	if (!virtqueue_kick(vq))
> >> >> +		goto unlock_err;
> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> >>  
> >> >> -	if (virtqueue_is_broken(vq))
> >> >> -		return -EIO;
> >> >> +	wait_for_completion(&cmd->completion);
> >> >>  
> >> >> -	return 0;
> >> >> +	return cmd->ret;
> >> >> +
> >> >> +unlock_err:
> >> >> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> >> >> +	return -EIO;
> >> >>  }
> >> >>  
> >> >>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> >> >> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
> >> >>  	virtio_pci_admin_cmd_list_init(vdev);
> >> >>  }
> >> >>  
> >> >> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
> >> >> +{
> >> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> >> +	struct virtio_admin_cmd *cmd;
> >> >> +	struct virtqueue *vq;
> >> >> +
> >> >> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> >> >> +		return;
> >> >> +
> >> >> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
> >> >> +	if (!vq)
> >> >> +		return;
> >> >> +
> >> >> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
> >> >> +		cmd->ret = -EIO;
> >> >> +		complete(&cmd->completion);
> >> >> +	}
> >> >> +}
> >> >> +
> >> >
> >> >
> >> >I think surprise removal is still broken with this.
> >> 
> >> Why do you think so? I will drain the remaining buffers from the queue
> >> and complete them all. What's missing?
> >
> >You have this:
> >
> >> >> +  wait_for_completion(&cmd->completion);
> >
> >if surprise removal triggers after you submitted command
> >but before it was used, no callback triggers and so no
> >completion either.
> 
> Well. In that case
> 
> virtio_pci_remove()
>  -> unregister_virtio_device()
>   -> device_unregister()
>    -> virtnet_remove()
>     -> remove_vq_common()
>      -> virtio_reset_device()
>       -> vp_reset()
>        -> vp_modern_avq_cleanup()
> which goes over these cmds and does complete
> them all. See vp_modern_avq_cleanup() above.
> 
> What am I missing?

Oh, you are right. Won't work for cvq but that's
a separate issue.


> 
> >
> >
> >> 
> >> >You need to add a callback and signal the completion.
> >> 
> >> Callback to what?
> >
> >for example, remove callback can signal completion.
> >
> >
> >> 
> >> 
> >> 
> >> >
> >> >-- 
> >> >MST
> >> >
> >

