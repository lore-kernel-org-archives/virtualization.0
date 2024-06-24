Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DB129A7B
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228899; cv=none; b=azJ9VccSQkDwMEX9OzkFx1VtdlWq2zGKRL9AQrrLv7rTHp3ZNKMKnp+br24n9F5ozxOzIYAEvot4NTJs/UDtB36B13exHUYEV7zdUk3tGDzBZSJSKWPeBWmnLv/iNBCJSbXTopG3b7jXqQ3MJLDoSMD8JhmNVSAcQOTLkJfIfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228899; c=relaxed/simple;
	bh=ZBvojgg3GO5LuiJ8PzHH9ebcM6GvNrdufDEEHKGr3p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TcVdD7i9OpOMfDv7rGjt7loLNQtBAnnVq4eKg+fcrNFyNV1LPx3e4fXo8WuKb7S0g5GAPZA07lL1ohec5fGNpmT1ewOgT1G9jAgHXMgEGsSXB0NFhudAzqipJT6WQvkOvZG2JC1sNHHP9Y13u+VDoCtvMRQPi3K7oiAod23VzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUeGf3v3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUeGf3v3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnK6R94x8u6CNkG+DfOM7w+39oWVD7gfbh3dEXcWW68=;
	b=AUeGf3v3JI7NJq/Z5i99jNinRaGhgpqcssY6pW+Ge1ok7Ji/ocZCGgeXSB2qv7GpJl2Liz
	JZvNHsJ9vUonksII+dGrM5CY3w0hpPtyGXYSmXUh5ZDPlGYBTms4uxgV5NwpUO5pi6d/xb
	0PC3MxEDTc1/dvZ7gyUPdsb/AGbMyBI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-q6iBCGkjOiiHbEK-k_0HFA-1; Mon, 24 Jun 2024 07:34:53 -0400
X-MC-Unique: q6iBCGkjOiiHbEK-k_0HFA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7169b4cfcfso57765866b.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 04:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228893; x=1719833693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnK6R94x8u6CNkG+DfOM7w+39oWVD7gfbh3dEXcWW68=;
        b=QaiH8vcYhNS3u01uviLMMjVS6PWV9leF1dlv8tCJDelE3AB6NjdtFWSYKB15YAJiF+
         o3Hkiu+7FPMg4QmN7xNVE3cpAHFci+TB7xVBfRPMSoUJuss9fdlmkBY6KmrL/7Go5BCD
         4t0w/Z+u3Y/qv83cZIJxYIM2u4ijTZC1UVLAOLiRo7pryo08xCAcHuvPEN0erLiaVGfo
         hLTbiImBjdEh9FOT9dh7ngB9Xi5ZOhlEa78xllKZMAgvyzd8n/nMJa1YWUD5iWRHPQuz
         e3mVNpOs3ofK/o1FI2lhr6jhw1OFJ9LkPKYAxLIo3J8Ggm6HtLovwtBFomHo8cTRnNAj
         gX6Q==
X-Gm-Message-State: AOJu0YwQ67VVY+Tb35xtBJqIgfPpmA62HGUlwg2lUpq991MaDrF1+iht
	9PAwBiGx8Qx1P2b78Pvj4T31Z8wqh/XSD8S0J/5PR92+hTLrJxXOGRacs9BjEcnrOMznunFTu7/
	OKW6+ZXzSJyD4x9obWK5980ZGHFp3PwicKB2P/o9vYG/eJB5hNQHLu4BV7ch+osTU
X-Received: by 2002:a17:907:d047:b0:a6f:2e28:4008 with SMTP id a640c23a62f3a-a7245c82455mr294085166b.54.1719228892581;
        Mon, 24 Jun 2024 04:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFo8uAzn97jJSlSJhD2Ff92FJGI9TfYH/uLxRiuFt/8sdk+00ro75clXmYkCZwnnUyUDh7NA==
