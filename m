Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65213D60E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234719; cv=none; b=RyEXZCvbp5EGlPl49vvdt6LnrWNpkJMHxpOzi3JjI2CFqUYmHsSof8SxqyiW8mbc6t73ocJzOT++NpZZrFe+wMrD3UgkbP4p7YrAuZWO/0hYhznTT8y13+CJfpCKvkRLhKjpdxiFBSnofz27JUhrujiatqkJD9GEz5UalYpgiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234719; c=relaxed/simple;
	bh=UxcAIgoPfKLiySPrxqXExBC/D3wsgP7C9Sqgzynofrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtxEBkEkzTUqrA7omK1zgrS+UkxsH0AYb6dSfchuGFia8UVXG7p8GTV3O6PwVr6JgUIDoEVF+bZ0M+E3GO0Lz3bnHciwtpb1fKC4QJ96AmGGQZvzja9+v5fox1XMaJ5IYZeooyDbZhPeSlr8glUvKeC1Ve9Rd+zyBi0OCWd+hTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=suIj3AA+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="suIj3AA+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4218008c613so35928315e9.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719234715; x=1719839515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEn5PvPiyEvI+c1cz7P9IJF5yhcMfZVAIiAKLHuTebQ=;
        b=suIj3AA+et20UD/keutFg2CiKvW2SapmcGBiYqJjkjkp0qNESuI5ZSkDN8CmgSDT8a
         40CXog5buZchQnogK0LlXG8V3JZxQyCYFLgZFASjZjEetmezopMekDwkWlg+Eq6Hpqz+
         kGIbPKebr5tUjM3us6TwcThLA5dHDK+FLptrNt5B059Jv1WQqiREbPHOgy4iJV2U4eRX
         omvPzYFiJquWAeHibxanhZTeiuzMs/H+9owgQVpsA74cSi4L6YA0CjtWEBNp0izB94t/
         vRdUu+/axKnQVB0NtUrjKiUHFRyaFKU2ccK1K7otCqyTS26q+o/NKpCyugPyDFUxrN+U
         fFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234715; x=1719839515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEn5PvPiyEvI+c1cz7P9IJF5yhcMfZVAIiAKLHuTebQ=;
        b=JX84aWtlWW9BwvDEoXqKM34hV8HTFeeI6FUH4NiXQls7Aea7Qu1X8495+I+nL2b4yC
         7oHYdxJxHkSnjNRA3dfF4B2jthROlOr6y8vmKKOYpf43Bsm43ZAvzgHNgtz7fSoiAAxl
         Mm5PXaLzz59X4MHu6RdVczK+psY4zZt6beyjNU3TGlajCMOmGpQQtykfmQr8AqIKUOW8
         2oYj/OPifXp+rxSNPYjDBoFf47dPBEI5Q5pmN1JEPjmcYrH2BR1HIIqlgSsPqB9jBmAJ
         idyOm3WnZxHqlRVW5wgkDNBzb1l17xQYNW4YSAfGrrxHd8eGnsciBicEPP1gLqshwpl7
         EvpA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/133aJ3+wiZmD1sDQvwF7MSllGcC9OCtlUGvzGP/4ugrG1nchbQQ5Mz3UlmUaMtKF4xyoWN+VmWbb54NpkTcIe/9cPh0gtB4fVRt4tY=
X-Gm-Message-State: AOJu0YzdJyeYJBP/PmbAIIFEDM70Xy+Ng0FTwyfSNvZaQT1uKgSkrQ4E
	9xh4ZWIgnbYKELn9H+NEJb38pEXPhxS6luMXqp6O1TzEHmB77NzbTLzUwevVh8o=
X-Google-Smtp-Source: AGHT+IFrPJRMaa0lSOSUsFZtxyO/2BSa0WvnD91NsaiO3fM+MCoq2DKymXQxiveM6FKho4ysbVSdTg==
X-Received: by 2002:a05:600c:5715:b0:421:5609:115d with SMTP id 5b1f17b1804b1-4248cc78a09mr31799325e9.41.1719234715498;
        Mon, 24 Jun 2024 06:11:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f687dsm10050264f8f.15.2024.06.24.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:11:55 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:11:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, parav@nvidia.com, feliu@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 1/8] virtio_pci: push out single vq find code to
 vp_find_one_vq_msix()
