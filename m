Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EBC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:27:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED2D650E8
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED2D650E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3D0287361;
	Fri,  5 Feb 2021 15:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jD08+gTRvqg; Fri,  5 Feb 2021 15:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA4B68734A;
	Fri,  5 Feb 2021 15:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C10CAC08A1;
	Fri,  5 Feb 2021 15:27:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E82EC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 63682872BD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dglpAW8psKxL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:27:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7767B87277
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612538841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkJ85pmPT0jRY9KVUggOoEd97lIiayLDWBOxGNlCN5o=;
 b=ad+WSEfJ74Gv1UbZfITfUuUwp4v/mN3Zp8BS7zBNWMemaqjla/NZGtNGKJn6JUOIevE/13
 K7mXjpyuBomnifiJOZwrkDMLSITmfqtcwxTXU5EOuDY3Uri3lgDaJqjKWo5PWK39lsAnyx
 tc2J7hGeOzfxs7I7eZFhvSAeSEC7e6U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-l8Xrm5H_PjyAMYZPI3gqYg-1; Fri, 05 Feb 2021 10:27:19 -0500
X-MC-Unique: l8Xrm5H_PjyAMYZPI3gqYg-1
Received: by mail-ej1-f69.google.com with SMTP id jg11so6988592ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 07:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lkJ85pmPT0jRY9KVUggOoEd97lIiayLDWBOxGNlCN5o=;
 b=qxKN1CloZr4c6gdUq3i84y51+hskqaIGwf5a/Pw4+f7ZYKnCZzMs9Ige40G73uPcVZ
 gNoo7qwwAMQEeP2pHVZCC5uLWz7pTxbbAIPkQjGKU6PJESfdMbw09X+OYHC6Blzr+HEz
 VEcNEgycGl7Y2JbybLdf0g+RMxd/4TrGIwGcgAjAPdgOuBgVl7FOZrGXzIMgVJ90kei8
 wxQKA2RjJdU0Nb10lnlIppfCcUa3Phb2W2N5eQ12mXtCgJpHI/sg3pgOoKKSTSrkZ3zb
 SPONEjb+sMOVoJ9L7IRXvD3L/CuRI7dw6UlkgfF8GYxYmLNTLCQ0tameEergz58fCeb5
 BDpg==
X-Gm-Message-State: AOAM530Jii1Jtf/4fm2NOTNQt8KncaPrWapc2ojDuO+kxofb2RywvsXP
 Og5g+cNi/QJCYvhvMbaWZ/WbOcFcdhObd0w0E5CMn9AdQQnPUd8G1hC5UI7e/F+/4/BrnkAJGGa
 5EL7frcTuXOOsX5HcNULwDrejdqQARKzqijNOUKAGrw==
X-Received: by 2002:aa7:da98:: with SMTP id q24mr3996647eds.370.1612538838293; 
 Fri, 05 Feb 2021 07:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz14kFXujPV+m0BMsIR9hKeSD8G6x+1pbVrCCMu6Pop+DPMTWoaAYbxIZyrBhCwOuOslafp1Q==
X-Received: by 2002:aa7:da98:: with SMTP id q24mr3996627eds.370.1612538838134; 
 Fri, 05 Feb 2021 07:27:18 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id u17sm4059550ejr.59.2021.02.05.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 07:27:17 -0800 (PST)
Date: Fri, 5 Feb 2021 10:27:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 17/19] vdpa: set the virtqueue num during register
Message-ID: <20210205102552-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-18-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210104065503.199631-18-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jan 04, 2021 at 02:55:01PM +0800, Jason Wang wrote:
> This patch delay the queue number setting to vDPA device
> registering. This allows us to probe the virtqueue numbers between
> device allocation and registering.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Conflicts with other patches in the vhost tree.
Can you rebase please?

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c   | 5 ++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++---
>  drivers/vdpa/vdpa.c               | 8 ++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 4 ++--
>  include/linux/vdpa.h              | 7 +++----
>  5 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 8b4028556cb6..d65f3221d8ed 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -438,8 +438,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -				    dev, &ifc_vdpa_ops,
> -				    IFCVF_MAX_QUEUE_PAIRS * 2);
> +				    dev, &ifc_vdpa_ops);
>  	if (adapter == NULL) {
>  		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>  		return -ENOMEM;
> @@ -463,7 +462,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
>  		vf->vring[i].irq = -EINVAL;
>  
> -	ret = vdpa_register_device(&adapter->vdpa);
> +	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
>  	if (ret) {
>  		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
>  		goto err;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f1d54814db97..a1b9260bf04d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1958,8 +1958,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>  	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>  
> -	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> -				 2 * mlx5_vdpa_max_qps(max_vqs));
> +	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops);
>  	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
> @@ -1986,7 +1985,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	if (err)
>  		goto err_res;
>  
> -	err = vdpa_register_device(&mvdev->vdev);
> +	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
>  	if (err)
>  		goto err_reg;
>  
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a69ffc991e13..ba89238f9898 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -61,7 +61,6 @@ static void vdpa_release_dev(struct device *d)
>   * initialized but before registered.
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> - * @nvqs: number of virtqueues supported by this device
>   * @size: size of the parent structure that contains private data
>   *
>   * Driver should use vdpa_alloc_device() wrapper macro instead of
> @@ -72,7 +71,6 @@ static void vdpa_release_dev(struct device *d)
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> -					int nvqs,
>  					size_t size)
>  {
>  	struct vdpa_device *vdev;
> @@ -99,7 +97,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	vdev->index = err;
>  	vdev->config = config;
>  	vdev->features_valid = false;
> -	vdev->nvqs = nvqs;
>  
>  	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
>  	if (err)
> @@ -122,11 +119,14 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
>   * vdpa_register_device - register a vDPA device
>   * Callers must have a succeed call of vdpa_alloc_device() before.
>   * @vdev: the vdpa device to be registered to vDPA bus
> + * @nvqs: number of virtqueues supported by this device
>   *
>   * Returns an error when fail to add to vDPA bus
>   */
> -int vdpa_register_device(struct vdpa_device *vdev)
> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
>  {
> +	vdev->nvqs = nvqs;
> +
>  	return device_add(&vdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_register_device);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..b129cb4dd013 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
>  	else
>  		ops = &vdpasim_net_config_ops;
>  
> -	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
> +	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
>  	if (!vdpasim)
>  		goto err_alloc;
>  
> @@ -393,7 +393,7 @@ static struct vdpasim *vdpasim_create(void)
>  	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>  
>  	vdpasim->vdpa.dma_dev = dev;
> -	ret = vdpa_register_device(&vdpasim->vdpa);
> +	ret = vdpa_register_device(&vdpasim->vdpa, VDPASIM_VQ_NUM);
>  	if (ret)
>  		goto err_iommu;
>  
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 30bc7a7223bb..d9e9d17b9083 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -244,18 +244,17 @@ struct vdpa_config_ops {
>  
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> -					int nvqs,
>  					size_t size);
>  
> -#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
> +#define vdpa_alloc_device(dev_struct, member, parent, config)   \
>  			  container_of(__vdpa_alloc_device( \
> -				       parent, config, nvqs, \
> +				       parent, config, \
>  				       sizeof(dev_struct) + \
>  				       BUILD_BUG_ON_ZERO(offsetof( \
>  				       dev_struct, member))), \
>  				       dev_struct, member)
>  
> -int vdpa_register_device(struct vdpa_device *vdev);
> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
>  void vdpa_unregister_device(struct vdpa_device *vdev);
>  
>  /**
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
