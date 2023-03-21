Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4434EC74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2ADA6111A;
	Tue, 21 Mar 2023 15:48:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2ADA6111A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N+nqMQZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZVyFuwjE8x0; Tue, 21 Mar 2023 15:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31CBD61119;
	Tue, 21 Mar 2023 15:48:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31CBD61119
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C24FC0071;
	Tue, 21 Mar 2023 15:48:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC37CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AD7181EF3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:48:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AD7181EF3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N+nqMQZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SEj7rICkTjQj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD2FA81E42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD2FA81E42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/o0veKHzKEYhUDBvRKAwkdEIIqv4zRPguQPr09zvNuk=;
 b=N+nqMQZIZEElZ1OuXNayfwCCQulCZV4luGMmm2cmKkYf/tbM2aABcLJQl47F7bUPJC/sLE
 dz6ik9f3jyyovpYgEKUNIaVwOvaYaKb2HwDd/FVztE6HR7ZDnf+hK4EUdAh+YbHlNLtSM6
 4s2UWvOUNd+MygEdD2fB1N3InM9tcd0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-bWChZptIMpaZEBZ2DqCyBQ-1; Tue, 21 Mar 2023 11:48:13 -0400
X-MC-Unique: bWChZptIMpaZEBZ2DqCyBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 l18-20020a05600c4f1200b003ed35ab903aso9784764wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o0veKHzKEYhUDBvRKAwkdEIIqv4zRPguQPr09zvNuk=;
 b=ytoYSmTefd7uYwdCtDAyME90MZX1oxD8VT6Z/9HL8IznrcBsjGVLsl+f8RTzedwu/2
 UQ+qaDTNwOyT0XYd9J3EOv+lmDdlwVWhR6HasA2JoIcqdXdo7JeDKZoYfPtglEo7lA2/
 0V1YRPR4ZPU/1LrvPwyjxXMN14dsOZIiwsJ2PjMGew7rEu7qj+fvPRWXSKhmAp8a3X6Q
 hznoYROsALKe098CUYEwg0b0pkUdSHMBvaVL8el8X8clsPFmKi9/x684+3VWMqDHga2/
 Gd3T2Th2LkmkbasVoxE7BBn/N4gSiqwOADAlmxLeNa1GjMoNZVr5F/wMKwPgB1P4QJ2C
 i49w==
X-Gm-Message-State: AO0yUKUYz5Nz/AMiUfTIRM0mv/TDcTAbK+idnsGRwmM66LS+PNbg8b4Y
 danWTDYDlRB1Opp865YAxo6++jpka/sInj9bDFUuw5iE0bA4rSP2u4pZKvFKShjB84m+rrFP9Kq
 8/7Ub3ohJMNP8gfOTc0tySt2bZ3CS23PQCd7F3yXdfS/JllEY2nU4VsckD0ZULWgo1ng4D9KWNw
 fr4JfLNEyLLwhoeLx/oySqAVkaDg==
X-Received: by 2002:a05:600c:220f:b0:3ed:9a09:183 with SMTP id
 z15-20020a05600c220f00b003ed9a090183mr2740484wml.2.1679413691622; 
 Tue, 21 Mar 2023 08:48:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YqhxDQpfS5NR1dT1A4CL5lP3K67FStlVUCkHzTbHZ4OmA894kPfK+s68ggo7GZKyrCyBFCQ==
X-Received: by 2002:a05:600c:220f:b0:3ed:9a09:183 with SMTP id
 z15-20020a05600c220f00b003ed9a090183mr2740463wml.2.1679413691320; 
 Tue, 21 Mar 2023 08:48:11 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 z15-20020a5d44cf000000b002ce9f0e4a8fsm11692694wrr.84.2023.03.21.08.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:48:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 7/8] vdpa_sim: replace the spinlock with a mutex to protect
 the state
Date: Tue, 21 Mar 2023 16:48:03 +0100
Message-Id: <20230321154804.184577-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154804.184577-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154804.184577-1-sgarzare@redhat.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
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
index 1cfa56c52e5a..ab4cfb82c237 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -178,7 +178,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (IS_ERR(vdpasim->worker))
 		goto err_iommu;
 
-	spin_lock_init(&vdpasim->lock);
+	mutex_init(&vdpasim->mutex);
 	spin_lock_init(&vdpasim->iommu_lock);
 
 	dev->dma_mask = &dev->coherent_dma_mask;
@@ -286,13 +286,13 @@ static void vdpasim_set_vq_ready(struct vdpa_device *vdpa, u16 idx, bool ready)
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
@@ -310,9 +310,9 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vrh->last_avail_idx = state->split.avail_index;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -409,9 +409,9 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	u8 status;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	status = vdpasim->status;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return status;
 }
@@ -420,19 +420,19 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
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
@@ -441,9 +441,9 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = false;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -453,7 +453,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = true;
 
 	if (vdpasim->pending_kick) {
@@ -464,7 +464,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 		vdpasim->pending_kick = false;
 	}
 
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -536,14 +536,14 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
 
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
