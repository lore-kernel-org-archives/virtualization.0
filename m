Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73891C433FE
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 11:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E309828AF;
	Tue,  7 Dec 2021 11:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aV-AyXUWaWDc; Tue,  7 Dec 2021 11:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 909448277E;
	Tue,  7 Dec 2021 11:44:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 885FBC0072;
	Tue,  7 Dec 2021 11:44:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F65C0012;
 Tue,  7 Dec 2021 11:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54CCC828AF;
 Tue,  7 Dec 2021 11:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AeLO-G5Troi9; Tue,  7 Dec 2021 11:44:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CCA98277E;
 Tue,  7 Dec 2021 11:44:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EC4B11FB;
 Tue,  7 Dec 2021 03:44:19 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 358823F73B;
 Tue,  7 Dec 2021 03:44:18 -0800 (PST)
Message-ID: <858e55cc-6afe-6b8a-41fd-4bd707d2ddc6@arm.com>
Date: Tue, 7 Dec 2021 11:44:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] iova: Move fast alloc size roundup into
 alloc_iova_fast()
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <1638875846-23993-1-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1638875846-23993-1-git-send-email-john.garry@huawei.com>
Cc: xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, mst@redhat.com
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

On 2021-12-07 11:17, John Garry wrote:
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.

I'd still much prefer to resolve the issue that there shouldn't *be* 
more than one caller in the first place, but hey.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Differences to v1:
> - Separate out from original series which conflicts with Robin's IOVA FQ work:
>    https://lore.kernel.org/linux-iommu/1632477717-5254-1-git-send-email-john.garry@huawei.com/
> - Add tags - thanks!
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b42e38a0dbe2..84dee53fe892 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -442,14 +442,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   
>   	shift = iova_shift(iovad);
>   	iova_len = size >> shift;
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>   
>   	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>   
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   	unsigned long iova_pfn;
>   	struct iova *new_iova;
>   
> +	/*
> +	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +	 * will come back to bite us badly, so we have to waste a bit of space
> +	 * rounding up anything cacheable to make sure that can't happen. The
> +	 * order of the unadjusted size will still match upon freeing.
> +	 */
> +	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +		size = roundup_pow_of_two(size);
> +
>   	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>   	if (iova_pfn)
>   		return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>   	unsigned long iova_len = iova_align(iovad, size) >> shift;
>   	unsigned long iova_pfn;
>   
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>   	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>   
>   	return iova_pfn << shift;
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
