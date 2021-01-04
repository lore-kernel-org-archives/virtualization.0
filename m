Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9CEC433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB9F2151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB9F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F6C586850;
	Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjq3GDXH8MdV; Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32FCD86805;
	Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E488C0893;
	Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB14C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1DDCF8684F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZPV0mUzHgwyG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8511C86805
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cz4Cg3nnzO3FS98gTMZZAIPsbgh47yB+xmLOC1GVS+Q=;
 b=XhjTtobgeMKoTyKOHcoBTe4811DQb+ncfmd0Wv7W7/OTGbfkM5QeG8tDYLlEsSAZHaoC56
 9RgDHov4QGmh78o7sXqhjHXCRIdEisn7HkSxw5th/4YzsCx+OWoa08z4r9T7G5TOYWr8MW
 fyjV9p/T1s4nZXhRtMc7Z5M4NUe/99w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Gp_mRJvgNuONC2pmOU0w4w-1; Mon, 04 Jan 2021 01:55:32 -0500
X-MC-Unique: Gp_mRJvgNuONC2pmOU0w4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B74107ACE3;
 Mon,  4 Jan 2021 06:55:31 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBC631002388;
 Mon,  4 Jan 2021 06:55:24 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 05/19] virtio-pci-modern: introduce helper to set config
 vector
Date: Mon,  4 Jan 2021 14:54:49 +0800
Message-Id: <20210104065503.199631-6-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: shahafs@mellanox.com, rdunlap@infradead.org, lulu@redhat.com
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

This patch introduces vp_modern_config_vector() for setting config
vector.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 4be9afad547e..2e37bfc89655 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -315,9 +315,16 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_synchronize_vectors(vdev);
 }
 
-static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+/*
+ * vp_modern_config_vector - set the vector for config interrupt
+ * @mdev: the modern virtio-pci device
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+static u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
+				   u16 vector)
 {
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* Setup the vector used for configuration events */
@@ -327,6 +334,11 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 	return vp_ioread16(&cfg->msix_config);
 }
 
+static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+{
+	return vp_modern_config_vector(&vp_dev->mdev, vector);
+}
+
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_pci_vq_info *info,
 				  unsigned index,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
