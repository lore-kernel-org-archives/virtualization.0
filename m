Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D5C43460
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6006F61390
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6006F61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3978660BF2;
	Thu,  1 Apr 2021 16:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n62clrf2KKnX; Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B09E760BE8;
	Thu,  1 Apr 2021 16:56:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E55EC000C;
	Thu,  1 Apr 2021 16:56:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63617C0017;
 Thu,  1 Apr 2021 16:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E94741889;
 Thu,  1 Apr 2021 16:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xz_6k7UtEUFn; Thu,  1 Apr 2021 16:56:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 767964187F;
 Thu,  1 Apr 2021 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=F/At/y3YpRYA0xMifJb6WYaRvzw/qWs4U1Utp3fOA3I=; b=HFkBoDC2gQqzR0/BMkABluFzVb
 3gakMZuzB5XR+6BX0Aj1OytKg2i4hAn10GfCqqYygamx5QBLvyvglTO+CwociDtgFFHoBElQl2z9C
 8vSKoiBIAW3F6tqOLYPp5fiGR2bP6vbJGLE7cWb6BixFCeOSNvJ4K1maSU3n4g1Q7mpPZT2T07c35
 IOMTZ0zeIeEGgKA2dxIZ8EK0kU0QMV3JhqqKyPs1AV8kBZN19SvvyFxFLUzRFNH5pIb+XJhARJbkW
 zRtou/lbZms6YtiTWLVyM7tCMX4ldsM7ZmafF6EhBjKGqEfhr9PhwxC99sSvMht8lYVuOOmKk4W3l
 pxTq5pyQ==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzd6-00CiZO-UO; Thu, 01 Apr 2021 15:53:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: cleanup unused or almost unused IOMMU APIs and the FSL PAMU driver v3
Date: Thu,  1 Apr 2021 17:52:36 +0200
Message-Id: <20210401155256.298656-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org, Lu Baolu <baolu.lu@linux.intel.com>
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

Hi all,

there are a bunch of IOMMU APIs that are entirely unused, or only used as
a private communication channel between the FSL PAMU driver and it's only
consumer, the qbman portal driver.

So this series drops a huge chunk of entirely unused FSL PAMU
functionality, then drops all kinds of unused IOMMU APIs, and then
replaces what is left of the iommu_attrs with properly typed, smaller
and easier to use specific APIs.

Changes since v2:
 - remove a comment fragment a little bit earlier
 - fix the aperture end passed to pamu_config_ppaace
 - fix a few trivial typos
 - remove more unused arguments to pamu_config_ppaace
 - do not accidentally enable lazy flushing for non-dma domains

Changes since v1:
 - use a different way to control strict flushing behavior (from Robin)
 - remove the iommu_cmd_line wrappers
 - simplify the pagetbl quirks a little more
 - slightly improved patch ordering
 - better changelogs

Diffstat:
 arch/powerpc/include/asm/fsl_pamu_stash.h   |   12 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |    5 
 drivers/iommu/amd/iommu.c                   |   23 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   75 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |    1 
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  111 +---
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |    2 
 drivers/iommu/dma-iommu.c                   |    9 
 drivers/iommu/fsl_pamu.c                    |  293 -----------
 drivers/iommu/fsl_pamu.h                    |   12 
 drivers/iommu/fsl_pamu_domain.c             |  688 ++--------------------------
 drivers/iommu/fsl_pamu_domain.h             |   46 -
 drivers/iommu/intel/iommu.c                 |   95 ---
 drivers/iommu/iommu.c                       |  118 +---
 drivers/soc/fsl/qbman/qman_portal.c         |   55 --
 drivers/vfio/vfio_iommu_type1.c             |   31 -
 drivers/vhost/vdpa.c                        |   10 
 include/linux/io-pgtable.h                  |    4 
 include/linux/iommu.h                       |   76 ---
 19 files changed, 203 insertions(+), 1463 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
