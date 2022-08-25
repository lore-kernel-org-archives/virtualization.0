Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBB4ECAA24
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 17:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E402160F21;
	Thu, 25 Aug 2022 17:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E402160F21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Py1bAr-7jc5v; Thu, 25 Aug 2022 17:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 250B560EFD;
	Thu, 25 Aug 2022 17:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 250B560EFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8A4C0033;
	Thu, 25 Aug 2022 17:17:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBE1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 17:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9FF560EFD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 17:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9FF560EFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2K2-dnUIUYP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 17:17:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5432160F25
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5432160F25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 17:17:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE5DD6E;
 Thu, 25 Aug 2022 10:17:27 -0700 (PDT)
Received: from [10.57.16.12] (unknown [10.57.16.12])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 192883F93E;
 Thu, 25 Aug 2022 10:17:21 -0700 (PDT)
Message-ID: <34e10279-160f-f126-2402-6dd38b9c4f5a@arm.com>
Date: Thu, 25 Aug 2022 18:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] iommu/virtio: Fix interaction with VFIO
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
References: <20220825154622.86759-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220825154622.86759-1-jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev, will@kernel.org, stable@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-08-25 16:46, Jean-Philippe Brucker wrote:
> Commit e8ae0e140c05 ("vfio: Require that devices support DMA cache
> coherence") requires IOMMU drivers to advertise
> IOMMU_CAP_CACHE_COHERENCY, in order to be used by VFIO. Since VFIO does
> not provide to userspace the ability to maintain coherency through cache
> invalidations, it requires hardware coherency. Advertise the capability
> in order to restore VFIO support.
> 
> The meaning of IOMMU_CAP_CACHE_COHERENCY also changed from "IOMMU can
> enforce cache coherent DMA transactions" to "IOMMU_CACHE is supported".

Argh! Massive apologies, I've been totally overlooking that detail and 
forgetting that we ended up splitting out the dedicated 
enforce_cache_coherency op... I do need reminding sometimes :)

> While virtio-iommu cannot enforce coherency (of PCIe no-snoop
> transactions), it does support IOMMU_CACHE.
> 
> We can distinguish different cases of non-coherent DMA:
> 
> (1) When accesses from a hardware endpoint are not coherent. The host
>      would describe such a device using firmware methods ('dma-coherent'
>      in device-tree, '_CCA' in ACPI), since they are also needed without
>      a vIOMMU. In this case mappings are created without IOMMU_CACHE.
>      virtio-iommu doesn't need any additional support. It sends the same
>      requests as for coherent devices.
> 
> (2) When the physical IOMMU supports non-cacheable mappings. Supporting
>      those would require a new feature in virtio-iommu, new PROBE request
>      property and MAP flags. Device drivers would use a new API to
>      discover this since it depends on the architecture and the physical
>      IOMMU.
> 
> (3) When the hardware supports PCIe no-snoop. It is possible for
>      assigned PCIe devices to issue no-snoop transactions, and the
>      virtio-iommu specification is lacking any mention of this.
> 
>      Arm platforms don't necessarily support no-snoop, and those that do
>      cannot enforce coherency of no-snoop transactions. Device drivers
>      must be careful about assuming that no-snoop transactions won't end
>      up cached; see commit e02f5c1bb228 ("drm: disable uncached DMA
>      optimization for ARM and arm64"). On x86 platforms, the host may or
>      may not enforce coherency of no-snoop transactions with the physical
>      IOMMU. But according to the above commit, on x86 a driver which
>      assumes that no-snoop DMA is compatible with uncached CPU mappings
>      will also work if the host enforces coherency.
> 
>      Although these issues are not specific to virtio-iommu, it could be
>      used to facilitate discovery and configuration of no-snoop. This
>      would require a new feature bit, PROBE property and ATTACH/MAP
>      flags.

Interpreted in the *correct* context, I do think this is objectively 
less wrong than before. We can't guarantee that the underlying 
implementation will respect cacheable mappings, but it is true that we 
can do everything in our power to ask for them.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: stable@vger.kernel.org
> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Since v2 [1], I tried to refine the commit message.
> This fix is needed for v5.19 and v6.0.
> 
> I can improve the check once Robin's change [2] is merged:
> capable(IOMMU_CAP_CACHE_COHERENCY) could return dev->dma_coherent for
> case (1) above.
> 
> [1] https://lore.kernel.org/linux-iommu/20220818163801.1011548-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com/
> ---
>   drivers/iommu/virtio-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 08eeafc9529f..80151176ba12 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>   }
>   
> +static bool viommu_capable(enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static struct iommu_ops viommu_ops = {
> +	.capable		= viommu_capable,
>   	.domain_alloc		= viommu_domain_alloc,
>   	.probe_device		= viommu_probe_device,
>   	.probe_finalize		= viommu_probe_finalize,
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
