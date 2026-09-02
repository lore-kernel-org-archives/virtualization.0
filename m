Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF141E6C5
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341465; cv=none; b=VnRh4kn9L5s8g/YS6p0EYvBp18RX1OHD+/Hdsexzsbci1VIKwCCQNFkn2yU/F9aevQ2Z3Yrgbjevq8Zee17lGSeimZlk8uUjlUi3z5TQ2LXPEy3S54KzL2W3q3kaDpCMBlOzroVh6kTkeZssgoWxJQtqLYy08WhrJlPufUauwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341465; c=relaxed/simple;
	bh=u6T3S6DGl/vdQjwLQo1/mNwbervzrV/kp7XKTcr4vN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pxteE+VsUqDfwEp7rkM/PLTX5+f6gzVXOmyKdtB57SoCU8dtHmkye054iTzBIS4c6sugvldVj499sVXVuNh5VJSmcUJczQxm/o+EP2JFxJwXNkxoNiH1OvgqJtqGbg2RR9qAiica1B0vH2Bh4wNMvLr5hHxPgAvmM1DI2IqGZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0UD7nne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0UD7nne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788341462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhxli8bPX19UcM4ifkJc7bPETZTcX18YS4RXJ1Akr/0=;
	b=F0UD7nneETczuHbn0aNAPA0zqGD9RMthcH/i5RieX+Yg3YMRdmphPnhWAPE5iCVDhonVUa
	SyGNpsKOMxjNgGmN40DqjXh9BQgC7udkZwNcI32+qHGs11YxLZFXVAlZwmwHORXCRpjI8h
	P/rMws0/QpwkJhM7ECQ2j4GINJWqwxw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-dYnuWyXAMZCYGF3gw49ymg-1; Wed, 02 Sept 2026 05:31:01 -0400
X-MC-Unique: dYnuWyXAMZCYGF3gw49ymg-1
X-Mimecast-MFC-AGG-ID: dYnuWyXAMZCYGF3gw49ymg_1788341460
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4843313047eso581150f8f.1
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 02:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341460; x=1788946260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bhxli8bPX19UcM4ifkJc7bPETZTcX18YS4RXJ1Akr/0=;
        b=EqYajtKgmQ363aLT5pQdIY+DMxJjHRybov6BHixDuekJtZyc8Iqw0sFureKsQjIoSo
         xC3IF0pg34OcMQvvyUau7ygtSa0InhApNjDxl2jKHsax2yGWH8LHXBHLvMlyK35ecwFg
         pIM8MOslAXU3SpTxoeQyXbxdl9/1Z3B3rEzyFOc6y65KJCC6FlI2hKyMoiXrcZUe0uJv
         f7lBKT52Hli2uS6gW512LBPDen+V7U0WLOtZZTkAa9QR7EdYBo6OjCePZjieBk+bu3T9
         zgN0VQw6Cvt9K4KzT4qP16n/tlE9w+JVKDwMF4WZx3kMd7ok6l9HuPWLb3rF+JjKOc9N
         GUHA==
X-Forwarded-Encrypted: i=1; AKwUvBx+LbCOBa3ZFL5nVxGwJ4eRWH6I7plhw/T3g4clSbmAg3b/IJg/roAtlAUQtBLNnZYGTdISPNH67sciqR4I/g==@lists.linux.dev
X-Gm-Message-State: AFuF++n4akqLe+v8O79Krrm+BDgVJ4fKv+mzm7hKpH9NaCT/2QQ9XQ16
	ZeaHQxPe+8/KuyKwNIBDQTVqUPdUkIyTQh5uGdOudBihEkhTSJRnAp4Kr8op31TEW4IF11gsVup
	amD/lpNGRsdJ0EZsI6dkNsvGV+OLHtd9csbzXCFApdbSkCM7EOEQ8PsL18zztnBeCm2El
