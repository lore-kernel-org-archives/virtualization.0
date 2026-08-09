Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD43859EB
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313690; cv=none; b=SjOjCq5AtroL7yAHI8frV6EeLvSo0fpucDcRO3cqXKiXtwHJuu2/syjzltFZpMjL5qOzClUS1/iHGCGWjarfN1gqJb0nviy4QWovOCcMHu/PZogsc9W9UCYWn2Wl79O/o2obi9v3qFXh/Ngh6sW+4paRNdZP1caccx1kTY/Pq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313690; c=relaxed/simple;
	bh=faUZpVf7h7iSK+Ou7Vp+F92wfPfWu6eYY7PbHbkr4bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ohiy5VGgiRG9fYfUZjA65mD78tXPnbQpFfOjg3bv+JA4BDBZKkAGWEC+EMomKf8Jy4Hfvacoi79oAf2ozwGfFHpP00aYLEXPHN/Z8D7NMjQj7nhW1vM9hl3nozB3Stn8Z9OYKvJSa7Rjyl97al+1z8qazELTUWT2iCbqayJJvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBQUQ9k1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBQUQ9k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786313687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ64y518F/ctkLa1NsQEZkdV3/E2VpMi7b7hx+0V0mg=;
	b=hBQUQ9k18XS9f/KIplSRJgUQyhqVv4hX0TY4DVFfcYoToGGQpxcD8l7M6itLI/kHVIPA11
	03nLus69ir0Jr0EpPlTQRas1MM7finOQH2shq26G2ScSE0hNOy9gwrc/Z6L6CBoBOKMJU7
	4xwYKRSq8QGV57Ljn9nZrsmHTgMYBhg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-5H8SPJScM66m4MRqYuZI5A-1; Sun, 09 Aug 2026 18:14:46 -0400
X-MC-Unique: 5H8SPJScM66m4MRqYuZI5A-1
X-Mimecast-MFC-AGG-ID: 5H8SPJScM66m4MRqYuZI5A_1786313685
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fecbb553bso855843f8f.2
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 15:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786313685; x=1786918485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJ64y518F/ctkLa1NsQEZkdV3/E2VpMi7b7hx+0V0mg=;
        b=NtTPUetzLXugZ20vr0JgmuCxrMfXySqB1fR7Cc+dsbeBjKow/d8VgYSx0zJXzqxDD1
         FzYDjH9r7+d9lG8b0GjzBl+h/ixOwhpkhGD7cGliGi1unde7/Bj+4U97DbbwlBG+m/bR
         s0YJbsE5gw1PhGWZHvTIK93d9q1UEebpW7+LgwneyS53YViHePTp68+XHla28r5iuUA9
         7DgcgN3f68DAGq5NVJ6/6nHBis6xho5qejni2Jj6AMzgOzcieLN7Sn9Y1UAofzacbFhA
         rOP1pObhGwmMbm6dfJ/oZZSn/xbY2+adi2lF8G/Ve2LMG2cR/mcue/pk1rktqWkxpNbH
         WMLw==
X-Forwarded-Encrypted: i=1; AHgh+RoTtCoi0hmYVi2MA9K808PAUtE2MDHqDfG2Ok1+MVqNipVC29Mt8IvexFEn12E7mHN+ggqoSyS0rSVEx8yxyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+jLI5zfLio1XvWgd/qV0Wn17GdU2XWwQheejRMAtSGl//dVbD
	xRA4o3hv0sa6amcVX+xtjOwqexkRhrpGVvyzDFYqbqVKhy+qQTT7mRqH4BJF/a93N8I4Ww3xTSI
	4MwFmllsglBOKjhBw9NrJi1t3laARbgpyK7iyC6tLIOVjQCc/gttg5MCIKFjPhNxyjltc
X-Gm-Gg: AR+sD13OuXFCdm0DExV0gEnetSmFEE0nqwCuhw9lGlb1TX1gz5owwSJch12O7bp3CAV
	GtcVgHOnz77wEbf7Fl+JXUa2OC464aZJOz9nZiD6E/z+ZhEnakrLJmvXtM2V8SBEaZUMFDsgwfi
	flzqAH0jK3EVIs9BuXO3EqVqFRr38XBruDESf30Hzav6zha4k0bAeic+9F6RvbASOEuVVQbnDqI
	17PH31WrBaMeCUKMjGofFvP5iioJgy9bYyFWQk15yjnFNwIFx3xpRnZWaAcwBhdE/tIoZJnqxOK
	ohFN4RdXXolri27bD/g3G4zctBaTS1xvCEzf7tRAJTXC9GDhjrFYFBDA/2cQj9epVw9HS4vuAhH
	OG/E2mZtM8Gx3KhOT7flSrw==
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr50037230f8f.4.1786313684627;
        Sun, 09 Aug 2026 15:14:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr50037197f8f.4.1786313684143;
        Sun, 09 Aug 2026 15:14:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm26074939f8f.2.2026.08.09.15.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 15:14:43 -0700 (PDT)
Date: Sun, 9 Aug 2026 18:14:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 08/12] virtio_pci: support VIRTIO_F_DMB
Message-ID: <20260809180920-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-9-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260809182010.32931-9-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HCbE0hTWMN7s9SlD3HeTTV1piLaM19cQAjsh8Y_v768_1786313685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2026 at 06:20:06PM +0000, Alexander Graf wrote:
> Let a modern virtio-pci device place its virtqueues and the buffers they
> reference in a Device Memory Buffer of its own: accept VIRTIO_F_DMB from
> vp_transport_features(), and implement the get_dmb_shm_id config op on
> top of vp_modern_get_dmb_shm_id().
> 
> Refuse a device whose common configuration is too short to hold
> dmb_shm_id, which would put that read outside what vp_modern_probe()
> mapped. The accept commits before the id can be read, so a region we
> fail to locate afterwards fails virtio_features_ok() and probe sets the
> FAILED status bit.
> 
> Four conditions gate the accept:
> 
>   1) VIRTIO_F_ACCESS_PLATFORM, because the feature is only defined
>      together with it.
>   2) VIRTIO_F_ORDER_PLATFORM where the device offers it. Without it
>      the ring emits the weaker barriers that assume the device sees
>      memory the way another CPU does, and a region that is not
>      ordinary host memory breaks that assumption.

