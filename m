Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8804CC49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:51:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5C1610CD
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5C1610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03F5460B0E;
	Fri, 18 Jun 2021 16:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfmO_aEIKM-g; Fri, 18 Jun 2021 16:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6548B60B10;
	Fri, 18 Jun 2021 16:51:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0484EC0023;
	Fri, 18 Jun 2021 16:51:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E897C000B;
 Fri, 18 Jun 2021 16:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F382F4011F;
 Fri, 18 Jun 2021 16:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hDo2WMvMrWs; Fri, 18 Jun 2021 16:51:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0365400CA;
 Fri, 18 Jun 2021 16:51:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A84513A1;
 Fri, 18 Jun 2021 09:51:48 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344023F70D;
 Fri, 18 Jun 2021 09:51:45 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] ACPI: Move IOMMU setup code out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-3-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7371f04-0239-5181-5493-2f6ba99f8542@arm.com>
Date: Fri, 18 Jun 2021 17:51:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-3-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: catalin.marinas@arm.com, guohanjun@huawei.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 sudeep.holla@arm.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
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
> Extract the code that sets up the IOMMU infrastructure from IORT, since
> it can be reused by VIOT. Move it one level up into a new
> acpi_iommu_configure_id() function, which calls the IORT parsing
> function which in turn calls the acpi_iommu_fwspec_init() helper.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/acpi/acpi_bus.h   |  3 ++
>   include/linux/acpi_iort.h |  8 ++---
>   drivers/acpi/arm64/iort.c | 74 +++++----------------------------------
>   drivers/acpi/scan.c       | 73 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 86 insertions(+), 72 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..41f092a269f6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -588,6 +588,9 @@ struct acpi_pci_root {
>   
>   bool acpi_dma_supported(struct acpi_device *adev);
>   enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops);
>   int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   		       u64 *size);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f7f054833afd..f1f0842a2cb2 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
>   int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>   /* IOMMU interface */
>   int iort_dma_get_ranges(struct device *dev, u64 *size);
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in);
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>   #else
> @@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>   /* IOMMU interface */
>   static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>   { return -ENODEV; }
> -static inline const struct iommu_ops *iort_iommu_configure_id(
> -				      struct device *dev, const u32 *id_in)
> -{ return NULL; }
> +static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{ return -ENODEV; }
>   static inline
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a940be1cf2af..487d1095030d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>   	return NULL;
>   }
>   
> -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
> -}
> -
> -static inline int iort_add_device_replay(struct device *dev)
> -{
> -	int err = 0;
> -
> -	if (dev->bus && !device_iommu_mapped(dev))
> -		err = iommu_probe_device(dev);
> -
> -	return err;
> -}
> -
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>   	}
>   }
>   
> -static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
> -			       struct fwnode_handle *fwnode,
> -			       const struct iommu_ops *ops)
> -{
> -	int ret = iommu_fwspec_init(dev, fwnode, ops);
> -
> -	if (!ret)
> -		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
> -
> -	return ret;
> -}
> -
>   static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>   {
>   	struct acpi_iort_root_complex *pci_rc;
> @@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>   		return iort_iommu_driver_enabled(node->type) ?
>   		       -EPROBE_DEFER : -ENODEV;
>   
> -	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
>   }
>   
>   struct iort_pci_alias_info {
> @@ -1020,24 +991,13 @@ static int iort_nc_iommu_map_id(struct device *dev,
>    * @dev: device to configure
>    * @id_in: optional input id const value pointer
>    *
> - * Returns: iommu_ops pointer on configuration success
> - *          NULL on configuration failure
> + * Returns: 0 on success, <0 on failure
>    */
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in)
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>   {
>   	struct acpi_iort_node *node;
> -	const struct iommu_ops *ops;
>   	int err = -ENODEV;
>   
> -	/*
> -	 * If we already translated the fwspec there
> -	 * is nothing left to do, return the iommu_ops.
> -	 */
> -	ops = iort_fwspec_iommu_ops(dev);
> -	if (ops)
> -		return ops;
> -
>   	if (dev_is_pci(dev)) {
>   		struct iommu_fwspec *fwspec;
>   		struct pci_bus *bus = to_pci_dev(dev)->bus;
> @@ -1046,7 +1006,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>   				      iort_match_node_callback, &bus->dev);
>   		if (!node)
> -			return NULL;
> +			return -ENODEV;
>   
>   		info.node = node;
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
> @@ -1059,7 +1019,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>   				      iort_match_node_callback, dev);
>   		if (!node)
> -			return NULL;
> +			return -ENODEV;
>   
>   		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
>   			      iort_nc_iommu_map(dev, node);
> @@ -1068,32 +1028,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   			iort_named_component_init(dev, node);
>   	}
>   
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> -	 */
> -	if (!err) {
> -		ops = iort_fwspec_iommu_ops(dev);
> -		err = iort_add_device_replay(dev);
> -	}
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err == -EPROBE_DEFER) {
> -		ops = ERR_PTR(err);
> -	} else if (err) {
> -		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -		ops = NULL;
> -	}
> -
> -	return ops;
> +	return err;
>   }
>   
>   #else
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *input_id)
> -{ return NULL; }
> +int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> +{ return -ENODEV; }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ea613df8f913..2a2e690040e9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>   #include <linux/kernel.h>
>   #include <linux/acpi.h>
>   #include <linux/acpi_iort.h>
> +#include <linux/iommu.h>
>   #include <linux/signal.h>
>   #include <linux/kthread.h>
>   #include <linux/dmi.h>
> @@ -1520,6 +1521,76 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   	return ret >= 0 ? 0 : ret;
>   }
>   
> +#ifdef CONFIG_IOMMU_API
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	int ret = iommu_fwspec_init(dev, fwnode, ops);
> +
> +	if (!ret)
> +		ret = iommu_fwspec_add_ids(dev, &id, 1);
> +
> +	return ret;
> +}
> +
> +static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	return fwspec ? fwspec->ops : NULL;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	int err;
> +	const struct iommu_ops *ops;
> +
> +	/*
> +	 * If we already translated the fwspec there is nothing left to do,
> +	 * return the iommu_ops.
> +	 */
> +	ops = acpi_iommu_fwspec_ops(dev);
> +	if (ops)
> +		return ops;
> +
> +	err = iort_iommu_configure_id(dev, id_in);
> +
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * iommu_probe_device() call for dev, replay it to get things in order.
> +	 */
> +	if (!err && dev->bus && !device_iommu_mapped(dev))
> +		err = iommu_probe_device(dev);
> +
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (err == -EPROBE_DEFER) {
> +		return ERR_PTR(err);
> +	} else if (err) {
> +		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +		return NULL;
> +	}
> +	return acpi_iommu_fwspec_ops(dev);
> +}
> +
> +#else /* !CONFIG_IOMMU_API */
> +
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	return -ENODEV;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	return NULL;
> +}
> +
> +#endif /* !CONFIG_IOMMU_API */
> +
>   /**
>    * acpi_dma_configure_id - Set-up DMA configuration for the device.
>    * @dev: The pointer to the device
> @@ -1539,7 +1610,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   
>   	acpi_arch_dma_setup(dev, &dma_addr, &size);
>   
> -	iommu = iort_iommu_configure_id(dev, input_id);
> +	iommu = acpi_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>   		return -EPROBE_DEFER;
>   
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
