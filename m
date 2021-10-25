Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 01:30:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF89C60FE7
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 01:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF89C60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 980456070E;
	Mon, 25 Oct 2021 01:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 150zkCGoNOGx; Mon, 25 Oct 2021 01:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6832C605A7;
	Mon, 25 Oct 2021 01:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B746C0019;
	Mon, 25 Oct 2021 01:30:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B98CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03B9F4028F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xkXbLThjhKPK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:30:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E981401DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635125439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k69NuAi94ADwVxkgElqbN5xWSdMe3IQXDHri6aQpSjY=;
 b=XOaEb8YONiRK3ijWqf2+TqnpAC/sKOj7gnpj1S6DVoVjS7WpFzUf82eMUIb37xqjHpkLKy
 PnLJD4GmFZZ4WSOJfBVNzjB7rtpbFoNE4E6GF9egWpxFArGEAjqDckRS6q/hQJ1l80X/ec
 aoaaq7NyuWX7oK4sV02Clk5c7F+0VQI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Q4szRk7WOCGrL38q2Wa2wA-1; Sun, 24 Oct 2021 21:30:35 -0400
X-MC-Unique: Q4szRk7WOCGrL38q2Wa2wA-1
Received: by mail-lf1-f72.google.com with SMTP id
 x17-20020a0565123f9100b003ff593b7c65so4520443lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 18:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k69NuAi94ADwVxkgElqbN5xWSdMe3IQXDHri6aQpSjY=;
 b=hTVIMc3V+0R32ocWtmQzT6JKhOn+9i+SvTHc659jGSdzmSeaV7aKtleZo+gzl1hNqg
 dS6lb+pcW20XJ6A+BLbpXAJeyROGN8px83gmXsTN0SWLHdHqRUgoVAqFZ9f8QChe4wHV
 YaLHX0lU0HfWTV8t4C/rQJY9KtYvWA1jziy/pXpbhay99udfN2vpsmKu6mVmKGn2XYu5
 shU0wism80jvEpPkci412onIj3YsMarb+zPNXonNfStp92v2hmqfh+EA+KfupyfSaCgh
 uWTP9vZCWPO/8b3cJ3cDaLDGjPsud56YYtXAgM/nbZfMLaPsq3Wi2H2QHXRkPqW5xVub
 UAvw==
X-Gm-Message-State: AOAM530MNneYqAS7GaZVHWaY1tyu/ArhEyKxdJK2ybpfwPRvRj4Evj7/
 uZZvT3yfHjMiOWNN6ShZOG2NhiNyeyOvmUCfrTVT7GuyWmKBMusZR5vI9wfkGmMt/2ClEj1PUsP
 +2cWDvXB56EGzLFc7v0eT+QpSnBj1qhonfuHHk1QjuNkdZ17CS+/2B7MIrQ==
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr671785lfp.580.1635125434001; 
 Sun, 24 Oct 2021 18:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo6oIzhNgcm8LIkg7lSuJnM+nTrEFxGbNUymtlOxvGj//PuJww/TSwqcv+hhPpj72T3k489gQs7bfRnlNvOb4=
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr671753lfp.580.1635125433603; 
 Sun, 24 Oct 2021 18:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <7bb4834a0638fabaf3ba1a585b607830392a088f.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <7bb4834a0638fabaf3ba1a585b607830392a088f.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 09:30:22 +0800
