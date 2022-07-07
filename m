Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F0BCCA47F
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 14:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E2A761227;
	Thu,  7 Jul 2022 14:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E2A761227
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrHgLl2pt7Dn; Thu,  7 Jul 2022 14:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0947460ADD;
	Thu,  7 Jul 2022 14:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0947460ADD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE87FC0035;
	Thu,  7 Jul 2022 14:46:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE36C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 14:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86FEE41B42
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 14:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86FEE41B42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lwDWy9gGt1Gg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 14:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A93A419B6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A93A419B6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 14:46:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D784E113E;
 Thu,  7 Jul 2022 07:46:20 -0700 (PDT)
Received: from [10.57.85.108] (unknown [10.57.85.108])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6E43F66F;
 Thu,  7 Jul 2022 07:46:19 -0700 (PDT)
Message-ID: <435b8da4-0db0-9111-badd-3fbdfd6045d5@arm.com>
Date: Thu, 7 Jul 2022 15:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] vdpa: Use device_iommu_capable()
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: mst@redhat.com, jasowang@redhat.com
References: <548e316fa282ce513fabb991a4c4d92258062eb5.1654688822.git.robin.murphy@arm.com>
In-Reply-To: <548e316fa282ce513fabb991a4c4d92258062eb5.1654688822.git.robin.murphy@arm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

On 2022-06-08 12:48, Robin Murphy wrote:
> Use the new interface to check the capability for our device
> specifically.

Just checking in case this got lost - vdpa is now the only remaining 
iommu_capable() user in linux-next, and I'd like to be able to remove 
the old interface next cycle.

Thanks,
Robin.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/vhost/vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 935a1d0ddb97..4cfebcc24a03 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1074,7 +1074,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>   	if (!bus)
>   		return -EFAULT;
>   
> -	if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> +	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
>   		return -ENOTSUPP;
>   
>   	v->domain = iommu_domain_alloc(bus);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
