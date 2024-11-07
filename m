Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22C1DBB37
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982539; cv=none; b=HFTGwjCuABc7jOzC5OBk49oRFQP1c1JzGTjtZjLRMew8zL3qM1qtnjrL5KkQ540sgLedlJN671Cq8tzVL+24mVnaBwGrup8u/GQ3qqlscFkjU7kYtIbysyCAWtFxYy2mefdC1ztqWx95/amY5UNMdTBu4lmDCBopvBoCoB8tiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982539; c=relaxed/simple;
	bh=9BcOmOmm3N32NIK3Xi22fcULUmMeJrOyDzDJ5YxiHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv3EGYeyfYdn5/Ny62FY4AjIJQutpi92sYFn2c72oHGJrC8O7R0XDbyrykA46l1TJpeGyEAs4Xi4S+kSxDj1N+kXdEITBFS2BZh8mRST2DNvwIMHxv22AWSak02cyPKkjg/2WoMZq9DpbYuRMWbQDXd7ZM5nPgHGZtOvme79tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9wZ/NHP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9wZ/NHP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f1292a9bso889548e87.2
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730982536; x=1731587336; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=szLWPnOjFdN+6LPjkfncw3oSvCaCr+ooHV/EdsRYR3s=;
        b=a9wZ/NHPZE33QvzbfdNe902IkZd8Abl3S4w5YEDUF1jz9U+0ADvGZt6cciLG/wqN9K
         6Zkq8KaTkEHs40SK00B/nD5rJENnxoYKU2vSXItyAd3qI8bwnkKL0UHkGdPPBDCT1JdP
         KAE/g2UDi25sC7IqGPJ7NIEb1imyeuN1G+mdqWcGeghvjQvtP6CAGzS9HVrWEy0Gwg8d
         Ax+fpRo4pKBEOHkSFcD5vSX7ZMjMz+X8RuRV8YWnhBLEj2qhBoMjPW+J27eBz4m4PCOr
         NYZM29ztRBubqGF4ZqK+m+zPnXKSnB7d/evAI07MCm8h/Cfw/d06XmoqLCenydxXeLWF
         5QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982536; x=1731587336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szLWPnOjFdN+6LPjkfncw3oSvCaCr+ooHV/EdsRYR3s=;
        b=jRNqcX0kQmIoAkC8FYgSnWSeduTAR9hgQ8i3Z4eEQ6GrmyjCmdCbcJODTs4DJLQqLb
         4DWUpjCrUgUV+eVpw0IYusXPT3AEDO+DzIMUejxAVMP1Ob97aIIFSN+peDAM85gK1zTQ
         8mpyI2mm7PZAUWtRXoWbCpk1e3kvEW7AmgJr1q2CqzFBHf1JJfCQJbszg63hZxOufv73
         nKHPXTexa+hblvacEoILkKgd1ErEzeN6ME4+TsNzmrQLnZc0RXHaMrz2MhOT/XzvTVcv
         HC6yEHMJr8pS0TKBKaaFj+TkGI2mikBu1W4wIpfvIYt1M5g3kt8IhO/BiRl7UwFFuUbj
         HCgg==
X-Forwarded-Encrypted: i=1; AJvYcCWvTo3doAVUObjkMj10HQFQ5vVhnT+8Vs6GNiNCVDnLxrlD2f6NX6/Y4GYxe31GYGsV2dFEesCBVV89/yMB9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEcc26naog+iYsT/BYqwCY67qWnggtSk+d3lvmPb7Tcpx8ztML
	F+l43SBcdc5VDEMmkpU0D7BHWZsYIY4nhXhMyYz7Lfz4qOURs2K6yfMNWjQKng==
X-Google-Smtp-Source: AGHT+IEaAJwLpucwqXX6/1LU7Wtk9LtMp74U+I4nOuVP5xwgdT0fFXZ4o3TIuzYTlDKlaaQAboMBJA==
X-Received: by 2002:a05:6512:a8e:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53b348dac0cmr22676843e87.30.1730982536094;
        Thu, 07 Nov 2024 04:28:56 -0800 (PST)
Received: from thinkpad ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9978afsm1584950f8f.52.2024.11.07.04.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:28:54 -0800 (PST)
Date: Thu, 7 Nov 2024 12:28:53 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.co, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mie@igel.co.jp
Subject: Re: [PATCH] virtio-pci: Add MSI support
Message-ID: <20241107122853.smxqk7mlb25lscmu@thinkpad>
References: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
 <20241106043714-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106043714-mutt-send-email-mst@kernel.org>