Message-ID: <CACGkMEvkDyhmZPY8YFWjC1bCeWvXRepcfTHZJhx2ynCRvFCWvA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] virtio-pci: introduce legacy device module
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Split common codes from virtio-pci-legacy so vDPA driver can reuse it
> later.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/Kconfig                 |  10 ++
>  drivers/virtio/Makefile                |   1 +
>  drivers/virtio/virtio_pci_common.c     |  10 +-
>  drivers/virtio/virtio_pci_common.h     |   9 +-
>  drivers/virtio/virtio_pci_legacy.c     | 101 +++---------
>  drivers/virtio/virtio_pci_legacy_dev.c | 220 +++++++++++++++++++++++++
>  include/linux/virtio_pci_legacy.h      |  42 +++++
>  7 files changed, 310 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
>  create mode 100644 include/linux/virtio_pci_legacy.h
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..8fcf94cd2c96 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -20,6 +20,15 @@ config VIRTIO_PCI_LIB
>           PCI device with possible vendor specific extensions. Any
>           module that selects this module must depend on PCI.
>
> +config VIRTIO_PCI_LIB_LEGACY
> +       tristate
> +       help
> +         Legacy PCI device (Virtio PCI Card 0.9.x Draft and older device)
> +         implementation.
> +         This module implements the basic probe and control for devices
> +         which are based on legacy PCI device. Any module that selects this
> +         module must depend on PCI.
> +
>  menuconfig VIRTIO_MENU
>         bool "Virtio drivers"
>         default y
> @@ -43,6 +52,7 @@ config VIRTIO_PCI_LEGACY
>         bool "Support for legacy virtio draft 0.9.X and older devices"
>         default y
>         depends on VIRTIO_PCI
> +       select VIRTIO_PCI_LIB_LEGACY
>         help
>            Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
>
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 699bbea0465f..0a82d0873248 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> +obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b35bb2d57f62..d724f676608b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -549,6 +549,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>
>         pci_set_master(pci_dev);
>
> +       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
> +
>         rc = register_virtio_device(&vp_dev->vdev);
>         reg_dev = vp_dev;
>         if (rc)
> @@ -557,10 +559,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>         return 0;
>
>  err_register:
> -       if (vp_dev->ioaddr)
> -            virtio_pci_legacy_remove(vp_dev);
> +       if (vp_dev->is_legacy)
> +               virtio_pci_legacy_remove(vp_dev);
>         else
> -            virtio_pci_modern_remove(vp_dev);
> +               virtio_pci_modern_remove(vp_dev);
>  err_probe:
>         pci_disable_device(pci_dev);
>  err_enable_device:
> @@ -587,7 +589,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>
>         unregister_virtio_device(&vp_dev->vdev);
>
> -       if (vp_dev->ioaddr)
> +       if (vp_dev->is_legacy)
>                 virtio_pci_legacy_remove(vp_dev);
>         else
>                 virtio_pci_modern_remove(vp_dev);
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index beec047a8f8d..eb17a29fc7ef 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -25,6 +25,7 @@
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ring.h>
>  #include <linux/virtio_pci.h>
> +#include <linux/virtio_pci_legacy.h>
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/highmem.h>
>  #include <linux/spinlock.h>
> @@ -44,16 +45,14 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_device {
>         struct virtio_device vdev;
>         struct pci_dev *pci_dev;
> +       struct virtio_pci_legacy_device ldev;
>         struct virtio_pci_modern_device mdev;
>
> -       /* In legacy mode, these two point to within ->legacy. */
> +       bool is_legacy;
> +
>         /* Where to read and clear interrupt */
>         u8 __iomem *isr;
>
> -       /* Legacy only field */
> -       /* the IO mapping for the PCI config space */
> -       void __iomem *ioaddr;
> -
>         /* a list of queues so we can dispatch IRQs */
>         spinlock_t lock;
>         struct list_head virtqueues;
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..82eb437ad920 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>   *  Michael S. Tsirkin <mst@redhat.com>
>   */
>
> +#include "linux/virtio_pci_legacy.h"
>  #include "virtio_pci_common.h"
>
>  /* virtio config->get_features() implementation */
> @@ -23,7 +24,7 @@ static u64 vp_get_features(struct virtio_device *vdev)
>
>         /* When someone needs more than 32 feature bits, we'll need to
>          * steal a bit to indicate that the rest are somewhere else. */
> -       return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> +       return vp_legacy_get_features(&vp_dev->ldev);
>  }
>
>  /* virtio config->finalize_features() implementation */
> @@ -38,7 +39,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
>         BUG_ON((u32)vdev->features != vdev->features);
>
>         /* We only support 32 feature bits. */
> -       iowrite32(vdev->features, vp_dev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +       vp_legacy_set_features(&vp_dev->ldev, vdev->features);
>
>         return 0;
>  }
> @@ -48,7 +49,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>                    void *buf, unsigned len)
>  {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -       void __iomem *ioaddr = vp_dev->ioaddr +
> +       void __iomem *ioaddr = vp_dev->ldev.ioaddr +
>                         VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>                         offset;
>         u8 *ptr = buf;
> @@ -64,7 +65,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>                    const void *buf, unsigned len)
>  {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -       void __iomem *ioaddr = vp_dev->ioaddr +
> +       void __iomem *ioaddr = vp_dev->ldev.ioaddr +
>                         VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>                         offset;
>         const u8 *ptr = buf;
> @@ -78,7 +79,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  static u8 vp_get_status(struct virtio_device *vdev)
>  {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -       return ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +       return vp_legacy_get_status(&vp_dev->ldev);
>  }
>
>  static void vp_set_status(struct virtio_device *vdev, u8 status)
> @@ -86,28 +87,24 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>         /* We should never be setting status to 0. */
>         BUG_ON(status == 0);
> -       iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +       vp_legacy_set_status(&vp_dev->ldev, status);
>  }
>
>  static void vp_reset(struct virtio_device *vdev)
>  {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>         /* 0 status means a reset. */
> -       iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +       vp_legacy_set_status(&vp_dev->ldev, 0);
>         /* Flush out the status write, and flush in device writes,
>          * including MSi-X interrupts, if any. */
> -       ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +       vp_legacy_get_status(&vp_dev->ldev);
>         /* Flush pending VQ/configuration callbacks. */
>         vp_synchronize_vectors(vdev);
>  }
>
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  {
> -       /* Setup the vector used for configuration events */
> -       iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> -       /* Verify we had enough resources to assign the vector */
> -       /* Will also flush the write out to device */
> -       return ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +       return vp_legacy_config_vector(&vp_dev->ldev, vector);
>  }
>
>  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> @@ -123,12 +120,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         int err;
>         u64 q_pfn;
>
> -       /* Select the queue we're interested in */
> -       iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> -
>         /* Check if queue is either not available or already active. */
> -       num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
> -       if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
> +       num = vp_legacy_get_queue_size(&vp_dev->ldev, index);
> +       if (!num || vp_legacy_get_queue_enable(&vp_dev->ldev, index))
>                 return ERR_PTR(-ENOENT);
>
>         info->msix_vector = msix_vec;
> @@ -151,13 +145,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         }
>
>         /* activate the queue */
> -       iowrite32(q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +       vp_legacy_set_queue_address(&vp_dev->ldev, index, q_pfn);
>
> -       vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> +       vq->priv = (void __force *)vp_dev->ldev.ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
>
>         if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
> -               iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> -               msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +               msix_vec = vp_legacy_queue_vector(&vp_dev->ldev, index, msix_vec);
>                 if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
>                         err = -EBUSY;
>                         goto out_deactivate;
> @@ -167,7 +160,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         return vq;
>
>  out_deactivate:
> -       iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +       vp_legacy_set_queue_address(&vp_dev->ldev, index, 0);
>  out_del_vq:
>         vring_del_virtqueue(vq);
>         return ERR_PTR(err);
> @@ -178,17 +171,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
>         struct virtqueue *vq = info->vq;
>         struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>
> -       iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> -
>         if (vp_dev->msix_enabled) {
> -               iowrite16(VIRTIO_MSI_NO_VECTOR,
> -                         vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +               vp_legacy_queue_vector(&vp_dev->ldev, vq->index,
> +                               VIRTIO_MSI_NO_VECTOR);
>                 /* Flush the write out to device */
> -               ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
> +               ioread8(vp_dev->ldev.ioaddr + VIRTIO_PCI_ISR);
>         }
>
>         /* Select and deactivate the queue */
> -       iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +       vp_legacy_set_queue_address(&vp_dev->ldev, vq->index, 0);
>
>         vring_del_virtqueue(vq);
>  }
> @@ -211,51 +202,18 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  /* the PCI probing function */
>  int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  {
> +       struct virtio_pci_legacy_device *ldev = &vp_dev->ldev;
>         struct pci_dev *pci_dev = vp_dev->pci_dev;
>         int rc;
>
> -       /* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
> -       if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
> -               return -ENODEV;
> -
> -       if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
> -               printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
> -                      VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
> -               return -ENODEV;
> -       }
> -
> -       rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> -       if (rc) {
> -               rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> -       } else {
> -               /*
> -                * The virtio ring base address is expressed as a 32-bit PFN,
> -                * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> -                */
> -               dma_set_coherent_mask(&pci_dev->dev,
> -                               DMA_BIT_MASK(32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT));
> -       }
> -
> -       if (rc)
> -               dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +       ldev->pci_dev = pci_dev;
>
> -       rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> +       rc = vp_legacy_probe(ldev);
>         if (rc)
>                 return rc;
>
> -       rc = -ENOMEM;
> -       vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -       if (!vp_dev->ioaddr)
> -               goto err_iomap;
> -
> -       vp_dev->isr = vp_dev->ioaddr + VIRTIO_PCI_ISR;
> -
> -       /* we use the subsystem vendor/device id as the virtio vendor/device
> -        * id.  this allows us to use the same PCI vendor/device id for all
> -        * virtio devices and to identify the particular virtio driver by
> -        * the subsystem ids */
> -       vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
> -       vp_dev->vdev.id.device = pci_dev->subsystem_device;
> +       vp_dev->isr = ldev->isr;
> +       vp_dev->vdev.id = ldev->id;
>
>         vp_dev->vdev.config = &virtio_pci_config_ops;
>
> @@ -264,16 +222,11 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>         vp_dev->del_vq = del_vq;
>
>         return 0;
> -
> -err_iomap:
> -       pci_release_region(pci_dev, 0);
> -       return rc;
>  }
>
>  void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
>  {
> -       struct pci_dev *pci_dev = vp_dev->pci_dev;
> +       struct virtio_pci_legacy_device *ldev = &vp_dev->ldev;
>
> -       pci_iounmap(pci_dev, vp_dev->ioaddr);
> -       pci_release_region(pci_dev, 0);
> +       vp_legacy_remove(ldev);
>  }
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> new file mode 100644
> index 000000000000..9b97680dd02b
> --- /dev/null
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "linux/virtio_pci.h"
> +#include <linux/virtio_pci_legacy.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +
> +/*
> + * vp_legacy_probe: probe the legacy virtio pci device, note that the
> + * caller is required to enable PCI device before calling this function.
> + * @ldev: the legacy virtio-pci device
> + *
> + * Return 0 on succeed otherwise fail
> + */
> +int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
> +{
> +       struct pci_dev *pci_dev = ldev->pci_dev;
> +       int rc;
> +
> +       /* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
> +       if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
> +               return -ENODEV;
> +
> +       if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION)
> +               return -ENODEV;
> +
> +       rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> +       if (rc) {
> +               rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> +       } else {
> +               /*
> +                * The virtio ring base address is expressed as a 32-bit PFN,
> +                * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> +                */
> +               dma_set_coherent_mask(&pci_dev->dev,
> +                               DMA_BIT_MASK(32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT));
> +       }
> +
> +       if (rc)
> +               dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
> +       rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> +       if (rc)
> +               return rc;
> +
> +       ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> +       if (!ldev->ioaddr)
> +               goto err_iomap;
> +
> +       ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
> +
> +       ldev->id.vendor = pci_dev->subsystem_vendor;
> +       ldev->id.device = pci_dev->subsystem_device;
> +
> +       return 0;
> +err_iomap:
> +       pci_release_region(pci_dev, 0);
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_probe);
> +
> +/*
> + * vp_legacy_probe: remove and cleanup the legacy virtio pci device
> + * @ldev: the legacy virtio-pci device
> + */
> +void vp_legacy_remove(struct virtio_pci_legacy_device *ldev)
> +{
> +       struct pci_dev *pci_dev = ldev->pci_dev;
> +
> +       pci_iounmap(pci_dev, ldev->ioaddr);
> +       pci_release_region(pci_dev, 0);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_remove);
> +
> +/*
> + * vp_legacy_get_features - get features from device
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the features read from the device
> + */
> +u64 vp_legacy_get_features(struct virtio_pci_legacy_device *ldev)
> +{
> +
> +       return ioread32(ldev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_features);
> +
> +/*
> + * vp_legacy_get_driver_features - get driver features from device
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the driver features read from the device
> + */
> +u64 vp_legacy_get_driver_features(struct virtio_pci_legacy_device *ldev)
> +{
> +       return ioread32(ldev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_driver_features);
> +
> +/*
> + * vp_legacy_set_features - set features to device
> + * @ldev: the legacy virtio-pci device
> + * @features: the features set to device
> + */
> +void vp_legacy_set_features(struct virtio_pci_legacy_device *ldev,
> +                           u32 features)
> +{
> +       iowrite32(features, ldev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_features);
> +
> +/*
> + * vp_legacy_get_status - get the device status
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the status read from device
> + */
> +u8 vp_legacy_get_status(struct virtio_pci_legacy_device *ldev)
> +{
> +       return ioread8(ldev->ioaddr + VIRTIO_PCI_STATUS);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_status);
> +
> +/*
> + * vp_legacy_set_status - set status to device
> + * @ldev: the legacy virtio-pci device
> + * @status: the status set to device
> + */
> +void vp_legacy_set_status(struct virtio_pci_legacy_device *ldev,
> +                                u8 status)
> +{
> +       iowrite8(status, ldev->ioaddr + VIRTIO_PCI_STATUS);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_status);
> +
> +/*
> + * vp_legacy_queue_vector - set the MSIX vector for a specific virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: queue index
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_legacy_queue_vector(struct virtio_pci_legacy_device *ldev,
> +                          u16 index, u16 vector)
> +{
> +       iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +       iowrite16(vector, ldev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +       /* Flush the write out to device */
> +       return ioread16(ldev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_queue_vector);
> +
> +/*
> + * vp_legacy_config_vector - set the vector for config interrupt
> + * @ldev: the legacy virtio-pci device
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_legacy_config_vector(struct virtio_pci_legacy_device *ldev,
> +                           u16 vector)
> +{
> +       /* Setup the vector used for configuration events */
> +       iowrite16(vector, ldev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +       /* Verify we had enough resources to assign the vector */
> +       /* Will also flush the write out to device */
> +       return ioread16(ldev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_config_vector);
> +
> +/*
> + * vp_legacy_set_queue_address - set the virtqueue address
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + * @queue_pfn: pfn of the virtqueue
> + */
> +void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
> +                            u16 index, u32 queue_pfn)
> +{
> +       iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +       iowrite32(queue_pfn, ldev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_queue_address);
> +
> +/*
> + * vp_legacy_get_queue_enable - enable a virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + *
> + * Returns whether a virtqueue is enabled or not
> + */
> +bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
> +                               u16 index)
> +{
> +       iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +       return ioread32(ldev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_queue_enable);
> +
> +/*
> + * vp_legacy_get_queue_size - get size for a virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + *
> + * Returns the size of the virtqueue
> + */
> +u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
> +                            u16 index)
> +{
> +       iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +       return ioread16(ldev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_queue_size);
> +
> +MODULE_VERSION("0.1");
> +MODULE_DESCRIPTION("Legacy Virtio PCI Device");
> +MODULE_AUTHOR("Wu Zongyong <wuzongyong@linux.alibaba.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci_legacy.h
> new file mode 100644
> index 000000000000..e5d665faf00e
> --- /dev/null
> +++ b/include/linux/virtio_pci_legacy.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_PCI_LEGACY_H
> +#define _LINUX_VIRTIO_PCI_LEGACY_H
> +
> +#include "linux/mod_devicetable.h"
> +#include <linux/pci.h>
> +#include <linux/virtio_pci.h>
> +
> +struct virtio_pci_legacy_device {
> +       struct pci_dev *pci_dev;
> +
> +       /* Where to read and clear interrupt */
> +       u8 __iomem *isr;
> +       /* The IO mapping for the PCI config space (legacy mode only) */
> +       void __iomem *ioaddr;
> +
> +       struct virtio_device_id id;
> +};
> +
> +u64 vp_legacy_get_features(struct virtio_pci_legacy_device *ldev);
> +u64 vp_legacy_get_driver_features(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_set_features(struct virtio_pci_legacy_device *ldev,
> +                       u32 features);
> +u8 vp_legacy_get_status(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_set_status(struct virtio_pci_legacy_device *ldev,
> +                       u8 status);
> +u16 vp_legacy_queue_vector(struct virtio_pci_legacy_device *ldev,
> +                          u16 idx, u16 vector);
> +u16 vp_legacy_config_vector(struct virtio_pci_legacy_device *ldev,
> +                    u16 vector);
> +void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
> +                            u16 index, u32 queue_pfn);
> +bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
> +                               u16 idx);
> +void vp_legacy_set_queue_size(struct virtio_pci_legacy_device *ldev,
> +                             u16 idx, u16 size);
> +u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
> +                            u16 idx);
> +int vp_legacy_probe(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_remove(struct virtio_pci_legacy_device *ldev);
> +
> +#endif
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
