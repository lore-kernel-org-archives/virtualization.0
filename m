Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC65FC433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:18:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8866C610CF
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866C610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 519D4607A8;
	Thu,  8 Apr 2021 16:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7_pAzfGNI-y; Thu,  8 Apr 2021 16:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77E026078D;
	Thu,  8 Apr 2021 16:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17621C000C;
	Thu,  8 Apr 2021 16:18:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57C93C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FA4B406AB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgJSL99sKWyT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:18:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1830C4011A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617898704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVwoTM+oNpxMQeZ9qdrvF1OSOoAmA57D5M6US4TQgYc=;
 b=hp+D/oLsNO2lWsRImqliUTusKn4cMWbKeHt4t3rtZVgQlCCF+1VmoVqPwzORIaIfowg4Hd
 UxIIg1+u+dUd02sWVV+IVO3v07eVZPGpCucroyj77E+ujYz34IiRX+ks0sW8HMSJZ3mIF3
 8XMrN2O23CJmPraOsEiyKNLrlVtEkPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Mp1KsFAKPwGr47a9bacV2w-1; Thu, 08 Apr 2021 12:18:23 -0400
X-MC-Unique: Mp1KsFAKPwGr47a9bacV2w-1
Received: by mail-wr1-f71.google.com with SMTP id z12so1188040wro.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 09:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MVwoTM+oNpxMQeZ9qdrvF1OSOoAmA57D5M6US4TQgYc=;
 b=KUC0yN6D5mw7Qcidar8HGwR+/yYeakhKFo5e0aJb7KfKTf+8SZEcYcNJVIsISC3RQN
 IraQonnKTzQZAkfYaWEVLfP31PSXdGoacGTAycqCJMVNCmqg10YyCLHOYsxUHixnvtoI
 iQ4RkJ5WrWJQE/m86ErMgMIAvObaJUQu0Eie+563HPhqjgpWOEqM4RfUfACj6k7uzmIY
 BrAbwJwr0gKF4hYEb7PTfOggOmh0xXf9zm2cMm8YwyItISbnKIVaUhPseQfY3LzBqVKq
 kV6XqQF5BfQ4TuEKTz94eIVt3kYUKXzrtcgGazzM2I2VA70tl79EtL6B4be3AOMeMWGd
 NBXA==
X-Gm-Message-State: AOAM530wOu1GST3QOUe7mbqxG1IHwQSChmrgNAGJM/vU3O/rpxKdxH0e
 mPDnhrmYTOtZ1me/LmM+cIhrl2epl4kmWCkGwLBwhiqC3+1c5xaO9m1tY/VtxdBuO3UZp4dqi94
 y+DjU4OQXGfOCBCksgTKRU/3b7MkJAb+CXik33UgqvQ==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr9390153wmb.59.1617898700918;
 Thu, 08 Apr 2021 09:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznx8V1UG8hxbwvTfdtJQbrkNgUurHCGieFo7yI4Yui43O19A5UCKCBISuTd4M8HzuJdreOvw==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr9390097wmb.59.1617898700480;
 Thu, 08 Apr 2021 09:18:20 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id x13sm17830214wrt.71.2021.04.08.09.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 09:18:19 -0700 (PDT)
Date: Thu, 8 Apr 2021 12:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 1/3] virtio: update reset callback to return status
Message-ID: <20210408121708-mutt-send-email-mst@kernel.org>
References: <20210408081109.56537-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210408081109.56537-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, nitzanc@nvidia.com, oren@nvidia.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Apr 08, 2021 at 08:11:07AM +0000, Max Gurtovoy wrote:
> The reset device operation, usually is an operation that might fail from
> various reasons. For example, the controller might be in a bad state and
> can't answer to any request. Usually, the paravirt SW based virtio
> devices always succeed in reset operation but this is not the case for
> HW based virtio devices.

Well it reports the error to callers however
no callers check the return value. So what good is it?
If callers are expected to just proceed then we don't
really need to return a value at all ...

