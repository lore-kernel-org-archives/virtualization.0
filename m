Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1689DC4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 14:30:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AFF22B2E
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AFF22B2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE7AF2E2F9;
	Fri,  4 Dec 2020 14:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hgUcUfCPufae; Fri,  4 Dec 2020 14:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47DE52E2F5;
	Fri,  4 Dec 2020 14:30:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23CBFC0FA8;
	Fri,  4 Dec 2020 14:30:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0CD0C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 14:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D1C898835D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 14:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RoZStTvHiLJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 14:30:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 81B6888372
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607092225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYtWzmxXW6p6TC0ZIb/TrsYV07jgBGeTTEO3fKTwfek=;
 b=CjGwDfvz9Y5OKuZH5XE9uxs1WrmVivB3hPb9i7k2CMPgr16DFfq9EtHLNGVPkzx7ABajSt
 tliN86DJiQcrImD5JvJQBY7u5G68ou2JwHQ1Vd/KjjIDxkz4NPjZVzji6jn9eY+2QcZx3Z
 DsZr+PGgDth4h46IxFP11kayqpO4txo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-yH-IEGBIPd6mTUoroaAGAQ-1; Fri, 04 Dec 2020 09:30:21 -0500
X-MC-Unique: yH-IEGBIPd6mTUoroaAGAQ-1
Received: by mail-wm1-f69.google.com with SMTP id q17so2005108wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Dec 2020 06:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NYtWzmxXW6p6TC0ZIb/TrsYV07jgBGeTTEO3fKTwfek=;
 b=Rbh+0rq0i08JUGpaTb5cP7rxkmyx0+mKay0a8fO4dmyt3xivUopYRw+OSJJaksju6a
 2Hg6ZSA+54ZcXbveT4N8IDi46sdP0XMXRm5AsDbJHY2WdStjWXUyEJ8d3ueVzmbmAQhF
 b6TIQGSyyG69h+hRLN3QmfOup9suYgbjFscP9HVx4A+F8hH2pA/Kgo9gCrqCh7Sjx47X
 mGfPObOhDussRPvRBijlWfkJhr3AVkzz9/LtmsxttIH9sx7+IJIu1KHfMPE5XYfPF+eh
 rbLXJCzxXQarqkJSRwcpU7rJliVEkBAIWbEATsHwdOpB4+bCW+Dq5FsWp5ks9T8ybATx
 QLwg==
X-Gm-Message-State: AOAM530A52hQ+os2QWpljcF/+Xl4gU8n9zPuevMM0wU6He1joEmClAEY
 b3qMnbp9818VCPpPL1T9fkZkJzwMpcji7o95LE0gK3YmDH6qzhuLf+C5hNdxaWl+Vj9dLM8ynrT
 DS5G6yg1XtqbVyq3zNg8jHxSVO2ZCXSLchF2u6IB95g==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1652569wrw.73.1607092220027; 
 Fri, 04 Dec 2020 06:30:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2IxOGe5/0uKbL3ffpg7oxTX+R4a0BhPUCp84b6RFm7CwcJDLyBWh2JM9Ikj/r9Hznj5g7yA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1652539wrw.73.1607092219716; 
 Fri, 04 Dec 2020 06:30:19 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id h204sm3563439wme.17.2020.12.04.06.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 06:30:19 -0800 (PST)
