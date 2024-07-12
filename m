Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1C14A4C8
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794734; cv=none; b=FAbDlk0AzgM5fo5HatgrAnh0Yszgu2SLN0B2keljAz2kmXDsQ4Sbdir5EsP7gUwTO4HvGYZo2zUxn2L2n5CfMPJRn9vIZ1KUkHZwD33D7U94CSYMuFkPGQ7rFeHh1FWmPurfN+QfwGo/HRjSpLuH939npnBYwLR9+jlng8dyq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794734; c=relaxed/simple;
	bh=VFCopUPBEjTjvEEJyJCDdw6ihpAQYILE8dCAvZP7nzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHNJ2o7s4JSmyZx/IXpdM4Ekl2NYD/5ucBv3NJvkgX9zKIMxFhMgZH5oalzqZWn11z6c+X5FIj14GPjMdcfxHz1DAtyWOwUq0qkjsYAi99AcA0dHv1ce9PIsw0Z+h185VxgSi75t8Bly/u/E6UFg5wiIUK4pyxTkrML9+O2y8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwBRydlD; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwBRydlD"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ca9835db95so1145430eaf.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720794732; x=1721399532; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8xzGj3vpubQKIl5IQbW92b7Jx4PGoJxyBPX5y3yAQE=;
        b=NwBRydlDgChyZYcKum0nwlcZBHaO61+AgZY5Qii4D16iPdUx5z4KIecAoS6uNFOHmu
         FOgpkh+ABw60litQJkxagm+ptH/Qjp+WnJzbBT7KNVbgBpKKTrCrQ34GTTc8IpcZ1BuZ
         Lf4oRnvUPGypx9ZgQK5YYRZjNUmqaZsAB/Fv6Qc2tucsox7xpY5heT49q6R1pANWRIMQ
         rAN5aRQoLtaqwO61AOVyB4AXnZwEd4yz2XanWutlXpd+SeWBmIJ18UqFPwOS1bRLyJGD
         VSVFPgFVU7fhv2/D2WaNgoi9IxhOe5JCvkcXs6ilnerE8TUCuEC1PhOabR0Fg2UNb9x1
         8jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794732; x=1721399532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8xzGj3vpubQKIl5IQbW92b7Jx4PGoJxyBPX5y3yAQE=;
        b=kFLigPOoYyDWp9xHWhvoGELQ5XZvVtF1HdA7W5nVgvrWjE4UTIg7UeNEUESW/cnjQt
         uTdd7Mm+g22JyQO3+g8Hou/O/8ONI028hsumRHuJsZlwzOzbiK9iQ7u4eV3Tkh2cCTWf
         gcJ8wfgCrVqf9wUVJPlTLvSyyk24k+Y5Usy33AjN4ChSwlH//5F4UJare0QzpZyPXbw3
         viQ1C9nApZIHfksE+6N4SF/UqqCiI9ly8oZBrILU/NxnqlRHSJyx3ELtLk6BkJ2BEatt
         AXY3UeYexA4nZ+QeRc+mhcC/E/Gwx2opQ0VQHuvNGS++qbq1zjWzA+CXPJxUf5RvfFDn
         JGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpfhM4NfImXMY0gv8JyrtXeNDlDm5Adju2EloDhgRnT8D8iCYQMrjPW3blRvzU82dGScIIkJTfFOr0RTpAnq9dhP6ZCOHxBHhUCI8wUcI=
X-Gm-Message-State: AOJu0Yx9NhpbbmDRcY0f2kW2vsvhal58jd7fLgbb4IALyrQmksnJqGKu
	U+uwMr9EJVJz4vJ121xkL3RdXC+isehYTqQ1U9HxpQC7ve8zzPxoopMV6bbKmg==
