Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7029CE8
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563384; cv=none; b=syXz4JapBZQUhLhhnbpXkusn1YM3yVDqGEjEe5bJNiw37OwA8ZkeDOqIDj8UVCYjqdIgBUmM7rDjRsl3MfalpDtQL0dccMCF8oZahbW1FTyGolhXaKAsP5TRTgHd8jmFiLBWkcU7HZaLxq61vu4nfTdoCTUEnWYCqiv/ldvZDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563384; c=relaxed/simple;
	bh=iSQnLApd2E7/mWWPFFDprgT6eyI6Xo4+BLRHeBY2BEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eV7FNUV8JqE6NlVLrHOypnfhUl3sdMSGwPuDdvxZlyWR13vzDV2XYljKrmMXh3tSbIPVTjDKcof16MzrrYs13UWOypvdBzKtNKcwOZ2cak/qtTnxn+Hm1lC+DbMUGF0apu+kVM7s/qlRGe2+ltSOuxWDBAN2bDZC4E+TSEzDbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WByTyOMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WByTyOMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712563382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6E8GItKx7EN132AXTarzFdSpYHF7NOPdh1F9V4NL34=;
	b=WByTyOMB/Deey0oVe1bkhfK2R1cIuDq61Y8L3e9aioJmFfSXqJxOuXrXCQ09BvssV/82QJ
	3+bbV7tX2demzZUsBoMM0oQTedY4Sh3I6A5nnrei3ELcoPL1u4LvaoEv7t4KIwyc4q8lQF
	BGcGgTZ9XiTt4oCVfnxLvK/xXlxokYQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-pU_S3wz3MOKvo_XlKPu-Pw-1; Mon, 08 Apr 2024 04:03:00 -0400
X-MC-Unique: pU_S3wz3MOKvo_XlKPu-Pw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d86adb107eso17264371fa.3
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 01:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563379; x=1713168179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6E8GItKx7EN132AXTarzFdSpYHF7NOPdh1F9V4NL34=;
        b=DxWCFgQY6U2yCWjni4ocoYWoq3MsLkh5DMtCRMeBsr3z3vCSACfIv8cDRG/Mc+rOBm
         8Xyf6Zu5qZFKnlU8253Vam+u8c8qsenf7hsDdvrew8YxsN5Re7nVc0Sbg1IYaxZhUynJ
         RpBHmDtxiIuTY4zkaUr6ioomPtR+UpZFpTtWooQq1aThy9JHJFwwka//xkCGRwse6G1x
         s14blIrWnn+gIdK9+T85mW2wrFpSEzuN9Yi8kbfVu9pRxwxkmS+iQYJ3wZC6wfggXTxS
         BE0QH6xMY7MLSOOPvMc/4SQSJZL7txyiFgrg3ne+tHP8w4hISgRCcwVlG37gkOz6ZyLv
         Gjpw==
X-Forwarded-Encrypted: i=1; AJvYcCVltVAbIry+VOrsGWWJ5WGK0ZYQ3zin3w9rk0RGgE3YAKYI9gGFDQ1qzpYnG5BQWG6VwNN8PJUqhAB2Z5sBKURmgbPxF4pMUakkRdCBei0=
X-Gm-Message-State: AOJu0Yz32MUMfuMo6VOGHAKRcdB/WfPh122lIDVx/cFGS0uUV6Fd0eC7
	A/wgIPAh9DQeRO7YZ0TFEgptw25OG2sJ7iBqRtH7UKlGbgpQCSMKl+/cWA0ePdXfChEl4hvi9VK
	LwW/wQOe3GuAaAzba0kutIy2GXU0T451ZjvEFVKZ2uZpMkYqanu877wMnEPHXDq31J1TUuDSy
X-Received: by 2002:a05:651c:b8c:b0:2d6:f96c:d84d with SMTP id bg12-20020a05651c0b8c00b002d6f96cd84dmr4740160ljb.16.1712563378667;
        Mon, 08 Apr 2024 01:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVOm56V+ijcwMGNqnuruxXGa0aHHJooBtndGYpq5tnW2yEqsqu6pSDMjmDG5tl0KD6S7bkBw==
