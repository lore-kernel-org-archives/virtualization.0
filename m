Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2102C433FE
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 06:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 395F6843E2;
	Fri, 21 Oct 2022 06:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 395F6843E2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bHDokm8i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vrtWRRi8sgwP; Fri, 21 Oct 2022 06:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C4716843EC;
	Fri, 21 Oct 2022 06:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4716843EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13999C007F;
	Fri, 21 Oct 2022 06:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 233DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6B7C843D9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6B7C843D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIv59xHzPUFD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27D48843E2
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27D48843E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666333660; x=1697869660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NnQlu/b7OKYqJy4jWUYIP9NkO/n7jpwIEwYD7R17ODQ=;
 b=bHDokm8iw+I1iyH/SuhpIWovZzpMFkxX8ug/U9vdEUpLsIRMjJxlW3go
 dYN4yYgXjfn5pmSrlqyBUL6jVKMigs7iXNCtDrixMgqBJn5gV+R/jAk1n
 0sCxhU4nhr1pHvN02k0j0Nx8jTMXmZUbB1X3nAZftTaOfyNiW4vjYCA8g
 ciHPTgsYVzm10ikpuidaLjJ2m+PRyyQ9eqy/FmOcbo91BrW/OhLpEcCmt
 xYJUQpPXAu8yz/PPAhPafmGioI5gPH8FcqXRMQGCs3cvNASGILhh4018F
 j34bJgRF3m9NMRouhjFqttizkozASFlB1If6wVMBFxCG4MwkDcrNksBlR w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294321576"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; d="scan'208";a="294321576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735358030"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; d="scan'208";a="735358030"
Received: from d8bbc18b98c6.jf.intel.com ([10.54.241.152])
 by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 23:27:39 -0700
From: shaoqin.huang@intel.com
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/2] virtio_pci: use helper function is_power_of_2()
Date: Thu, 20 Oct 2022 23:27:33 -0700
Message-Id: <20221021062734.228881-2-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021062734.228881-1-shaoqin.huang@intel.com>
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

From: Shaoqin Huang <shaoqin.huang@intel.com>

Use helper function is_power_of_2() to check if num is power of two.
Minor readability improvement.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index c3b9f2761849..207294bd7b9d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -310,7 +310,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (num & (num - 1)) {
+	if (!is_power_of_2(num)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
