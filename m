Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559F3C7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 10:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08C1F400D8;
	Fri, 26 May 2023 10:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08C1F400D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d6B3TH/H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4aBYgot4Hvu2; Fri, 26 May 2023 10:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6BF0E4018F;
	Fri, 26 May 2023 10:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BF0E4018F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40345C0036;
	Fri, 26 May 2023 10:16:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6A3C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C99854018F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C99854018F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AP8Er5ILFkVW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 424A8400D8
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 424A8400D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685096162; x=1716632162;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X7k8WZt9ivrs86FT946r9LIIfPS8nth72TJNaGjY4KA=;
 b=d6B3TH/HhrFdfD4rGPvKmQHU2bYF0uIyuTxmwGmmfM6wx6QBT86wC3/Y
 lrNirWzO+3LUhsCfIv33w9f2xZV4C6s7BPrAEo96z5r3hA/tJ1RuZOvkg
 s1s+DjmFUOZ/pG7PVFi4NNggO5+tglXJnAmUwoerOf4s+TVuL5aApchw3
 wMwLNsWLWGcxYf2lXs0s/qmj88X/AIhHQepHnfgDOS/rtlOFfKVE7tqw3
 teJ6weVtE1B3nh5UtDpOvkkV0m4XxIOviuHtXnelv4zaVCecPu1Hu3tVX
 pniYOAYbE8hwSN49nvdSxItb/uCFNPojYNqxoFgwKvfuJ52o6xoGo0mdd Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351679984"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="351679984"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 03:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770293656"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="770293656"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 26 May 2023 03:15:59 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC] virtio-net: support modern-transtional devices
Date: Sat, 27 May 2023 02:15:42 +0800
Message-Id: <20230526181542.364412-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
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

Current virtio-net only probes a device with VIRITO_ID_NET == 1.

For a modern-transtional virtio-net device which has a transtional
device id 0x1000 and acts as a modern device, current virtio-pci
modern driver will assign the sub-device-id to its mdev->id.device,
which may not be 0x1, this sub-device-id is up to the vendor.

That means virtio-net driver doesn't probe a modern-transitonal
virtio-net with a sub-device-id other than 0x1, which is a bug.

Other types of devices also have similar issues, like virito-blk.

I propose to fix this problem of modern-transitonal device
whith this solution, all in the modern code path:
1) assign the device id to mdev->id.device
2) add transitional device ids in the virtio-net(and others) probe table.

Comments are welcome!

Thanks!

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/net/virtio_net.c               | 1 +
 drivers/virtio/virtio_pci_modern_dev.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 56ca1d270304..6b45d8602a6b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 869cb46bef96..80846e1195ce 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 		/* Transitional devices: use the PCI subsystem device id as
 		 * virtio device id, same as legacy driver always did.
 		 */
-		mdev->id.device = pci_dev->subsystem_device;
+		mdev->id.device = pci_dev->device;
 	} else {
 		/* Modern devices: simply use PCI device id, but start from 0x1040. */
 		mdev->id.device = pci_dev->device - 0x1040;
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