X-Gm-Gg: AYBFou2jRFEv0ixjIP7JjpyGtGOpWt8dVdKMpjXAXqnn7a3EMcI2dgncL87+6FrvabE
	FgTanhew6ZndXbZu1FmAlAK5NnEPBAz03B36TbYUj4ht2Xyz6y07ymgr8lfVMYZ4xyQ3vzDcwMi
	vb5P4qagIAxbuxAnIjv6FGych4j8eqqP86fzaGyET9o8SI6cmuSUZFf0aA2S9e6DkKjdaxyQSwd
	7a2ycjznwgdk8jh0jrim8r2dW76k0DPiknOJJ6jv2JViKHKZTTkyXMAdRqfbXysoI7r2PC1y1vR
	OBRfAG5q+tTNhXJlBcBDxUNebTUZPEvYHfd2+ElEEmFmL+PXN+c+OhphOpLl2wwizS0=
X-Received: by 2002:a5d:5d05:0:b0:484:3cbf:f254 with SMTP id ffacd0b85a97d-484914b8ba0mr6424124f8f.21.1788341459761;
        Wed, 02 Sep 2026 02:30:59 -0700 (PDT)
X-Received: by 2002:a5d:5d05:0:b0:484:3cbf:f254 with SMTP id ffacd0b85a97d-484914b8ba0mr6423961f8f.21.1788341459058;
        Wed, 02 Sep 2026 02:30:59 -0700 (PDT)
