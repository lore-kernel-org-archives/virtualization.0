Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41629C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:07:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB25207AE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB25207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C45A87AA9;
	Thu,  3 Dec 2020 17:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTR-eo27zMB7; Thu,  3 Dec 2020 17:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B934887A98;
	Thu,  3 Dec 2020 17:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBFEC163C;
	Thu,  3 Dec 2020 17:07:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE849C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BD21687269
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLqdmHHrgd-4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:07:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F9CC87216
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607015254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/IQ5CgYG87iq4cFVye0i8EGHIOCur9MYL1pVEfl7Mg=;
 b=DWM0Z/Vwh5TajG6y7JY7+NQgA1Wje9m3SKltlG4ha5HMIX9OVi9tjN9Ps6yaVVofJANpeh
 CA7iSblgE+tVrqgEFm7oykB56+82aZ5X5Oty8bmP2dconzPSyWPp4Tq7SJ/EALv5Voa0bP
 TMDQHfeA/FptK1Mp3dLxBj2B4oAP3sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-dl0kiUnnPyWm6kZcPnf2Qw-1; Thu, 03 Dec 2020 12:07:32 -0500
X-MC-Unique: dl0kiUnnPyWm6kZcPnf2Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53812425ED;
 Thu,  3 Dec 2020 17:07:31 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com
 [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCE3E5D9CA;
 Thu,  3 Dec 2020 17:07:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 15/19] vdpa_sim: set vringh notify callback
Date: Thu,  3 Dec 2020 18:05:07 +0100
Message-Id: <20201203170511.216407-16-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Instead of calling the vq callback directly, we can leverage the
vringh_notify() function, adding vdpasim_vq_notify() and setting it
in the vringh notify callback.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- cleared notify during reset [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 03a8717f80ea..1243b02488f7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -123,6 +123,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
 	return vdpa_to_sim(vdpa);
 }
 
+static void vdpasim_vq_notify(struct vringh *vring)
+{
+	struct vdpasim_virtqueue *vq =
+		container_of(vring, struct vdpasim_virtqueue, vring);
+
+	if (!vq->cb)
+		return;
+
+	vq->cb(vq->private);
+}
+
 static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -134,6 +145,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->driver_addr,
 			  (struct vring_used *)
 			  (uintptr_t)vq->device_addr);
+
+	vq->vring.notify = vdpasim_vq_notify;
 }
 
 static void vdpasim_vq_reset(struct vdpasim *vdpasim,
@@ -147,6 +160,8 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->private = NULL;
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
 			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
+
+	vq->vring.notify = NULL;
 }
 
 static void vdpasim_reset(struct vdpasim *vdpasim)
@@ -223,10 +238,10 @@ static void vdpasim_net_work(struct work_struct *work)
 		smp_wmb();
 
 		local_bh_disable();
-		if (txq->cb)
-			txq->cb(txq->private);
-		if (rxq->cb)
-			rxq->cb(rxq->private);
+		if (vringh_need_notify_iotlb(&txq->vring) > 0)
+			vringh_notify(&txq->vring);
+		if (vringh_need_notify_iotlb(&rxq->vring) > 0)
+			vringh_notify(&rxq->vring);
 		local_bh_enable();
 
 		if (++pkts > 4) {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
