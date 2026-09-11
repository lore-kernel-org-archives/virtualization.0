Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840E45D90B
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115341; cv=none; b=ROUlpZEOdwIHkXbdNByybtsFYNAOYT0u9c+ckpyuHyRnEVm1pzTZ1HkSttM2Dv5D64g+6r3lxHOxaoeQ7QPvJfbr9I+guhf4El5RM7a6HlTiwinqgaG5HTBsa9oYNZkD7vPhUsz3wNodzqfRYc6nk14mQo17RS9pDyxcx7zrNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115341; c=relaxed/simple;
	bh=Pu4S5l41insNr8QgUfy9ULCojMzy0MiSQy41d7XP7eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hwJOWECKO6nEtQsOKziOaDdeNbcNVuVw56HeVsI9dnl3xYh6O1eCfJAyKfqN4MB7ZyG7ts9SMMjdubVQHUaHJaW375Ds3j8Ch/Y1IqiV+F8efn1p0slvJ9RChoh9Ljxj7c4LNafT4URRosOrqLbsWi97bcqp9SuvTU65OjxlQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fntbOtCR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fntbOtCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789115338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbNS9M9TjAXtdSfLFxEY4oQmReqXLtUfbSYm45GdAjU=;
	b=fntbOtCRXyPQEo25FBPcvAlR1fImzaXFxC9lD0+/kSlXPuvKmJfaY1yfNG9M3fW/Eysill
	YTawvTWaJLrb8tyryTeHkI7MaJhzJuF4N6GUFBwVMJOzTSR5I6lnbZsgoqp34AdabzkSyo
	il8gULvcvHAe0nNJdNL2pVjgJjSXhLs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-l-O9SNnXMLiSelHxkuiHSA-1; Fri, 11 Sep 2026 04:28:57 -0400
X-MC-Unique: l-O9SNnXMLiSelHxkuiHSA-1
X-Mimecast-MFC-AGG-ID: l-O9SNnXMLiSelHxkuiHSA_1789115336
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486f197e5c2so168755f8f.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 01:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789115336; x=1789720136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbNS9M9TjAXtdSfLFxEY4oQmReqXLtUfbSYm45GdAjU=;
        b=GShoL1V2R86ncHbp1H0wkfvYGtxqNtjD5fEHs/kvrO/iMmNejm05fDjlYs2GsYjw55
         9Bsrsq/bUOoX+u9R39RlUEFE5dzsbyw/CxN5GPoEMBnulG88oQBnUoMErti/Q7BWe+a+
         le+E9TjGhhX3DRLY2qwmOFYhjVfKnofD9JBAE3+xNIpkGCSE2agnu4Yxh0R5EOXuJ1fl
         cDDTyBEy6i6nWb17INLzgfhwirJfcRapDs/mnex76ms0WsLJXDaCei/RRyAzx1ILiCBM
         xSHkJ7dHyndZBl++D8WxBiSMkbYpXrx8NRCZGMprCzrEt2MrxRBL0WV/wuI1Y/9c2hAH
         lErg==
X-Forwarded-Encrypted: i=1; AKwUvBzlg8Hg1cvG169+65HLMxB7jF5QvO2gvCxRnTJ51rfJVe6lUSORiwh2YyejTOxz41oruLk/41vlXd78/2BrAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kshvL2uyejJVeIX4aA/eRJqWIpzO/7LgfT8m00pEtfZ+3QTNCt
	pqzqi0atFHRxhuvR8SvVZdVGWjF6pVXH8CBt5COt0dmbZO+ZMdUD20NQ3FYXrorRVqI/ettIU/s
	eGT1kh3tI+7wwKijprwv+Epz2VTLnt+zs/XSOkA4ujx0MqBGqQFZB5p+QnhDKasCk45W6
