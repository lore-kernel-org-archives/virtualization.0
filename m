Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799D5C4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1491C41DCA;
	Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1491C41DCA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yz3QYMGX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ol5T-29KKK3P; Mon,  6 Nov 2023 07:14:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9416841DD9;
	Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9416841DD9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C759C0071;
	Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01E5DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2B2261043
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2B2261043
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Yz3QYMGX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-i_N3xV1WuH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A64361038
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A64361038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699254841; x=1730790841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c9GeMl676tMxuvRJHqXrxAMwFdaSUf5heq0NrXZPU0Q=;
 b=Yz3QYMGXBJaVza0EErGtDr++UqnzoYwipTPYBeeJZIjZITKxzCNvxyGV
 KKMiM9oe9bDJdynXu5iR4jDXxeE8W+vLpWHzrthCKCkcDOF1q8woWVMRT
 kyxVKLDI3dC5HsfrKiiElE4+lgelm0dCGwKJw5AWPpD1eXuiKUVAZl5i8
 OQprKUnp0uHtkv8jhE5TW13W7zobrb5UwfKAPRX69pMGcS41kg11Ysd8l
 PShFL+qPhrtR/6mf2KjT6eBw4SVKDTf0f00AJ2gvk9FRwqeLmSxBiNr6B
 jExKqBxZgF4P6i6w3y2B2P9wXUbivZW8Qbh8UuDFFVryElB5cA4we0pft g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759044"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="10759044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 23:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690868"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="1093690868"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:13:57 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [RFC PATCH 1/5] iommu/virtio-iommu: Correct the values of granule and
 nr_pages
Date: Mon,  6 Nov 2023 02:12:22 -0500
Message-Id: <20231106071226.9656-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The value of granule is ilog2(pgsize). When the value of pgsize isn't
a power of two, granule would make pgsize less than the actual size of
pgsize. E.g., if pgsize = 0x6000 and granule = ilog2(gather->pgsize), then
granule = 0xe. 2^0xe = 0x4000 makes the pgsize (0x4000) smaller than the
actual pgsize (0x6000). Invalidating IOTLB with smaller range would lead
to cache incoherence. So, roundup pgsize value to the nearest power of 2
to make sure the granule won't make pgsize less than the actual size. The
value of "gather->end - gather->start + 1" also needs similar adjustment.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08e310672e57..b1ceaac974e2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1289,8 +1289,8 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 		if (!gather->pgsize)
 			return;
 
-		granule = ilog2(gather->pgsize);
-		nr_pages = (gather->end - gather->start + 1) >> granule;
+		granule = ilog2(__roundup_pow_of_two(gather->pgsize));
+		nr_pages = __roundup_pow_of_two(gather->end - gather->start + 1) >> granule;
 		req = (struct virtio_iommu_req_invalidate) {
 			.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
 			.inv_gran	= cpu_to_le16(VIRTIO_IOMMU_INVAL_G_VA),
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
