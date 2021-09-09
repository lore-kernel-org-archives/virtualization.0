Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B72C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:58:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA9761260
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCA9761260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6EE540354;
	Thu,  9 Sep 2021 13:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_eSXNXwFXga; Thu,  9 Sep 2021 13:58:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9D8340330;
	Thu,  9 Sep 2021 13:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B07C4C000F;
	Thu,  9 Sep 2021 13:58:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E11C1C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEC2340116
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id euUMLkhJawXl
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:57:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 224D6400B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631195878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lRrSINgYt7KKDKEjczqr2TnpglKua5JOe8A4G8xWzs=;
 b=Xw762+qjIu4KyZtG7LJ3X4mgo4RZUCTJFQMuUTjTxE/t1HqswTlqBUkdsZxBxU6eC+0W4n
 0d6WKYmo05u8nGoeIYutBQXyiUWGhMmku32Q2pINIIwKR8ENnGD4tdwEzwkUjrk/fLRUWf
 z/zAnB0a8HRE1PqMpUa6JzWUVBN6378=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-gcxqc9YdPYeXsyOmvoeHCA-1; Thu, 09 Sep 2021 09:57:56 -0400
X-MC-Unique: gcxqc9YdPYeXsyOmvoeHCA-1
Received: by mail-ej1-f72.google.com with SMTP id
 ne21-20020a1709077b95b029057eb61c6fdfso827623ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 06:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6lRrSINgYt7KKDKEjczqr2TnpglKua5JOe8A4G8xWzs=;
 b=Vm6l1HZj2Kn0xuFdTNmKsQdjQHD5EEl7YIGjXiResB17voFlH0E3XnkkV/jOJuQ6B/
 TqtLsEpaeqZoBjUL/PFcD+Lz8aDsZPIBDNP9ODQdDkZfo0JtwI5bUll2eJQ8HFd2u/W1
 VQltc8pGiCt6l0UfOpDlNPeog3zsUYM8U2i0ukis8utdOLxYDJBCgjls8p4fVcTwD00g
 O4EKMDdGyEOjPw/RIAFLaXQahPYlrUN41OqABOwQrSXKJfN1HzFdN/rlwlCQcf8qjfNd
 zAAebJdprl+/aKncCqBFSTjva1p/di6HeU1FGfEBgb9RDxtRZUYA3Up34Fh3Nf+/mbps
 13Kw==
X-Gm-Message-State: AOAM530byNwM3bjXuCmZbixd0WUln3QVTNJrOKBwpGW2aAtgl6IvHqG1
 sU704TBUlYnbWVDbh8wOjuFFCEWHi+JzamfjI9mixVLMQyzxLKNa2dJOrLDHr+UUZC8BYxACrao
 EiyKaUo5P26tVtSVkZLse2ENCVwH7ZZf+wdFBQk37sQ==
X-Received: by 2002:a17:906:3693:: with SMTP id
 a19mr3635328ejc.237.1631195875147; 
 Thu, 09 Sep 2021 06:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpJzxglH5/0UharMIxDbvc3npEImAW6R9ruLt01RvaJ13152dqSzgpdHFBX0CBhIiMaKK/zg==
X-Received: by 2002:a17:906:3693:: with SMTP id
 a19mr3635311ejc.237.1631195874906; 
 Thu, 09 Sep 2021 06:57:54 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
 by smtp.gmail.com with ESMTPSA id z12sm1178369edi.44.2021.09.09.06.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:57:54 -0700 (PDT)
Date: Thu, 9 Sep 2021 09:57:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH 6/6] vp_vdpa: introduce legacy virtio pci driver
Message-ID: <20210909095725-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <8b084e5beb1111ad98bb64177ebd0e9845c178fa.1631101392.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8b084e5beb1111ad98bb64177ebd0e9845c178fa.1631101392.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Sep 08, 2021 at 08:20:37PM +0800, Wu Zongyong wrote:
> This patch implements a vdpa driver for legacy virtio-pci device. And
> this has been tested with the ENI(Elastic Network Interface) which is a
> hardware virtio network device in Alibaba ECS baremetal instance.
> 
> Note that legacy device doesn't support to change the virtqueue size, so
> users should use get_vq_num_unchangeable callback to check if the
> virqueue size can be changed.

Hmm isn't this implicit in this being a legacy device?