X-Received: by 2002:a17:907:d047:b0:a6f:2e28:4008 with SMTP id a640c23a62f3a-a7245c82455mr294082666b.54.1719228891837;
        Mon, 24 Jun 2024 04:34:51 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7263b3d60esm4765666b.113.2024.06.24.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:34:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:34:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <20240624073115-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240624090451.2683976-8-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 11:04:50AM +0200, Jiri Pirko wrote:
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
>  drivers/virtio/virtio_pci_common.c | 10 +++---
>  drivers/virtio/virtio_pci_common.h |  3 ++
>  drivers/virtio/virtio_pci_modern.c | 52 +++++++++++++++++++++++-------
>  include/linux/virtio.h             |  2 ++
>  4 files changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 07c0511f170a..5ff7304c7a2a 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -346,6 +346,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  		for (i = 0; i < nvqs; ++i)
>  			if (names[i] && callbacks[i])
>  				++nvectors;
> +		if (avq_num)
> +			++nvectors;
>  	} else {
>  		/* Second best: one for change, shared for all vqs. */
>  		nvectors = 2;
> @@ -375,8 +377,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  	if (!avq_num)
>  		return 0;
>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> -	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name,
> -				     false, &allocated_vectors);
> +	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
> +				     avq->name, false, &allocated_vectors);
>  	if (IS_ERR(vqs[i])) {
>  		err = PTR_ERR(vqs[i]);
>  		goto error_find;
> @@ -432,8 +434,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	if (!avq_num)
>  		return 0;
>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> -	vqs[i] = vp_setup_vq(vdev, queue_idx++, NULL, avq->name,
> -			     false, VIRTIO_MSI_NO_VECTOR);
> +	vqs[i] = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done,
> +			     avq->name, false, VIRTIO_MSI_NO_VECTOR);
>  	if (IS_ERR(vqs[i])) {
>  		err = PTR_ERR(vqs[i]);
>  		goto out_del_vqs;
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index b3ef76287b43..38a0b6df0844 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -45,6 +45,8 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_admin_vq {
>  	/* serializing admin commands execution. */
>  	struct mutex cmd_lock;
> +	/* Protects virtqueue access. */
> +	spinlock_t lock;
>  	u64 supported_cmds;
>  	/* Name of the admin queue: avq.$vq_index. */
>  	char name[10];
> @@ -174,6 +176,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>  #endif
>  
> +void vp_modern_avq_done(struct virtqueue *vq);
>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>  			     struct virtio_admin_cmd *cmd);
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index b4041e541fc3..b9937e4b8a69 100644
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
>  static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>  				    struct virtio_pci_admin_vq *admin_vq,
>  				    u16 opcode,
> @@ -62,7 +79,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>  				    struct virtio_admin_cmd *cmd)
>  {
>  	struct virtqueue *vq;
> -	int ret, len;
> +	unsigned long flags;
> +	int ret;
>  
>  	vq = vp_dev->vqs[admin_vq->vq_index]->vq;
>  	if (!vq)
> @@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>  		return -EOPNOTSUPP;
>  
> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> -	if (ret < 0)
> -		return -EIO;
> -
> -	if (unlikely(!virtqueue_kick(vq)))
> -		return -EIO;
> +	init_completion(&cmd->completion);
>  
> -	while (!virtqueue_get_buf(vq, &len) &&
> -	       !virtqueue_is_broken(vq))
> -		cpu_relax();
> +again:
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
> +	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
> +		goto unlock_err;


This can actually happen with suprise removal.
So WARN_ON_ONCE isn't really appropriate I think.


> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>  
> -	if (virtqueue_is_broken(vq))
> -		return -EIO;
> +	wait_for_completion(&cmd->completion);
>  
>  	return 0;
> +
> +unlock_err:
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> +	return -EIO;
>  }
>  
>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> @@ -787,6 +814,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  	vp_dev->isr = mdev->isr;
>  	vp_dev->vdev.id = mdev->id;
>  
> +	spin_lock_init(&vp_dev->admin_vq.lock);
>  	mutex_init(&vp_dev->admin_vq.cmd_lock);
>  	return 0;
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 26c4325aa373..5db8ee175e71 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -10,6 +10,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/completion.h>
>  
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -109,6 +110,7 @@ struct virtio_admin_cmd {
>  	__le64 group_member_id;
>  	struct scatterlist *data_sg;
>  	struct scatterlist *result_sg;
> +	struct completion completion;
>  };
>  
>  /**
> -- 
> 2.45.1

