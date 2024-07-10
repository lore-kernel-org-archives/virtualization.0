Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4D18FA0A
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612054; cv=none; b=MdSwZVcm6l5Md7PYKH4513YEBGkmZIiJFpLBJOFQPsG3RX+7ZoOz/ruqL8Sg8GUpoWOezsJuHV1640r2Cn1llzvgWjtaffvBtLo5qouEvwoVoMxWBwBLaxldzUjzZr0QYjDLlNuVf6iN2ONLuG3ZnqoTdGhaKyNoFMDhhB4zXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612054; c=relaxed/simple;
	bh=18bUd5E99J4AfJbvo+q4zZz3ta++N3pqEpn497fFm3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uCqdeUmaH9X/bAloI1jtwaGfRejGoetOqFWFOhDv+EoRbDeNxYv5o1Q4wJqMXFQXbTn0Yz16h2gwVVqrhdIptLpLBZDE2KlyrN8amJ0JydehP14eqp52Br6xIlLalkxD4TDIuLpLbS0UezSslmm6MGmaULdPspk3WZ+dEY25Y5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKDTK+YV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKDTK+YV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720612050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ/ITKetR1d6guGxS6yJ2GDwzze6vP30yCOV1YmfOWQ=;
	b=fKDTK+YVhODaFmIFPT5EEPZzb4Xf6CnPRJxNXOzVYOUbMH78DmbwMhy/0FiDN0dJpE5M9m
	20MfdUsOkz5ZyDYi4h1LTQK0qJ52ovPL2d8cKogo53TjRE4zbvSZgQ9zD2k6H8HJviWMV6
	KR2iIg6VG8hSXI4YFoTMDSDaxkJJjLk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-xzWk0Z1zO3Kc7HDB8YpQZA-1; Wed, 10 Jul 2024 07:47:28 -0400
X-MC-Unique: xzWk0Z1zO3Kc7HDB8YpQZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426724679f0so3914935e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 04:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612047; x=1721216847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ/ITKetR1d6guGxS6yJ2GDwzze6vP30yCOV1YmfOWQ=;
        b=ZtNkhUs/aTrOtFiYXtKm5oSOR1MRRgbk3eT1M3AVoNk2Ivo2zGfVuYKLTr+9NmWFSa
         v8F8tCK0Zqan94bdHXhidQKGLo6jhahom31AgGk7iGH462d3nexxQ7jXMPm/yWM73/RV
         47tXLDywGWRnmw0v9j9IEj5QUmtmv+eU7yZpqVbCNqw6iC9RLR4UxWueamIFZR/Vhoyz
         dTtLfevIZHZhfroIxWPFHra4yd9BOkgLY8kIYtJr/9QpEmskiMnx1sLgOF4LLt/FqQ64
         YufZi7kSc13AnuXK6L++Cf0uWZCtt01IIi3SVbCC+Y/65D9QcO/+axA4flYsQRlVWKCL
         UzTQ==
X-Gm-Message-State: AOJu0YwiEYZvun5EwV6DtxTvsf/F08lP29/heKM4z3uGZkG3m2O4Zrzp
	/JmDL336cUhtPHWPTAEr/Yxzm6Kl4nYSwKT9L4kkHuHw4AJQ18ITke5G69k7qpwzwYOCWAYhu1G
	l1yEFAKudvvlTyf7fhDUEsT299R78cl6FSGi6rL1LiH6ex4Mi6c6qZ7qgST9MzLpi
X-Received: by 2002:a05:600c:2d92:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-42672351ae4mr44734505e9.17.1720612047775;
        Wed, 10 Jul 2024 04:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi66D/Cn8VR4dN9xp5oP6bk1tmLn0tQ8Z+5Z8P8pxYWkRwIrKM1Sr7B1fgxQuJrG64Lg6YGw==
X-Received: by 2002:a05:600c:2d92:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-42672351ae4mr44734315e9.17.1720612047161;
        Wed, 10 Jul 2024 04:47:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde891cesm5156169f8f.62.2024.07.10.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:47:26 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:47:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <20240710073925-mutt-send-email-mst@kernel.org>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710063601.2000149-13-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, the code waits in a busy loop on every admin virtqueue issued
