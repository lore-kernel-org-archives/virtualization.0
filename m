Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE72C47093
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:45:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B3C6138C
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B3C6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66F0B83C8E;
	Tue,  1 Jun 2021 08:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMaDX8Pe2IOo; Tue,  1 Jun 2021 08:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF66683C87;
	Tue,  1 Jun 2021 08:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B512FC000D;
	Tue,  1 Jun 2021 08:45:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54348C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3520B607E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4puGUtR056H
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:45:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BDDF6078B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPnz+bPdexG/R3nGKtBKfo8Ssf6HrlChuTyrsE87lfM=;
 b=h9lRA7/iM+y1dM8Dfjxeo3UKNuTKN1M2VT9tSMIbLdW8rAD6ex+Ly6fYOJlOzny8SRryWm
 jftt8x7VM/LpDiqdhcunKLubC33FEuoXfaOO3MpwD2OurvdE1qRfZijL5beMFVlxx0osmx
 FmbmLI2/sNWmpOLZ6KEU1rFPknCmsts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-WL4LUiDoPOupO8q48SqqkQ-1; Tue, 01 Jun 2021 04:45:22 -0400
X-MC-Unique: WL4LUiDoPOupO8q48SqqkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27BE0104FB9B;
 Tue,  1 Jun 2021 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD90D100763C;
 Tue,  1 Jun 2021 08:45:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/4] vdpa: support packed virtqueue for set/get_vq_state()
Date: Tue,  1 Jun 2021 16:45:00 +0800
Message-Id: <20210601084503.34724-2-jasowang@redhat.com>
In-Reply-To: <20210601084503.34724-1-jasowang@redhat.com>
References: <20210601084503.34724-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: eli@mellanox.com
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

This patch extends the vdpa_vq_state to support packed virtqueue
state which is basically the device/driver ring wrap counters and the
avail and used index. This will be used for the virito-vdpa support
for the packed virtqueue and the future vhost/vhost-vdpa support for
the packed virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  |  4 ++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  4 ++--
 drivers/vhost/vdpa.c             |  4 ++--
 include/linux/vdpa.h             | 25 +++++++++++++++++++++++--
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ab0ab5cf0f6e..5d3891b1ca28 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -264,7 +264,7 @@ static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	state->avail_index = ifcvf_get_vq_state(vf, qid);
+	state->split.avail_index = ifcvf_get_vq_state(vf, qid);
 	return 0;
 }
 
@@ -273,7 +273,7 @@ static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return ifcvf_set_vq_state(vf, qid, state->avail_index);
+	return ifcvf_set_vq_state(vf, qid, state->split.avail_index);
 }
 
 static void ifcvf_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 98f793bc9376..14e024de5cbf 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -374,7 +374,7 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vringh *vrh = &vq->vring;
 
 	spin_lock(&vdpasim->lock);
-	vrh->last_avail_idx = state->avail_index;
+	vrh->last_avail_idx = state->split.avail_index;
 	spin_unlock(&vdpasim->lock);
 
 	return 0;
@@ -387,7 +387,7 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	state->avail_index = vrh->last_avail_idx;
+	state->split.avail_index = vrh->last_avail_idx;
 	return 0;
 }
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index fb41db3da611..210ab35a7ebf 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -383,7 +383,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.avail_index;
+		vq->last_avail_idx = vq_state.split.avail_index;
 		break;
 	}
 
@@ -401,7 +401,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		vq_state.avail_index = vq->last_avail_idx;
+		vq_state.split.avail_index = vq->last_avail_idx;
 		if (ops->set_vq_state(vdpa, idx, &vq_state))
 			r = -EINVAL;
 		break;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f311d227aa1b..3357ac98878d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -28,13 +28,34 @@ struct vdpa_notification_area {
 };
 
 /**
- * struct vdpa_vq_state - vDPA vq_state definition
+ * struct vdpa_vq_state_split - vDPA split virtqueue state
  * @avail_index: available index
  */
-struct vdpa_vq_state {
+struct vdpa_vq_state_split {
 	u16	avail_index;
 };
 
+/**
+ * struct vdpa_vq_state_packed - vDPA packed virtqueue state
+ * @last_avail_counter: last driver ring wrap counter observed by device
+ * @last_avail_idx: device available index
+ * @last_used_counter: device ring wrap counter
+ * @last_used_idx: used index
+ */
+struct vdpa_vq_state_packed {
+        u16	last_avail_counter:1;
+        u16	last_avail_idx:15;
+        u16	last_used_counter:1;
+        u16	last_used_idx:15;
+};
+
+struct vdpa_vq_state {
+     union {
+          struct vdpa_vq_state_split split;
+          struct vdpa_vq_state_packed packed;
+     };
+};
+
 struct vdpa_mgmt_dev;
 
 /**
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
