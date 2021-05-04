Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F718C433ED
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 08:21:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BDD611EE
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 08:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BDD611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2902540575;
	Tue,  4 May 2021 08:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MG2f1N5qifCP; Tue,  4 May 2021 08:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8074240568;
	Tue,  4 May 2021 08:21:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 589CAC001C;
	Tue,  4 May 2021 08:21:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCD57C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A98426075B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIK-IHXzKhCL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECB43606C9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620116462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tMP1xx5RM3W39LPjwsE6CWlx07bFQEOIwnlzCme4Sl4=;
 b=IZ2Ps/CIC8t8c9Iv2vWXqG2ZMiWlhQoC+RROdDl9h1rP4jHuFjUMyCVhcjR3BuFHK7AaBV
 hgraIlIImeT8hjgE8w/WrxOtshz3zRGEYtIztcQXA/q22yy/u5d8BeaU4KMMcvnLDpb4j0
 dEcprlleIpyAly+MsNgnzxGUGa4BXOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-iOCCoM_rPbO5vLmhAD-IRQ-1; Tue, 04 May 2021 04:20:59 -0400
X-MC-Unique: iOCCoM_rPbO5vLmhAD-IRQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n9-20020a1c40090000b02901401bf40f9dso165184wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 01:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tMP1xx5RM3W39LPjwsE6CWlx07bFQEOIwnlzCme4Sl4=;
 b=jEIWypKSTZ07Ikxy5k+lxgWGPYjbvjMBn7XtnVrbEdpSEz67LDn7iEo6O0qm5zVtwT
 bKUB8D0gnXc9y4+PSlI1LJgl36zMgSdY/vmYZovkLnpP7ri4qov2EgE/UqykYhr/ndif
 fkZRt96UlghGpijnx+F5lRO6FKyHep6/UwStGAjw1z3Fj+2m3OETTavIlGczqnZ77eCn
 NP/9QLcGgMjUbWcmKQSjMPktPuCGk6/9wVgeqwkmAPFanT9yKjShi5HgKE7rGTOUy3hA
 wKwVGFUVuzzNmU3b0rEfMEWFT7iFwntUZBEOBJd1jOSk/TiomskIc+du/j+I5uTXW3jJ
 Vw6w==
X-Gm-Message-State: AOAM5316KNKqJpwmiF/+2aFJ/A4UoYl0dEaSfd4d4QS3fbvIc6bRTRIC
 6r1JTbooooWid4ibmY1037Atpj8x4IaZtUlQFjRZ7Sk8pqWk6JO25N/Sak1Ten/cHCsSo+tYVQh
 9puHNh7uXOipZtYf75NCrIlUWjXIugTVpbuRztI49vg==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr2604810wma.144.1620116458150; 
 Tue, 04 May 2021 01:20:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTbu5ekU7D/8mrl31/CpdYXkrj1VnJHihiA9z9xrr3YZFmIJDwfjFftMechzR6ujZAAVINxg==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr2604801wma.144.1620116457988; 
 Tue, 04 May 2021 01:20:57 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id l66sm1845078wmf.20.2021.05.04.01.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 01:20:57 -0700 (PDT)
Date: Tue, 4 May 2021 04:20:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio_pci_modern: correct sparse tags for notify
Message-ID: <20210504082034.118581-2-mst@redhat.com>
References: <20210504082034.118581-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210504082034.118581-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, kernel test robot <lkp@intel.com>,
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

When switching virtio_pci_modern to use a helper for mappings we lost an
__iomem tag. Restore it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9e3bb9b79a71 ("virtio_pci_modern: introduce helper to map vq notify area")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 9 ++++-----
 include/linux/virtio_pci_modern.h      | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index ae87b3fa8858..54f297028586 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -605,8 +605,8 @@ static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
  *
  * Returns the address of the notification area
  */
-void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-			      u16 index, resource_size_t *pa)
+void __iomem *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+				      u16 index, resource_size_t *pa)
 {
 	u16 off = vp_modern_get_queue_notify_off(mdev, index);
 
@@ -624,10 +624,9 @@ void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
 		if (pa)
 			*pa = mdev->notify_pa +
 			      off * mdev->notify_offset_multiplier;
-		return (void __force *)mdev->notify_base +
-			off * mdev->notify_offset_multiplier;
+		return mdev->notify_base + off * mdev->notify_offset_multiplier;
 	} else {
-		return (void __force *)vp_modern_map_capability(mdev,
+		return vp_modern_map_capability(mdev,
 				       mdev->notify_map_cap, 2, 2,
 				       off * mdev->notify_offset_multiplier, 2,
 				       NULL, pa);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index cdfabbefacdf..6a95b58fd0f4 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -101,8 +101,8 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-                              u16 index, resource_size_t *pa);
+void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+				       u16 index, resource_size_t *pa);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
 #endif
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