X-Google-Smtp-Source: AGHT+IEqKgGv8X4d1PLEand1okJOTyiilqjq0/2Hga1bEFuVpLT//VwEmjG8yjliBCOFR49jaJ4bKA==
X-Received: by 2002:a05:6359:740f:b0:1aa:a19e:f1a4 with SMTP id e5c5f4694b2df-1aade0883ecmr887161555d.1.1720794731681;
        Fri, 12 Jul 2024 07:32:11 -0700 (PDT)
Received: from thinkpad ([120.60.61.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm5920291a12.22.2024.07.12.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:32:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:02:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mie@igel.co.jp
Subject: Re: [PATCH] virtio-pci: Add MSI support
Message-ID: <20240712143202.GB3571@thinkpad>
References: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>

+ Jason Wang (email got truncated).

On Fri, Jul 12, 2024 at 07:59:14PM +0530, Manivannan Sadhasivam wrote:
> Virtio spec has so far only supported MSI-X and INTX for receiving the
> interrupts from the virtio device on PCI transport. But this becomes a
> limiting factor for devices supporting only MSI (plus INTX emulation) as
> they have to use the legacy INTX emulation which is limited to one IRQ per
> PCIe function.
> 
> But this now addressed with the help of a proposal to the Virtio spec
> adding MSI support [1]. Based on that, let's implement MSI support in the
> virtio-pci driver.
> 
> The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
> config_msix_vector/queue_msix_vector fields of the Virito common config
> structure. Following that, MSI support in virtio-pci driver is also added
> on top of the existing MSI-X implementation and it mostly reuses the MSI-X
> code base. The existing vp_find_vqs_msix() API is modified to support MSI
> along with MSI-X.
> 
> The preference for interrupt allocation is still given to MSI-X as per the
> spec. The driver will try to allocate MSI only if both of the MSI-X
> allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
> driver will try to allocate one MSI vector for each queue first, and if
> that fails, it will try to allocate 2 vectors (one for config queue and one
> shared for queues). If both of them fails, driver will fallback to the
> legacy INTX as usual.
> 
> For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
> flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
> functionalities such as IRQ affinity are also reused for MSI (but the
> affinity setting really depends on the underlying IRQCHIP controller).
> 
> [1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |  2 +-
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index f6b0b00e4599..6f80b0c46c5f 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> -				   bool per_vq_vectors, struct irq_affinity *desc)
> +				   bool per_vq_vectors, struct irq_affinity *desc,
> +				   unsigned int flags)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
> -	unsigned int flags = PCI_IRQ_MSIX;
>  	unsigned int i, v;
>  	int err = -ENOMEM;
>  
> @@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  		const char * const names[], bool per_vq_vectors,
>  		const bool *ctx,
> -		struct irq_affinity *desc)
> +		struct irq_affinity *desc, unsigned int flags)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 msix_vec;
> @@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  	}
>  
>  	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
> -				      per_vq_vectors ? desc : NULL);
> +				      per_vq_vectors ? desc : NULL, flags);
>  	if (err)
>  		goto error_find;
>  
> @@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	int err;
>  
>  	/* Try MSI-X with one vector per queue. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> +			       desc, PCI_IRQ_MSIX);
>  	if (!err)
>  		return 0;
>  	/* Fallback: MSI-X with one vector for config, one shared for queues. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> +			       desc, PCI_IRQ_MSIX);
> +	if (!err)
> +		return 0;
> +	/* Try MSI with one vector per queue. */
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> +			       desc, PCI_IRQ_MSI);
> +	if (!err)
> +		return 0;
> +	/* Fallback: MSI with one vector for config, one shared for queues. */
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> +			       desc, PCI_IRQ_MSI);
>  	if (!err)
>  		return 0;
>  	/* Is there an interrupt? If not give up. */
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 7fef52bee455..a5062ca85f3b 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -77,7 +77,7 @@ struct virtio_pci_device {
>  
>  	struct virtio_pci_admin_vq admin_vq;
>  
> -	/* MSI-X support */
> +	/* MSI/MSI-X support */
>  	int msix_enabled;
>  	int intx_enabled;
>  	cpumask_var_t *msix_affinity_masks;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
