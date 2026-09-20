Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D933F8BC
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893665; cv=none; b=WL+P5gXiPwSyarhBis9zBxrmm3gzkdKykMZZddp2CDD/HDh0JbrCMG5QfKRfthp14VP/1x5BgMesJtIBMd3A0d+VgwLZb3gdPAXVtdEFIvnkxBYBpoJaGxb5spKo9wZqqD/169tLpJcIDrq0ZYr5piqkcF3kVIbcq3CvX8wvHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893665; c=relaxed/simple;
	bh=ykGXpOTSwkD+kZlTkUDlQyQhAvjdAjJfcMPyyTVPUJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HyjUqblO/Nyx1iSCGAzmfbC8jFHJWhFd3xOXu3iq7L0CKL32ELW4uf48zvSM2nJk55vMr7wWOBc9IeBKlzDkvmtsszpzToGr+J0H+XcyDEttp4z+UsFRXYI3NBLqc94BG/i9gZc1TGlDL7XovTEJxk09aJRFFDVbWCpEcZMPgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTk9ZVCZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTk9ZVCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789893662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTt5rsEMUhc0hpK6WOw/BRk/X47z1K1j501rXPcd6ms=;
	b=QTk9ZVCZ7Y0ec/FgX27ywPr3UtFkZfMfbaQrTzFrxVyoNst57qpLjM5BH4n0zhCBXXV6sb
	7eE9lHiqux/wGDJ5t2tFWjnXEY4iEp0CbvlLqg7+lNOX+G9JzLDbhhlaJELEpFQArrJS9n
	6RELKz6zX39EefIuQbLntUtAzWDTd7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-0lyrmvADOpeFq6FAB2H1aw-1; Sun, 20 Sep 2026 04:41:00 -0400
X-MC-Unique: 0lyrmvADOpeFq6FAB2H1aw-1
X-Mimecast-MFC-AGG-ID: 0lyrmvADOpeFq6FAB2H1aw_1789893660
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48589603501so916708f8f.3
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 01:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789893659; x=1790498459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTt5rsEMUhc0hpK6WOw/BRk/X47z1K1j501rXPcd6ms=;
        b=Pd+kPyPBVIbkYmXe+XNWAvKyQ5TjLeQiEh9g+JnYgkYeRViCq9CYC4Ch4emqKiep2A
         CU5taMMPJAB18MRXOIj/MSTdCTTcW/XyY/7ogEmDU5dw68ZD+nHTfga8eMfLeDiFdSZa
         8eu4saOnXlNT3wP+mVl0eRH+NMvzpAllQFYm9Q2gTNB9h1f+itLcJprwiWId9ABLA/5I
         83H7qsMkesMtKomXV8HEgmnpWKCaLS5nQQhLDHCnS/NHpmkb/zCvxToIJMOR3jch82SA
         cCxkghRWphMXYg70H66NeeOn3ocef3XufEK0xtm/g8Gx6hivuAW2lcLWR7kRA5BpkTe5
         6IbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2dRe41I8KivG8PnVrwOWA6FjVLxiOK6XEUKYLGxeCqjzR9ybazPjpbwoiXbOBUmAy0kqDRehMlcoCO1QKcg==@lists.linux.dev
X-Gm-Message-State: AFuF++l9RUqHlwnKq45n9opgK/vgfppmb+lMNty0+4FPNyurnZ2b3+k6
	fvEeX01l0jCEgg9RxB882mqKgvhww7d0/Tc/N4UE5hg6ZCPAgB/HShAiwA4wtHxEayaaPtXAQwb
	tSwm5s4V3dA6q7YXdsOfJwT43oLZSVlXNLf3xjsjZoSZWker+qP29lkNeo1bm4cfedulL
X-Gm-Gg: AYBFou0266U+BPlY+qb8JVhMfl+nWWRnLELWSLnf7eF1qWYMV5Ib70aI30XWzL6IBuZ
	We5GWnCXjJ4fl3X1ie7IvDIo8i3+MtMY0Bi0CzYHfb+Ogw9BbMtJoUjXzPm7tGhE45LSZ2oVaaz
	goBIFLP70lOVjkp3XzefSHHHd9bBlZXBSJUiUbaTWEu/jCEsz/FM4X0BQx4L49HWVJmS1x8kkMM
	LFrBxRHVlw8Su6GgMQX0vmpmr+JQklYoIogPNPqaZcUP9biCCY7oH0grFNaISnGQaV61wdXDQKP
	ns0auuamVIs+SOSgaJeD4824mZJmydfKbd+AipXKs1fHzk5K8fqC9aMU+DCEsN001ttScdGbnBz
	WU+77bQehrYZiooRPe21PDVw=
