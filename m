Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A354AB1D7
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265941; cv=none; b=DXg/McmDArSWOt6d4/m5c93vLvXf8Q683vta5QE+g0dwk4YgskrkZ75+QYcVYCpM9Rc0FV8oVC/TUeWxAA4jjVmU2oeNF0bdOBaHVmqj+sjgsaNrrnyXkhwnsxBNFjItGZpHJVg98CloXDnTFdujabl9B6y8VwBEevP3Or7hFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265941; c=relaxed/simple;
	bh=G6PmJO5EpYc6Fz1VCzI/cKNPIwZcP7eFPifu6L3sgcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JDhMGJ6LvA3/LRYzR+dLmrDtkSCrWNKzcuthLpcTgsy6iot4poZzAhnAcKWIaIeLbcmG3K7l7r7pbWF5tnOrMaKYzioVOf1mljPXtyClOLdhO9hpKmqsYZ2hdndXn9J3PC/L7XVMKh1nGa0MnSbfJcqWLt52MhQjFeXRpkt2Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZNqoqGl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZNqoqGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790265938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4shkN+TR5HjZRGgfaHF65+qYFGwMQ1YA7fz/+kVdr/M=;
	b=cZNqoqGlOCddSa1PTrRAonHg7/gyS1fk0mKg4Uusek0Hqdnuy8X0kfXyoPwv5hiHLIk4YG
	/Ch/LPUU1+H14MJmNDVr6oqQlFjCyk3oVuRCr2vLo/cujv6BfsXm78MGPCOs80wnc2EJiT
	WXBu9+P1GTJrZCOPwWqcKMY8r+f05fM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-l-PjzP8BO8CWXxU9zssNlg-1; Thu, 24 Sep 2026 12:05:36 -0400
X-MC-Unique: l-PjzP8BO8CWXxU9zssNlg-1
X-Mimecast-MFC-AGG-ID: l-PjzP8BO8CWXxU9zssNlg_1790265935
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c252a2ae8e1so238181766b.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265935; x=1790870735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4shkN+TR5HjZRGgfaHF65+qYFGwMQ1YA7fz/+kVdr/M=;
        b=NiCfkaCRz0Prz9Lgl1dr4Z29MRoL4TEfSAS4UalhJ5hV3pW9zuse+k6v7IHI2lj6xJ
         U2WtSyHystzJz/uWnVi82ERaEySpMKmwpAHvHp4PX13EoKPalfc3bDNw5qeJIGnpCD23
         FlhPRj+1uryIqiHmCTlW26C26lKha5CAhKz9l/1rgluCCod9pPiYRX3a+auDoOaDuCPw
         it6Hh26fGDehjcj+e47FOWzbRKK7qxUZBn3s0lPrddQWrPaazeLCvKKLTshmhVpF6ton
         Rb5TFZlSWKN5uj319VY6KDtB2So1NAPaNu/7iL1poy74v0TJ7EdPL5Y5Aled20fQSIHf
         FSjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpPpymk+5KjIMvOO/e5E6773f1+Whf3+DcSsuG/EbwbXny+zon4SiMOUT1s021KnB0lrajiGLiEmRw1hizTg==@lists.linux.dev
X-Gm-Message-State: AFuF++mvRuAtGmxxrMvY+Aycp4e5nFozbNaDi+zv6ccORgaANe0w3Qmi
	NNLYoUWt/Doy5DRRQ8sYlfZF807GgopKcujHnuxZcMe7KX/PjBG2EdUoAwZZWWmywir7pJZRLRm
	hID7771/d7EoHYfX79Ryp1zbH2REOoQsgyp10BBYbP7kH6x2IweM5nUrbRSLKkneVeYq8baCBse
	xN
X-Gm-Gg: AYBFou2fi7Kmec1kZ54Kgrt4em3z+SFi1d+0T7MD/SQ75ZSIP0mmAalsSdzPy8jBGa3
	NIZtdddux3NSuqJ5cp14RzLfAf9EgrXCxkjBWZkF224Mwn6NaGDaNCG69pGVRg45LIf3Mn6nGBD
	qHDPbqe1qWE215RTO7LffXa4y72sqri3CfKT5iLOUuCa/q+qge1Qkw++BJXAcpbma3UXYzSnLRA
	4Z9w0oZj7NDdW2A/gzACXH0zsRr2dhm7Ht0ib+uvOBvu7b3brypqS99Tt7e2OfCacFMWTktxNyp
	0eVMKuEETQzquoRnfHNlYQ4vvhT5AU3DpQ8UhmV99NgWoO1OeEaVLYl2LqAZB8aSWchzqkcSioU
	M9Oz7XJ3mgq/KXD2jj0xlLyD08fQ0kiN4Ba7hnG5epUQN9WEWdiWpqQMz3dgGtjLBtg==
