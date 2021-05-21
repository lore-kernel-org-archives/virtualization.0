Return-Path: <SRS0=ctfp=KQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D427C47076
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 16:39:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2717E613E9
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 16:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2717E613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC1B840236;
	Fri, 21 May 2021 16:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XB14N8nrQ9Ol; Fri, 21 May 2021 16:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id F04F7400CF;
	Fri, 21 May 2021 16:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B894EC000E;
	Fri, 21 May 2021 16:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11E08C0001;
 Fri, 21 May 2021 16:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04F5D83B60;
 Fri, 21 May 2021 16:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ecB6q7rJAiXp; Fri, 21 May 2021 16:39:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 234DB835ED;
 Fri, 21 May 2021 16:39:36 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id c3so20176314oic.8;
 Fri, 21 May 2021 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5L/RoK6wup09rAoEsvKy77fTqf/Hy3G7bB4uSc9Jrfo=;
 b=bqFAyMdKprEFzIQOehgF/QpinZkCeeDfL5tFBNQ13asDuiBtmMdIGIjw45Wi/3Y5me
 oF82Hmhpxyj8HJnQpCA8F95NLXPfAP+M/PgHSg7/qPNk05HV/dxoFEdmnMZjZHCml4zn
 t+hGdz605pTx50N6YK+oSkrVaGsshIv6lQVdxfcSjv5E+HRAIHpLI+nkDkkvK9qhPBPw
 eQQBK9Ae1tCVz/odacEkkVpGur8hVzacF6K351RuAPlsgybdvZhuf+Vthvd+SELkaERY
 W/IGqBl12zvPr5Ere+IbwseiceHsctu5d679XErUIhNQHXdPO4a+uNz2Fyj5bbCE8vb8
 04XQ==
X-Gm-Message-State: AOAM533jdoimXADEDpkjYnT8lA7vqY2sMkpjfjGXFyWfmh0T9Te8D+uT
 X2uUrnkZmUFeGoeK8s8ZW8R416FrLfIrP+Fc7pU=
X-Google-Smtp-Source: ABdhPJybUpZcko8bDzbsYB0EWlv5wAQPE40mmkviuVqrnlJf1vsIP3osFfCJr1yxVSlO/8tJbLKE8TlBsZTeC8zPyhw=
X-Received: by 2002:aca:4758:: with SMTP id u85mr2840877oia.71.1621615175113; 
 Fri, 21 May 2021 09:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-4-jean-philippe@linaro.org>
In-Reply-To: <20210423113836.3974972-4-jean-philippe@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 May 2021 18:39:24 +0200
Message-ID: <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: Add driver for the VIOT table
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux-foundation.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 sebastien.boeuf@intel.com, Eric Auger <eric.auger@redhat.com>,
 Hanjun Guo <guohanjun@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The ACPI Virtual I/O Translation Table describes topology of
> para-virtual platforms, similarly to vendor tables DMAR, IVRS and IORT.
> For now it describes the relation between virtio-iommu and the endpoints
> it manages.
>
> Three steps are needed to configure DMA of endpoints:
>
> (1) acpi_viot_init(): parse the VIOT table, find or create the fwnode
>     associated to each vIOMMU device.
>
> (2) When probing the vIOMMU device, the driver registers its IOMMU ops
>     within the IOMMU subsystem. This step doesn't require any
>     intervention from the VIOT driver.
>
> (3) viot_iommu_configure(): before binding the endpoint to a driver,
>     find the associated IOMMU ops. Register them, along with the
>     endpoint ID, into the device's iommu_fwspec.
>
> If step (3) happens before step (2), it is deferred until the IOMMU is
> initialized, then retried.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/Kconfig      |   3 +
>  drivers/iommu/Kconfig     |   1 +
>  drivers/acpi/Makefile     |   2 +
>  include/linux/acpi_viot.h |  19 +++
>  drivers/acpi/bus.c        |   2 +
>  drivers/acpi/scan.c       |   3 +
>  drivers/acpi/viot.c       | 350 ++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS               |   8 +
>  8 files changed, 388 insertions(+)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/viot.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index eedec61e3476..3758c6940ed7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -526,6 +526,9 @@ endif
>
>  source "drivers/acpi/pmic/Kconfig"
>
> +config ACPI_VIOT
> +       bool
> +
>  endif  # ACPI
>
>  config X86_PM_TIMER
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..aff8a4830dd1 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -403,6 +403,7 @@ config VIRTIO_IOMMU
>         depends on ARM64
>         select IOMMU_API
>         select INTERVAL_TREE
> +       select ACPI_VIOT if ACPI
>         help
>           Para-virtualised IOMMU driver with virtio.
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 700b41adf2db..a6e644c48987 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -118,3 +118,5 @@ video-objs                  += acpi_video.o video_detect.o
>  obj-y                          += dptf/
>
>  obj-$(CONFIG_ARM64)            += arm64/
> +
> +obj-$(CONFIG_ACPI_VIOT)                += viot.o
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> new file mode 100644
> index 000000000000..1eb8ee5b0e5f
> --- /dev/null
> +++ b/include/linux/acpi_viot.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_VIOT_H__
> +#define __ACPI_VIOT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_VIOT
> +void __init acpi_viot_init(void);
> +int viot_iommu_configure(struct device *dev);
> +#else
> +static inline void acpi_viot_init(void) {}
> +static inline int viot_iommu_configure(struct device *dev)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif /* __ACPI_VIOT_H__ */
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..b835ca702ff0 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -27,6 +27,7 @@
>  #include <linux/dmi.h>
>  #endif
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
> @@ -1339,6 +1340,7 @@ static int __init acpi_init(void)
>         pci_mmcfg_late_init();
>         acpi_iort_init();
>         acpi_scan_init();
> +       acpi_viot_init();
>         acpi_ec_init();
>         acpi_debugfs_init();
>         acpi_sleep_proc_init();
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5924421075f6..4db43c822ee7 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
> @@ -1554,6 +1555,8 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>                 return ops;
>
>         err = iort_iommu_configure_id(dev, id_in);
> +       if (err && err != -EPROBE_DEFER)
> +               err = viot_iommu_configure(dev);
>
>         /*
>          * If we have reason to believe the IOMMU driver missed the initial
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> new file mode 100644
> index 000000000000..710e5a5eac70
> --- /dev/null
> +++ b/drivers/acpi/viot.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual I/O topology

In the first place, more information on what this is all about, please.

What it does and how it is used.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
