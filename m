Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDF390C8A
	for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327255; cv=none; b=SdkeHIoEm/A9783PlJaKkV979kzq6LiOKHarmwnMAOrvY8GcrELGkhUyjwIpRJNTIJZvJb34zo9Y3lXm1oaA4EImM6xgm9bhBKsKr9swbQpMb8ay/gjX5Y1h6qRmr55Cn8xzbTYXa5+VEz+QaMfIsKwHwpfrO4l7/3Xi28FTbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327255; c=relaxed/simple;
	bh=NCC71HkSDsN0dl/3w6XnHsANF7SLTH9FseDTh2/4ypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SRwHPE0T7mFpNA4r1KkiuVmRbg2YjsMixYTWCfPYXAdxRFPLgm0fuA5D+C39r9+plXVEvLC5OmPG1TukZ5tzSW/eOOzAnf9T06/JL/y+Zr8urD31HPG5TpyiKLjKGxU4ABsCNiNZChCsV9MGUujpHHnKv2hZzGUDXl4LaVIyFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7X2uUc4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7X2uUc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789327252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6o7bQLZfZokKH6jgKHJRg9U19DeisY5amWr6PH9NZU4=;
	b=B7X2uUc4fFF/9UlB6zwcUkvnzEFMHXZs0gl1t4BQPXcUaHDsu2K24iIqvxLj7GOcrV4rsS
	rYMJun6p7CvjkiLRjjvQVDY/1LHo+TGueeiKaloBctZ1ShCM/DQTH9sUlsUBSNlMrFH4zs
	JBsTvIOHkStxFieSfVkcedfyJ0Yeos4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-7HEjPIQ0MOSXq9hDHwhNig-1; Sun, 13 Sep 2026 15:20:50 -0400
X-MC-Unique: 7HEjPIQ0MOSXq9hDHwhNig-1
X-Mimecast-MFC-AGG-ID: 7HEjPIQ0MOSXq9hDHwhNig_1789327249
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4870144a179so90685f8f.1
        for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 12:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327249; x=1789932049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6o7bQLZfZokKH6jgKHJRg9U19DeisY5amWr6PH9NZU4=;
        b=fvidDk8nN3ddQrYRknfcUOiYzRgMyHNJsl52FZAyGQqeQKjy9bwF5xogX3OFwpPljm
         kfXoK5O97KiM6ymx8b98Ez4PmcJfBpKLwgtCaeu9qeI2oNC8MGbRXCSLpSqpCFjwXSgj
         A8w6QK/NSyf7IP93G97tsGRBiwpxpmyr8bxwuDkOD+mmqlMOPW/mFryMRYLbWHp4MzYJ
         Rc9Q/TUnGtJ1i5gUlRO3QXG+R1/zRhMb06G8u3UoiNFe8+hhRB+umg0AXqE7ReYGehYL
         p4QWlep4S0tNtNw+BtYTY1cp9IlIWbOyuzqyZKzKxjxBLo4wrbIvnNkD8IUwwRBDS/wJ
         ez0Q==
X-Forwarded-Encrypted: i=1; AKwUvBysQIb5A9Jr8y+/qR3gy8buUFsL51vmTANstOPK2W4aKim6ueKpwgUPUz0j7tbjjGpETPacH3DgStrLgZkKvA==@lists.linux.dev
X-Gm-Message-State: AFuF++mJqLcXk1ZeKrZRZ8ORv7hsMw/C+k8ZxOhGy3z0V2+wtrbwXTV3
	CxUkOdwd9oy5dAgLjMZ75NhEReahbpjdh2yizcG3xP63IX7v8cTw+g9KpyMAgJu5QciWh4EKs5a
	FguaPKb1RP1QB21Z2eXd+DtPhH7UO6haC5UKrQXfczOHTHjCQ0N/0kaIOujgcH+36BGNwBhk16m
	Zh
