Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3837C4167B
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9EB9340574;
	Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EB9340574
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gY/XfZt4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxip6i89pKMw; Fri, 25 Nov 2022 15:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 172A640575;
	Fri, 25 Nov 2022 15:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 172A640575
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52BD5C007D;
	Fri, 25 Nov 2022 15:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEFA1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 978AD820DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 978AD820DD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gY/XfZt4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gf3pmVlvL588
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAD1081ED0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAD1081ED0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388792; x=1700924792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HOdj0oUK3WbeLxjf51f9tIDc5rxKdwxZGte7o/oQccQ=;
 b=gY/XfZt4AIh5Bs9B27AklgjHxosxVhw2xrJSi5ZzbI8KQqG6IjRCxQ1T
 /1CqT1SVW+jVOXif9fP3cNKv38qW1o8XKYiRbCkWyHezQFQVED94QZ9cZ
 eSJGga8vcpIhBfxRsngxNcpN3zfupxUZLs3OtdIbTPasVZYxMEFvooidi
 PisiuKU4Au/Wp/B/2SbkD3pvWRug1VqwADAclN+i7n3MAC44I0/mi4tBX
 yj5BZAzrLScwJBt6v812jvR6qY4F5sFr0+t/MO4pBFd4nwJJf0Cy31z8M
 jpXYYZt6VgwVIX7CHRjSS539PCgE+kOud1/tQhhbDwZIG3nFrm/TcFkw+ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787356"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787356"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240249"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240249"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:30 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 04/12] vDPA/ifcvf: decouple vq IRQ releasers from the
 adapter
Date: Fri, 25 Nov 2022 22:57:16 +0800
Message-Id: <20221125145724.1129962-5-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, piotr.uminski@intel.com, stable@vger.kernel.org,
 hang.yuan@intel.com, virtualization@lists.linux-foundation.org
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

This commit decouples the IRQ releasers from the
adapter, so that these functions could be
safely invoked once probe

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 306a57c05509..7dac0285b71d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -69,10 +69,9 @@ static void ifcvf_free_irq_vectors(void *data)
 	pci_free_irq_vectors(data);
 }
 
-static void ifcvf_free_per_vq_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_per_vq_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int i;
 
 	for (i = 0; i < vf->nr_vring; i++) {
@@ -83,10 +82,9 @@ static void ifcvf_free_per_vq_irq(struct ifcvf_adapter *adapter)
 	}
 }
 
-static void ifcvf_free_vqs_reused_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_vqs_reused_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 
 	if (vf->vqs_reused_irq != -EINVAL) {
 		devm_free_irq(&pdev->dev, vf->vqs_reused_irq, vf);
@@ -95,14 +93,12 @@ static void ifcvf_free_vqs_reused_irq(struct ifcvf_adapter *adapter)
 
 }
 
-static void ifcvf_free_vq_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_vq_irq(struct ifcvf_hw *vf)
 {
-	struct ifcvf_hw *vf = &adapter->vf;
-
 	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
-		ifcvf_free_per_vq_irq(adapter);
+		ifcvf_free_per_vq_irq(vf);
 	else
-		ifcvf_free_vqs_reused_irq(adapter);
+		ifcvf_free_vqs_reused_irq(vf);
 }
 
 static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
@@ -126,8 +122,9 @@ static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
 static void ifcvf_free_irq(struct ifcvf_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
+	struct ifcvf_hw *vf = &adapter->vf;
 
-	ifcvf_free_vq_irq(adapter);
+	ifcvf_free_vq_irq(vf);
 	ifcvf_free_config_irq(adapter);
 	ifcvf_free_irq_vectors(pdev);
 }
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
