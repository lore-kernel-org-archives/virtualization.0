Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C3EC49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D562613E2
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D562613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0262415D7;
	Fri, 18 Jun 2021 16:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzaXLUQxEL7p; Fri, 18 Jun 2021 16:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09384415CC;
	Fri, 18 Jun 2021 16:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9BA7C0023;
	Fri, 18 Jun 2021 16:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D6BC000B;
 Fri, 18 Jun 2021 16:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C11526062C;
 Fri, 18 Jun 2021 16:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFELbU4WwZrZ; Fri, 18 Jun 2021 16:36:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B37B2607D1;
 Fri, 18 Jun 2021 16:36:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FC7813A1;
 Fri, 18 Jun 2021 09:36:04 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411503F70D;
 Fri, 18 Jun 2021 09:36:01 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] ACPI: arm64: Move DMA setup operations out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-2-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca1668fa-7aec-fba1-9adb-ed9f932253fd@arm.com>
Date: Fri, 18 Jun 2021 17:35:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-2-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com
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

On 2021-06-18 16:20, Jean-Philippe Brucker wrote:
> Extract generic DMA setup code out of IORT, so it can be reused by VIOT.
> Keep it in drivers/acpi/arm64 for now, since it could break x86
> platforms that haven't run this code so far, if they have invalid
> tables.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/acpi/arm64/Makefile |  1 +
>   include/linux/acpi.h        |  3 +++
>   include/linux/acpi_iort.h   |  6 ++---
>   drivers/acpi/arm64/dma.c    | 50 ++++++++++++++++++++++++++++++++++
>   drivers/acpi/arm64/iort.c   | 54 ++++++-------------------------------
>   drivers/acpi/scan.c         |  2 +-
>   6 files changed, 66 insertions(+), 50 deletions(-)
>   create mode 100644 drivers/acpi/arm64/dma.c
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 6ff50f4ed947..66acbe77f46e 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-y				+= dma.o
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..7aaa9559cc19 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -259,9 +259,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>   
>   #ifdef CONFIG_ARM64
>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
>   #else
>   static inline void
>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> +static inline void
> +acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
>   #endif
>   
>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..f7f054833afd 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -34,7 +34,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>   void acpi_configure_pmsi_domain(struct device *dev);
>   int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>   /* IOMMU interface */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
> +int iort_dma_get_ranges(struct device *dev, u64 *size);
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> @@ -48,8 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(
>   { return NULL; }
>   static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>   /* IOMMU interface */
> -static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
> -				  u64 *size) { }
> +static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
> +{ return -ENODEV; }
>   static inline const struct iommu_ops *iort_iommu_configure_id(
>   				      struct device *dev, const u32 *id_in)
>   { return NULL; }
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> new file mode 100644
> index 000000000000..f16739ad3cc0
> --- /dev/null
> +++ b/drivers/acpi/arm64/dma.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
> +#include <linux/device.h>
> +#include <linux/dma-direct.h>
> +
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +{
> +	int ret;
> +	u64 end, mask;
> +	u64 dmaaddr = 0, size = 0, offset = 0;
> +
> +	/*
> +	 * If @dev is expected to be DMA-capable then the bus code that created
> +	 * it should have initialised its dma_mask pointer by this point. For
> +	 * now, we'll continue the legacy behaviour of coercing it to the
> +	 * coherent mask if not, but we'll no longer do so quietly.
> +	 */
> +	if (!dev->dma_mask) {
> +		dev_warn(dev, "DMA mask not set\n");
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +	}
> +
> +	if (dev->coherent_dma_mask)
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	else
> +		size = 1ULL << 32;
> +
> +	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	if (ret == -ENODEV)
> +		ret = iort_dma_get_ranges(dev, &size);
> +	if (!ret) {
> +		/*
> +		 * Limit coherent and dma mask based on size retrieved from
> +		 * firmware.
> +		 */
> +		end = dmaaddr + size - 1;
> +		mask = DMA_BIT_MASK(ilog2(end) + 1);
> +		dev->bus_dma_limit = end;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);
> +	}
> +
> +	*dma_addr = dmaaddr;
> +	*dma_size = size;
> +
> +	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> +
> +	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +}
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..a940be1cf2af 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1144,56 +1144,18 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>   }
>   
>   /**
> - * iort_dma_setup() - Set-up device DMA parameters.
> + * iort_dma_get_ranges() - Look up DMA addressing limit for the device
> + * @dev: device to lookup
> + * @size: DMA range size result pointer
>    *
> - * @dev: device to configure
> - * @dma_addr: device DMA address result pointer
> - * @dma_size: DMA range size result pointer
> + * Return: 0 on success, an error otherwise.
>    */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +int iort_dma_get_ranges(struct device *dev, u64 *size)
>   {
> -	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
> -	int ret;
> -
> -	/*
> -	 * If @dev is expected to be DMA-capable then the bus code that created
> -	 * it should have initialised its dma_mask pointer by this point. For
> -	 * now, we'll continue the legacy behaviour of coercing it to the
> -	 * coherent mask if not, but we'll no longer do so quietly.
> -	 */
> -	if (!dev->dma_mask) {
> -		dev_warn(dev, "DMA mask not set\n");
> -		dev->dma_mask = &dev->coherent_dma_mask;
> -	}
> -
> -	if (dev->coherent_dma_mask)
> -		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	if (dev_is_pci(dev))
> +		return rc_dma_get_range(dev, size);
>   	else
> -		size = 1ULL << 32;
> -
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -	if (ret == -ENODEV)
> -		ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
> -				      : nc_dma_get_range(dev, &size);
> -
> -	if (!ret) {
> -		/*
> -		 * Limit coherent and dma mask based on size retrieved from
> -		 * firmware.
> -		 */
> -		end = dmaaddr + size - 1;
> -		mask = DMA_BIT_MASK(ilog2(end) + 1);
> -		dev->bus_dma_limit = end;
> -		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> -		*dev->dma_mask = min(*dev->dma_mask, mask);
> -	}
> -
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +		return nc_dma_get_range(dev, size);
>   }
>   
>   static void __init acpi_iort_register_irq(int hwirq, const char *name,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e10d38ac7cf2..ea613df8f913 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1537,7 +1537,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   		return 0;
>   	}
>   
> -	iort_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev, &dma_addr, &size);
>   
>   	iommu = iort_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
