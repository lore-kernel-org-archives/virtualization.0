Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA744C761AF
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84A3F420C4;
	Fri, 31 Mar 2023 12:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84A3F420C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mqmzzj6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYDNaME8io7S; Fri, 31 Mar 2023 12:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CB8C420B6;
	Fri, 31 Mar 2023 12:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CB8C420B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC616C0036;
	Fri, 31 Mar 2023 12:49:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDCEBC007C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A84084224C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A84084224C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Mqmzzj6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id My6YgTiVv-Nj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4812422D4
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4812422D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266950; x=1711802950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n+5+SUZzPrxatwYjN1ApwjxG0eo4koKtFj5Tv7Hn1hA=;
 b=Mqmzzj6sNX+vxnQUxiYBKmWRdF7KcpzSnAU2D5Ke25Dlpe4fGuJqEGF7
 b/FX3jTx91rIkz0tgdlhvDnYwbCGssfTW2HozBs8OWuPH6cVHF0rZbVLu
 nDF6Tl5dZk+by2gdCCFjd2z8O9wS/snDzp1MXJIKZJG1x70b50LidMFi/
 Gy9YCsodsymLLrHQB+of9FvdHBR8M1bpTwrdq+Okff6ZYOvnu154lCCjB
 uiDQv6pt7X+uvEOOpnr/wd6xMHsZ+p0c+QRxdCwwaFemAZQWFeDx5jan+
 VC2tVZl7yIgGuuXLKz1VY+O0e+dD17uZgsCWhCRrW7yl/e+7+p4kdWr6q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162367"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162367"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931156007"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931156007"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:49:06 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 5/5] a vendor driver should not set _CONFIG_S_FAILED
Date: Sat,  1 Apr 2023 04:48:54 +0800
Message-Id: <20230331204854.20082-6-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230331204854.20082-1-lingshan.zhu@intel.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
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
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 15c6157ee841..f228fba74c61 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -423,9 +423,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
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
