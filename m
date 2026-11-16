Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817107;
	b=Ci71RaRXfo3YxUVD9KLmcHrkQJ98UksiWeiYdHm0wVqbFmiJD5cO1P8Vu8Lu1gVoTYGz
	 VWUWCzZeivNhN7L8lx+/DwmVPj7HQLVCIZmetx9z/2fC7u5DlF05pUQ5dha53WIBRNDyk
	 6jYbxqaUsCBE6JUMBcpRFS51+WV4VOeuEUD18sOabwxtwdq70wZD0BzCWmX5ep/1dnPeZ
	 xIqREzGT5FshcGheFVc7BdUnlC/ATMqLjQr2ccApO2gMqqugG0n2Nzg/mJmTZBPH9Gbgh
	 yBFsdpGBfigYG36xPKVZ/josahmznPAsEF+r16c8nWs0RZoVN1wfSDF8F4J25CzZy6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817107;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=/MsxKHT1v+wbsuT8knl2lByYutV0BQaZynJDwVTf7Q8=;
	b=lNTghhlC+Wq0JRdHPjfAYKhenmDg33VkbVzQpIwLpelzioCJKD23HxlqbdU3al8vjQeh
	 hDaQ1717I3PEO1lWJq57wzvkj9hyyCJegDn4mmToyuy9ZSKz56TuNoMPFCONXAwNB6v2W
	 Yi3RmrMu+9CeqjDfgS0b01z05aa0Y/Ou+iJpG6Jto072a7ZPjvc9JyPTg4EZRwGm/aURm
	 LpxW0fl2Qivae3GD/UfCa7rRkI2mz6/4AOt369vHDRMomWY/n+PKW8hi0Z1AzoUXCP4TI
	 ef/iILo6VLz9VKGSgSZsqnbvTy9jneM0EwyF1txrG4vpyrZqPWTb62poxpySUEGWuBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VPy25xh8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CB606A323
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 08:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4CB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VPy25xh8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MsxKHT1v+wbsuT8knl2lByYutV0BQaZynJDwVTf7Q8=;
	b=VPy25xh8KWskD9Vzf9ch16EDrB9ITsqyptN8gu+jtuZbT5z4GJYCQ/NW2Lma5zPezJglsE
	+v1daWHsc98CQbN2Z/8PA1EEUBHBX+RcBpwlqYqzyhF+qq80Yrd7pAbJ+F7lqTiI0SHZTU
	79T7G62S3Mvhs33owP+3LYNPKRLvTTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-n-0kiS9iOTaZlUEku2aC4A-1; Mon, 16 Nov 2026 03:18:24 -0500
X-MC-Unique: n-0kiS9iOTaZlUEku2aC4A-1
X-Mimecast-MFC-AGG-ID: n-0kiS9iOTaZlUEku2aC4A_1794817103
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so17313725e9.3
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 00:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817103; x=1795421903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MsxKHT1v+wbsuT8knl2lByYutV0BQaZynJDwVTf7Q8=;
        b=Val4wlgAA7bGr28A5iuojO3NCtS66bYaEiQBsrNoJPRIS+Vy7qPrr73qd1q7fn4RNJ
         eFhNc3+p8SQ8HpJbHBPZd0SNnr4IkoYg1xpoxWao2jsziQOLWyYppS/agov9DExNhwjO
         WnJUTci+hDdX+CNhCIIJOWbENWAp+qpEiVj/jxkNP219C95uKnzyUQ1uS9PZg2OYitTn
         fwlB2/sn60rXCXro8t8hIxh0yg/0WBagUxQHW33oGGdkFL9ynFYw+wY3g33indooIFur
         UOVPulXzxTwIRVixAEGqbKwDFrPU9V7WUKHK96h7hEQbNBE8z5VDjVCuHvFpMBR/HZgY
         6TSQ==
X-Forwarded-Encrypted: i=1; AL+hErEc1GiG1c6dq42JMXYrq+gJ3DcPlrt3KEqo3x7sEiL2zJUfOAwb8hj5T0ECmBwtwqAK8xnoICVxzor7FpBJ4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z82mD+cLTLR0SexJq30d01Okvf9b3E5KFKLuIuyoIriWzPlQB8Q
	0eNPMeSLM4ajgowY3xYdMhtRIDbHXbZswx254iAyMwrorn5pcgJo1mhQzO2QSGG5R2x9rbthZ2p
	NPePZBL9B4eLIk9VzTa6LxI+YqrB0/qJEjG7n6Xbyy3IcjfMw/jAAgIRKZgi1fjwKt+5K
