Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B9C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 08:27:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5657C61159
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 08:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5657C61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E908384D12;
	Thu,  8 Apr 2021 08:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEQYDMAMiIR4; Thu,  8 Apr 2021 08:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A885A84D1F;
	Thu,  8 Apr 2021 08:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6F5C000C;
	Thu,  8 Apr 2021 08:27:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86384C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 08:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6ABFA6069F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 08:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f15ucSMFt6M7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 08:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 747BB60627
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617870421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tp5v2YH5Yi9li+KSzkJrd9m6gNC6HOE1WkYusKD5XUE=;
 b=hFlA6QY2Dvv/iD8Bo64MaqHVwmMAmaP/5tjzOBx9jhdvL8cNPhfWORWW+vwX4VbOi3Xdkb
 bojm6iOjGf3wTAvwKRDlO3l+wWjfBCU4HwJW+w+vfEIwi8OPVuVBbJD80093L9P1H5TO/R
 CMDeC4fiT2EXFHalRwUPeQ0IhgNuPFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-KQFmKFSkMIuDB2PSmWulJg-1; Thu, 08 Apr 2021 04:26:59 -0400
X-MC-Unique: KQFmKFSkMIuDB2PSmWulJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687C36D241;
 Thu,  8 Apr 2021 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-53.pek2.redhat.com [10.72.13.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 147DB5D9CC;
 Thu,  8 Apr 2021 08:26:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] vdpa: mandate 1.0 device
Date: Thu,  8 Apr 2021 16:26:48 +0800
Message-Id: <20210408082648.20145-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: elic@nvidia.com
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

This patch mandates 1.0 for vDPA devices. The goal is to have the
semantic of normative statement in the virtio spec and eliminate the
burden of transitional device for both vDPA bus and vDPA parent.

uAPI seems fine since all the vDPA parent mandates
VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.

For legacy guests, it can still work since Qemu will mediate when
necessary (e.g doing the endian conversion).

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0fefeb976877..cfde4ec999b4 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <uapi/linux/virtio_config.h>
 
 /**
  * vDPA callback definition.
@@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
         const struct vdpa_config_ops *ops = vdev->config;
 
+        /* Mandating 1.0 to have semantics of normative statements in
+         * the spec. */
+        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
+		return -EINVAL;
+
 	vdev->features_valid = true;
         return ops->set_features(vdev, features);
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
