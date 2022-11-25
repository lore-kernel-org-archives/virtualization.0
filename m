Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B52AC4332F
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F22241961;
	Fri, 25 Nov 2022 15:06:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F22241961
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdzEef9Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAveaX8ISYph; Fri, 25 Nov 2022 15:06:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A5D441926;
	Fri, 25 Nov 2022 15:06:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A5D441926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44BEFC0033;
	Fri, 25 Nov 2022 15:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF0FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A5B082162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A5B082162
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JdzEef9Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AK6glcq0HRO2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 016D382156
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 016D382156
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388804; x=1700924804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sc7yv6l7w+mdzUT7XAZNvCklCr0OubkKRD1No7y/EJw=;
 b=JdzEef9Z5lk8f56+IqKrKbTrqBbJAOI4a527ZjtErzdh2z+8SK0IMtbr
 Lmwho+QLhBdd5DN/GK86BFgo+SK/JtD/XJ2UQnXiukdUtJJlsvFwpdOU3
 BGmQpeOx2oDpV9Q0on3hBUBKAjMBFzRY2l97aJKiBxOD24mC54GkaRLeF
 wnTAItdbx7TMCaS7DUuOQ+myFb3ilPFusdcPEUsZCf3nGv3rzwDMUqpMp
 3tP7pkAC4+DOq9YfxpK1MIF12hXbfgpZqlcUOonNX4SRawg6nLrUe0a8g
 /5ieuBe/EHbud1CUJfH2jgpbBpB8JTk0PsCcwrzPTzXB+bGTP22dmO63Z A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787437"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240289"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240289"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:41 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 08/12] vDPA/ifcvf: ifcvf_request_irq works on ifcvf_hw
Date: Fri, 25 Nov 2022 22:57:20 +0800
Message-Id: <20221125145724.1129962-9-lingshan.zhu@intel.com>
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

All ifcvf_request_irq's callees are refactored
to work on ifcvf_hw, so it should be decoupled
from the adapter as well

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8320bdacace8..cb3df395d3fb 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -314,9 +314,8 @@ static int ifcvf_request_config_irq(struct ifcvf_hw *vf)
 	return -EFAULT;
 }
 
-static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_irq(struct ifcvf_hw *vf)
 {
-	struct ifcvf_hw *vf = &adapter->vf;
 	int nvectors, ret, max_intr;
 
 	nvectors = ifcvf_alloc_vectors(vf);
@@ -468,7 +467,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		ret = ifcvf_request_irq(adapter);
+		ret = ifcvf_request_irq(vf);
 		if (ret) {
 			status = ifcvf_get_status(vf);
 			status |= VIRTIO_CONFIG_S_FAILED;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
