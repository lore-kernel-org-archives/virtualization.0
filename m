Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB4C63697
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8FD2223F
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNYqzrfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8FD2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D7BF187483;
	Fri, 13 Nov 2020 13:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8Dq-NSVHk8Q; Fri, 13 Nov 2020 13:48:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B6228745B;
	Fri, 13 Nov 2020 13:48:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 409C1C0891;
	Fri, 13 Nov 2020 13:48:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2340DC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F209E20439
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7f5QysLEv+r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 20FBF204A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUWlJHRXTci3OE9aKsACoxuZyffR9CQAnZGBUFnY9/4=;
 b=iNYqzrfWSyJsvejltqTNdRkTViybijLRqPF4h0YqUzoUpsIQMyhNrudPP3o24TOvpaDDQQ
 17e78ER5dCjCJF+ncVFE+xMZva0xLQX2JZuT9xRf45vnF6q9rCzq2wm+/BcSyBQni5wPyo
 gcaS/EfD1+qQMBBJ569IO49Xn6ov8eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Q5dfMm2JN-uBAE7tf67S5Q-1; Fri, 13 Nov 2020 08:48:45 -0500
X-MC-Unique: Q5dfMm2JN-uBAE7tf67S5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6F31084C96;
 Fri, 13 Nov 2020 13:48:44 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 064605D9F3;
 Fri, 13 Nov 2020 13:48:42 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field in
 riov and wiov
Date: Fri, 13 Nov 2020 14:47:10 +0100
Message-Id: <20201113134712.69744-11-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

vringh_getdesc_iotlb() manages 2 iovs for writable and readable
descriptors. This is very useful for the block device, where for
each request we have both types of descriptor.

Let's split the vdpasim_virtqueue's iov field in riov and wiov
to use them with vringh_getdesc_iotlb().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 +++---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 8 ++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index cc21e07aa2f7..0d4629675e4b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -27,7 +27,8 @@ struct vdpasim;
 
 struct vdpasim_virtqueue {
 	struct vringh vring;
-	struct vringh_kiov iov;
+	struct vringh_kiov riov;
+	struct vringh_kiov wiov;
 	unsigned short head;
 	bool ready;
 	u64 desc_addr;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 122a3c039507..8e41b3ab98d5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -41,13 +41,13 @@ static void vdpasim_blk_work(struct work_struct *work)
 		if (!vq->ready)
 			continue;
 
-		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
+		while (vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
 					    &vq->head, GFP_ATOMIC) > 0) {
 
 			int write;
 
-			vq->iov.i = vq->iov.used - 1;
-			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
+			vq->wiov.i = vq->wiov.used - 1;
+			write = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
 			if (write <= 0)
 				break;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index d0a1403f64b2..783b1e85b09c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -47,12 +47,12 @@ static void vdpasim_net_work(struct work_struct *work)
 
 	while (true) {
 		total_write = 0;
-		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
+		err = vringh_getdesc_iotlb(&txq->vring, &txq->riov, NULL,
 					   &txq->head, GFP_ATOMIC);
 		if (err <= 0)
 			break;
 
-		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
+		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->wiov,
 					   &rxq->head, GFP_ATOMIC);
 		if (err <= 0) {
 			vringh_complete_iotlb(&txq->vring, txq->head, 0);
@@ -60,13 +60,13 @@ static void vdpasim_net_work(struct work_struct *work)
 		}
 
 		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
+			read = vringh_iov_pull_iotlb(&txq->vring, &txq->riov,
 						     vdpasim->buffer,
 						     PAGE_SIZE);
 			if (read <= 0)
 				break;
 
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->wiov,
 						      vdpasim->buffer, read);
 			if (write <= 0)
 				break;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