X-Received: by 2002:a05:651c:b8c:b0:2d6:f96c:d84d with SMTP id bg12-20020a05651c0b8c00b002d6f96cd84dmr4740153ljb.16.1712563378109;
        Mon, 08 Apr 2024 01:02:58 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b004146e58cc35sm16061938wmo.46.2024.04.08.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:02:57 -0700 (PDT)
Date: Mon, 8 Apr 2024 04:02:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "gavin.liu" <gavin.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: Re: [PATCH v2] vp_vdpa: fix the method of calculating vectors
Message-ID: <20240408035346-mutt-send-email-mst@kernel.org>
References: <20240318130008.1928-1-gavin.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240318130008.1928-1-gavin.liu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 09:00:08PM +0800, gavin.liu wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware MSI or MSI-X resources as well as system
> IRQ resources. Referencing the per_vq_vectors mode in the
> vp_find_vqs_msix function, calculate the required number
> of vectors based on whether the callback is set.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Overall, the patch makes sense. But you need to clean it up.
Also, given previous versions were broken,
pls document which configurations you tested, and how.

> ---
> 
> V1 -> V2: fix when allocating IRQs, scan all queues.
> V1: https://lore.kernel.org/all/20240318030121.1873-1-gavin.liu@jaguarmicro.com/
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 281287fae89f..87329d4358ce 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,8 +160,15 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	struct pci_dev *pdev = mdev->pci_dev;
>  	int i, ret, irq;
>  	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int allocated_vectors, vectors = 0;
> +	u16 msix_vec;

The names are messed up.
What we allocate should be called allocated_vectors.
So rename vectors -> allocated_vectors.
The currect vector used for each vq can be called e.g. msix_vec.
And it is pointless to make it u16 here IMHO - just int will do.

>  
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback != NULL)


I don't like != NULL style - just
	if (vp_vdpa->vring[i].cb.callback)
will do.

> +			vectors++;
> +	}
> +	/*By default, config interrupts request a single vector*/

bad coding style
and what does "by default" mean here?

> +	vectors = vectors + 1;
>  	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>  	if (ret != vectors) {
>  		dev_err(&pdev->dev,
> @@ -169,13 +176,17 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  			vectors, ret);
>  		return ret;
>  	}
> -

why?

>  	vp_vdpa->vectors = vectors;
>  
>  	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback == NULL)
> +			continue;
> +		else
> +			msix_vec = allocated_vectors++;

So just put replace allocated_vectors with msix_vec
incrementing it at the end of the loop,
and you will not need the allocated_vectors variable.




> +

Same here.
	if (!vp_vdpa->vring[i].cb.callback)

Also there's no need for else after continue.


>  		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>  			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -		irq = pci_irq_vector(pdev, i);
> +		irq = pci_irq_vector(pdev, msix_vec);
>  		ret = devm_request_irq(&pdev->dev, irq,
>  				       vp_vdpa_vq_handler,
>  				       0, vp_vdpa->vring[i].msix_name,
> @@ -185,13 +196,14 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  				"vp_vdpa: fail to request irq for vq %d\n", i);
>  			goto err;
>  		}
> -		vp_modern_queue_vector(mdev, i, i);
> +		vp_modern_queue_vector(mdev, i, msix_vec);
>  		vp_vdpa->vring[i].irq = irq;
>  	}
>  
> +	msix_vec = allocated_vectors;
>  	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
>  		 pci_name(pdev));
> -	irq = pci_irq_vector(pdev, queues);
> +	irq = pci_irq_vector(pdev, msix_vec);
>  	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>  			       vp_vdpa->msix_name, vp_vdpa);
>  	if (ret) {
> @@ -199,7 +211,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  			"vp_vdpa: fail to request irq for vq %d\n", i);
>  			goto err;
>  	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>  	vp_vdpa->config_irq = irq;
>  
>  	return 0;
> -- 
> 2.43.0

