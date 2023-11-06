Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C2C4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F9B641DF5;
	Mon,  6 Nov 2023 07:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F9B641DF5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iCGJDlT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id he7pFwvxgiCY; Mon,  6 Nov 2023 07:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C0CF41DD8;
	Mon,  6 Nov 2023 07:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C0CF41DD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E815BC0071;
	Mon,  6 Nov 2023 07:14:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D21C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E94A461043
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E94A461043
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iCGJDlT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zStnm526QdkT
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59703610BF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59703610BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699254846; x=1730790846;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gWxXYuEpy8G84pCRxEr8zR2qYt2dBXJPyl6P3BJNrtQ=;
 b=iCGJDlT80R6YCHX5t8JBh5lfoEhLNwqldMKYrIszg6vl+2jAWpg5MPKj
 fv+avqXdwNJAvcnaROHzr7Uj+ktrVGazLbsl9UNRcUx0SF30HdDfCqlpR
 QywpLBbS6x8zTZK6oaS4ifXvKn87imaFo7sF9SANme1m9GXEIvud7r/Um
 /Sqh1MKpPmzSx/91yGbI4BNHot85N1WZLNvrsCXRCntnYJacqJbkhIM+v
 TW8pa2lCHZxn9reEIlKOAs/agXepX84ib4yGF5wuVS68x+Qh1+Ub1PsxX
 JtQfbovuLeU9g2z3YGPNvEm6YbT6xLNd8k+i+Skz1m5nSRVnounzUB339 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759060"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="10759060"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 23:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690893"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="1093690893"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:02 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [RFC PATCH 3/5] iommu/io-pgtable: Introduce struct vtd_cfg
Date: Mon,  6 Nov 2023 02:12:24 -0500
Message-Id: <20231106071226.9656-4-tina.zhang@intel.com>
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

VT-d hardware cap/ecap information is needed for driver to generate VT-d
format IO page table. Add struct vtd_cfg to keep the info.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/io-pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b2857c18f963..ae6a2e44b027 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,11 @@ struct io_pgtable_cfg {
 			u32 n_ttbrs;
 		} apple_dart_cfg;
 
+		struct {
+			u64 cap_reg;
+			u64 ecap_reg;
+		} vtd_cfg;
+
 		struct {
 			dma_addr_t	pgd;
 		} virt;
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