X-Received: by 2002:a05:6000:491e:b0:485:8fb2:b8cd with SMTP id ffacd0b85a97d-4871e21572fmr10552281f8f.6.1789893659478;
        Sun, 20 Sep 2026 01:40:59 -0700 (PDT)
X-Received: by 2002:a05:6000:491e:b0:485:8fb2:b8cd with SMTP id ffacd0b85a97d-4871e21572fmr10552255f8f.6.1789893658887;
        Sun, 20 Sep 2026 01:40:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724422790sm12616968f8f.5.2026.09.20.01.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:40:57 -0700 (PDT)
Date: Sun, 20 Sep 2026 04:40:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci_modern: skip unused trailing driver feature
 words
Message-ID: <20260920043705-mutt-send-email-mst@kernel.org>
References: <20260920065746.86415-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260920065746.86415-1-flyingpeng@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-9HqTQBERfppj7z_ax6XiRqnnjYRGzQkf_qjOjSOOg_1789893660
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2026 at 02:57:46PM +0800, Peng Hao wrote:
> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features"), vp_modern_set_extended_features() writes all 128
> feature bits on every device.  Each 32-bit word requires one write to
> guest_feature_select and another to guest_feature, even when the upper
> 64 feature bits are all zero.
> 
> Feature negotiation starts after a device reset, which clears the
> device-side driver features.  There is therefore no need to write
> trailing zero 64-bit words on the first feature finalization.
> 
> finalize_features() can, however, be called again without an intervening
> reset when a driver's validate callback changes the negotiated features.
> Remember how many words were written since the last reset and include
> that range in the next write, so that a repeated finalization can clear
> features which were previously enabled.
> 
> This avoids four MMIO writes for devices which negotiate no feature
> above bit 63, while preserving the full-overwrite behavior when the
> negotiated feature range shrinks.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

I don't get it. pci updates features in units of 32 bit dwords.

Most devices only use the 1st 32 bit dword.

/scm/linux$ git grep _F_ include/uapi/linux/virtio*h|grep [4-9][0-9]|wc -l
21
/scm/linux$ git grep _F_ include/uapi/linux/virtio*h|wc -l
190

Why are you tracking 64-bit qwords?


> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 22 +++++++++++++++++++++-
>  include/linux/virtio_pci_modern.h      |  3 +++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c353463..8211e491a17b 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  
>  	check_offsets();
>  
> +	mdev->driver_features_u64s = 1;
> +
>  	if (mdev->device_id_check) {
>  		devid = mdev->device_id_check(pci_dev);
>  		if (devid < 0)
> @@ -446,14 +448,29 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
>  				     const u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u8 u64s = VIRTIO_FEATURES_U64S;
> +	u8 write_u64s;
>  	int i;
>  
> -	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> +	/*
> +	 * A reset clears the device-side driver features, so trailing zero
> +	 * words need not be written.  Include words written by the previous
> +	 * call, though, so a repeated feature finalization can clear features
> +	 * that were previously enabled.
> +	 */
> +	while (u64s > 1 && !features[u64s - 1])
> +		u64s--;
> +
> +	write_u64s = max(u64s, mdev->driver_features_u64s);
> +
> +	for (i = 0; i < write_u64s * 2; i++) {
>  		u32 cur = features[i >> 1] >> (32 * (i & 1));
>  
>  		vp_iowrite32(i, &cfg->guest_feature_select);
>  		vp_iowrite32(cur, &cfg->guest_feature);
>  	}
> +
> +	mdev->driver_features_u64s = u64s;
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
>  
> @@ -495,6 +512,9 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>  
> +	if (!status)
> +		mdev->driver_features_u64s = 1;
> +
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
>  	 * that the cache coherent memory writes have completed
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 9a3f2fc53bd6..8df287d545c9 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -27,6 +27,8 @@
>   *		    Returns the found device id or ERRNO
>   * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
>   *		    for vendor devices with DMA space address limitations
> + * @driver_features_u64s: Number of 64-bit driver feature words programmed
> + *		    since the last device reset
>   */
>  struct virtio_pci_modern_device {
>  	struct pci_dev *pci_dev;
> @@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
>  
>  	int (*device_id_check)(struct pci_dev *pdev);
>  	u64 dma_mask;
> +	u8 driver_features_u64s;
>  };
>  
>  /*
> -- 
> 2.43.7

