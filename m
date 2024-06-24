Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F352F24
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226685; cv=none; b=TKfkIjfCjBvx3M2Fr75ZN09d9EW+3s9lvtrtQvnQBGCRDKCmY/QD8YVCT7kYeVTPaAO/AYAwfyO7iq/7zWulhl1g56vImktWf6pTdNK56cAXEzMvMixwFq1H7Jawzj0omF4EOgJzhK8YjjC6kLrx1mM4ByKG9p4tIrXCnEqYpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226685; c=relaxed/simple;
	bh=kJavpS+JaxzlGg/EGIg85zfGr1vADLbZVqGkh8TG3A4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=JCc+ivBq/IljXg7I+VafGPPjG3xAY5o4NxBQl5oTyyDOBiUGn1gqF5AVxJ9Pad088dR5bJIwmNBzmkXDvklv70wFZ4txBmMIrhw5HfM2kREGdnKhGuKWU2xsfmbtkZzEDVSckeXEWqdlxV1wS3LLtidKGSIveIGCGGEJHtQ043A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ap4BZxDb; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ap4BZxDb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719226680; h=Message-ID:Subject:Date:From:To;
	bh=h9U2C+iQNGUBCS/uwLmW6MtoRsflJ7tcwikzH+xCcbA=;
	b=ap4BZxDb1Cj/2q7Z2hejKQI3Yb3veEMW2ZGX/US8wGx/f+kMfn0y0fwGFk0W+yuF7Qs5LKzNpHXtlTjb4heVbqG3hsrYuOqySJilcydSJdHBAUdJZ8TjLKDZNMB5h0TTEiajMWDT7/8ajaahe1vHSukBI7dgGx2DSyuWvx5NWlQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W989Dgc_1719226677;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W989Dgc_1719226677)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 18:57:58 +0800
Message-ID: <1719226367.026366-19-hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 1/8] virtio_pci: push out single vq find code to vp_find_one_vq_msix()
Date: Mon, 24 Jun 2024 18:52:47 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 parav@nvidia.com,
 feliu@nvidia.com,
 virtualization@lists.linux.dev
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-2-jiri@resnulli.us>
In-Reply-To: <20240624090451.2683976-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 24 Jun 2024 11:04:44 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In order to be reused for admin queue setup, push out common code to
> setup and configure irq for one vq into a separate helper.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 69 ++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index f6b0b00e4599..1fb2183e409b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -284,6 +284,44 @@ void vp_del_vqs(struct virtio_device *vdev)
>  	vp_dev->vqs = NULL;
>  }
>  
> +static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
> +					     int queue_idx,
> +					     vq_callback_t *callback,
> +					     const char *name, bool ctx,
> +					     int *allocated_vectors)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtqueue *vq;
> +	u16 msix_vec;
> +	int err;
> +
> +	if (!callback)
> +		msix_vec = VIRTIO_MSI_NO_VECTOR;
> +	else if (vp_dev->per_vq_vectors)
> +		msix_vec = (*allocated_vectors)++;
> +	else
> +		msix_vec = VP_MSIX_VQ_VECTOR;
> +	vq = vp_setup_vq(vdev, queue_idx++, callback, name, ctx, msix_vec);

Looks like we don't need this ++.

Thanks.

> +	if (IS_ERR(vq))
> +		return vq;
> +
> +	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> +		return vq;
> +
> +	/* allocate per-vq irq if available and necessary */
> +	snprintf(vp_dev->msix_names[msix_vec], sizeof(*vp_dev->msix_names),
> +		 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
> +	err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> +			  vring_interrupt, 0,
> +			  vp_dev->msix_names[msix_vec], vq);
> +	if (err) {
> +		vp_del_vq(vq);
> +		return ERR_PTR(err);
> +	}
> +
> +	return vq;
> +}
> +
>  static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  		const char * const names[], bool per_vq_vectors,
> @@ -291,7 +329,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  		struct irq_affinity *desc)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	u16 msix_vec;
>  	int i, err, nvectors, allocated_vectors, queue_idx = 0;
>  
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> @@ -321,37 +358,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  			vqs[i] = NULL;
>  			continue;
>  		}
> -
> -		if (!callbacks[i])
> -			msix_vec = VIRTIO_MSI_NO_VECTOR;
> -		else if (vp_dev->per_vq_vectors)
> -			msix_vec = allocated_vectors++;
> -		else
> -			msix_vec = VP_MSIX_VQ_VECTOR;
> -		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -				     ctx ? ctx[i] : false,
> -				     msix_vec);
> +		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, callbacks[i],
> +					     names[i], ctx ? ctx[i] : false,
> +					     &allocated_vectors);
>  		if (IS_ERR(vqs[i])) {
>  			err = PTR_ERR(vqs[i]);
>  			goto error_find;
>  		}
> -
> -		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> -			continue;
> -
> -		/* allocate per-vq irq if available and necessary */
> -		snprintf(vp_dev->msix_names[msix_vec],
> -			 sizeof *vp_dev->msix_names,
> -			 "%s-%s",
> -			 dev_name(&vp_dev->vdev.dev), names[i]);
> -		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -				  vring_interrupt, 0,
> -				  vp_dev->msix_names[msix_vec],
> -				  vqs[i]);
> -		if (err) {
> -			vp_del_vq(vqs[i]);
> -			goto error_find;
> -		}
>  	}
>  	return 0;
>  
> -- 
> 2.45.1
> 
> 
