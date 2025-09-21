Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0453363
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491586; cv=none; b=WRwMclqvYeKTRqGqKGfuEhfa/AmkZtc1o9GhKOQtTyLwIf2MBml5OUqZ8PCgHlIknuglvFFNN7LF/2SVOFW1W9vcCM7GKGUIhpYrM+slTTlcLweMfkUA5/gDkn8evFJjpRPBkGdu6zmPMLIaX4CosvRuFNbRqJmRTxYyy75KcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491586; c=relaxed/simple;
	bh=7gDBK/sxHAPC9g1Qd2iiEtrL0ip72Q0hLpe7VGa8lh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Aa5x8xEcaqNCp7AmPY1CKwpF9S+CevyyF5iXKRebkBPGQPKcfRDJlEbbeUSDAC7uT81WSjzAImMN1NuzPsedTIxTxNbGVkkpwKL68sdaVwnymvsr1Bn6XbboV83AKiL2pOgvkKlflSiGZCgEUg3vY8S6n6NVeIRHRX4ZiHZjkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhXsp7mx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhXsp7mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758491583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcKvA7u1IVRddU6A8Lgq8eQ28KV9wZQaC1W8gdDHFHY=;
	b=fhXsp7mxIe3w9zaby9pXZdqdNt2BWWVx7IUwjfVU2HXDcfXVwQkdNlWSb9qGhzdi+EN5Rv
	2/wzwAOGGsfs4vC10+yuW4bbVUfCmhE08WySwLNdNDdccVtl/YKfiCqPqpHkuun8eARhgt
	QW0uw3Y1nQ4XzyIVcMWPBnQAQ24Zx+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-6VL74CFHOxiB9ABY41l6Cw-1; Sun, 21 Sep 2025 17:53:02 -0400
X-MC-Unique: 6VL74CFHOxiB9ABY41l6Cw-1
X-Mimecast-MFC-AGG-ID: 6VL74CFHOxiB9ABY41l6Cw_1758491581
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b227bbf65so9121645e9.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 14:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491581; x=1759096381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcKvA7u1IVRddU6A8Lgq8eQ28KV9wZQaC1W8gdDHFHY=;
        b=hW9VXqiKfojiWNAIP7JA30dwWu481DOzCGedsPWLZHcljIDDsjK+59NwDhPvRxC3nw
         uC+F3v89d0Y5GC38CFGW0IpZ8JVizE064PZ1W00J8+6XLGmvvQRCVuw3HiNtyaNGoUxZ
         naM0aViM4gR06yWXHx6gpwlEdDr7qg4AOWBWLR0ToZA2Yj1k0BqI/2LyCuqRBi/PK0M+
         CiFCzqQ0RF/h61H9LT53jbJN9Eu6ALOW0cjpFt2/09xFsesJcSrxaRrL0v/aZskJ8qXH
         2GpRMg6e2O/p6r/JZUE94cAeGC/FZ84QDyrZUP1q7VG6aA7oVAbSt7xzq2IyFnHl91dn
         O3xA==
X-Forwarded-Encrypted: i=1; AJvYcCX5cVj3u2m7tu07ZLmmGsOl8bOvCOZk0dUXDOyNOSVrnmZu6KC5J2CvTaq4vZH6+gmTYl9iMeVE2mEV0H1FNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0N0byFv+CW7A/7aZpzSn0Ji8PkEBQvePC36YnF8uzzvByRDpz
	QN6Hz5p09fTibvDEArGjaAl8qn3NIv7t1jaM88QkSL/vhxj5KvfPW3obUTQtu0N+QWocsHdRR5o
	7plmCMuZr0RFXof47zOQJdtJvgFlyYrmqOt8R8v80a7hvs5wCd5bTK9t+5N4WJvsLXzlD
X-Gm-Gg: ASbGncsmiS5bJt9QIZfXXlmEtBEh1zDGXfwTf6oVWppJP1AQf9WNbgyLrt0evWuet8Q
	mHNFS1dcuFi4GnPGNkS0Lb4u83XMvlRJIwoGdUwgZYEtO9yvz5G5RH8dUuWtppFEO7URES3Kwx2
	/M9Tu0Srh9IHTysWew9EV/V8PlSCVbnPPM4cBVGnl3tdE1//YIvCzuNooY5qm1y/m+gtmCZGgVI
	SKYO9BTmzghRpQR1oJ9rdMyGIzyCbOu2p2b9hz6uKWTFlZLhE/6cEa2RUBXvnMiIQjPPZfw3LLS
	z6CAwm7JldUD4OiQw6bEy6Lr6+aT8373Pbc=
