Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A7AC4332F
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93B85611CA;
	Fri, 25 Nov 2022 15:06:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93B85611CA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Eqb8D/d/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5HxsFdFWeX1; Fri, 25 Nov 2022 15:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D6B360B49;
	Fri, 25 Nov 2022 15:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D6B360B49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECEABC0033;
	Fri, 25 Nov 2022 15:06:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9914FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6581081F0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6581081F0C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Eqb8D/d/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id niRwvZkqL21W
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6003821BE
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6003821BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388811; x=1700924811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K6MLOac5x03nQbMI3Jm3nrQy7Pwz2Jj+yd6eNvVvvJY=;
 b=Eqb8D/d/dCKORuoXxyc401J1fDdMte7uCVKaJZ5UaYgDElLXN8akFGF9
 /2JaxRogKIcjS1otgyfDF6EAmrlWfDx/qFCydtVuyZThg+TnY91IdYSLX
 tMp2VIIFPrkFg/rsWDr/5VqxIuq2JTpQIUqZueAvBwF1ZkXBmnzIRWVbW
 n7PcpQojcIT9a7rBNYtSZ04Bf9x2rzEVIXbr/uFvU2OLTpIwL/ixovO3b
 h1PdBU9/SBcqdJ4uY8dNTJuDRss16i9jVH/8Wg2BjBqThBXjU0L2MCT24
 93gjNBMHorpWsFNefV9wLfg1XRCjxaLvj4JIdWIiqGlNV3XmkayD3F9pj A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787480"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240303"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240303"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:49 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 11/12] vDPA/ifcvf: retire ifcvf_private_to_vf
Date: Fri, 25 Nov 2022 22:57:23 +0800
Message-Id: <20221125145724.1129962-12-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: piotr.uminski@intel.com, hang.yuan@intel.com, kvm@vger.kernel.org,
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

This commit retires ifcvf_private_to_vf, because
the vf is already a member of the adapter,
so it could be easily addressed by adapter->vf.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 ---
 drivers/vdpa/ifcvf/ifcvf_main.c | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 25bd4e927b27..d41e255c581b 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -38,9 +38,6 @@
 #define IFCVF_DBG(pdev, fmt, ...)	dev_dbg(&pdev->dev, fmt, ##__VA_ARGS__)
 #define IFCVF_INFO(pdev, fmt, ...)	dev_info(&pdev->dev, fmt, ##__VA_ARGS__)
 
-#define ifcvf_private_to_vf(adapter) \
-	(((struct ifcvf_adapter *)adapter)->vf)
-
 /* all vqs and config interrupt has its own vector */
 #define MSIX_VECTOR_PER_VQ_AND_CONFIG		1
 /* all vqs share a vector, and config interrupt has a separate vector */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 4450ddb53806..5fb3580594d5 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -346,9 +346,9 @@ static int ifcvf_request_irq(struct ifcvf_hw *vf)
 	return 0;
 }
 
-static int ifcvf_start_datapath(void *private)
+static int ifcvf_start_datapath(struct ifcvf_adapter *adapter)
 {
-	struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
+	struct ifcvf_hw *vf = adapter->vf;
 	u8 status;
 	int ret;
 
@@ -362,9 +362,9 @@ static int ifcvf_start_datapath(void *private)
 	return ret;
 }
 
-static int ifcvf_stop_datapath(void *private)
+static int ifcvf_stop_datapath(struct ifcvf_adapter *adapter)
 {
-	struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
+	struct ifcvf_hw *vf = adapter->vf;
 	int i;
 
 	for (i = 0; i < vf->nr_vring; i++)
@@ -377,7 +377,7 @@ static int ifcvf_stop_datapath(void *private)
 
 static void ifcvf_reset_vring(struct ifcvf_adapter *adapter)
 {
-	struct ifcvf_hw *vf = ifcvf_private_to_vf(adapter);
+	struct ifcvf_hw *vf = adapter->vf;
 	int i;
 
 	for (i = 0; i < vf->nr_vring; i++) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
