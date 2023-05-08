Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC90C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 10:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC88281FAB;
	Mon,  8 May 2023 10:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC88281FAB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PjJu9OUy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oyft6HFE0Lcx; Mon,  8 May 2023 10:05:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5782E81F56;
	Mon,  8 May 2023 10:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5782E81F56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33B27C008D;
	Mon,  8 May 2023 10:05:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6D1C0037
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1657241B52
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1657241B52
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PjJu9OUy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T31JBBjLPrGx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46A1441B36
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46A1441B36
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683540329; x=1715076329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u4cOkH7/q+SQ1z1WGw9j+lpmUGHSbSpnABFa/da+m80=;
 b=PjJu9OUyFq7iA++vWr9LGwEG6w9MgYzWQCPZd52pmPeONrfIHAtKTXGY
 Isvf+MEMCd5lDMzvV0RYLyVnAW2aYIYgLj+54jc10QlFqAiZqtcS6Wvdv
 9BoJjPr2t7cfLz3+hSRcbRMXNY6/YHd/UiY4P99JfQwV0VzHOoBrM1LyT
 dxOo2HNYjNWvt6Q3pIwBf/W9EpBfSu7xlGtvf7oTwGg26vDXz9tvAYc1w
 0VgTN7AXq7p3NFMLndNUKLUVn2jLw/E77fz8+VuoQRMbJKOOq6coKJTkV
 /skQ/tB6hwAcOEqG9+Hv8K9nEJscnRibdC0D+YYXIAfHc9izcY+eEHfr8 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338828033"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="338828033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 03:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842639102"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="842639102"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 03:05:27 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 5/5] vDPA/ifcvf: a vendor driver should not set
 _CONFIG_S_FAILED
Date: Tue,  9 May 2023 02:05:12 +0800
Message-Id: <20230508180512.17371-6-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230508180512.17371-1-lingshan.zhu@intel.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org
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

VIRTIO_CONFIG_S_FAILED indicates the guest driver has given up
the device due to fatal errors. So it is the guest decision,
the vendor driver should not set this status to the device.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 3401b9901dd2..b413688e13c4 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -426,9 +426,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		ret = ifcvf_request_irq(vf);
 		if (ret) {
-			status = ifcvf_get_status(vf);
-			status |= VIRTIO_CONFIG_S_FAILED;
-			ifcvf_set_status(vf, status);
+			IFCVF_ERR(vf->pdev, "failed to request irq with error %d\n", ret);
 			return;
 		}
 	}
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