I don't get this last sentence. Not really?


>   3) CONFIG_VIRTIO_DMB, so a device offering the feature to a kernel
>      built without it is driven as an ordinary device.
>   4) VIRTIO_F_VERSION_1, because virtio_features_ok() returns early
>      without it, which would leave the feature negotiated and the
>      region never built. This transport refuses such a device anyway.


What is missing is actually validating that the region is cache coherent.

For regular pci devices, which this patch seems to try to handle,
this is not the case.


Maybe this feature is CONFIG_VIRTIO_DMB_COHERENT actually.


> 
> vp_dmb_ordering_ok() asks the device with vp_modern_get_features()
> instead of reading the feature word vp_transport_features() is handed.
> That word holds what the driver accepts, so a device offering
> VIRTIO_F_ORDER_PLATFORM to a driver that declined it would read there as
> a device that never offered it.
> 
> Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 65 ++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 565d37b630b3..c43c1fc6e843 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -364,6 +364,36 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>  	}
>  }
>  
> +/*
> + * The proposal

proposal?

> makes accepting VIRTIO_F_DMB conditional on accepting
> + * VIRTIO_F_ORDER_PLATFORM where the device offers it.  Without it the barriers
> + * the ring emits order accesses only as seen by a device that can be assumed
> + * to run on identical CPUs in an SMP configuration, which a device whose
> + * region is not ordinary host memory is not.  Accepting
> + * VIRTIO_F_ORDER_PLATFORM is otherwise only a SHOULD, so nothing else couples
> + * the two.

This thought process kind of thing (what we considered and discarded)
is fine in the commit log but not in the code.


> + *
> + * The offer is read back from the device rather than taken from the feature
> + * word vp_transport_features() is given, because that word is what the driver
> + * still wants rather than what the device offered.  The two differ exactly
> + * where this has to hold: virtio_dev_probe() calls finalize_features() a
> + * second time when a driver's validate() changed the set, and a validate()
> + * that declined VIRTIO_F_ORDER_PLATFORM leaves the bit absent from the word
> + * as well, which would read as an offer that never happened.  virtio_balloon
> + * declines VIRTIO_F_ACCESS_PLATFORM from validate() today, so the shape is
> + * not hypothetical.
> + */
> +static bool vp_dmb_ordering_ok(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	if (__virtio_test_bit(vdev, VIRTIO_F_ORDER_PLATFORM))
> +		return true;
> +
> +	return !(vp_modern_get_features(&vp_dev->mdev) &
> +		 BIT_ULL(VIRTIO_F_ORDER_PLATFORM));
> +}
> +
>  static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -378,6 +408,27 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  
>  	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
>  		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> +
> +	/*
> +	 * VIRTIO_F_DMB is only defined together with
> +	 * VIRTIO_F_ACCESS_PLATFORM, so accept it only when the driver accepts
> +	 * that too.  vring_transport_features() has already run, so the bit in
> +	 * vdev is the one the driver accepts rather than the one the device
> +	 * offered, and the proposal words the requirement against what the
> +	 * driver accepts.  VIRTIO_F_ORDER_PLATFORM is required where the device
> +	 * offers it, for the reason vp_dmb_ordering_ok() gives.
> +	 * VIRTIO_F_VERSION_1 is required because the core locates and releases
> +	 * the region from virtio_features_ok(), which returns before it gets
> +	 * that far for a device without VERSION_1, so accepting the feature
> +	 * without it would leave the feature negotiated and the region never
> +	 * built.
> +	 */
> +	if (IS_ENABLED(CONFIG_VIRTIO_DMB) &&
> +	    (features & BIT_ULL(VIRTIO_F_DMB)) &&
> +	    __virtio_test_bit(vdev, VIRTIO_F_ACCESS_PLATFORM) &&
> +	    (features & BIT_ULL(VIRTIO_F_VERSION_1)) &&
> +	    vp_dmb_ordering_ok(vdev))
> +		__virtio_set_bit(vdev, VIRTIO_F_DMB);


So maybe let's not couple them in the spec and our lives will be easier.
!VIRTIO_F_ACCESS_PLATFORM is generally a PV thing.

>  }
>  
>  static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> @@ -413,6 +464,9 @@ static int vp_check_common_size(struct virtio_device *vdev)
>  	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_ADMIN_VQ, admin_queue_num))
>  		return -EINVAL;
>  
> +	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_DMB, dmb_shm_id))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -878,6 +932,15 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  	return true;
>  }
>  
> +static int vp_get_dmb_shm_id(struct virtio_device *vdev, u16 *id)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	*id = vp_modern_get_dmb_shm_id(&vp_dev->mdev);
> +
> +	return 0;
> +}
> +
>  /*
>   * virtio_pci_admin_has_dev_parts - Checks whether the device parts
>   * functionality is supported
> @@ -1241,6 +1304,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
>  	.get_shm_region  = vp_get_shm_region,
> +	.get_dmb_shm_id = vp_get_dmb_shm_id,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
>  };
> @@ -1261,6 +1325,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
>  	.get_shm_region  = vp_get_shm_region,
> +	.get_dmb_shm_id = vp_get_dmb_shm_id,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
>  };