> This commit is also a preparation for adding a timeout mechanism for
> resetting virtio devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
>  - update virtio_ccw.c (Cornelia)
>  - update virtio_uml.c
>  - update mlxbf-tmfifo.c
> 
> ---
>  arch/um/drivers/virtio_uml.c             |  4 +++-
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  4 +++-
>  drivers/remoteproc/remoteproc_virtio.c   |  4 +++-
>  drivers/s390/virtio/virtio_ccw.c         |  9 ++++++---
>  drivers/virtio/virtio.c                  | 22 +++++++++++++++-------
>  drivers/virtio/virtio_mmio.c             |  3 ++-
>  drivers/virtio/virtio_pci_legacy.c       |  4 +++-
>  drivers/virtio/virtio_pci_modern.c       |  3 ++-
>  drivers/virtio/virtio_vdpa.c             |  4 +++-
>  include/linux/virtio_config.h            |  5 +++--
>  10 files changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 91ddf74ca888..b6e66265ed32 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -827,11 +827,13 @@ static void vu_set_status(struct virtio_device *vdev, u8 status)
>  	vu_dev->status = status;
>  }
>  
> -static void vu_reset(struct virtio_device *vdev)
> +static int vu_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
>  
>  	vu_dev->status = 0;
> +
> +	return 0;
>  }
>  
>  static void vu_del_vq(struct virtqueue *vq)
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index bbc4e71a16ff..c192b8ac5d9e 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -980,11 +980,13 @@ static void mlxbf_tmfifo_virtio_set_status(struct virtio_device *vdev,
>  }
>  
>  /* Reset the device. Not much here for now. */
> -static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
> +static int mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
>  {
>  	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
>  
>  	tm_vdev->status = 0;
> +
> +	return 0;
>  }
>  
>  /* Read the value of a configuration field. */
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 0cc617f76068..ca9573c62c3d 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -191,7 +191,7 @@ static void rproc_virtio_set_status(struct virtio_device *vdev, u8 status)
>  	dev_dbg(&vdev->dev, "status: %d\n", status);
>  }
>  
> -static void rproc_virtio_reset(struct virtio_device *vdev)
> +static int rproc_virtio_reset(struct virtio_device *vdev)
>  {
>  	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
>  	struct fw_rsc_vdev *rsc;
> @@ -200,6 +200,8 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>  
>  	rsc->status = 0;
>  	dev_dbg(&vdev->dev, "reset !\n");
> +
> +	return 0;
>  }
>  
>  /* provide the vdev features as retrieved from the firmware */
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 54e686dca6de..52b32555e746 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -732,14 +732,15 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  	return ret;
>  }
>  
> -static void virtio_ccw_reset(struct virtio_device *vdev)
> +static int virtio_ccw_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct ccw1 *ccw;
> +	int ret;
>  
>  	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
>  	if (!ccw)
> -		return;
> +		return -ENOMEM;
>  
>  	/* Zero status bits. */
>  	vcdev->dma_area->status = 0;
> @@ -749,8 +750,10 @@ static void virtio_ccw_reset(struct virtio_device *vdev)
>  	ccw->flags = 0;
>  	ccw->count = 0;
>  	ccw->cda = 0;
> -	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_RESET);
> +	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_RESET);
>  	ccw_device_dma_free(vcdev->cdev, ccw, sizeof(*ccw));
> +
> +	return ret;
>  }
>  
>  static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..ddbfd5b5f3bd 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -338,7 +338,7 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* Assign a unique device index and hence name. */
>  	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
>  	if (err < 0)
> -		goto out;
> +		goto out_err;
>  
>  	dev->index = err;
>  	dev_set_name(&dev->dev, "virtio%u", dev->index);
> @@ -349,7 +349,9 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
> -	dev->config->reset(dev);
> +	err = dev->config->reset(dev);
> +	if (err)
> +		goto out_ida;
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> @@ -362,10 +364,14 @@ int register_virtio_device(struct virtio_device *dev)
>  	 */
>  	err = device_add(&dev->dev);
>  	if (err)
> -		ida_simple_remove(&virtio_index_ida, dev->index);
> -out:
> -	if (err)
> -		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +		goto out_ida;
> +
> +	return 0;
> +
> +out_ida:
> +	ida_simple_remove(&virtio_index_ida, dev->index);
> +out_err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(register_virtio_device);
> @@ -408,7 +414,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
> -	dev->config->reset(dev);
> +	ret = dev->config->reset(dev);
> +	if (ret)
> +		goto err;
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..12b8f048c48d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -256,12 +256,13 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
>  	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
>  }
>  
> -static void vm_reset(struct virtio_device *vdev)
> +static int vm_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +	return 0;
>  }
>  
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..0b5d95e3efa1 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -89,7 +89,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
>  }
>  
> -static void vp_reset(struct virtio_device *vdev)
> +static int vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	/* 0 status means a reset. */
> @@ -99,6 +99,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> +
> +	return 0;
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index fbd4ebc00eb6..cc3412a96a17 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -158,7 +158,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  	vp_modern_set_status(&vp_dev->mdev, status);
>  }
>  
> -static void vp_reset(struct virtio_device *vdev)
> +static int vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> @@ -174,6 +174,7 @@ static void vp_reset(struct virtio_device *vdev)
>  		msleep(1);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> +	return 0;
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e28acf482e0c..5fd4e627a9b0 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -97,11 +97,13 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>  	return ops->set_status(vdpa, status);
>  }
>  
> -static void virtio_vdpa_reset(struct virtio_device *vdev)
> +static int virtio_vdpa_reset(struct virtio_device *vdev)
>  {
>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>  
>  	vdpa_reset(vdpa);
> +
> +	return 0;
>  }
>  
>  static bool virtio_vdpa_notify(struct virtqueue *vq)
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8519b3ae5d52..d2b0f1699a75 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -44,9 +44,10 @@ struct virtio_shm_region {
>   *	status: the new status byte
>   * @reset: reset the device
>   *	vdev: the virtio device
> - *	After this, status and feature negotiation must be done again
> + *	Upon success, status and feature negotiation must be done again
>   *	Device must not be reset from its vq/config callbacks, or in
>   *	parallel with being added/removed.
> + *	Returns 0 on success or error status.
>   * @find_vqs: find virtqueues and instantiate them.
>   *	vdev: the virtio_device
>   *	nvqs: the number of virtqueues to find
> @@ -82,7 +83,7 @@ struct virtio_config_ops {
>  	u32 (*generation)(struct virtio_device *vdev);
>  	u8 (*get_status)(struct virtio_device *vdev);
>  	void (*set_status)(struct virtio_device *vdev, u8 status);
> -	void (*reset)(struct virtio_device *vdev);
> +	int (*reset)(struct virtio_device *vdev);
>  	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  			const char * const names[], const bool *ctx,
> -- 
> 2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
