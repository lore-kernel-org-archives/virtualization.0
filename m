Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15926C43460
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B114361249
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B114361249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73B0B846F2;
	Thu, 15 Apr 2021 07:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6OlmzRG8yXDx; Thu, 15 Apr 2021 07:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35051846F1;
	Thu, 15 Apr 2021 07:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 061A9C000B;
	Thu, 15 Apr 2021 07:32:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 456CBC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41675846F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ddEt_C6_vtR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86FE8846F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=uRjAyfH2EocMqkl3avo14HGtZCvwSJwDpt6RMldr+oE=;
 b=S6ds40VybceZ/ymYIic5AwVjGXOPJfLNj9VEzafnTvld1RAVXYV+1PvYUZZSlt90Fykqgq
 RnNqLIBldYniORG+xaadfIIAGmZ3tzqTX4ea9NFDQowgCLbbQPkXc3sjXrzs1iqexejDyj
 eUIEf055wKLRIu1bPvG5tIyxwQUw0ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-i91gOzhSMYyoL9NgjpgkUg-1; Thu, 15 Apr 2021 03:32:18 -0400
X-MC-Unique: i91gOzhSMYyoL9NgjpgkUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B3510054F6;
 Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC7660657;
 Thu, 15 Apr 2021 07:32:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 4/7] virtio_pci_modern: hide vp_modern_get_queue_notify_off()
Date: Thu, 15 Apr 2021 03:31:44 -0400
Message-Id: <20210415073147.19331-5-jasowang@redhat.com>
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

All users (both virtio-pci library and vp_vdpa driver) has been
switched to use vp_modern_map_vq_notify(). So there's no need to
export the low level helper of vp_modern_get_queue_notify_off().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 5 ++---
 include/linux/virtio_pci_modern.h      | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 28cb5847fafa..5a657e56b46d 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -584,14 +584,13 @@ EXPORT_SYMBOL_GPL(vp_modern_get_num_queues);
  *
  * Returns the notification offset for a virtqueue
  */
-u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
-				   u16 index)
+static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
+					  u16 index)
 {
 	vp_iowrite16(index, &mdev->common->queue_select);
 
 	return vp_ioread16(&mdev->common->queue_notify_off);
 }
-EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
 
 /*
  * vp_modern_map_vq_notify - map notification area for a
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 1b95d39b00fc..179a2fb4bf37 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -99,8 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
-				   u16 idx);
 void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 				       size_t minlen,
 				       u32 align,
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