X-Gm-Gg: AYBFou3mHlnrZJZOUta+VVZ8IG0/s6YSjtUsVTrjOYBFqDC2cJ1VbnQRCpFq4USuOUY
	bYDejqC73tseKi5qwzP1ItOUWrCrdrPVnFGwBG5LnUxa5kI7biiGvT8HUy7zbln3dj2Uztdbt+t
	bwNCzhKgzJVt1u9X+x5hSQNSM3XRj8o7Gk96gxxFUQX4G5JlC71UJyQ1MaAHLcOwgijYNIaDgvR
	gCyiKUEFJQVwwIFea8kxJyPY8C2KWe1cmeRIxQ3UrVtXD6HLYffUlPAho0yZErOsicPk4slS+rz
	F+H9K1OYH+GkBOpsI37CjTLntokXujghnhuRyRYGvs+jD+t67X0ljK3Izh8jBeLWNx3DvS5RqqQ
	DQa3frk7bJrv8HaxNht98WwA=
X-Received: by 2002:a5d:4e8c:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-486eb329f46mr11719064f8f.33.1789327248791;
        Sun, 13 Sep 2026 12:20:48 -0700 (PDT)
X-Received: by 2002:a5d:4e8c:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-486eb329f46mr11719037f8f.33.1789327248286;
        Sun, 13 Sep 2026 12:20:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bd1esm21015133f8f.31.2026.09.13.12.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:20:47 -0700 (PDT)
Date: Sun, 13 Sep 2026 15:20:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	Peng Hao <flyingingpeng@tencent.com>
Subject: Re: [PATCH] virtio_pci_modern: fall back to 64 bits features for
 devices without an extended features space
Message-ID: <20260913152022-mutt-send-email-mst@kernel.org>
References: <20260911081133.16434-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260911081133.16434-1-flyingpeng@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _DGq5eqUQgNDELv0smRO6Tt3dDmXoctaClgPWgfGKTI_1789327249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2026 at 04:11:33PM +0800, Peng Hao wrote:
> From: Peng Hao <flyingingpeng@tencent.com>
> 
> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features") the modern virtio-pci driver unconditionally
> accesses the whole 128 bits features space, i.e. it drives
> device_feature_select / guest_feature_select with the values 0..3.
> 
> Devices predating the extended features space only implement the
> legacy 64 bits one, and what they report for the selectors above it is
> not a valid features space.  Negotiating it makes the driver and the
> device end up with different features sets: on a smart NIC exposing a
> virtio_net device the link comes up but carries no traffic, while the
> same device works with a kernel that only accesses the low 64 bits.
> 
> Reading the features space has no side effect, so keep reading all of
> it and use the extended part to tell whether the device implements it:
> report the legacy 64 bits only when the extended words read back as
> all-ones or as an alias of the low words, and latch the device down for
> good.  As the features negotiation ANDs the device and driver features,
> no feature above bit 63 can be negotiated afterwards.
> 
> Writing a selector the device does not implement cannot be relied upon
> the same way, so never drive one above the highest word that actually
> carries a bit.  The reset preceding the features negotiation zeroes the
> device side features, hence the words left unwritten stay cleared.
> 
> Also dump the raw device_feature dwords, and add a max_features_u64s
> module parameter to force the legacy 64 bits space on devices whose
> quirk the detection does not catch.
> 
> Conforming devices are unaffected: their extended words are neither
> all-ones nor an alias of the low ones, so the detection does not
> trigger.
> 
> Signed-off-by: Peng Hao <flyingingpeng@tencent.com>


Also can you dump the pci header of the device please?

