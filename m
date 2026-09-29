Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CD48E0DF
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674886; cv=none; b=qkDyWrwer05nS8ShWmmVnL4HiiAx1uzaoUhXTFv1EpB0uIriRVTbzrB7ARC//tip30udr6VE+7n2bbDJX51Rk92/f8CoaIHzJtfQDENYpALj7ircBogMkulezsq+pbA0m/evEEuwABllmWB4g7UMFeqXyFsV6GQQjgDx44klV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674886; c=relaxed/simple;
	bh=cUaT3OZecTG/4HHBOvbDDwcjrKIdHsh/HmzoS8loDjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Julv1Uqs1u/6i/bBI8ssutZjrMZ0PskjT0FxK3wJH3L02g9Nebe6guYZJSA8Ih9/92PEiewd5dmfilBK5n3R1L453qIu2laMrweWs/pOzgm6OyvIJbtFHFo02UshFgK7ThjzWlE9ecIR9Sa6yc4H9vSlgDNXam7+hTxlYDEoaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfYEtUX+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfYEtUX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790674883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9i0W97gMxqvsAbLIZp02uIZH9NW4uSbL4+H/ESvwuo=;
	b=AfYEtUX+alNMMUaqi2uWudFMsrm4YdiwfSCpnKcXv21LFClowoiHx4phhr73JWWq7BP6iV
	jEnaig8gWI8RzKFZsqUgY1fZaQ+UJLgSkKziB3wDhySMTD9VuO/i6MZeV+PN7l3sFXlCdU
	AtlJGoVIP2xTUs2Rfo5/IcNtaQtMx2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-r9eU9EdNPaaITtU1f0mpgw-1; Tue, 29 Sep 2026 05:41:21 -0400
X-MC-Unique: r9eU9EdNPaaITtU1f0mpgw-1
X-Mimecast-MFC-AGG-ID: r9eU9EdNPaaITtU1f0mpgw_1790674880
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29959eb71fso408723466b.1
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 02:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674880; x=1791279680;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9i0W97gMxqvsAbLIZp02uIZH9NW4uSbL4+H/ESvwuo=;
        b=rxoolVQI2WjyUFilGOk81OGT4hpDvXvkv7qQqXZ/mjt/q4z5Sfldn9iLXbYQplr2Jk
         lm10WkSpygm+rw1PzYd6D0rozOoyMMxk6YUZm/Z4+RzKgwsqCODKqEetSshMdr3otYZ9
         o98MzzfbNJIGaezGL9s9y8TNrX5DRPym9RWxtSNhcU1DrCVzNY4ZeYWpWgBHHSeq2MMM
         6f6OWZvGBp1e3aWX3N4ZIwyh/gLjOrXILEZpSNwvyM6QGxe1Ea43X10RQr/4HrQzyzpS
         B51L4Oi/i/Z+c3Iu9Nj3nf0It7ZUTF9n5ePU9oC36z6jZ4wG4WfP5fu9Nk5ND9mafddT
         sGdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLpoa3UIOgNt7pytIsAppnSlE/0GwGDN3QgdZacY8mhubw7r/sYUFuTUmjAvOgKoO+kcRJyBCixIYQICVqSw==@lists.linux.dev
X-Gm-Message-State: AFuF++kxHvuM2GDs5s4QLXesatyeCgeWeio1tG1Cv1C+VjJ3R5dvLNKH
	fp0WLjYBioxkXkwL5hCQjgYDMq6UYgnuUQYx73e4I89TE/aHRuFe4K36DhFOqW2OEP4O1t+MKt6
	03EetmDe9ID7wG9K3n+c0Pp0oHtAAU/n8GG8JJC28aTSVlicdDGQpOt5UGwZHbZ07Li34
X-Gm-Gg: AYBFou0GiR9XjDv81dNvY5odxbqXAldVciLQGUe8SuiUlV79rgO4d6vcy0hJj2xEQKA
	Aj08dEv1fgFRwsUMAYmK5zfQL2tFgUkfkphwXwaFRCkDA4BFJXveYrYdGUHgX1neWmhyLlFSRps
	Qe3gJuua3mhleSHbX8O00BdvnCKSAiW5dsKt0gPybojEW5Owja7AeVIy6g79M0Qx3VjQUiNZ21O
	XGiVVREXWGF2zrkUp1cvguRJu/Wk7kNA/76Ap5QuscXXIn9zyWBe72UYjJKAUs8yoJwcelp4oOb
	Hdc3rpq8j9nqez5oTr4Hmlfkl5Oz9u75R4dn39Unk+S/3galvvla9VQhCo1T7a/RIc9sCg==