> command to get a reply. That prevents callers from issuing multiple
> commands in parallel.
> 
> To overcome this limitation, introduce a virtqueue event callback for
> admin virtqueue. For every issued command, use completion mechanism
> to wait on a reply. In the event callback, trigger the completion
> is done for every incoming reply.
> 
> Alongside with that, introduce a spin lock to protect the admin
> virtqueue operations.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - rebased on top of newly added patches
> - rebased on top of changes in previous patches (vq info, vqs[])
> - removed WARN_ON_ONCE() when calling virtqueue_kick()
> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
> - added vp_modern_avq_cleanup() implementation to handle surprise
>   removal case
> ---
>  drivers/virtio/virtio_pci_common.c | 13 ++++--
>  drivers/virtio/virtio_pci_common.h |  3 ++
>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
>  include/linux/virtio.h             |  3 ++
>  4 files changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 267643bb1cd5..c44d8ba00c02 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  			if (vqi->name && vqi->callback)
>  				++nvectors;
>  		}
> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
> +			++nvectors;
>  	} else {
>  		/* Second best: one for change, shared for all vqs. */
>  		nvectors = 2;
> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  	if (!avq_num)
>  		return 0;
>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
> -				 true, &allocated_vectors, vector_policy,
> -				 &vp_dev->admin_vq.info);
> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
> +				 avq->name, false, true, &allocated_vectors,
> +				 vector_policy, &vp_dev->admin_vq.info);
>  	if (IS_ERR(vq)) {
>  		err = PTR_ERR(vq);
>  		goto error_find;
> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	if (!avq_num)
>  		return 0;
>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
> +			 false, VIRTIO_MSI_NO_VECTOR,
> +			 &vp_dev->admin_vq.info);
>  	if (IS_ERR(vq)) {
>  		err = PTR_ERR(vq);
>  		goto out_del_vqs;
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index de59bb06ec3c..90df381fbbcf 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
>  	struct virtio_pci_vq_info *info;
>  	/* serializing admin commands execution. */
>  	struct mutex cmd_lock;
> +	/* Protects virtqueue access. */
> +	spinlock_t lock;
>  	u64 supported_cmds;
>  	/* Name of the admin queue: avq.$vq_index. */
>  	char name[10];
> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>  #endif
>  
> +void vp_modern_avq_done(struct virtqueue *vq);
>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>  			     struct virtio_admin_cmd *cmd);
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 0fd344d1eaf9..608df3263df1 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>  	return index == vp_dev->admin_vq.vq_index;
>  }
>  
> +void vp_modern_avq_done(struct virtqueue *vq)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> +	struct virtio_admin_cmd *cmd;
> +	unsigned long flags;
> +	unsigned int len;
> +
> +	spin_lock_irqsave(&admin_vq->lock, flags);
> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((cmd = virtqueue_get_buf(vq, &len)))
> +			complete(&cmd->completion);
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> +}
> +
>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  				    u16 opcode,
>  				    struct scatterlist **sgs,
> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  				    struct virtio_admin_cmd *cmd)
>  {
>  	struct virtqueue *vq;
> -	int ret, len;
> +	unsigned long flags;
> +	int ret;
>  
>  	vq = admin_vq->info->vq;
>  	if (!vq)
> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>  		return -EOPNOTSUPP;
>  
> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> -	if (ret < 0)
> -		return -EIO;
> +	init_completion(&cmd->completion);
>  
> -	if (unlikely(!virtqueue_kick(vq)))
> +again:
> +	if (virtqueue_is_broken(vq))
>  		return -EIO;
>  
> -	while (!virtqueue_get_buf(vq, &len) &&
> -	       !virtqueue_is_broken(vq))
> -		cpu_relax();
> +	spin_lock_irqsave(&admin_vq->lock, flags);
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +	if (ret < 0) {
> +		if (ret == -ENOSPC) {
> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
> +			cpu_relax();
> +			goto again;
> +		}
> +		goto unlock_err;
> +	}
> +	if (!virtqueue_kick(vq))
> +		goto unlock_err;
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>  
> -	if (virtqueue_is_broken(vq))
> -		return -EIO;
> +	wait_for_completion(&cmd->completion);
>  
> -	return 0;
> +	return cmd->ret;
> +
> +unlock_err:
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> +	return -EIO;
>  }
>  
>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
>  	virtio_pci_admin_cmd_list_init(vdev);
>  }
>  
> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_admin_cmd *cmd;
> +	struct virtqueue *vq;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> +		return;
> +
> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
> +	if (!vq)
> +		return;
> +
> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
> +		cmd->ret = -EIO;
> +		complete(&cmd->completion);
> +	}
> +}
> +


I think surprise removal is still broken with this.
You need to add a callback and signal the completion.

-- 
MST

