Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E7DC433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B2D613C8
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B2D613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F8C4846EC;
	Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePp1SXVaqnbx; Thu, 15 Apr 2021 07:32:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8743846F0;
	Thu, 15 Apr 2021 07:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7357C000B;
	Thu, 15 Apr 2021 07:32:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F3ACC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E8D9846F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NcXjNZxOe3w6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E9DA846F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=x3GwZ1zgb9EqVeYW21l457HIOUZj2XqF5DommpMrgvs=;
 b=BNUaFhxbgN7kKGOzqlws3ADV4TctY4o9ub8pzY0v5AKGyqfPfhaNzwIRyc85GtJGhnGaRa
 Olhyb4ZrP0PORqp0tEJyEU58FTwVzvUqw2UqAnLSUSiUZLP374XZlUTdI4BqZEMOSD7fi9
 HrGDgu1YAP/hcAXTj8Elu29NzqYuZ3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-_UaDBgr6Nd6y2k-LGK_jwg-1; Thu, 15 Apr 2021 03:32:10 -0400
X-MC-Unique: _UaDBgr6Nd6y2k-LGK_jwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5010107ACCA;
 Thu, 15 Apr 2021 07:32:09 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC3E769FD0;
 Thu, 15 Apr 2021 07:32:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/7] vp_vdpa: switch to use vp_modern_map_vq_notify()
Date: Thu, 15 Apr 2021 03:31:43 -0400
Message-Id: <20210415073147.19331-4-jasowang@redhat.com>
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

This patch switches to use vp_vdpa to use vp_modern_map_notify().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 1321a2fcd088..2afc90645660 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -369,7 +369,6 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct virtio_pci_modern_device *mdev;
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa;
-	u16 notify_off;
 	int ret, i;
 
 	ret = pcim_enable_device(pdev);
@@ -415,10 +414,12 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	for (i = 0; i < vp_vdpa->queues; i++) {
-		notify_off = vp_modern_get_queue_notify_off(mdev, i);
 		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
-		vp_vdpa->vring[i].notify = mdev->notify_base +
-			notify_off * mdev->notify_offset_multiplier;
+		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
+		if (!vp_vdpa->vring[i].notify) {
+			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
+			goto err;
+		}
 	}
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