Received: from redhat.com ([187.15.128.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80745sm5200574f8f.15.2026.09.02.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:30:58 -0700 (PDT)
Date: Wed, 2 Sep 2026 05:30:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Radu Rendec <radu@rendec.net>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] virtio: avoid hanging forever in reset
Message-ID: <20260902021849-mutt-send-email-mst@kernel.org>
References: <20260902020741.3686084-1-radu@rendec.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260902020741.3686084-1-radu@rendec.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OpwhKfyzWa3Suuojae0n24kVeEII00cK2WBrOpMQMP8_1788341460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2026 at 10:07:41PM -0400, Radu Rendec wrote:
> Under certain conditions(*) vp_modern_get_status() can always return
> 0xff. This has a ripple effect that ultimately makes the system fail to
> boot if the drivers are built-in and the virtio devices are probed
> during boot:
>  * vp_reset() for the virtio-net-pci device spins forever in the loop
>    around vp_modern_get_status(mdev), which always returns 0xff.
>  * vp_reset() is called in the context of the probe() function for the
>    virtio-net-pci device, so probe() never returns.
>  * the init task gets stuck in wait_for_device_probe() before it
>    executes the real init binary.
> 
> Add a timeout to the reset function and make the device probing fail if
> the reset function times out.

Generally, I like using gdb stub in qemu to debug kernel
and anything that will make things time out and fail
is unwelcome.

> 
> (*) This is not a theoretical problem. It happens on imx8mp-evk under
> Qemu due to a relatively recent change to the dw_pcie driver that's
> incompatible with the dw_pcie emulation in Qemu. I reported that bug
> separately as a follow up to the patch that introduced it:
> https://lore.kernel.org/all/ed86629d74368c6811e9f3b8f169584c0faf71ce.camel@rendec.net/

So presumably it will be fixed in qemu? Or find a different way,
e.g. poke at device/vendor id of virtio. or add a workaround
in the driver if you prefer.

> Signed-off-by: Radu Rendec <radu@rendec.net>
> ---
>  drivers/remoteproc/remoteproc_virtio.c |  4 +++-
>  drivers/virtio/virtio.c                |  8 +++++---
>  drivers/virtio/virtio_mmio.c           |  5 ++++-
>  drivers/virtio/virtio_pci_legacy.c     |  4 +++-
>  drivers/virtio/virtio_pci_modern.c     | 15 ++++++++++++---
>  include/linux/virtio.h                 |  2 +-
>  include/linux/virtio_config.h          |  2 +-
>  7 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d5e9ff045a28..d103b80b1faf 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -231,7 +231,7 @@ static void rproc_virtio_set_status(struct virtio_device *vdev, u8 status)
>  	dev_dbg(&vdev->dev, "status: %d\n", status);
>  }
>  
> -static void rproc_virtio_reset(struct virtio_device *vdev)
> +static int rproc_virtio_reset(struct virtio_device *vdev)
>  {
>  	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
>  	struct fw_rsc_vdev *rsc;
> @@ -240,6 +240,8 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>  
>  	rsc->status = 0;
>  	dev_dbg(&vdev->dev, "reset !\n");
> +
> +	return 0;
>  }
>  
>  /* provide the vdev features as retrieved from the firmware */
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75bb4ffe3b87..9542e4f7cb31 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -250,7 +250,7 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * call/workqueue/bh.  Invoking virtio_break_device then flushing any such
>   * contexts is one way to handle that.
>   * */
> -void virtio_reset_device(struct virtio_device *dev)
> +int virtio_reset_device(struct virtio_device *dev)
>  {
>  #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
> @@ -263,7 +263,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  	virtio_synchronize_cbs(dev);
>  #endif
>  
> -	dev->config->reset(dev);
> +	return dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
>  
> @@ -567,7 +567,9 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
> -	virtio_reset_device(dev);
> +	err = virtio_reset_device(dev);
> +	if (err)
> +		goto out_of_node_put;
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 316f03b97356..537d38841331 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -249,7 +249,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
>  	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
>  }
>  
> -static void vm_reset(struct virtio_device *vdev)
> +static int vm_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  
> @@ -260,7 +260,10 @@ static void vm_reset(struct virtio_device *vdev)
>  		/* Wait for reset to complete. */
>  		while (vm_get_status(vdev))
>  			fsleep(1000);
> +		/* TODO: add timeout */
>  	}
> +
> +	return 0;
>  }
>  
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d9cbb02b35a1..2882756c7084 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -90,7 +90,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  	vp_legacy_set_status(&vp_dev->ldev, status);
>  }
>  
> -static void vp_reset(struct virtio_device *vdev)
> +static int vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	/* 0 status means a reset. */
> @@ -100,6 +100,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	vp_legacy_get_status(&vp_dev->ldev);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> +
> +	return 0;
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..4a6906a18cfa 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -21,6 +21,7 @@
>  #include "virtio_pci_common.h"
>  
>  #define VIRTIO_AVQ_SGS_MAX	4
> +#define VIRTIO_PCI_RESET_TIMEOUT_MS 1000
>  
>  static void vp_get_features(struct virtio_device *vdev, u64 *features)
>  {
> @@ -543,10 +544,11 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  		vp_modern_avq_activate(vdev);
>  }
>  
> -static void vp_reset(struct virtio_device *vdev)
> +static int vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	int timeout = VIRTIO_PCI_RESET_TIMEOUT_MS;
>  
>  	/* 0 status means a reset. */
>  	vp_modern_set_status(mdev, 0);
> @@ -555,13 +557,20 @@ static void vp_reset(struct virtio_device *vdev)
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_modern_get_status(mdev))
> -		msleep(1);
> +	while (vp_modern_get_status(mdev)) {
> +		if (!timeout--) {
> +			dev_warn(&vdev->dev, "reset timeout");
> +			return -ETIMEDOUT;
> +		}
> +		msleep(1000);


1 second is a long time. normally devices reset immediately.

> +	}
>  
>  	vp_modern_avq_cleanup(vdev);
>  
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> +
> +	return 0;
>  }
>  
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)


So now if the device does not reset, during cleanup we
previously blocked and now it will corrupt memory.




> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f923e42cfd01..568e1bd95e4c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -212,7 +212,7 @@ void virtio_config_driver_enable(struct virtio_device *dev);
>  int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
>  #endif
> -void virtio_reset_device(struct virtio_device *dev);
> +int virtio_reset_device(struct virtio_device *dev);
>  void virtio_device_shutdown(struct virtio_device *dev);
>  int virtio_device_reset_prepare(struct virtio_device *dev);
>  int virtio_device_reset_done(struct virtio_device *dev);
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..153426b0ae79 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -117,7 +117,7 @@ struct virtio_config_ops {
>  	u32 (*generation)(struct virtio_device *vdev);
>  	u8 (*get_status)(struct virtio_device *vdev);
>  	void (*set_status)(struct virtio_device *vdev, u8 status);
> -	void (*reset)(struct virtio_device *vdev);
> +	int (*reset)(struct virtio_device *vdev);
>  	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
>  			struct virtqueue *vqs[],
>  			struct virtqueue_info vqs_info[],
> -- 
> 2.55.0

