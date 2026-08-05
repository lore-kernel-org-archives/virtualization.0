Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E739CD05
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908235; cv=none; b=Ny+3OFgYUWcMKe9q6a2Sd5Gyp3FaJMrj2kHIH2Ee4fE0AVPzyiwsmLbohwvSyEEbxXvnnzWp+vpLZR+qFdltDWMUbDxV1Zn2GaWrD3iAz7cWkT04XWxWHA2yZsq0bwmNM9ydDfMSf/2T9lct1mA7F06M8WUPo0LMstme0d7iccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908235; c=relaxed/simple;
	bh=e2f4jv+vddGdp/+tAV76YfONq6iQs8Ulaik9rath9Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QkFTmXJPaaBsGRAmMm0eyVGPI9PLxYJhHxVLQva4Ez69w+5KvhUc5j3nZaymxCx/p/xB0MF9Q11H9qsxG1Xq4pjFYsHhbHNx/Niq/Mus88+v2KrSZrPTAQ4LJ5M1k7LE5B6xXaTf8DJTzzDpQGpHPSo4jFNbT/CiZYszHlWkl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLVw5a/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLVw5a/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785908233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlGRErAW413VLAmfzqbAojxRMBz/ChRXiAFusGe8Ptk=;
	b=GLVw5a/B9GklhKMJOIIN744g5Rj9/+0Cs4rD+HTTtDqIjGy+qFF5kS7DmHB70xZfg0iEgg
	FLBTUZciPu8GiqhVxyqRBaA+fFC+9uCOuIdoxawI1mRU2Hi9wcedAAjfr8opVrWAfsuRwY
	GaPTF75Nq4P5Yq9BnPatvDgaFzdsibc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-ktQekfQwPeiJTdml0BUS0A-1; Wed, 05 Aug 2026 01:37:07 -0400
X-MC-Unique: ktQekfQwPeiJTdml0BUS0A-1
X-Mimecast-MFC-AGG-ID: ktQekfQwPeiJTdml0BUS0A_1785908226
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso302790f8f.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 22:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908226; x=1786513026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlGRErAW413VLAmfzqbAojxRMBz/ChRXiAFusGe8Ptk=;
        b=dKnpic1cxX2AXJbqd7BINQEPASCK9FgdIV12ZdSrIWAViQ7Na/AXOIXjeBvtvrSb1L
         HdlUwUOevpJdGg9Kkbp/vcdORGSmvHXaR6b4byWLVdgoThvJ/+TMdtudM4M8g+f8DZS8
         ja7K03JdtNr0cedX1Hmwo4Z+Dsr5Y1aRISLzEWskhi7U5kQBRw+dEuSGslKbpivPWIz9
         L1lFyMWoG/03Mx4QbXoYiN+lAWp+0raPupfQgkrg+M40Zlde0umuZW2+MP2cSs7Tjp8o
         rLVZI33Cz24omP2JhxJUtRFe0LDDzorKnvf17AZeTqwLWU0vFdyqbxCzK0jWEW7xgYRO
         7I7A==
X-Gm-Message-State: AOJu0YyFFlZ7Tim0rYkGGofSNehlsOFt70RtNiAH04SExPYPJUNg80Qf
	o9eVtwgcCVa64O9sGnEVbOxPycPj1xhCMZeld3nzpJDwhJCGjM5M11JCCk1kw8Xb7r2hn2b9v9P
	I5SF94ydYwvtDW2QoWJ6roBPG/Jt/t+hrGBX1W6LJar+yTF05zhjd/XKCiGIKtSd0j2wn
X-Gm-Gg: AR+sD13/rLNdsJXCNh+ANST7/gq2UExYhr6UBgNS3NFP3mYtdo9B3YuwzPg0roMo51a
	wKmkyi16W0PxlvLlRsAGmAGFF63nEPe3MHL1cNhc+CMyc+49SsWx2vxRehVH306XhhqnSAucIqb
	iJdEiyV57t8dXlLOKsQOo50zZFS53/u2tN2Vs4qiUQ92vrHpBBM8dzn03ILJ5EYdU9AkBuTVL/f
	7jKgAw0tlm4IiCup6btoAgrq6xLQuVDwaSfZ5dRurLptC171ukrbBWV2vS70gU5kJ46YkifnF9k
	9N4dVR3OU6mYBx8kRW9Gmpd5e+5iy65DJzmyvzMBde8q8S0zJut+xg1dxO/N6dgBAO9hSOR2/6b
	+CcaPo9XLKh9oXPxJx6TwlA==
X-Received: by 2002:a5d:5e08:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fec4e419emr6719580f8f.4.1785908225903;
        Tue, 04 Aug 2026 22:37:05 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fec4e419emr6719507f8f.4.1785908225411;
        Tue, 04 Aug 2026 22:37:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232e40sm6878560f8f.19.2026.08.04.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:37:04 -0700 (PDT)
Date: Wed, 5 Aug 2026 01:37:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Message-ID: <20260805013203-mutt-send-email-mst@kernel.org>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j0Zadc26cfNDxYRvQ3HGChoNHnraoe_M6tBdYVFcfjk_1785908226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 11:29:34AM +0800, Xiong Weimin wrote:
> vp_request_msix_vectors() bumps desc->pre_vectors in place to reserve
> the virtio config vector. vp_find_vqs() may call it more than once while
> retrying MSI-X with different per-vq policies, so the caller's
> irq_affinity keeps accumulating and later attempts get the wrong
> affinity layout.
> 
> Copy the descriptor to a stack local, adjust pre_vectors there, and
> pass that to pci_alloc_irq_vectors_affinity().
> 
> Fixes: ba74b6f7fcc0 ("virtio_pci: fix cpu affinity support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/virtio/virtio_pci_common.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 164f480b1..9e75fd03e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
> +	struct irq_affinity tmp_aff, *aff = NULL;


"tmp" in what sense? if we can come up with a sensible name, just
"affinity" will do.


>  	unsigned int flags = PCI_IRQ_MSIX;
>  	unsigned int i, v;
>  	int err = -ENOMEM;
> @@ -146,16 +147,19 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  					GFP_KERNEL))
>  			goto error;
>  
> -	if (!per_vq_vectors)
> -		desc = NULL;
> -
> -	if (desc) {
> +	if (per_vq_vectors && desc) {
> +		/*
> +		 * Do not mutate the caller's irq_affinity across MSI-X
> +		 * fallback retries in vp_find_vqs().
> +		 */


We do not need a comment arguing with previous version of the code.

> +		tmp_aff = *desc;
> +		tmp_aff.pre_vectors++; /* virtio config vector */
> +		aff = &tmp_aff;


just assign to desc, instead?

>  		flags |= PCI_IRQ_AFFINITY;
> -		desc->pre_vectors++; /* virtio config vector */
>  	}
>  
>  	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> -					     nvectors, flags, desc);
> +					     nvectors, flags, aff);
>  	if (err < 0)
>  		goto error;
>  	vp_dev->msix_enabled = 1;
> -- 
> 2.43.0

