Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB0C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2650B23381
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2650B23381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC6F0869EF;
	Wed, 16 Dec 2020 06:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ojAMkN6Zhq-r; Wed, 16 Dec 2020 06:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87BCE86992;
	Wed, 16 Dec 2020 06:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC87C0893;
	Wed, 16 Dec 2020 06:50:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34AF0C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 206DF869D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSxBcs6VVEtl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 73BFD86773
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FjubrHlP/6mleRaFOH0oCUrngCxQxLxf5JK/Qo5XpE=;
 b=fNwvB8eD/re4nsyjC9A1IHwgh8LayobdUPEQv3l3rKx14tP/tby+mi9oDvoJO/IMKiIa4M
 WYlAokfbTZRYA9ZbEGP1HTVU2ptcEKXsWuk6S92tykyu7xjS/Ol6UzZN7/NiUnxRQ/vfNJ
 T1Mo4E2BnlC0ANOzxxnHCidLGsaHyaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-Cti1jdVrPPWnBXuG_DC3Ww-1; Wed, 16 Dec 2020 01:50:44 -0500
X-MC-Unique: Cti1jdVrPPWnBXuG_DC3Ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46343800D53;
 Wed, 16 Dec 2020 06:50:43 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B58210013C1;
 Wed, 16 Dec 2020 06:50:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 19/21] vdpa_sim: factor out buffer completion logic
Date: Wed, 16 Dec 2020 14:48:16 +0800
Message-Id: <20201216064818.48239-20-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8d051cf25f0a..e901177c6dfe 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -159,6 +159,22 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	++vdpasim->generation;
 }
 
+static void vdpasim_complete(struct vdpasim_virtqueue *vq, size_t len)
+{
+	/* Make sure data is wrote before advancing index */
+	smp_wmb();
+
+	vringh_complete_iotlb(&vq->vring, vq->head, len);
+
+	/* Make sure used is visible before rasing the interrupt. */
+	smp_wmb();
+
+	local_bh_disable();
+	if (vq->cb)
+		vq->cb(vq->private);
+	local_bh_enable();
+}
+
 static void vdpasim_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct
@@ -207,21 +223,8 @@ static void vdpasim_work(struct work_struct *work)
 			total_write += write;
 		}
 
-		/* Make sure data is wrote before advancing index */
-		smp_wmb();
-
-		vringh_complete_iotlb(&txq->vring, txq->head, 0);
-		vringh_complete_iotlb(&rxq->vring, rxq->head, total_write);
-
-		/* Make sure used is visible before rasing the interrupt. */
-		smp_wmb();
-
-		local_bh_disable();
-		if (txq->cb)
-			txq->cb(txq->private);
-		if (rxq->cb)
-			rxq->cb(rxq->private);
-		local_bh_enable();
+		vdpasim_complete(txq, 0);
+		vdpasim_complete(rxq, total_write);
 
 		if (++pkts > 4) {
 			schedule_work(&vdpasim->work);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
