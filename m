Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80655C433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE28613B1
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE28613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C61D360D84;
	Thu, 15 Apr 2021 07:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsmI7Yq1WQFE; Thu, 15 Apr 2021 07:32:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6916060D75;
	Thu, 15 Apr 2021 07:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49342C000D;
	Thu, 15 Apr 2021 07:32:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECEBBC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC56260D84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtOYnUF9r3JJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34B0760D75
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=y065v3sS7iQ67BPMJsfUR3YKWdqlGuSLEniDjFK1rEM=;
 b=AkVqAWBLag9yeRvxm5TJC25cF1X6QlxivPsOjIRcTyRg0ji1TPZ4ATvnnMllZuY2T+2Gr8
 GGd7/nkJxNdcT2vB+lpTIZ9D3ch3GMY+QgyjLKGReRArJlGeC2zNlj5QT8jr4MdOB1aJ4S
 hadnolIGOCFrNSZt7IfxEM2igXNyjAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fDVhN6ksNsGBHCS9UEHFcA-1; Thu, 15 Apr 2021 03:32:21 -0400
X-MC-Unique: fDVhN6ksNsGBHCS9UEHFcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD14784E20A;
 Thu, 15 Apr 2021 07:32:19 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0BCB60657;
 Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 5/7] virito_pci libray: hide vp_modern_map_capability()
Date: Thu, 15 Apr 2021 03:31:45 -0400
Message-Id: <20210415073147.19331-6-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

No user now and the capability should not be setup
externally. Instead, every access to the capability should be done via
virtio_pci_modern_device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 10 ++++------
 include/linux/virtio_pci_modern.h      |  5 -----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 5a657e56b46d..9c241c9bd920 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -16,11 +16,10 @@
  *
  * Returns the io address of for the part of the capability
  */
-void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
-				       size_t minlen,
-				       u32 align,
-				       u32 start, u32 size,
-				       size_t *len)
+static void __iomem *
+vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
+			 size_t minlen, u32 align, u32 start, u32 size,
+			 size_t *len)
 {
 	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
@@ -90,7 +89,6 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
 			length, offset, bar);
 	return p;
 }
-EXPORT_SYMBOL_GPL(vp_modern_map_capability);
 
 /**
  * virtio_pci_find_capability - walk capabilities to find device info.
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 179a2fb4bf37..e6e7072413c1 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -99,11 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
-				       size_t minlen,
-				       u32 align,
-				       u32 start, u32 size,
-				       size_t *len);
 void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
                               u16 index);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
