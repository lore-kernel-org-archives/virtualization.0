Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:27:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE066054F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DE066054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C628A80E2C;
	Mon, 25 Oct 2021 02:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jk1fdNPU_E1u; Mon, 25 Oct 2021 02:27:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A51A80E23;
	Mon, 25 Oct 2021 02:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 104EBC0012;
	Mon, 25 Oct 2021 02:27:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD01C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1A1A80E23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AOpSw6MZAEdU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD5D080E2C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635128865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8uyGOiIGZbLFaG8vZJP6/O6+Uxymzsqc0XA6VlvcyM=;
 b=INBDuo5kAaln+W1NJ39ZveeSFkLfWRaR2of+/iCPJ3pAObF89JLW2I0Ii1h20zDQV4Z+2D
 T4TFNDb4OrE29at2FmWwy4DH+VJ2lBolYoppmOChGt9BujfeRlN8FoS8FBF3yP/uTSfuyq
 zVXztAo0R/2gRDqSI43dCripiUvKp/w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-lm5ReeAjMiyiyHP9V5cXAQ-1; Sun, 24 Oct 2021 22:27:44 -0400
X-MC-Unique: lm5ReeAjMiyiyHP9V5cXAQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 k15-20020a0565123d8f00b003ffb31e2ea9so75881lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S8uyGOiIGZbLFaG8vZJP6/O6+Uxymzsqc0XA6VlvcyM=;
 b=wAci9KpBpETJhQPH48TCQwtM0CugHQzQSa7RCYTMM/HhHR43kXg0ziOepjvpimZYNH
 UuwzbXV9B0w+EShOB5V2wvWlOMio7x5IDt+8/nOl1bpacWeByJoxkm7OIGPmWfF8I6GB
 jP9/AEfU1QXHUpnbdpsEo7S+Tw9Lfz/Vr7JgsA9Z9BRvBBMZKCWAcoIsNMox+yar69st
 EEVDpH0HkLP/onYXt+2SM05iCtj99ONjWdGmnTuOu5ggsjt5pDDKgoGAaJ+y2Z3R9SRN
 I0kG7s+yO4VxPApo7FmBxjHx6JdowFkRcGz8sJnaXNQaWiK83kGY3qGnJPtQgBZaGfgC
 Pykg==
X-Gm-Message-State: AOAM533KDlx26j5gN160IVUNKWfl/laS6+u26UhvjFC4fYn3f0EkMLDW
 0Fnea8t+X0zqKXR/O+3GE4GsAS2JO6otSiN1WVkp7S500gO+w5jCf0wL2zxCNIwyIfQMh19GRBV
 HVWBrtGxSXm7uLAQTd5qJuoYAUbATjmx+3KXi2WhV28+rk60QsPZs2ccVTg==
X-Received: by 2002:a05:6512:128a:: with SMTP id
 u10mr14648199lfs.84.1635128862923; 
 Sun, 24 Oct 2021 19:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2gyBtC/WMAeyGq5kx7faKSbkeCJpKNkqxtJrv3rWm498mSd1NSPUJrekmZvNcnHRl7jEyBvrgp8ZfLoCVhdo=
X-Received: by 2002:a05:6512:128a:: with SMTP id
 u10mr14648182lfs.84.1635128862722; 
 Sun, 24 Oct 2021 19:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:27:31 +0800
Message-ID: <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
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
> This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
> Interface) which is build upon virtio 0.9.5 specification.
> And this driver doesn't support to run on BE host.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/Kconfig            |   8 +
>  drivers/vdpa/Makefile           |   1 +
>  drivers/vdpa/alibaba/Makefile   |   3 +
>  drivers/vdpa/alibaba/eni_vdpa.c | 553 ++++++++++++++++++++++++++++++++
>  4 files changed, 565 insertions(+)
>  create mode 100644 drivers/vdpa/alibaba/Makefile
>  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..c0232a2148a7 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>         help
>           This kernel module bridges virtio PCI device to vDPA bus.
>
> +config ALIBABA_ENI_VDPA
> +       tristate "vDPA driver for Alibaba ENI"
> +       select VIRTIO_PCI_LEGACY_LIB
> +       depends on PCI_MSI && !CPU_BIG_ENDIAN
> +       help
> +         VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon
> +         virtio 0.9.5 specification.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index f02ebed33f19..15665563a7f4 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_VDPA_USER) += vdpa_user/
>  obj-$(CONFIG_IFCVF)    += ifcvf/
>  obj-$(CONFIG_MLX5_VDPA) += mlx5/
>  obj-$(CONFIG_VP_VDPA)    += virtio_pci/
> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
> diff --git a/drivers/vdpa/alibaba/Makefile b/drivers/vdpa/alibaba/Makefile
> new file mode 100644
> index 000000000000..ef4aae69f87a
> --- /dev/null
> +++ b/drivers/vdpa/alibaba/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += eni_vdpa.o
> +
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> new file mode 100644
> index 000000000000..6a09f157d810
> --- /dev/null
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
> + *
> + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> + *
> + */
> +
> +#include "linux/bits.h"
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/vdpa.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_pci_legacy.h>
> +#include <uapi/linux/virtio_net.h>
> +
> +#define ENI_MSIX_NAME_SIZE 256
> +
> +#define ENI_ERR(pdev, fmt, ...)        \
> +       dev_err(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +#define ENI_DBG(pdev, fmt, ...)        \
> +       dev_dbg(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +#define ENI_INFO(pdev, fmt, ...) \
> +       dev_info(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +
> +struct eni_vring {
> +       void __iomem *notify;
> +       char msix_name[ENI_MSIX_NAME_SIZE];
> +       struct vdpa_callback cb;
> +       int irq;
> +};
> +
> +struct eni_vdpa {
> +       struct vdpa_device vdpa;
> +       struct virtio_pci_legacy_device ldev;
> +       struct eni_vring *vring;
> +       struct vdpa_callback config_cb;
> +       char msix_name[ENI_MSIX_NAME_SIZE];
> +       int config_irq;
> +       int queues;
> +       int vectors;
> +};
> +
> +static struct eni_vdpa *vdpa_to_eni(struct vdpa_device *vdpa)
> +{
> +       return container_of(vdpa, struct eni_vdpa, vdpa);
> +}
> +
> +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +
> +       return &eni_vdpa->ldev;
> +}
> +
> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +       u64 features = vp_legacy_get_features(ldev);
> +
> +       features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +       features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> +
> +       return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +               ENI_ERR(ldev->pci_dev,
> +                       "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +               return -EINVAL;
> +       }
> +
> +       vp_legacy_set_features(ldev, (u32)features);
> +
> +       return 0;
> +}
> +

So my comments have not been addressed since v4. Please address or
answer the questions before posting a new version.

Thanks

> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +     u64 features = vp_legacy_get_features(ldev);
> +
> +     features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +     features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);

VERSION_1 is also needed?


> +
> +     return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +     if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +             ENI_ERR(ldev->pci_dev,
> +                     "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +             return -EINVAL;

Do we need to make sure FEATURE_OK is not set in this case or the ENI can do
this for us?

Other looks good.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