X-Gm-Gg: AYBFou0eyc94axlw3gKBC/3FsTGxRsNCsFCt/jV35Jg9rfmljmKP4UMdMhMt2PumJWl
	RyuKbKNQnrKeuC9dU9yGUQjqYqAJm2qcxJ0VGAiORsbcZoKj4Z5RziEhEprOwXk6OPZU22oq0Qh
	jv0B8fHI6uj9rUMh2C6b02xlch4dgigDWKoF9GMzjwU01ndhezQXB7gXnc5RiI4K14wqx3g5PN5
	mCAWH38FgRtfA4LayMo5z4fSgyQDzqeTZlIFz3JBSeYYSoUpbx/mqO33frhPGQ3xF6sZDBXoOvE
	IdwQnupl1Jm+wIGWpbVPOpbUaUaRI36YmJUJmg/cJbcXdxklKpUAzr/sAEUWa2DR25gXzzzh2pO
	FpZ6+LMdJMWUSUiMgNmK64YU=
X-Received: by 2002:a05:6000:4545:b0:485:ac96:7251 with SMTP id ffacd0b85a97d-486eb33d733mr4553272f8f.21.1789115335880;
        Fri, 11 Sep 2026 01:28:55 -0700 (PDT)
X-Received: by 2002:a05:6000:4545:b0:485:ac96:7251 with SMTP id ffacd0b85a97d-486eb33d733mr4553191f8f.21.1789115335332;
        Fri, 11 Sep 2026 01:28:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm4392983f8f.19.2026.09.11.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:28:54 -0700 (PDT)
Date: Fri, 11 Sep 2026 04:28:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	Peng Hao <flyingingpeng@tencent.com>
Subject: Re: [PATCH] virtio_pci_modern: fall back to 64 bits features for
 devices without an extended features space
Message-ID: <20260911041337-mutt-send-email-mst@kernel.org>
References: <20260911081133.16434-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260911081133.16434-1-flyingpeng@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IVY7YvaUoL1wjSTv47U3sXzutdozFTuDSJuGVdeG59k_1789115336
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
> not a valid features space.


That's a device bug then? The spec says:

\begin{description}
\item[\field{device_feature_select}]
        The driver uses this to select which feature bits \field{device_feature} shows.
        Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits 32 to 63, etc.

that "etc" means any value is valid)

There's no "extended features space". It's a quick hack we did
in the virtio code to avoid changing all drivers, but the spec
treats all features uniformly.


So you have a device that ignores a feature selector? Or some specific
bits from it?

>  Negotiating it makes the driver and the
> device end up with different features sets: on a smart NIC exposing a
> virtio_net device the link comes up but carries no traffic, while the
> same device works with a kernel that only accesses the low 64 bits.
> 
> Reading the features space has no side effect, so keep reading all of
> it and use the extended part to tell whether the device implements it:
> report the legacy 64 bits only when the extended words read back as
> all-ones or as an alias of the low words, and latch the device down for
> good.

So using all bits is illegal, and so is anything that will by luck
mirror low bits?

This is really VIRTIO_F_BAD_FEATURE mess replaying itself.

Really quite a hack :( 



>  As the features negotiation ANDs the device and driver features,
> no feature above bit 63 can be negotiated afterwards.
> 
> Writing a selector the device does not implement cannot be relied upon
> the same way, so never drive one above the highest word that actually
> carries a bit.

This part is ok.

>  The reset preceding the features negotiation zeroes the
> device side features, hence the words left unwritten stay cleared.
> 
> Also dump the raw device_feature dwords,

dump?

> and add a max_features_u64s
> module parameter to force the legacy 64 bits space on devices whose
> quirk the detection does not catch.

This is even worse.


> Conforming devices are unaffected: their extended words are neither
> all-ones nor an alias of the low ones, so the detection does not
> trigger.
> 
> Signed-off-by: Peng Hao <flyingingpeng@tencent.com>

Can you simply fix the device please? Why not?

And please tell us in what way exactly are your devices broken?

I am not merging multiple hacks "just in case" because there's no
way to test them for me.

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