> ---
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c353463..cfb10c9f32dd 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -5,6 +5,21 @@
>  #include <linux/pci.h>
>  #include <linux/delay.h>
>  
> +static int max_features_u64s = -1;
> +module_param(max_features_u64s, int, 0444);
> +MODULE_PARM_DESC(max_features_u64s,
> +		 "Max number of 64 bit words of the virtio features space to access (1 = legacy 64 bits only, -1 = auto-detect)");
> +
> +static u8 vp_modern_features_u64s(const struct virtio_pci_modern_device *mdev)
> +{
> +	u8 u64s = mdev->features_u64s ?: VIRTIO_FEATURES_U64S;
> +
> +	if (max_features_u64s > 0 && u64s > max_features_u64s)
> +		u64s = max_features_u64s;
> +
> +	return u64s;
> +}
> +
>  /*
>   * vp_modern_map_capability - map a part of virtio pci capability
>   * @mdev: the modern virtio-pci device
> @@ -230,6 +245,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  
>  	check_offsets();
>  
> +	mdev->features_u64s = VIRTIO_FEATURES_U64S;
> +
>  	if (mdev->device_id_check) {
>  		devid = mdev->device_id_check(pci_dev);
>  		if (devid < 0)
> @@ -398,15 +415,36 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
>  				     u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u32 raw[VIRTIO_FEATURES_BITS / 32];
> +	u8 u64s = vp_modern_features_u64s(mdev);
>  	int i;
>  
> -	virtio_features_zero(features);
>  	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> -		u64 cur;
> -
>  		vp_iowrite32(i, &cfg->device_feature_select);
> -		cur = vp_ioread32(&cfg->device_feature);
> -		features[i >> 1] |= cur << (32 * (i & 1));
> +		raw[i] = vp_ioread32(&cfg->device_feature);
> +	}
> +
> +	dev_info(&mdev->pci_dev->dev,
> +		 "virtio_pci: device_feature[0..3] = 0x%08x 0x%08x 0x%08x 0x%08x\n",
> +		 raw[0], raw[1], raw[2], raw[3]);
> +
> +	virtio_features_zero(features);
> +	for (i = 0; i < u64s * 2; i++)
> +		features[i >> 1] |= (u64)raw[i] << (32 * (i & 1));
> +
> +	for (i = 1; i < u64s; i++) {
> +		int j;
> +
> +		if (features[i] != U64_MAX &&
> +		    !(features[0] && features[i] == features[0]))
> +			continue;
> +
> +		dev_info(&mdev->pci_dev->dev,
> +			 "virtio_pci: no extended features space, using 64 bits features only\n");
> +		mdev->features_u64s = 1;
> +		for (j = 1; j < VIRTIO_FEATURES_U64S; j++)
> +			features[j] = 0;
> +		break;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_extended_features);
> @@ -424,10 +462,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
>  				       u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u8 u64s = vp_modern_features_u64s(mdev);
>  	int i;
>  
>  	virtio_features_zero(features);
> -	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> +	for (i = 0; i < u64s * 2; i++) {
>  		u64 cur;
>  
>  		vp_iowrite32(i, &cfg->guest_feature_select);
> @@ -446,9 +485,19 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
>  				     const u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u8 u64s = vp_modern_features_u64s(mdev);
>  	int i;
>  
> -	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> +	/*
> +	 * Never drive a selector the device may not implement: stop at the
> +	 * highest word that carries a bit.  The device side features are
> +	 * zeroed by the reset that precedes the features negotiation, so the
> +	 * words left unwritten keep the value the driver wants for them.
> +	 */
> +	while (u64s > 1 && !features[u64s - 1])
> +		u64s--;
> +
> +	for (i = 0; i < u64s * 2; i++) {
>  		u32 cur = features[i >> 1] >> (32 * (i & 1));
>  
>  		vp_iowrite32(i, &cfg->guest_feature_select);
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 9a3f2fc53bd6..7dc76afa671e 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -27,6 +27,9 @@
>   *		    Returns the found device id or ERRNO
>   * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
>   *		    for vendor devices with DMA space address limitations
> + * @features_u64s:  Number of 64 bit words of the features space that can be
> + *		    accessed on this device; 1 for devices not implementing
> + *		    the extended (128 bits) features space
>   */
>  struct virtio_pci_modern_device {
>  	struct pci_dev *pci_dev;
> @@ -49,6 +52,7 @@ struct virtio_pci_modern_device {
>  
>  	int (*device_id_check)(struct pci_dev *pdev);
>  	u64 dma_mask;
> +	u8 features_u64s;
>  };
>  
>  /*
> -- 
> 2.43.0