X-Received: by 2002:a17:907:8e11:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c2dc7393f1bmr546325466b.32.1790674880129;
        Tue, 29 Sep 2026 02:41:20 -0700 (PDT)
X-Received: by 2002:a17:907:8e11:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c2dc7393f1bmr546323166b.32.1790674879587;
        Tue, 29 Sep 2026 02:41:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd380636sm418377566b.66.2026.09.29.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:41:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 05:41:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v3] virtio_pci_modern: skip unused driver feature
 registers
Message-ID: <20260929054057-mutt-send-email-mst@kernel.org>
References: <20260928123455.49982-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260928123455.49982-1-flyingpeng@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nWwu6zMlnC9aKmkqfVT4qYvpG9c2EswKvbmC8woH354_1790674880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2026 at 08:34:55PM +0800, Peng Hao wrote:
> vp_modern_set_extended_features() currently writes all four 32-bit
> driver feature registers.  Selecting and writing each register requires
> two MMIO accesses, and each access may cause a VM exit when Linux runs as
> a guest.
> 
> The virtio core resets a device before feature negotiation.  Resetting
> clears all driver feature registers, so the initial finalization only
> needs to write through the highest nonzero register.  A typical modern
> device uses bits 0..63 and therefore saves four MMIO accesses, or up to
> four VM exits, during each feature negotiation.  Devices using a feature
> in bits 64..95 save two.

Why does this matter, in the big scheme of things?

> A driver's validate callback may remove features and cause a second
> finalization without another reset.  Track how many registers the
> previous finalization wrote and cover at least that range on the next
> call, writing zero where needed to clear a removed feature.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 38 ++++++++++++++++++++++++--
>  include/linux/virtio_pci_modern.h      |  3 ++
>  2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c3..631b60f 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -437,6 +437,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
>  
> +static u32 vp_modern_features_dword(const u64 *features, unsigned int index)
> +{
> +	return features[index / 2] >> (32 * (index % 2));
> +}
> +
>  /*
>   * vp_modern_set_extended_features - set features to device
>   * @mdev: the modern virtio-pci device
> @@ -446,14 +451,38 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
>  				     const u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u8 required_features_dwords = VIRTIO_FEATURES_BITS / 32;
> +	u8 features_dwords_to_write;
>  	int i;
>  
> -	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> -		u32 cur = features[i >> 1] >> (32 * (i & 1));
> +	/*
> +	 * Find the highest 32-bit feature register containing a negotiated
> +	 * feature.  Register 0 is always written, even when no device-specific
> +	 * feature was negotiated.
> +	 */
> +	while (required_features_dwords > 1 &&
> +	       !vp_modern_features_dword(features,
> +					 required_features_dwords - 1))
> +		required_features_dwords--;
>  
> +	/*
> +	 * vp_modern_set_status(mdev, 0) clears every driver feature register
> +	 * and sets driver_features_dwords to 0.  The first finalization
> +	 * therefore only needs to write required_features_dwords.  If
> +	 * finalization is repeated without a reset, also rewrite every register
> +	 * touched by the previous call so that features removed by validation
> +	 * are cleared.
> +	 */
> +	features_dwords_to_write = max(required_features_dwords,
> +				       mdev->driver_features_dwords);
> +
> +	for (i = 0; i < features_dwords_to_write; i++) {
>  		vp_iowrite32(i, &cfg->guest_feature_select);
> -		vp_iowrite32(cur, &cfg->guest_feature);
> +		vp_iowrite32(vp_modern_features_dword(features, i),
> +			     &cfg->guest_feature);
>  	}
> +
> +	mdev->driver_features_dwords = required_features_dwords;
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
>  
> @@ -495,6 +524,9 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>  
> +	if (!status)
> +		mdev->driver_features_dwords = 0;
> +
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
>  	 * that the cache coherent memory writes have completed
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 9a3f2fc..7a5b200 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -27,6 +27,8 @@
>   *		    Returns the found device id or ERRNO
>   * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
>   *		    for vendor devices with DMA space address limitations
> + * @driver_features_dwords: Number of 32-bit driver feature registers written
> + *		    by the most recent feature finalization, or 0 after reset
>   */
>  struct virtio_pci_modern_device {
>  	struct pci_dev *pci_dev;
> @@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
>  
>  	int (*device_id_check)(struct pci_dev *pdev);
>  	u64 dma_mask;
> +	u8 driver_features_dwords;
>  };
>  
>  /*

