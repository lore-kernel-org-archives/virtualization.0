Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E17DC4727D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:26:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAA323600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGH+qloE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAA323600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3116B86AE6;
	Thu, 24 Sep 2020 03:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bdyE4KiIntHb; Thu, 24 Sep 2020 03:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8857585B9D;
	Thu, 24 Sep 2020 03:26:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F4AC0889;
	Thu, 24 Sep 2020 03:26:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55F23C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3D2452E06F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wQgOKYR-DQ3Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:26:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 308582DFF8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600918011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzcxzyADJqfutv0Yef/9BUCGgg6y/qtDrjWB9MVUZUg=;
 b=MGH+qloE+wIBvhIwR9wdcN9g8Uh+dhM74E1Y3GyNeJtSCDmdfQTqRiP8iRpvC8WvTLlDY2
 rQ8+aPsgwYrjuz8gDIrNzJiryTszuc9zmG7j7hFYURaALBs32w2PjivgnjmwhoPJmJB1KL
 ErZU8vH5DNcWwHhMw0ZO2pt39rNSRC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-xS6m44hAP0Wfr4GQ85hX2Q-1; Wed, 23 Sep 2020 23:26:09 -0400
X-MC-Unique: xS6m44hAP0Wfr4GQ85hX2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1640100854A;
 Thu, 24 Sep 2020 03:26:07 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12D7A3782;
 Thu, 24 Sep 2020 03:25:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 23/24] vdpa_sim: filter destination mac address
Date: Thu, 24 Sep 2020 11:21:24 +0800
Message-Id: <20200924032125.18619-24-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Add a simple unicast filter to filter out the dest MAC doesn't match
to the one stored in the config.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 49 ++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b21670e054ba..66d901fb4c57 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -171,6 +171,22 @@ static void vdpasim_complete(struct vdpasim_virtqueue *vq, size_t len)
 	local_bh_enable();
 }
 
+static bool receive_filter(struct vdpasim *vdpasim, size_t len)
+{
+	bool modern = vdpasim->features & (1ULL << VIRTIO_F_VERSION_1);
+	size_t hdr_len = modern ? sizeof(struct virtio_net_hdr_v1) :
+				  sizeof(struct virtio_net_hdr);
+
+	if (len < ETH_ALEN + hdr_len)
+		return false;
+
+	if (!strncmp(vdpasim->buffer + hdr_len,
+		     vdpasim->config.mac, ETH_ALEN))
+		return true;
+
+	return false;
+}
+
 static void vdpasim_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct
@@ -178,7 +194,6 @@ static void vdpasim_work(struct work_struct *work)
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
 	ssize_t read, write;
-	size_t total_write;
 	int pkts = 0;
 	int err;
 
@@ -191,36 +206,34 @@ static void vdpasim_work(struct work_struct *work)
 		goto out;
 
 	while (true) {
-		total_write = 0;
 		err = vringh_getdesc_iotlb(&txq->vring, &txq->riov, NULL,
 					   &txq->head, GFP_ATOMIC);
 		if (err <= 0)
 			break;
 
+		read = vringh_iov_pull_iotlb(&txq->vring, &txq->riov,
+					     vdpasim->buffer,
+					     PAGE_SIZE);
+
+		if (!receive_filter(vdpasim, read)) {
+			vdpasim_complete(txq, 0);
+			continue;
+		}
+
 		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->wiov,
 					   &rxq->head, GFP_ATOMIC);
 		if (err <= 0) {
-			vringh_complete_iotlb(&txq->vring, txq->head, 0);
+			vdpasim_complete(txq, 0);
 			break;
 		}
 
-		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->riov,
-						     vdpasim->buffer,
-						     PAGE_SIZE);
-			if (read <= 0)
-				break;
-
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->wiov,
-						      vdpasim->buffer, read);
-			if (write <= 0)
-				break;
-
-			total_write += write;
-		}
+		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->wiov,
+					      vdpasim->buffer, read);
+		if (write <= 0)
+			break;
 
 		vdpasim_complete(txq, 0);
-		vdpasim_complete(rxq, total_write);
+		vdpasim_complete(rxq, write);
 
 		if (++pkts > 4) {
 			schedule_work(&vdpasim->work);
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
