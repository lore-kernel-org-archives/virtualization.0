Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D5C4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25186222B6
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25186222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF38187F36;
	Fri,  4 Dec 2020 04:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5amzYss0Kjq; Fri,  4 Dec 2020 04:04:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 442AD8816B;
	Fri,  4 Dec 2020 04:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29848C1834;
	Fri,  4 Dec 2020 04:04:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C087CC0FA7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE11C87812
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiC_pbJR3MpA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 25FC48748F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607054694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlSrvPYi7Sf8S1ru+B79DHoQTOX3kJJE4+lQVOglXBY=;
 b=ghiy2TzsSF5VHdTReEd8a6j/snKgIS3rU+tzrPwwFIAM3JxYusiogvZ0kfrPLX8ATl4Eqb
 PwkLMsv0dfM4caGfjd4T6X7yJ1tiGTPs/pOc7md6pdRv3BI2mYkTi5ny9w4zN2k4egxWbW
 Y0ruGBLrVCm5h4ge51b79VN9S6hY1Uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-lwagjO8PNXOT0IdvcRSONw-1; Thu, 03 Dec 2020 23:04:50 -0500
X-MC-Unique: lwagjO8PNXOT0IdvcRSONw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3868D1842140;
 Fri,  4 Dec 2020 04:04:49 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-116.pek2.redhat.com [10.72.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CDC01A890;
 Fri,  4 Dec 2020 04:04:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/19] virtio-pci-modern: introduce helper for getting
 queue nums
Date: Fri,  4 Dec 2020 12:03:47 +0800
Message-Id: <20201204040353.21679-14-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

This patch introduces helper for getting queue num of modern device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7a89226135af..bccad1329871 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -292,6 +292,17 @@ static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 
 }
 
+/*
+ * vp_modern_get_num_queues - get the number of virtqueues
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the number of virtqueues
+ */
+static u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
+{
+	return vp_ioread16(&mdev->common->num_queues);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -510,7 +521,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	u16 num, off;
 	int err;
 
-	if (index >= vp_ioread16(&cfg->num_queues))
+	if (index >= vp_modern_get_num_queues(mdev))
 		return ERR_PTR(-ENOENT);
 
 	/* Select the queue we're interested in */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
