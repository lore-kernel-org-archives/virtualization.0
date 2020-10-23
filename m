Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F0C388F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C7A22253
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fagBJ87x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C7A22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 51A9520526;
	Fri, 23 Oct 2020 09:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEhV7edTBL4P; Fri, 23 Oct 2020 09:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C766420472;
	Fri, 23 Oct 2020 09:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE947C088B;
	Fri, 23 Oct 2020 09:01:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2377AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 111D6204D5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w9Ygpky2eS2V
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B9F0D204DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603443664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/j69+zKcBzq6KNK0IFEIFbu1MSwgGVITvu6ksyjS0w=;
 b=fagBJ87x9aoOM5DwI3sHviGtHnyiBQN3C1Amyl4zHwZXEqPWBLOeOpOqnwM6/kCPnT8vT6
 10chtVo95WzVcblpT/5iOh20BOYyyXuYNGZL258Pz2xAGqmq7Mr+uAp1C1B5pFa7y1K6Uz
 o+BZQwqnlMGBU6cIcip83giNJVDVyT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-KHWZLqYTNy28NZjblBBDgQ-1; Fri, 23 Oct 2020 05:01:02 -0400
X-MC-Unique: KHWZLqYTNy28NZjblBBDgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77741188C129;
 Fri, 23 Oct 2020 09:01:00 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-85.pek2.redhat.com [10.72.13.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E50505B4C4;
 Fri, 23 Oct 2020 09:00:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] vdpa: introduce config op to get valid iova range
Date: Fri, 23 Oct 2020 17:00:41 +0800
Message-Id: <20201023090043.14430-2-jasowang@redhat.com>
In-Reply-To: <20201023090043.14430-1-jasowang@redhat.com>
References: <20201023090043.14430-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patch introduce a config op to get valid iova range from the vDPA
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index eae0bfd87d91..30bc7a7223bb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -52,6 +52,16 @@ struct vdpa_device {
 	int nvqs;
 };
 
+/**
+ * vDPA IOVA range - the IOVA range support by the device
+ * @first: start of the IOVA range
+ * @last: end of the IOVA range
+ */
+struct vdpa_iova_range {
+	u64 first;
+	u64 last;
+};
+
 /**
  * vDPA_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -151,6 +161,10 @@ struct vdpa_device {
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
+ * @get_iova_range:		Get supported iova range (optional)
+ *				@vdev: vdpa device
+ *				Returns the iova range supported by
+ *				the device.
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -216,6 +230,7 @@ struct vdpa_config_ops {
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
+	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