On Wed, Nov 06, 2024 at 04:37:57AM -0500, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 07:59:14PM +0530, Manivannan Sadhasivam wrote:
> > Virtio spec has so far only supported MSI-X and INTX for receiving the
> > interrupts from the virtio device on PCI transport. But this becomes a
> > limiting factor for devices supporting only MSI (plus INTX emulation) as
> > they have to use the legacy INTX emulation which is limited to one IRQ per
> > PCIe function.
> > 
> > But this now addressed with the help of a proposal to the Virtio spec
> > adding MSI support [1]. Based on that, let's implement MSI support in the
> > virtio-pci driver.
> > 
> > The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
> > config_msix_vector/queue_msix_vector fields of the Virito common config
> > structure. Following that, MSI support in virtio-pci driver is also added
> > on top of the existing MSI-X implementation and it mostly reuses the MSI-X
> > code base. The existing vp_find_vqs_msix() API is modified to support MSI
> > along with MSI-X.
> > 
> > The preference for interrupt allocation is still given to MSI-X as per the
> > spec. The driver will try to allocate MSI only if both of the MSI-X
> > allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
> > driver will try to allocate one MSI vector for each queue first, and if
> > that fails, it will try to allocate 2 vectors (one for config queue and one
> > shared for queues). If both of them fails, driver will fallback to the
> > legacy INTX as usual.
> > 
> > For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
> > flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
> > functionalities such as IRQ affinity are also reused for MSI (but the
> > affinity setting really depends on the underlying IRQCHIP controller).
> > 
> > [1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> So I think the spec versions are mostly acceptable to people.
> So you want TC to vote as is or tweak it?
> 

The feedback (and the conclusion) on the spec patch was to remove the INTx
fallback and use single MSI vector. So both spec and this patch needs to be
changed to accomodate that.

- Mani

> In any case, this patch has to be rebased to be applied.
> 
> 
> 
> > ---
> >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |  2 +-
> >  2 files changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index f6b0b00e4599..6f80b0c46c5f 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> >  }
> >  
> >  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > -				   bool per_vq_vectors, struct irq_affinity *desc)
> > +				   bool per_vq_vectors, struct irq_affinity *desc,
> > +				   unsigned int flags)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	const char *name = dev_name(&vp_dev->vdev.dev);
> > -	unsigned int flags = PCI_IRQ_MSIX;
> >  	unsigned int i, v;
> >  	int err = -ENOMEM;
> >  
> > @@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >  		const char * const names[], bool per_vq_vectors,
> >  		const bool *ctx,
> > -		struct irq_affinity *desc)
> > +		struct irq_affinity *desc, unsigned int flags)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	u16 msix_vec;
> > @@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >  	}
> >  
> >  	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
> > -				      per_vq_vectors ? desc : NULL);
> > +				      per_vq_vectors ? desc : NULL, flags);
> >  	if (err)
> >  		goto error_find;
> >  
> > @@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >  	int err;
> >  
> >  	/* Try MSI-X with one vector per queue. */
> > -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> > +			       desc, PCI_IRQ_MSIX);
> >  	if (!err)
> >  		return 0;
> >  	/* Fallback: MSI-X with one vector for config, one shared for queues. */
> > -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> > +			       desc, PCI_IRQ_MSIX);
> > +	if (!err)
> > +		return 0;
> > +	/* Try MSI with one vector per queue. */
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> > +			       desc, PCI_IRQ_MSI);
> > +	if (!err)
> > +		return 0;
> > +	/* Fallback: MSI with one vector for config, one shared for queues. */
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> > +			       desc, PCI_IRQ_MSI);
> >  	if (!err)
> >  		return 0;
> >  	/* Is there an interrupt? If not give up. */
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index 7fef52bee455..a5062ca85f3b 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -77,7 +77,7 @@ struct virtio_pci_device {
> >  
> >  	struct virtio_pci_admin_vq admin_vq;
> >  
> > -	/* MSI-X support */
> > +	/* MSI/MSI-X support */
> >  	int msix_enabled;
> >  	int intx_enabled;
> >  	cpumask_var_t *msix_affinity_masks;
> > -- 
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
