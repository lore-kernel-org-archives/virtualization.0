Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3EE15350D
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607505; cv=none; b=YwOfoEbL6kK3oGffR65JyBD9ve3VZg1KuQmB7ndfRQMHXBvJDYOWq774XORerkBPbg+PNRDJOxbUxrv931nEYwrY0LDjdpEt/h3o+V9ruXjvh/m3nJlLgAbRHz5AV8koLs05qBWrY1QMWhjO/iJn8aKwrsuP7urAONk38sXvAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607505; c=relaxed/simple;
	bh=h65OdvpLKk/fGTrxs6DwMDQuM4CLeMzeeaCkAuYoPIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p2nMkkQ19ElJbYcmAgu96gdvbaOJZ/yJMtt9vjZKwsecw7fju5eQCURYmAeDEDW/BGC2fGhwbd5GSWDLG3J5O9DwMvtfGOyMXNqWoj6v6WjQ+GrxFhbQC5cIYjd9xHYbWmAfiCCe0wWzYPjYhepiQN+mT4eePK/chnreR/+T/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+p2lWlU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+p2lWlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715607502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sUWkAGSC2Q6cDBGDOzw2WbvYaI+hQ2R2mWiaKUzv4Y=;
	b=G+p2lWlUeTRsT6mtYex5tRN3Xud+/BftVfxIwfCJsOUXDzvKQGt1XILbE/SRZTttsCZ6xt
	njlrnxdl/g2wGtpsWbMgHthbY+cUOdS/ccdRLLMWtkpat4rfBs1p/FKSz33jj1kiU3YW6R
	tBgB2stosCrbysaT9hApq0xigoyAvd4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-ta4KelZUOqqFQeaaJuJnqw-1; Mon, 13 May 2024 09:38:21 -0400
X-MC-Unique: ta4KelZUOqqFQeaaJuJnqw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e32c301353so31760981fa.2
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607500; x=1716212300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sUWkAGSC2Q6cDBGDOzw2WbvYaI+hQ2R2mWiaKUzv4Y=;
        b=tjGRzkmGSOhoU+S954t2xVfWu/Z2fiuPpLJLa9URZo1m+QBmAlqYVrQEKDpN8mvWi6
         q0KgSDMjWkvCssSiXY+eRImf2hHtAYKnTR1ExgKLbH8/aDO8QSIApHkL2zg4eTe3V8G4
         LFPyxzkajKH07apnzKZKc1uRfMEYaxvu4MDMa7BC7l7DNacsCXkX0xcDPqBtP5wrkrkP
         8CnZfTIGlcr5cYJA/7S6MZNnh7YXArWGJI/2yaKRFXIZeL9jfNF+HX4QviZTUoj+WLTo
         Zlk42tnOcwwn+VYGdhwys5ZYVfLEY2hp/JXOAXU/570hP6+pN1kSJM3w/O6uMH5Gq12w
         ud8A==
X-Forwarded-Encrypted: i=1; AJvYcCWUhjApjaujkF1iZOgyvjcVMW6fvZMziLDApNVvzTf6177VfsF0UyUurPtTzZ8KlKFf0CraviP4e4zEKzhWBuI9LBrznt8oP2SbUoQZ9jY=
X-Gm-Message-State: AOJu0Ywo9skZ1/9fzcNQpq8uhUcT92yYqNbp2yNGH3dUwd8d6smBVEyv
	s6Sr61ypFKTRkKl0x0Kuy9FvwTXoQppRXeuONYTUishfe5azetX3qZLj9Mj+/ZR/+BOtC91hsbx
	GpLNvI8A7cte9xc1qbwms4B/zNaXwF6eRh5G1ETaL+a+/QRnJhyNlJnzPa1xWD2ygTVZ4yR8f
X-Received: by 2002:a05:6512:3b86:b0:51f:3f6c:7466 with SMTP id 2adb3069b0e04-5220fe79356mr8347690e87.48.1715607499515;
        Mon, 13 May 2024 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENVyXhGWmI3SJ2hEESDlR3sDBSYWN/VvQPQJchcUrFFXVIXapi8GvOiA7m15u641R2Q0kCUg==
X-Received: by 2002:a05:6512:3b86:b0:51f:3f6c:7466 with SMTP id 2adb3069b0e04-5220fe79356mr8347647e87.48.1715607498897;
        Mon, 13 May 2024 06:38:18 -0700 (PDT)
Received: from redhat.com ([31.187.78.17])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad6aasm1786968e87.46.2024.05.13.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:18 -0700 (PDT)
Date: Mon, 13 May 2024 09:38:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Message-ID: <20240513093506-mutt-send-email-mst@kernel.org>
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240513212707.9894-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2024 at 05:27:07AM +0800, Zhu Lingshan wrote:
> Most of ifcvf code work for standard virtio pci,
> except for bar4. This commit makes bar4 only effective
> for Intel products, thereby turning ifcvf into
> a standard virtio pci driver.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/Kconfig            |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_base.c | 17 ++++++++++++-----
>  drivers/vdpa/ifcvf/ifcvf_main.c |  5 ++++-
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 656c1cb541de..dbf09f35bcef 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -44,7 +44,7 @@ config VDPA_USER
>  	  in a userspace program.
>  
>  config IFCVF
> -	tristate "Intel IFC VF vDPA driver"
> +	tristate "Intel IFC VF and standard virtio-pci vDPA driver"
>  	depends on PCI_MSI
>  	help
>  	  This kernel module can drive Intel IFC VF NIC to offload
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 472daa588a9d..47bc9b11c678 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -178,7 +178,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
>  		hw->vring[i].irq = -EINVAL;
>  	}
>  
> -	hw->lm_cfg = hw->base[IFCVF_LM_BAR];
> +	if (hw->pdev->subsystem_vendor == PCI_VENDOR_ID_INTEL)
> +		hw->lm_cfg = hw->base[IFCVF_LM_BAR];
>  
>  	IFCVF_DBG(pdev,
>  		  "PCI capability mapping: common cfg: %p, notify base: %p\n, isr cfg: %p, device cfg: %p, multiplier: %u\n",
> @@ -330,18 +331,24 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>  	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>  	u16 last_avail_idx;
>  
> -	last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
> +	if (lm_cfg) {
> +		last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
> +		return last_avail_idx;
> +	}
>  
> -	return last_avail_idx;
> +	return -EOPNOTSUPP;
>  }
>  
>  int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
>  {
>  	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>  
> -	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
> +	if (lm_cfg) {
> +		vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
> +		return 0;
> +	}
>  
> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>  
>  void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num)
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 80d0a0460885..e89fd4d96ff1 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Intel IFC VF NIC driver for virtio dataplane offloading
> + * This driver also drives standard virtio-pci hardwares
>   *
>   * Copyright (C) 2020 Intel Corporation.
>   *
> @@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>  			 VIRTIO_TRANS_ID_BLOCK,
>  			 PCI_VENDOR_ID_INTEL,
>  			 VIRTIO_ID_BLOCK) },
> -
> +	/* standard virtio pci devices */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
> +		     PCI_ANY_ID) },
>  	{ 0 },
>  };
>  MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);

Will make it conflict with the normal virtio driver, won't it?

What are you trying to achieve here?



> -- 
> 2.43.0

