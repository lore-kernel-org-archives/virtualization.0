Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DAE71072
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 13:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F20240902;
	Thu, 21 Sep 2023 13:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F20240902
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TsE1JiNU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCFnYKmENtoq; Thu, 21 Sep 2023 13:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D7DF40929;
	Thu, 21 Sep 2023 13:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D7DF40929
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1B86C0039;
	Thu, 21 Sep 2023 13:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2771AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E186160DC6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E186160DC6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TsE1JiNU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUYH3RlfFPfQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:58:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A70060D7B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A70060D7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695304682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1Dy+qxUIsvP08PXthETRtICNDaWynbQea+1pitxzmk=;
 b=TsE1JiNU4NixHL72YuiaV/s2Xf2Kqp13vFbAWd5LfJvXTBrKueWqFHq5aLt744mn2ExMem
 6I9EtwZBXXWJTNpvgjB+MqOA/3OlJjsa2IGK8t/++L6CjxwpU9qWYaRb0i5cIqXk4ipFpt
 U/cjUN3WR9r5pG6ZI81MGZXrCG9zfqw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-L_dIIKNfNwWARQMfmp5jyw-1; Thu, 21 Sep 2023 09:57:59 -0400
X-MC-Unique: L_dIIKNfNwWARQMfmp5jyw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso45777166b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 06:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695304678; x=1695909478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1Dy+qxUIsvP08PXthETRtICNDaWynbQea+1pitxzmk=;
 b=s8CbV1cGnv9T4fcsSZoKyoelAkbhQUIjoZiaW4UzUxNHutjah4yxYJwqQftbDJq3KU
 yEe436+yvsk6pHm6dv1jEnWtlmQPnGaC3Ap5z+uvZKpB0y1llAQsMEL+aDkGs+Sxt5D1
 /9WhIMqh8mbFMUAafaPrU3Y5/4zA0FtAO6JEtcYCSpHQscAjuH/q56fwaX3msy+g6c5I
 Ir3G01oz90EqVV/FX+T+dkoWYPmY8r3zJj6gEj1ER6Wx3vuBscoWe9HtKFUDHe/uw7+/
 WbklfIRkFnN5rMxziwvXY3Yj2uGgdhiVHSrkt2Rpu4rgT1ye27WgPLpxGGGuVEtII/kn
 +FPQ==
X-Gm-Message-State: AOJu0YyBn3P4eHwxRd9KcBilljVUemAIgkV/tZRHCE2thGM2URFLrB1r
 lGk41kEehXiAvYqCqoazan0uD1O8VUvnMAtLSg2it8cqY/ws9ITO9YNAnZ5MqlUWz8JdBMPQvT/
 hnaiqjdeW94doz8JI0b0aqnjFRd+SBaFgkb807hyoMg==
X-Received: by 2002:a17:906:8a64:b0:9a1:a916:17c0 with SMTP id
 hy4-20020a1709068a6400b009a1a91617c0mr5241979ejc.50.1695304677813; 
 Thu, 21 Sep 2023 06:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdCvL5opRJK3mVyxGjNUls7MWSFIqctHRj7hOXwFR3APXpu3I0EzJPrqa/eC6hDBdHcMTVAQ==
X-Received: by 2002:a17:906:8a64:b0:9a1:a916:17c0 with SMTP id
 hy4-20020a1709068a6400b009a1a91617c0mr5241955ejc.50.1695304677409; 
 Thu, 21 Sep 2023 06:57:57 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 rp13-20020a170906d96d00b009ada9f7217asm1095930ejb.88.2023.09.21.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:57:56 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:57:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 03/11] virtio-pci: Introduce admin virtqueue
Message-ID: <20230921095216-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-4-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921124040.145386-4-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:40:32PM +0300, Yishai Hadas wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> Introduce support for the admin virtqueue. By negotiating
> VIRTIO_F_ADMIN_VQ feature, driver detects capability and creates one
> administration virtqueue. Administration virtqueue implementation in
> virtio pci generic layer, enables multiple types of upper layer
> drivers such as vfio, net, blk to utilize it.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio.c                | 37 +++++++++++++--
>  drivers/virtio/virtio_pci_common.h     | 15 +++++-
>  drivers/virtio/virtio_pci_modern.c     | 10 +++-
>  drivers/virtio/virtio_pci_modern_avq.c | 65 ++++++++++++++++++++++++++