Message-ID: <Znlwl5h_h7T1TyC4@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-2-jiri@resnulli.us>
 <1719226367.026366-19-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719226367.026366-19-hengqi@linux.alibaba.com>

Mon, Jun 24, 2024 at 12:52:47PM CEST, hengqi@linux.alibaba.com wrote:
>On Mon, 24 Jun 2024 11:04:44 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In order to be reused for admin queue setup, push out common code to
>> setup and configure irq for one vq into a separate helper.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 69 ++++++++++++++++++------------
>>  1 file changed, 41 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index f6b0b00e4599..1fb2183e409b 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -284,6 +284,44 @@ void vp_del_vqs(struct virtio_device *vdev)
>>  	vp_dev->vqs = NULL;
>>  }
>>  
>> +static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
>> +					     int queue_idx,
>> +					     vq_callback_t *callback,
>> +					     const char *name, bool ctx,
>> +					     int *allocated_vectors)
>> +{
>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +	struct virtqueue *vq;
>> +	u16 msix_vec;
>> +	int err;
>> +
>> +	if (!callback)
>> +		msix_vec = VIRTIO_MSI_NO_VECTOR;
>> +	else if (vp_dev->per_vq_vectors)
>> +		msix_vec = (*allocated_vectors)++;
>> +	else
>> +		msix_vec = VP_MSIX_VQ_VECTOR;
>> +	vq = vp_setup_vq(vdev, queue_idx++, callback, name, ctx, msix_vec);
>
>Looks like we don't need this ++.

True. Will remove this leftover.

>
>Thanks.
>
>> +	if (IS_ERR(vq))
>> +		return vq;
>> +
>> +	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
>> +		return vq;
>> +
>> +	/* allocate per-vq irq if available and necessary */
>> +	snprintf(vp_dev->msix_names[msix_vec], sizeof(*vp_dev->msix_names),
>> +		 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
>> +	err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
>> +			  vring_interrupt, 0,
>> +			  vp_dev->msix_names[msix_vec], vq);
>> +	if (err) {
>> +		vp_del_vq(vq);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	return vq;
>> +}
>> +
>>  static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>  		const char * const names[], bool per_vq_vectors,
>> @@ -291,7 +329,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  		struct irq_affinity *desc)
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> -	u16 msix_vec;
>>  	int i, err, nvectors, allocated_vectors, queue_idx = 0;
>>  
>>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>> @@ -321,37 +358,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  			vqs[i] = NULL;
>>  			continue;
>>  		}
>> -
>> -		if (!callbacks[i])
>> -			msix_vec = VIRTIO_MSI_NO_VECTOR;
>> -		else if (vp_dev->per_vq_vectors)
>> -			msix_vec = allocated_vectors++;
>> -		else
>> -			msix_vec = VP_MSIX_VQ_VECTOR;
>> -		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>> -				     ctx ? ctx[i] : false,
>> -				     msix_vec);
>> +		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, callbacks[i],
>> +					     names[i], ctx ? ctx[i] : false,
>> +					     &allocated_vectors);
>>  		if (IS_ERR(vqs[i])) {
>>  			err = PTR_ERR(vqs[i]);
>>  			goto error_find;
>>  		}
>> -
>> -		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
>> -			continue;
>> -
>> -		/* allocate per-vq irq if available and necessary */
>> -		snprintf(vp_dev->msix_names[msix_vec],
>> -			 sizeof *vp_dev->msix_names,
>> -			 "%s-%s",
>> -			 dev_name(&vp_dev->vdev.dev), names[i]);
>> -		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
>> -				  vring_interrupt, 0,
>> -				  vp_dev->msix_names[msix_vec],
>> -				  vqs[i]);
>> -		if (err) {
>> -			vp_del_vq(vqs[i]);
>> -			goto error_find;
>> -		}
>>  	}
>>  	return 0;
>>  
>> -- 
>> 2.45.1
>> 
>> 
