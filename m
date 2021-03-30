Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3662BC433C1
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC38D61994
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC38D61994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C04F83A5B;
	Tue, 30 Mar 2021 13:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcwZGZnrcH_A; Tue, 30 Mar 2021 13:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4762983A6C;
	Tue, 30 Mar 2021 13:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C95A5C0015;
	Tue, 30 Mar 2021 13:11:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20421C000A;
 Tue, 30 Mar 2021 13:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E86483A6A;
 Tue, 30 Mar 2021 13:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JqywRY5e5u7M; Tue, 30 Mar 2021 13:11:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EFC283A5B;
 Tue, 30 Mar 2021 13:11:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3807E6190A;
 Tue, 30 Mar 2021 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617109915;
 bh=E7y/dbAAWo9buKdnhgJzSLhrZuvZjF7e5JPqlaZDmKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nAM/OfXEJ+5P0AOFZGxwgS6k50PSZ6ZL+0SdM34bRXqilkdD1BMlp5kMlv2jKqeXJ
 RFq44I5uncbXNQhliA7OD3QPB8lN5hZkxWoXcop6y/Y1IBJ/rcfxLyHIo2tS0SpYkp
 OrUIMp3MFAVbY8783Qbhv1kqq1hoEVaLylEPRKuYQXQBu5/MlghjYIEFwHWboYdrOO
 pByYsjfgLgrsFLdpXDlg/y+xqfu7E4iOvnHrOCmu5gaK38t1EdeblYuZ40EdwPrZjo
 qX1I0Z4jkjNv3rxdihUqdwy79Vet1JWSllchMLwPrvfbEnP8SACK28FDZ/JTY6Eypo
 iicajwfBXpXWA==
Date: Tue, 30 Mar 2021 14:11:49 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/18] iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
Message-ID: <20210330131149.GP5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-17-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-17-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
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

On Tue, Mar 16, 2021 at 04:38:22PM +0100, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Instead make the global iommu_dma_strict paramete in iommu.c canonical by
> exporting helpers to get and set it and use those directly in the drivers.
> 
> This make sure that the iommu.strict parameter also works for the AMD and
> Intel IOMMU drivers on x86.  As those default to lazy flushing a new
> IOMMU_CMD_LINE_STRICT is used to turn the value into a tristate to
> represent the default if not overriden by an explicit parameter.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>.
> [ported on top of the other iommu_attr changes and added a few small
>  missing bits]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/amd/iommu.c                   | 23 +-------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +---------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 27 +--------
>  drivers/iommu/dma-iommu.c                   |  9 +--
>  drivers/iommu/intel/iommu.c                 | 64 ++++-----------------
>  drivers/iommu/iommu.c                       | 27 ++++++---
>  include/linux/iommu.h                       |  4 +-
>  8 files changed, 40 insertions(+), 165 deletions(-)

I really like this cleanup, but I can't help wonder if it's going in the
wrong direction. With SoCs often having multiple IOMMU instances and a
distinction between "trusted" and "untrusted" devices, then having the
flush-queue enabled on a per-IOMMU or per-domain basis doesn't sound
unreasonable to me, but this change makes it a global property.

For example, see the recent patch from Lu Baolu:

https://lore.kernel.org/r/20210225061454.2864009-1-baolu.lu@linux.intel.com

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