if you have a .c file without a .h file you know there's something
fishy. Just add this inside drivers/virtio/virtio_pci_modern.c ?

>  include/linux/virtio_config.h          |  4 ++
>  include/linux/virtio_pci_modern.h      |  3 ++
>  7 files changed, 129 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/virtio/virtio_pci_modern_avq.c
> 
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 8e98d24917cc..dcc535b5b4d9 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> +virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o virtio_pci_modern_avq.o
>  virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb26..f4080692b351 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
>  	if (err)
>  		goto err;
>  
> +	if (dev->config->create_avq) {
> +		err = dev->config->create_avq(dev);
> +		if (err)
> +			goto err;
> +	}
> +
>  	err = drv->probe(dev);
>  	if (err)
> -		goto err;
> +		goto err_probe;
>  
>  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
>  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> @@ -316,6 +322,10 @@ static int virtio_dev_probe(struct device *_d)
>  	virtio_config_enable(dev);
>  
>  	return 0;
> +
> +err_probe:
> +	if (dev->config->destroy_avq)
> +		dev->config->destroy_avq(dev);
>  err:
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
> @@ -331,6 +341,9 @@ static void virtio_dev_remove(struct device *_d)
>  
>  	drv->remove(dev);
>  
> +	if (dev->config->destroy_avq)
> +		dev->config->destroy_avq(dev);
> +
>  	/* Driver should have reset device. */
>  	WARN_ON_ONCE(dev->config->get_status(dev));
>  
> @@ -489,13 +502,20 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
>  int virtio_device_freeze(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
>  
>  	virtio_config_disable(dev);
>  
>  	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
>  
> -	if (drv && drv->freeze)
> -		return drv->freeze(dev);
> +	if (drv && drv->freeze) {
> +		ret = drv->freeze(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (dev->config->destroy_avq)
> +		dev->config->destroy_avq(dev);
>  
>  	return 0;
>  }
> @@ -532,10 +552,16 @@ int virtio_device_restore(struct virtio_device *dev)
>  	if (ret)
>  		goto err;
>  
> +	if (dev->config->create_avq) {
> +		ret = dev->config->create_avq(dev);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	if (drv->restore) {
>  		ret = drv->restore(dev);
>  		if (ret)
> -			goto err;
> +			goto err_restore;
>  	}
>  
>  	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> @@ -546,6 +572,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  
>  	return 0;
>  
> +err_restore:
> +	if (dev->config->destroy_avq)
> +		dev->config->destroy_avq(dev);
>  err:
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return ret;
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 602021967aaa..9bffa95274b6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -41,6 +41,14 @@ struct virtio_pci_vq_info {
>  	unsigned int msix_vector;
>  };
>  
> +struct virtio_avq {

admin_vq would be better. and this is pci specific yes? so virtio_pci_

> +	/* Virtqueue info associated with this admin queue. */
> +	struct virtio_pci_vq_info info;
> +	/* Name of the admin queue: avq.$index. */
> +	char name[10];
> +	u16 vq_index;
> +};
> +
>  /* Our device structure */
>  struct virtio_pci_device {
>  	struct virtio_device vdev;
> @@ -58,10 +66,13 @@ struct virtio_pci_device {
>  	spinlock_t lock;
>  	struct list_head virtqueues;
>  
> -	/* array of all queues for house-keeping */
> +	/* Array of all virtqueues reported in the
> +	 * PCI common config num_queues field
> +	 */
>  	struct virtio_pci_vq_info **vqs;
>  	u32 nvqs;
>  
> +	struct virtio_avq *admin;

and this could be thinkably admin_vq.

>  	/* MSI-X support */
>  	int msix_enabled;
>  	int intx_enabled;
> @@ -115,6 +126,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		const char * const names[], const bool *ctx,
>  		struct irq_affinity *desc);
>  const char *vp_bus_name(struct virtio_device *vdev);
> +void vp_destroy_avq(struct virtio_device *vdev);
> +int vp_create_avq(struct virtio_device *vdev);
>  
>  /* Setup the affinity for a virtqueue:
>   * - force the affinity for per vq vector
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..a72c87687196 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -37,6 +37,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  
>  	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
>  		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> +
> +	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
> +		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
>  }
>  
>  /* virtio config->finalize_features() implementation */
> @@ -317,7 +320,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	else
>  		notify = vp_notify;
>  
> -	if (index >= vp_modern_get_num_queues(mdev))
> +	if (!((index < vp_modern_get_num_queues(mdev) ||
> +	      (vp_dev->admin && vp_dev->admin->vq_index == index))))
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Check if queue is either not available or already active. */
> @@ -509,6 +513,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.create_avq = vp_create_avq,
> +	.destroy_avq = vp_destroy_avq,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -529,6 +535,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.create_avq = vp_create_avq,
> +	.destroy_avq = vp_destroy_avq,
>  };
>  
>  /* the PCI probing function */
> diff --git a/drivers/virtio/virtio_pci_modern_avq.c b/drivers/virtio/virtio_pci_modern_avq.c
> new file mode 100644
> index 000000000000..114579ad788f
> --- /dev/null
> +++ b/drivers/virtio/virtio_pci_modern_avq.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/virtio.h>
> +#include "virtio_pci_common.h"
> +
> +static u16 vp_modern_avq_num(struct virtio_pci_modern_device *mdev)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +	return vp_ioread16(&cfg->admin_queue_num);
> +}
> +
> +static u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +	return vp_ioread16(&cfg->admin_queue_index);
> +}
> +
> +int vp_create_avq(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_avq *avq;
> +	struct virtqueue *vq;
> +	u16 admin_q_num;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> +		return 0;
> +
> +	admin_q_num = vp_modern_avq_num(&vp_dev->mdev);
> +	if (!admin_q_num)
> +		return -EINVAL;
> +
> +	vp_dev->admin = kzalloc(sizeof(*vp_dev->admin), GFP_KERNEL);
> +	if (!vp_dev->admin)
> +		return -ENOMEM;
> +
> +	avq = vp_dev->admin;
> +	avq->vq_index = vp_modern_avq_index(&vp_dev->mdev);
> +	sprintf(avq->name, "avq.%u", avq->vq_index);
> +	vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin->info, avq->vq_index, NULL,
> +			      avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
> +	if (IS_ERR(vq)) {
> +		dev_err(&vdev->dev, "failed to setup admin virtqueue");
> +		kfree(vp_dev->admin);
> +		return PTR_ERR(vq);
> +	}
> +
> +	vp_dev->admin->info.vq = vq;
> +	vp_modern_set_queue_enable(&vp_dev->mdev, avq->info.vq->index, true);
> +	return 0;
> +}
> +
> +void vp_destroy_avq(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	if (!vp_dev->admin)
> +		return;
> +
> +	vp_dev->del_vq(&vp_dev->admin->info);
> +	kfree(vp_dev->admin);
> +}
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 2b3438de2c4d..028c51ea90ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -93,6 +93,8 @@ typedef void vq_callback_t(struct virtqueue *);
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @create_avq: initialize admin virtqueue resource.
> + * @destroy_avq: destroy admin virtqueue resource.
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -120,6 +122,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*create_avq)(struct virtio_device *vdev);
> +	void (*destroy_avq)(struct virtio_device *vdev);
>  };
>  
>  /* If driver didn't advertise the feature, it will never appear. */
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 067ac1d789bc..f6cb13d858fd 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -10,6 +10,9 @@ struct virtio_pci_modern_common_cfg {
>  
>  	__le16 queue_notify_data;	/* read-write */
>  	__le16 queue_reset;		/* read-write */
> +
> +	__le16 admin_queue_index;	/* read-only */
> +	__le16 admin_queue_num;		/* read-only */
>  };


ouch.
actually there's a problem

        mdev->common = vp_modern_map_capability(mdev, common,
                                      sizeof(struct virtio_pci_common_cfg), 4,
                                      0, sizeof(struct virtio_pci_common_cfg),
                                      NULL, NULL);

extending this structure means some calls will start failing on
existing devices.

even more of an ouch, when we added queue_notify_data and queue_reset we
also possibly broke some devices. well hopefully not since no one
reported failures but we really need to fix that.


>  
>  struct virtio_pci_modern_device {
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