Date: Fri, 4 Dec 2020 15:30:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 17/19] vdpa: set the virtqueue num during register
Message-ID: <20201204143016.xdjptprvtuthcebg@steredhat>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-18-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201204040353.21679-18-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 04, 2020 at 12:03:51PM +0800, Jason Wang wrote:
>This patch delay the queue number setting to vDPA device
>registering. This allows us to probe the virtqueue numbers between
>device allocation and registering.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c   | 5 ++---
> drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++---
> drivers/vdpa/vdpa.c               | 8 ++++----
> drivers/vdpa/vdpa_sim/vdpa_sim.c  | 4 ++--
> include/linux/vdpa.h              | 7 +++----
> 5 files changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 8b4028556cb6..d65f3221d8ed 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -438,8 +438,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	}
>
> 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
>-				    dev, &ifc_vdpa_ops,
>-				    IFCVF_MAX_QUEUE_PAIRS * 2);
>+				    dev, &ifc_vdpa_ops);
> 	if (adapter == NULL) {
> 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
> 		return -ENOMEM;
>@@ -463,7 +462,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
> 		vf->vring[i].irq = -EINVAL;
>
>-	ret = vdpa_register_device(&adapter->vdpa);
>+	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
> 	if (ret) {
> 		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
> 		goto err;
>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>index 1fa6fcac8299..3c3eb2a02f76 100644
>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>@@ -1940,8 +1940,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> 	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>
>-	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>-				 2 * mlx5_vdpa_max_qps(max_vqs));
>+	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops);
> 	if (IS_ERR(ndev))
> 		return ndev;
>
>@@ -1968,7 +1967,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> 	if (err)
> 		goto err_res;
>
>-	err = vdpa_register_device(&mvdev->vdev);
>+	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> 	if (err)
> 		goto err_reg;
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index a69ffc991e13..ba89238f9898 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -61,7 +61,6 @@ static void vdpa_release_dev(struct device *d)
>  * initialized but before registered.
>  * @parent: the parent device
>  * @config: the bus operations that is supported by this device
>- * @nvqs: number of virtqueues supported by this device
>  * @size: size of the parent structure that contains private data
>  *
>  * Driver should use vdpa_alloc_device() wrapper macro instead of
>@@ -72,7 +71,6 @@ static void vdpa_release_dev(struct device *d)
>  */
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs,
> 					size_t size)
> {
> 	struct vdpa_device *vdev;
>@@ -99,7 +97,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 	vdev->index = err;
> 	vdev->config = config;
> 	vdev->features_valid = false;
>-	vdev->nvqs = nvqs;
>
> 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
> 	if (err)
>@@ -122,11 +119,14 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
>  * vdpa_register_device - register a vDPA device
>  * Callers must have a succeed call of vdpa_alloc_device() before.
>  * @vdev: the vdpa device to be registered to vDPA bus
>+ * @nvqs: number of virtqueues supported by this device
>  *
>  * Returns an error when fail to add to vDPA bus
>  */
>-int vdpa_register_device(struct vdpa_device *vdev)
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> {
>+	vdev->nvqs = nvqs;
>+
> 	return device_add(&vdev->dev);
> }
> EXPORT_SYMBOL_GPL(vdpa_register_device);
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 6a90fdb9cbfc..b129cb4dd013 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
> 	else
> 		ops = &vdpasim_net_config_ops;
>
>-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
>+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
> 	if (!vdpasim)
> 		goto err_alloc;
>
>@@ -393,7 +393,7 @@ static struct vdpasim *vdpasim_create(void)
> 	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>
> 	vdpasim->vdpa.dma_dev = dev;
>-	ret = vdpa_register_device(&vdpasim->vdpa);
>+	ret = vdpa_register_device(&vdpasim->vdpa, VDPASIM_VQ_NUM);
> 	if (ret)
> 		goto err_iommu;
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 30bc7a7223bb..d9e9d17b9083 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -244,18 +244,17 @@ struct vdpa_config_ops {
>
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs,
> 					size_t size);
>
>-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
>+#define vdpa_alloc_device(dev_struct, member, parent, config)   \
> 			  container_of(__vdpa_alloc_device( \
>-				       parent, config, nvqs, \
>+				       parent, config, \
> 				       sizeof(dev_struct) + \
> 				       BUILD_BUG_ON_ZERO(offsetof( \
> 				       dev_struct, member))), \
> 				       dev_struct, member)
>
>-int vdpa_register_device(struct vdpa_device *vdev);
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> void vdpa_unregister_device(struct vdpa_device *vdev);
>
> /**
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
