Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41426C43334
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 12:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6F6D61545;
	Thu, 14 Jul 2022 12:01:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6F6D61545
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id preB755kwFAC; Thu, 14 Jul 2022 12:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 941C06151D;
	Thu, 14 Jul 2022 12:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 941C06151D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 754A2C0033;
	Thu, 14 Jul 2022 12:01:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 456F3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 12:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 114ED846FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 12:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 114ED846FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPt4bJWiD5dn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 12:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF40880BED
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF40880BED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 12:01:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66CA213D5;
 Thu, 14 Jul 2022 05:01:44 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B423F792;
 Thu, 14 Jul 2022 05:01:42 -0700 (PDT)
Message-ID: <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
Date: Thu, 14 Jul 2022 13:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
References: <20220714111059.708735-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220714111059.708735-1-jean-philippe@linaro.org>
Cc: eric.auger@redhat.com, iommu@lists.linux.dev, will@kernel.org,
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

On 2022-07-14 12:11, Jean-Philippe Brucker wrote:
> Fix virtio-iommu interaction with VFIO, as VFIO now requires
> IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
> mappings, and always expects to be called with IOMMU_CACHE.

Can we know this is actually true though? What if the virtio-iommu 
implementation is backed by something other than VFIO, and the 
underlying hardware isn't coherent? AFAICS the spec doesn't disallow that.

Thanks,
Robin.

> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/virtio-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..bf340d779c10 100644
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