X-Gm-Gg: AYBFou1BZP+5XMa0WCJCxQOVQSMpi+CAPgSyxeLIzMMe4txwqLWD2CvPb0hieMllvPo
	DhKaUsjg9bpP5FqgLY6YwICagS+MJu/RQfvLbLsVWezfKrU8uw8wanfCu8GncbybuGE40rwisLr
	JqrFNUknverWfroLPt65BowA64J+JFzO9paIj5eUz47xWKus8PiNwcKTJUAkBhOvE5YMGZExmzq
	O8LFQhezRtAdlk6AsuLqcLrtEMBKXr6l5+B28F4p0r4DZJIeHHLMpGeAFZgzqZksYl5pTRvpqzP
	otGZHJdMnv7ONFdm0Z8GX9Vjnb68c2V7Go67/8vCQPGRzrY0vVkNTLmeHkNTAjP3dsno0D4fiwo
	uT4ZFHX/8gU0+o3AYMmE0s0hvlj7PLJCFu1K7SsNXsg==
X-Received: by 2002:a05:600c:3ba1:b0:4bb:6847:792d with SMTP id 5b1f17b1804b1-4bb68477c2dmr108079575e9.20.1794817102831;
        Mon, 16 Nov 2026 00:18:22 -0800 (PST)
X-Received: by 2002:a05:600c:3ba1:b0:4bb:6847:792d with SMTP id 5b1f17b1804b1-4bb68477c2dmr108079055e9.20.1794817102280;
        Mon, 16 Nov 2026 00:18:22 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb64ec7b58sm207200255e9.5.2026.11.16.00.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:18:21 -0800 (PST)
Date: Mon, 16 Nov 2026 03:18:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Wait for device reset to complete
Message-ID: <20261116031658-mutt-send-email-mst@kernel.org>
References: <20261116030152.1704527-2-oss.patchbox@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261116030152.1704527-2-oss.patchbox@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6EHPV4lO2htUPqzRxaaZ2N3aNnOy3TGt2jELItdlHxk_1794817103
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 15, 2026 at 10:01:44PM -0500, Yuho Choi wrote:
> vp_vdpa_reset() writes 0 to device_status and returns success right
> away. The virtio specification requires the driver to wait until a read
> of device_status returns 0 before reinitializing the device, and
> virtio_pci_modern's vp_reset() does exactly that: the read-back flushes
> the posted status write and any in-flight device writes, including
> MSI-X messages.
> 
> Without it, vhost-vdpa (or virtio-vdpa) can go on to tear down the
> IOTLB/IOMMU mappings or reprogram the queues while the device has not
> yet finished its reset, and may still be DMAing to the old virtqueue
> addresses. The MSI-X vectors are also freed while an interrupt from
> the old configuration may still be in flight.
> 
> Poll device_status after writing 0, in the same way as vp_reset(),
> before freeing the IRQs and returning.
> 
> Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> v2:
> - Drop Cc: stable, as this has not been reproduced.
> - Rebased on current mainline. No code change.
> 
> v1: https://lore.kernel.org/r/20260926211507.1330179-1-oss.patchbox@gmail.com
> 
> Like vp_reset(), the new loop has no bound, so a surprise-removed
> device that reads back all ones would keep it spinning (the Sashiko
> review of v1 pointed this out). I kept it the same as vp_reset()
> rather than handling that case only here.
> 
> Compile-tested only (x86_64 defconfig + VP_VDPA, W=1).

If you can't bother testing, why should I bother merging?

>  drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 646efd9384fb..eba82ff253ea 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -8,6 +8,7 @@
>   * Based on virtio_pci_modern.c.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -236,6 +237,9 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>  	u8 s = vp_vdpa_get_status(vdpa);
>  
>  	vp_modern_set_status(mdev, 0);
> +	/* Wait for the reset to complete */
> +	while (vp_modern_get_status(mdev))
> +		fsleep(1000);
>  
>  	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>  		vp_vdpa_free_irq(vp_vdpa);
> 
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
> -- 
> 2.43.0