> If not, users should get the virqueue size
> first by the get_vq_num_max callback first then allocate same size
> memory for the virtqueue otherwise the device won't work correctly.
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/Kconfig                     |   7 +
>  drivers/vdpa/virtio_pci/Makefile         |   1 +
>  drivers/vdpa/virtio_pci/vp_vdpa_common.c |   5 +
>  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  11 +
>  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
>  5 files changed, 370 insertions(+)
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index a503c1b2bfd9..ccb4fdb11f0f 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -67,4 +67,11 @@ config VP_VDPA
>  	help
>  	  This kernel module bridges virtio PCI device to vDPA bus.
>  
> +config VP_VDPA_LEGACY
> +	bool "Support legacy virtio pci device"
> +	depends on VP_VDPA
> +	select VIRTIO_PCI_LIB_LEGACY
> +	help
> +	  This option enables bridges legacy virito PCI device to vDPA bus.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
> index a772d86952b1..77c52dfb8b56 100644
> --- a/drivers/vdpa/virtio_pci/Makefile
> +++ b/drivers/vdpa/virtio_pci/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  vp_vdpa-y += vp_vdpa_common.o vp_vdpa_modern.o
> +vp_vdpa-$(CONFIG_VP_VDPA_LEGACY) += vp_vdpa_legacy.o
>  obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.c b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> index 3ff24c9ad6e4..fa91dc153244 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> @@ -8,6 +8,7 @@
>   * Based on virtio_pci_modern.c.
>   */
>  
> +#include "linux/err.h"
>  #include <linux/irqreturn.h>
>  #include <linux/interrupt.h>
>  #include "vp_vdpa_common.h"
> @@ -172,6 +173,10 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  
>  	vp_vdpa = vp_vdpa_modern_probe(pdev);
> +	if (PTR_ERR(vp_vdpa) == -ENODEV) {
> +		dev_info(&pdev->dev, "Tring legacy driver");
> +		vp_vdpa = vp_vdpa_legacy_probe(pdev);
> +	}
>  	if (IS_ERR(vp_vdpa))
>  		return PTR_ERR(vp_vdpa);
>  
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.h b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> index 57886b55a2e9..39f241d8321b 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> @@ -10,6 +10,7 @@
>  #include <linux/virtio_ring.h>
>  #include <linux/virtio_pci.h>
>  #include <linux/virtio_pci_modern.h>
> +#include <linux/virtio_pci_legacy.h>
>  
>  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>  #define VP_VDPA_NAME_SIZE 256
> @@ -26,6 +27,7 @@ struct vp_vdpa {
>  	struct vdpa_device vdpa;
>  	struct pci_dev *pci_dev;
>  	struct virtio_pci_modern_device mdev;
> +	struct virtio_pci_legacy_device ldev;
>  	struct vp_vring *vring;
>  	struct vdpa_callback config_cb;
>  	char msix_name[VP_VDPA_NAME_SIZE];
> @@ -53,4 +55,13 @@ void vp_vdpa_free_irq_vectors(void *data);
>  
>  struct vp_vdpa *vp_vdpa_modern_probe(struct pci_dev *pdev);
>  
> +#if IS_ENABLED(CONFIG_VP_VDPA_LEGACY)
> +struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev);
> +#else
> +static inline struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +#endif
> +
>  #endif
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c b/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> new file mode 100644
> index 000000000000..75a6879a27ca
> --- /dev/null
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vDPA bridge driver for legacy virtio-pci device
> + *
> + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> + */
> +
> +#include "linux/pci.h"
> +#include "linux/virtio_byteorder.h"
> +#include "linux/virtio_pci_legacy.h"
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_blk.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_pci.h>
> +#include "vp_vdpa_common.h"
> +
> +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return &vp_vdpa->ldev;
> +}
> +
> +static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	return vp_legacy_get_features(ldev);
> +}
> +
> +static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	vp_legacy_set_features(ldev, features);
> +
> +	return 0;
> +}
> +
> +static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	return vp_legacy_get_status(ldev);
> +}
> +
> +static int vp_vdpa_set_vq_state_split(struct vdpa_device *vdpa,
> +				      const struct vdpa_vq_state *state)
> +{
> +	const struct vdpa_vq_state_split *split = &state->split;
> +
> +	if (split->avail_index == 0)
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
> +				const struct vdpa_vq_state *state)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	/* Note that this is not supported by virtio specification.
> +	 * But if the state is by chance equal to the device initial
> +	 * state, we can let it go.
> +	 */
> +	if (!vp_legacy_get_queue_enable(ldev, qid))
> +		return vp_vdpa_set_vq_state_split(vdpa,	state);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> +				 u16 qid, bool ready)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	/* Legacy devices can only be activated by setting vq address,
> +	 * and queue_enable is not supported by specification. So for
> +	 * legacy devices, we use @vp_vdpa_set_vq_address to set vq
> +	 * ready instead.
> +	 */
> +	if (!ready)
> +		vp_legacy_set_queue_address(ldev, qid, 0);
> +}
> +
> +static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	return vp_legacy_get_queue_enable(ldev, qid);
> +}
> +
> +/* Legacy devices don't support set vq num by specification,
> + * just report an error if someone try to set it.
> + */
> +static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
> +			       u32 num)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	dev_err(&ldev->pci_dev->dev, "legacy device don't support set vq num\n");
> +}
> +
> +static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	/* assume all virtqueues have the same size */
> +	return vp_legacy_get_queue_size(ldev, 0);
> +}
> +
> +static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
> +				  u64 desc_area, u64 driver_area,
> +				  u64 device_area)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	vp_legacy_set_queue_address(ldev, qid, desc_area >> VIRTIO_PCI_QUEUE_ADDR_SHIFT);
> +
> +	return 0;
> +}
> +
> +static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	return ldev->id.device;
> +}
> +
> +static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	return ldev->id.vendor;
> +}
> +
> +static size_t vp_vdpa_get_config_size(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +	size_t size;
> +
> +	switch (ldev->id.device) {
> +	case VIRTIO_ID_NET:
> +		size = sizeof(struct virtio_net_config);
> +		break;
> +	case VIRTIO_ID_BLOCK:
> +		size = sizeof(struct virtio_blk_config);
> +		break;
> +	default:
> +		size = 0;
> +		dev_err(&ldev->pci_dev->dev, "VIRTIO ID %u not support\n", ldev->id.device);
> +	}
> +
> +	return size;
> +}
> +
> +static void vp_vdpa_get_config(struct vdpa_device *vdpa,
> +			       unsigned int offset,
> +			       void *buf, unsigned int len)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> +	void __iomem *ioaddr = ldev->ioaddr +
> +		VIRTIO_PCI_CONFIG_OFF(vp_vdpa->vectors) +
> +		offset;
> +	u8 *p = buf;
> +	int i;
> +
> +	/* legacy devices don't have a configuration generation field,
> +	 * so we just read it once.
> +	 */
> +	for (i = 0; i < len; i++)
> +		*p++ = ioread8(ioaddr + i);
> +}
> +
> +static void vp_vdpa_set_config(struct vdpa_device *vdpa,
> +			       unsigned int offset, const void *buf,
> +			       unsigned int len)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> +	void __iomem *ioaddr = ldev->ioaddr +
> +		VIRTIO_PCI_CONFIG_OFF(vp_vdpa->vectors) +
> +		offset;
> +	const u8 *p = buf;
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		iowrite8(*p++, ioaddr + i);
> +}
> +
> +static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> +	u8 s = vp_vdpa_get_status(vdpa);
> +
> +	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> +	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		vp_vdpa_request_irq(vp_vdpa);
> +	}
> +
> +	vp_legacy_set_status(ldev, status);
> +
> +	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +	    (s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		vp_vdpa_free_irq(vp_vdpa);
> +	}
> +}
> +
> +static bool vp_vdpa_get_vq_num_unchangeable(struct vdpa_device *vdpa)
> +{
> +	return true;
> +}
> +
> +static const struct vdpa_config_ops vp_vdpa_ops = {
> +	.get_features	= vp_vdpa_get_features,
> +	.set_features	= vp_vdpa_set_features,
> +	.get_status	= vp_vdpa_get_status,
> +	.set_status	= vp_vdpa_set_status,
> +	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
> +	.get_vq_state	= vp_vdpa_get_vq_state,
> +	.set_vq_state	= vp_vdpa_set_vq_state,
> +	.set_vq_cb	= vp_vdpa_set_vq_cb,
> +	.set_vq_ready	= vp_vdpa_set_vq_ready,
> +	.get_vq_ready	= vp_vdpa_get_vq_ready,
> +	.set_vq_num	= vp_vdpa_set_vq_num,
> +	.set_vq_address	= vp_vdpa_set_vq_address,
> +	.kick_vq	= vp_vdpa_kick_vq,
> +	.get_device_id	= vp_vdpa_get_device_id,
> +	.get_vendor_id	= vp_vdpa_get_vendor_id,
> +	.get_vq_align	= vp_vdpa_get_vq_align,
> +	.get_config_size = vp_vdpa_get_config_size,
> +	.get_config	= vp_vdpa_get_config,
> +	.set_config	= vp_vdpa_set_config,
> +	.set_config_cb  = vp_vdpa_set_config_cb,
> +	.get_vq_irq	= vp_vdpa_get_vq_irq,
> +	.get_vq_num_unchangeable = vp_vdpa_get_vq_num_unchangeable,
> +};
> +
> +static u16 vp_vdpa_get_num_queues(struct vp_vdpa *vp_vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> +	u32 features = vp_legacy_get_features(ldev);
> +	u16 num;
> +
> +	switch (ldev->id.device) {
> +	case VIRTIO_ID_NET:
> +		num = 2;
> +		if (features & VIRTIO_NET_F_MQ) {
> +			__virtio16 max_virtqueue_pairs;
> +
> +			vp_vdpa_get_config(&vp_vdpa->vdpa,
> +				offsetof(struct virtio_net_config, max_virtqueue_pairs),
> +				&max_virtqueue_pairs,
> +				sizeof(max_virtqueue_pairs));
> +			num = 2 * __virtio16_to_cpu(virtio_legacy_is_little_endian(),
> +						max_virtqueue_pairs);
> +		}
> +
> +		if (features & VIRTIO_NET_F_CTRL_VQ)
> +			num += 1;
> +		break;
> +	case VIRTIO_ID_BLOCK:
> +		num = 1;
> +		break;
> +	default:
> +		num = 0;
> +		dev_err(&ldev->pci_dev->dev, "VIRTIO ID %u not support\n", ldev->id.device);
> +	}
> +
> +	return num;
> +}
> +
> +static u16 vp_vdpa_queue_vector(struct vp_vdpa *vp_vdpa, u16 idx, u16 vector)
> +{
> +	return vp_legacy_queue_vector(&vp_vdpa->ldev, idx, vector);
> +}
> +
> +static u16 vp_vdpa_config_vector(struct vp_vdpa *vp_vdpa, u16 vector)
> +{
> +	return vp_legacy_config_vector(&vp_vdpa->ldev, vector);
> +}
> +
> +struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct vp_vdpa *vp_vdpa;
> +	struct virtio_pci_legacy_device *ldev;
> +	int ret, i;
> +
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops, NULL);
> +	if (vp_vdpa == NULL) {
> +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ldev = &vp_vdpa->ldev;
> +	ldev->pci_dev = pdev;
> +
> +	ret = vp_legacy_probe(ldev);
> +	if (ret) {
> +		dev_err(dev, "Failed to probe legacy PCI device\n");
> +		goto err;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, vp_vdpa);
> +
> +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> +	vp_vdpa->queues = vp_vdpa_get_num_queues(vp_vdpa);
> +
> +	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed for adding devres for freeing irq vectors\n");
> +		goto err;
> +	}
> +
> +	vp_vdpa->vring = devm_kcalloc(dev, vp_vdpa->queues,
> +				      sizeof(*vp_vdpa->vring),
> +				      GFP_KERNEL);
> +	if (!vp_vdpa->vring) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail to allocate virtqueues\n");
> +		goto err;
> +	}
> +
> +	for (i = 0; i < vp_vdpa->queues; i++) {
> +		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> +		vp_vdpa->vring[i].notify = ldev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> +		vp_vdpa->vring[i].notify_pa = pci_resource_start(pdev, 0) + VIRTIO_PCI_QUEUE_NOTIFY;
> +	}
> +	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
> +
> +	vp_vdpa->queue_vector = vp_vdpa_queue_vector;
> +	vp_vdpa->config_vector = vp_vdpa_config_vector;
> +
> +	return vp_vdpa;
> +
> +err:
> +	put_device(&vp_vdpa->vdpa.dev);
> +	return ERR_PTR(ret);
> +}
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
