Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A1C61DA0
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 10:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FC42418C8;
	Wed, 25 Jan 2023 10:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FC42418C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=xjLIYBe2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-dLLOTYZTWM; Wed, 25 Jan 2023 10:59:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 604FD418C5;
	Wed, 25 Jan 2023 10:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 604FD418C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D499C0032;
	Wed, 25 Jan 2023 10:59:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C125C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60C8360F95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60C8360F95
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=xjLIYBe2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmc93pt1DA9q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:59:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BEBF60F4C
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BEBF60F4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:59:31 +0000 (UTC)
Received: from 8bytes.org
 (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de
 [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id EA1A7262E65;
 Wed, 25 Jan 2023 11:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1674644369;
 bh=T38KYBmqOO/YysbFxidRcHI2EqxeKT2mSwZbXhYqf1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xjLIYBe2Reb4sUbyDIO/QWp7US6P8C31V+nRPiKC12bUvIf7ZM2sEz6rexMly82MG
 SdqC2ipNyx624847dznAPsTr5JegX+avBcrYfRuhpCCtUCj00j5UMMKFv2s5yqcp78
 M0y7wdWzVXQ3svUwvlcuJMoxQJuspChvYRhYbBD4VgYfSxytDzzifVhHBhI3LbACxs
 T3fe0NZnfc4OI4+mzTVEq4TCO9vBUsWz4/KYFySgVFLjFM48o+FEL/Pas2FYAxM+s5
 h6WCzD311EPYK4UyWDMAMAz7XrOhVE163Ksfw3L/LtMiYeejlNUntipX85M2JSVOt+
 8KBgiGtflHGcg==
Date: Wed, 25 Jan 2023 11:59:27 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Let iommufd charge IOPTE allocations to the
 memory cgroup
Message-ID: <Y9ELj1yKsE58mlgi@8bytes.org>
References: <0-v3-76b587fe28df+6e3-iommu_map_gfp_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v3-76b587fe28df+6e3-iommu_map_gfp_jgg@nvidia.com>
Cc: kvm@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-s390@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, linux-rdma@vger.kernel.org,
 ath10k@lists.infradead.org, iommu@lists.linux.dev, ath11k@lists.infradead.org,
 linux-media@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Mon, Jan 23, 2023 at 04:35:53PM -0400, Jason Gunthorpe wrote:
> Jason Gunthorpe (10):
>   iommu: Add a gfp parameter to iommu_map()
>   iommu: Remove iommu_map_atomic()
>   iommu: Add a gfp parameter to iommu_map_sg()
>   iommu/dma: Use the gfp parameter in __iommu_dma_alloc_noncontiguous()
>   iommufd: Use GFP_KERNEL_ACCOUNT for iommu_map()
>   iommu/intel: Add a gfp parameter to alloc_pgtable_page()
>   iommu/intel: Support the gfp argument to the map_pages op
>   iommu/intel: Use GFP_KERNEL in sleepable contexts
>   iommu/s390: Push the gfp parameter to the kmem_cache_alloc()'s
>   iommu/s390: Use GFP_KERNEL in sleepable contexts

Merged into branch iommu-memory-accounting and merged that branch into
core.

The merge commit contains your cover-letter descriptions. Given all
tests pass I will push it out later today.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