X-Received: by 2002:a05:600c:1f85:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-467ec45ff4amr86557595e9.36.1758491580660;
        Sun, 21 Sep 2025 14:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKCDsmMvMU4fXj2nCCXV7OjJgVEAJCplUWRNphRHTfWpaJxzAkg1yyJt0qMCeaw2BitIKi6A==
X-Received: by 2002:a05:600c:1f85:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-467ec45ff4amr86557435e9.36.1758491580227;
        Sun, 21 Sep 2025 14:53:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm12218628f8f.40.2025.09.21.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:52:59 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:52:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 8/9] vdpa: introduce map ops
Message-ID: <20250921175040-mutt-send-email-mst@kernel.org>
References: <20250821064641.5025-1-jasowang@redhat.com>
 <20250821064641.5025-9-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250821064641.5025-9-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wCTLBRF_G_02Q-3fLPp6SCeQC6NlvyhMndGLquuJ7L8_1758491581
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2025 at 02:46:40PM +0800, Jason Wang wrote:
> Virtio core allows the transport to provide device or transport
> specific mapping functions. This patch adds this support to vDPA. We
> can simply do this by allowing the vDPA parent to register a
> virtio_map_ops.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c          |  3 ++-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  3 ++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++--
>  drivers/vdpa/pds/vdpa_dev.c              |  3 ++-
>  drivers/vdpa/solidrun/snet_main.c        |  4 ++--
>  drivers/vdpa/vdpa.c                      |  3 +++
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 ++-
>  drivers/virtio/virtio_vdpa.c             |  4 +++-
>  include/linux/vdpa.h                     | 10 +++++++---
>  12 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 54aea086d08c..e476504db0c8 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -478,7 +478,8 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  
>  	eni_vdpa = vdpa_alloc_device(struct eni_vdpa, vdpa,
> -				     dev, &eni_vdpa_ops, 1, 1, NULL, false);
> +				     dev, &eni_vdpa_ops, NULL,
> +				     1, 1, NULL, false);
>  	if (IS_ERR(eni_vdpa)) {
>  		ENI_ERR(pdev, "failed to allocate vDPA structure\n");
>  		return PTR_ERR(eni_vdpa);
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 979d188d74ee..6658dc74d915 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -705,7 +705,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	vf = &ifcvf_mgmt_dev->vf;
>  	pdev = vf->pdev;
>  	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -				    &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL, false);
> +				    &pdev->dev, &ifc_vdpa_ops,
> +				    NULL, 1, 1, NULL, false);
>  	if (IS_ERR(adapter)) {
>  		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>  		return PTR_ERR(adapter);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index a7e76f175914..82034efb74fc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3882,7 +3882,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	}
>  
>  	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
> -				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
> +				 NULL, MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
>  	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index 5818dae133a3..9e8d07078606 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -508,8 +508,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	u64 device_features;
>  	int ret;
>  
> -	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops, 1, 1,
> -				     NULL, false);
> +	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops,
> +				     NULL, 1, 1, NULL, false);
>  	if (IS_ERR(oct_vdpa)) {
>  		dev_err(&pdev->dev, "Failed to allocate vDPA structure for octep vdpa device");
>  		return PTR_ERR(oct_vdpa);
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 63d82263fb52..36f61cc96e21 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -632,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	}
>  
>  	pdsv = vdpa_alloc_device(struct pds_vdpa_device, vdpa_dev,
> -				 dev, &pds_vdpa_ops, 1, 1, name, false);
> +				 dev, &pds_vdpa_ops, NULL,
> +				 1, 1, name, false);
>  	if (IS_ERR(pdsv)) {
>  		dev_err(dev, "Failed to allocate vDPA structure: %pe\n", pdsv);
>  		return PTR_ERR(pdsv);
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 39050aab147f..4588211d57eb 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -1008,8 +1008,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
>  	}
>  
>  	/* Allocate vdpa device */
> -	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
> -				 false);
> +	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops,
> +				 NULL, 1, 1, NULL, false);
>  	if (!snet) {
>  		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c71debeb8471..ec4cb0162849 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
>   * initialized but before registered.
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map opeartions that is supported by this device

operations

>   * @ngroups: number of groups supported by this device
>   * @nas: number of address spaces supported by this device
>   * @size: size of the parent structure that contains private data
> @@ -156,6 +157,7 @@ static void vdpa_release_dev(struct device *d)
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> +					const struct virtio_map_ops *map,
>  					unsigned int ngroups, unsigned int nas,
>  					size_t size, const char *name,
>  					bool use_va)
> @@ -187,6 +189,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	vdev->dev.release = vdpa_release_dev;
>  	vdev->index = err;
>  	vdev->config = config;
> +	vdev->map = map;
>  	vdev->features_valid = false;
>  	vdev->use_va = use_va;
>  	vdev->ngroups = ngroups;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 22ee53538444..c1c6431950e1 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -215,7 +215,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>  	else
>  		ops = &vdpasim_config_ops;
>  
> -	vdpa = __vdpa_alloc_device(NULL, ops,
> +	vdpa = __vdpa_alloc_device(NULL, ops, NULL,
>  				   dev_attr->ngroups, dev_attr->nas,
>  				   dev_attr->alloc_size,
>  				   dev_attr->name, use_va);
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f68ed569394c..ad782d20a8ed 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2009,7 +2009,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  		return -EEXIST;
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -				 &vduse_vdpa_config_ops, 1, 1, name, true);
> +				 &vduse_vdpa_config_ops, NULL,
> +				 1, 1, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
>  
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 242641c0f2bd..17a19a728c9c 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -511,7 +511,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	int ret, i;
>  
>  	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> +				    dev, &vp_vdpa_ops, NULL,
> +				    1, 1, name, false);
>  
>  	if (IS_ERR(vp_vdpa)) {
>  		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 8b27c6e8eebb..2464fa655f09 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -466,9 +466,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
>  	if (!vd_dev)
>  		return -ENOMEM;
>  
> -	vd_dev->vdev.dev.parent = vdpa_get_map(vdpa).dma_dev;
> +	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
> +				  vdpa_get_map(vdpa).dma_dev;
>  	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
>  	vd_dev->vdev.config = &virtio_vdpa_config_ops;
> +	vd_dev->vdev.map = vdpa->map;
>  	vd_dev->vdpa = vdpa;
>  
>  	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index ae0451945851..4cf21d6e9cfd 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -76,6 +76,7 @@ struct vdpa_mgmt_dev;
>   *                   because core frees it; use driver_set_override() to
>   *                   set or clear it.
>   * @config: the configuration ops for this device.
> + * @map: the map ops for this device
>   * @cf_lock: Protects get and set access to configuration layout.
>   * @index: device index
>   * @features_valid: were features initialized? for legacy guests
> @@ -91,6 +92,7 @@ struct vdpa_device {
>  	union virtio_map vmap;
>  	const char *driver_override;
>  	const struct vdpa_config_ops *config;
> +	const struct virtio_map_ops *map;
>  	struct rw_semaphore cf_lock; /* Protects get/set config */
>  	unsigned int index;
>  	bool features_valid;
> @@ -447,6 +449,7 @@ struct vdpa_config_ops {
>  
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> +					const struct virtio_map_ops *map,
>  					unsigned int ngroups, unsigned int nas,
>  					size_t size, const char *name,
>  					bool use_va);
> @@ -458,6 +461,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   * @member: the name of struct vdpa_device within the @dev_struct
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map operations that is supported by this device
>   * @ngroups: the number of virtqueue groups supported by this device
>   * @nas: the number of address spaces
>   * @name: name of the vdpa device
> @@ -465,10 +469,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   *
>   * Return allocated data structure or ERR_PTR upon error
>   */
> -#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, nas, \
> -			  name, use_va) \
> +#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
> +			  ngroups, nas, name, use_va)		   \
>  			  container_of((__vdpa_alloc_device( \
> -				       parent, config, ngroups, nas, \
> +				       parent, config, map, ngroups, nas, \
>  				       (sizeof(dev_struct) + \
>  				       BUILD_BUG_ON_ZERO(offsetof( \
>  				       dev_struct, member))), name, use_va)), \
> -- 
> 2.31.1

