Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BEC48BE5
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E447861352
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E447861352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB53983145;
	Tue, 22 Jun 2021 07:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l7sL76GUymwV; Tue, 22 Jun 2021 07:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 290C3831A7;
	Tue, 22 Jun 2021 07:46:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C887EC0023;
	Tue, 22 Jun 2021 07:46:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0289C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADA69606DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzGTi0hrlQD4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:46:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD70760615
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624347992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5f3bvS7GZvWVtyFwxLN1QlKyB6zTisOpr3FYaadj24=;
 b=bVOwMkQwhyb3DuvJ5xWD+WrrbCmMAME/iIblyM7iLbHLF9PekWmDurOGR5btCGB14HmxXR
 7jcfgmcpSpVoMBsgxCo5hO1oCzlmnGWMmg/5f3aXXoySdTMUMkZ176iz1T+Yhpk/EFKVFT
 De9EUNxR0ffA8P+4Ml0IuypoCbK8UEM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-pUBYuhlAMdWTP1tJV1wiRw-1; Tue, 22 Jun 2021 03:46:29 -0400
X-MC-Unique: pUBYuhlAMdWTP1tJV1wiRw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l9-20020a05600c1d09b02901dc060832e2so969315wms.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 00:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=x5f3bvS7GZvWVtyFwxLN1QlKyB6zTisOpr3FYaadj24=;
 b=m0T0J+P4t62ni4pNeVmDpw4q+H8wxLLChBgsuhKphMZeoqcPVQFEYp0gfx29v96YGL
 ikXtaGlZ+TLxfUyg1SDaiVm878AJAdcYohXmoBGkikJAXZbtmc8ioLCm3Hod+xoBpO19
 EIriobizAme1R96p1aDrbr0ui6OGasY0nAqU+DRDfnyVjhtiKG2w6T5ACsHJqEb7mbpZ
 X2wkWoLgvY08x+FYJsGvhGNpSS5J0s4wiah4tmiAGLL2zVtbsH8Hw+EBVjKqrSulV++9
 wBEJP+TldnCCQXpPN5lTOP/Hvblxv9tSklhwoJT/H9JCQSAAGLJkcAY3Pm/lMc/EnlRr
 XYSw==
X-Gm-Message-State: AOAM531xXes9gpVBkLgZ88qXy9ufivlIzNN1lngm0qRuPnoRz963hcYs
 g2aygbg5Ka0p5slpNbWb95XnGb4ehLl2S9/hFsZ9LsRlF2qkItvDjpD3DKyauD14WBUbelXInVM
 G/wM1Q1VG9tsPogG/y35T6Rs+HQOvHSYMDr09ohYSXQ==
X-Received: by 2002:adf:c54b:: with SMTP id s11mr3106164wrf.349.1624347988047; 
 Tue, 22 Jun 2021 00:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7QcWI8FJ95aqU4FW0VTatFzT/ZlH2y3xbB+zmvo9mrdoUIlvfW4P0sodDcWmUan4mPoZSHw==
X-Received: by 2002:adf:c54b:: with SMTP id s11mr3106134wrf.349.1624347987821; 
 Tue, 22 Jun 2021 00:46:27 -0700 (PDT)
Received: from [192.168.43.95] ([37.173.9.63])
 by smtp.gmail.com with ESMTPSA id g10sm1443719wmh.33.2021.06.22.00.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 00:46:27 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] ACPI: Move IOMMU setup code out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-3-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <6da435e7-3204-e0d1-4c53-e7115e537cb5@redhat.com>
Date: Tue, 22 Jun 2021 09:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-3-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,
On 6/18/21 5:20 PM, Jean-Philippe Brucker wrote:
> Extract the code that sets up the IOMMU infrastructure from IORT, since
> it can be reused by VIOT. Move it one level up into a new
> acpi_iommu_configure_id() function, which calls the IORT parsing
> function which in turn calls the acpi_iommu_fwspec_init() helper.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  include/acpi/acpi_bus.h   |  3 ++
>  include/linux/acpi_iort.h |  8 ++---
>  drivers/acpi/arm64/iort.c | 74 +++++----------------------------------
>  drivers/acpi/scan.c       | 73 +++++++++++++++++++++++++++++++++++++-
>  4 files changed, 86 insertions(+), 72 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..41f092a269f6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -588,6 +588,9 @@ struct acpi_pci_root {
>  
>  bool acpi_dma_supported(struct acpi_device *adev);
>  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops);
>  int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  		       u64 *size);
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f7f054833afd..f1f0842a2cb2 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in);
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
> @@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>  /* IOMMU interface */
>  static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  { return -ENODEV; }
> -static inline const struct iommu_ops *iort_iommu_configure_id(
> -				      struct device *dev, const u32 *id_in)
> -{ return NULL; }
> +static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{ return -ENODEV; }
>  static inline
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a940be1cf2af..487d1095030d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
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
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>  	}
>  }
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
>  static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_root_complex *pci_rc;
> @@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>  		return iort_iommu_driver_enabled(node->type) ?
>  		       -EPROBE_DEFER : -ENODEV;
>  
> -	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
>  }
>  
>  struct iort_pci_alias_info {
> @@ -1020,24 +991,13 @@ static int iort_nc_iommu_map_id(struct device *dev,
>   * @dev: device to configure
>   * @id_in: optional input id const value pointer
>   *
> - * Returns: iommu_ops pointer on configuration success
> - *          NULL on configuration failure
> + * Returns: 0 on success, <0 on failure
>   */
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in)
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>  	struct acpi_iort_node *node;
> -	const struct iommu_ops *ops;
>  	int err = -ENODEV;
>  
> -	/*
> -	 * If we already translated the fwspec there
> -	 * is nothing left to do, return the iommu_ops.
> -	 */
> -	ops = iort_fwspec_iommu_ops(dev);
> -	if (ops)
> -		return ops;
> -
>  	if (dev_is_pci(dev)) {
>  		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> @@ -1046,7 +1006,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>  				      iort_match_node_callback, &bus->dev);
>  		if (!node)
> -			return NULL;
> +			return -ENODEV;
>  
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> @@ -1059,7 +1019,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>  				      iort_match_node_callback, dev);
>  		if (!node)
> -			return NULL;
> +			return -ENODEV;
>  
>  		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
>  			      iort_nc_iommu_map(dev, node);
> @@ -1068,32 +1028,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  			iort_named_component_init(dev, node);
>  	}
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
>  }
>  
>  #else
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *input_id)
> -{ return NULL; }
> +int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ea613df8f913..2a2e690040e9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/iommu.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
>  #include <linux/dmi.h>
> @@ -1520,6 +1521,76 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  	return ret >= 0 ? 0 : ret;
>  }
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
>  /**
>   * acpi_dma_configure_id - Set-up DMA configuration for the device.
>   * @dev: The pointer to the device
> @@ -1539,7 +1610,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  
>  	acpi_arch_dma_setup(dev, &dma_addr, &size);
>  
> -	iommu = iort_iommu_configure_id(dev, input_id);
> +	iommu = acpi_iommu_configure_id(dev, input_id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