X-Received: by 2002:a17:907:9406:b0:c26:19de:912c with SMTP id a640c23a62f3a-c2ac256d509mr320153466b.31.1790265935255;
        Thu, 24 Sep 2026 09:05:35 -0700 (PDT)
X-Received: by 2002:a17:907:9406:b0:c26:19de:912c with SMTP id a640c23a62f3a-c2ac256d509mr320150166b.31.1790265934723;
        Thu, 24 Sep 2026 09:05:34 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c70afsm320151166b.19.2026.09.24.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:05:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtio_pci_modern: skip trailing zero feature dwords
Message-ID: <20260924115824-mutt-send-email-mst@kernel.org>
References: <20260924071412.6765-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260924071412.6765-1-flyingpeng@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N4yb6ZGUQyzPG_nJ_FvPUF0LHH6qUdl3RG9eXzwiW94_1790265935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 03:14:12PM +0800, Peng Hao wrote:
> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features"), vp_modern_set_extended_features() writes all four
> feature dwords on every device, even when the upper ones are zero.
> 
> Feature negotiation follows a device reset, which clears the device-side
> driver features, so trailing zero dwords need not be written at all.
> finalize_features() can be called again without an intervening reset,
> though, when a driver's validate callback narrows the features, so also
> write any dword written since the last reset, to clear what the previous
> call had enabled.
> 
> Devices negotiating nothing above bit 63 save four MMIO writes; those
> using the 64..95 range (e.g. the UDP tunnel GSO features) save two.
> Counting dwords rather than 64-bit words is what makes the latter work:
> with VIRTIO_F_VERSION_1 at bit 32 the second dword is set on every modern
> device, so a qword count never drops below two.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

So .. why does all this matter? how many exits do you save
during a guest boot? is it worth the complexity?

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 32 ++++++++++++++++++++++----
>  include/linux/virtio_pci_modern.h      |  3 +++
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c353463..7b4da37b6ae5 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  
>  	check_offsets();
>  
> +	mdev->driver_features_dwords = 1;
> +
>  	if (mdev->device_id_check) {
>  		devid = mdev->device_id_check(pci_dev);
>  		if (devid < 0)
> @@ -437,6 +439,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
>  
> +static u32 vp_modern_features_dword(const u64 *features, int dword)
> +{
> +	return features[dword / 2] >> (32 * (dword % 2));
> +}
> +
>  /*
>   * vp_modern_set_extended_features - set features to device
>   * @mdev: the modern virtio-pci device
> @@ -446,14 +453,27 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
>  				     const u64 *features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -	int i;
> +	int dwords = VIRTIO_FEATURES_BITS / 32;
> +	int i, write_dwords;
>  
> -	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> -		u32 cur = features[i >> 1] >> (32 * (i & 1));


below is arguing with previous version of code
instead of straight explaining what is this code doing.
pls rewrite this comment.

> +	/*
> +	 * A device reset

what "a device reset"? who did reset and when?

> clears the driver features, so trailing all-zero

trailing?

> +	 * dwords need not be written out.  Include any dword written since
> +	 * that reset,

what "that" reset?

> though, so that a repeated finalization can clear
> +	 * features which were enabled by the previous one.
> +	 */

> +	while (dwords > 1 && !vp_modern_features_dword(features, dwords - 1))
> +		dwords--;

what's all this > 1, - 1?

> +
> +	write_dwords = max_t(int, dwords, mdev->driver_features_dwords);

and what is this. i have a vague idea but needs a comment.

>  
> +	for (i = 0; i < write_dwords; i++) {
>  		vp_iowrite32(i, &cfg->guest_feature_select);
> -		vp_iowrite32(cur, &cfg->guest_feature);
> +		vp_iowrite32(vp_modern_features_dword(features, i),
> +			     &cfg->guest_feature);
>  	}
> +
> +	mdev->driver_features_dwords = dwords;


contradicts the comment near driver_features_dwords.

>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
>  
> @@ -495,6 +515,10 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>  
> +	/* A reset clears the device's copy of the driver features. */
> +	if (!status)
> +		mdev->driver_features_dwords = 1;

so why 1 not 0?

> +
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
>  	 * that the cache coherent memory writes have completed
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 9a3f2fc53bd6..b9f4783f0e02 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -27,6 +27,8 @@
>   *		    Returns the found device id or ERRNO
>   * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
>   *		    for vendor devices with DMA space address limitations
> + * @driver_features_dwords: Number of 32-bit driver feature words written
> + *		    to the device since the last reset
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
> -- 
> 2.43.7

