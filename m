Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F932CD37B0
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 16:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A14160BD0;
	Mon, 18 Sep 2023 16:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A14160BD0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNanDA6RlIal; Mon, 18 Sep 2023 16:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01AD260B78;
	Mon, 18 Sep 2023 16:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01AD260B78
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE6A9C0039;
	Mon, 18 Sep 2023 16:37:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5FB8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 16:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82DE64074E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 16:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82DE64074E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snYxAZNz-WIP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 16:37:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C4C840164
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 16:37:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C4C840164
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BDF1FB;
 Mon, 18 Sep 2023 09:38:31 -0700 (PDT)
Received: from [10.57.94.165] (unknown [10.57.94.165])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DBE53F59C;
 Mon, 18 Sep 2023 09:37:53 -0700 (PDT)
Message-ID: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
Date: Mon, 18 Sep 2023 17:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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

On 2023-09-18 12:51, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.

Is it really a requirement? Deferred flush only deals with unmapping. Or 
are you just trying to say that it's not too worthwhile to try doing 
more for unmapping performance while obvious mapping performance is 
still left on the table?

> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..3649586f0e5c 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>   	int ret;
>   	unsigned long flags;
>   
> +	/*
> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> +	 */
> +	if (!viommu)
> +		return 0;

Minor nit: I'd be inclined to make that check explicitly in the places 
where it definitely is expected, rather than allowing *any* sync to 
silently do nothing if called incorrectly. Plus then they could use 
vdomain->nr_endpoints for consistency with the equivalent checks 
elsewhere (it did take me a moment to figure out how we could get to 
.iotlb_sync_map with a NULL viommu without viommu_map_pages() blowing up 
first...)

Thanks,
Robin.

>   	spin_lock_irqsave(&viommu->request_lock, flags);
>   	ret = __viommu_sync_req(viommu);
>   	if (ret)
> @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>   			.flags		= cpu_to_le32(flags),
>   		};
>   
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>   		if (ret) {
>   			viommu_del_mappings(vdomain, iova, end);
>   			return ret;
> @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>   	viommu_sync_req(vdomain->viommu);
>   }
>   
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>   {
>   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
>   		.unmap_pages		= viommu_unmap_pages,
>   		.iova_to_phys		= viommu_iova_to_phys,
>   		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>   		.free			= viommu_domain_free,
>   	}
>   };
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
