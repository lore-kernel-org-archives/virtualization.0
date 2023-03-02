Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7268CC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ED1E81F43;
	Thu,  2 Mar 2023 11:35:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1ED1E81F43
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpHHUkYU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z5BFgzhTqmII; Thu,  2 Mar 2023 11:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 629358202D;
	Thu,  2 Mar 2023 11:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 629358202D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3F3C0035;
	Thu,  2 Mar 2023 11:35:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E0C1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDF9E8202E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDF9E8202E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F35y6FHipSHh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8AF98202B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8AF98202B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gj3dXUcrOW7GQbHC3bzCmguoR9a2asK1vNem232OL7c=;
 b=LpHHUkYUuZjSnP377+4wqhPPWp9ul9x3fPMBvM1LzaZTktdtq5gLPJkTMnEiit1aenrVLY
 egBJXdD4OFIkfIpjyfkZw21dMaqMi4TBMZsbpSIBdAUkm2qqCDJ34Adi6wenQdnnimFJAN
 NNYpRihr1kb9ZoNJ/Ztj6cHqNOp5Ruc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-M7HKRFTbPXqgL9jtoILVYg-1; Thu, 02 Mar 2023 06:35:17 -0500
X-MC-Unique: M7HKRFTbPXqgL9jtoILVYg-1
Received: by mail-qk1-f200.google.com with SMTP id
 8-20020a370508000000b00724fd33cb3eso9840364qkf.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gj3dXUcrOW7GQbHC3bzCmguoR9a2asK1vNem232OL7c=;
 b=wvQnNwoTvO7wXnnl7/TZeQBCT5DCtJvoRA4AVNKYSGtbtnQjPRYq5zFWDox580cuPH
 cPAA6jVP65jbW/I/pBmrzuxuRdI3Gge+qbHz/f9QHgguVkax1yEJakD1cPzQZ52sIdlH
 Cc0/zIABQsLoWd7ETPso9nyFR+EIas/3y6WvrEnKgXRXO66QZQQPjMg/g3HSlLezzwtJ
 4FhGtK3h6PO0CsJUr5iyZkn1w6n16Fyl8Va99X4HRHzmfKrxUxphqU3opzU8fmQ+NB+d
 RNOecUZ22HPi7romIAdRVgpwoF4YohNDFWqLtD+CmhQ6nti8+SaDl+jVxrnb9OkOEKQU
 +nUQ==
X-Gm-Message-State: AO0yUKWNE8YrUYZQPYHCTvJpe8FYNVTRtidW4H8sJeEjSGV3V0VkJvN6
 PDSS0OhbVKu7d5qO+TW+1+yGYZn5gVhvA1WuK0XWqe2nEXPnE9wXXheownYAFeGysovTg0F035S
 c4UrQzSaixnSAAiNUUwLIfE8qbIuWMezhiqhsPwv3VI3OEC92POWGLlawrbc0vIZX5ZbHpW4tZB
 LBFH+JLFYpAC5rSCpzGBF/Ufc=
X-Received: by 2002:ac8:594f:0:b0:3a7:e9a2:4f4a with SMTP id
 15-20020ac8594f000000b003a7e9a24f4amr16171748qtz.8.1677756917024; 
 Thu, 02 Mar 2023 03:35:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9qGmJaKuL+3K0McFJot1ZlCw7XvULWgrVcRPD18Yd6j00eYkZLuQoDKp7LYfL8P/tkphEXgw==
X-Received: by 2002:ac8:594f:0:b0:3a7:e9a2:4f4a with SMTP id
 15-20020ac8594f000000b003a7e9a24f4amr16171717qtz.8.1677756916710; 
 Thu, 02 Mar 2023 03:35:16 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a37420c000000b007426ec97253sm8383058qka.111.2023.03.02.03.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:35:16 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 7/8] vdpa_sim: replace the spinlock with a mutex to protect
 the state
Date: Thu,  2 Mar 2023 12:34:20 +0100
Message-Id: <20230302113421.174582-8-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

The spinlock we use to protect the state of the simulator is sometimes
held for a long time (for example, when devices handle requests).

This also prevents us from calling functions that might sleep (such as
kthread_flush_work() in the next patch), and thus having to release
and retake the lock.

For these reasons, let's replace the spinlock with a mutex that gives
us more flexibility.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  4 ++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 34 ++++++++++++++--------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  4 ++--
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  4 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index ce83f9130a5d..4774292fba8c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -60,8 +60,8 @@ struct vdpasim {
 	struct kthread_worker *worker;
 	struct kthread_work work;
 	struct vdpasim_dev_attr dev_attr;
-	/* spinlock to synchronize virtqueue state */
-	spinlock_t lock;
+	/* mutex to synchronize virtqueue state */
+	struct mutex mutex;
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6feb29726c2a..a28103a67ae7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -166,7 +166,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (IS_ERR(vdpasim->worker))
 		goto err_iommu;
 
-	spin_lock_init(&vdpasim->lock);
+	mutex_init(&vdpasim->mutex);
 	spin_lock_init(&vdpasim->iommu_lock);
 
 	dev = &vdpasim->vdpa.dev;
@@ -275,13 +275,13 @@ static void vdpasim_set_vq_ready(struct vdpa_device *vdpa, u16 idx, bool ready)
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	bool old_ready;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	old_ready = vq->ready;
 	vq->ready = ready;
 	if (vq->ready && !old_ready) {
 		vdpasim_queue_ready(vdpasim, idx);
 	}
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 }
 
 static bool vdpasim_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
@@ -299,9 +299,9 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vrh->last_avail_idx = state->split.avail_index;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -398,9 +398,9 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	u8 status;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	status = vdpasim->status;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return status;
 }
@@ -409,19 +409,19 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 }
 
 static int vdpasim_reset(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = 0;
 	vdpasim_do_reset(vdpasim);
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -430,9 +430,9 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = false;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -442,7 +442,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = true;
 
 	if (vdpasim->pending_kick) {
@@ -453,7 +453,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 		vdpasim->pending_kick = false;
 	}
 
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -525,14 +525,14 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
 
 	iommu = &vdpasim->iommu[asid];
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
 		if (vdpasim_get_vq_group(vdpa, i) == group)
 			vringh_set_iotlb(&vdpasim->vqs[i].vring, iommu,
 					 &vdpasim->iommu_lock);
 
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index eb4897c8541e..568119e1553f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -290,7 +290,7 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 	bool reschedule = false;
 	int i;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
 		goto out;
@@ -321,7 +321,7 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 		}
 	}
 out:
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	if (reschedule)
 		vdpasim_schedule_work(vdpasim);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index e61a9ecbfafe..7ab434592bfe 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -201,7 +201,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 	u64 rx_drops = 0, rx_overruns = 0, rx_errors = 0, tx_errors = 0;
 	int err;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	if (!vdpasim->running)
 		goto out;
@@ -264,7 +264,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 	}
 
 out:
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	u64_stats_update_begin(&net->tx_stats.syncp);
 	net->tx_stats.pkts += tx_pkts;
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
