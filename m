Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D3C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFA6A4087A;
	Tue,  4 Apr 2023 13:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFA6A4087A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0Jzp41p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxUEj2JvGIl9; Tue,  4 Apr 2023 13:17:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B3AA409EA;
	Tue,  4 Apr 2023 13:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B3AA409EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9FC1C0036;
	Tue,  4 Apr 2023 13:17:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4034C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD4E24096B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD4E24096B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ocZ1rSkccUV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84ED140942
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84ED140942
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQ8fDN2h9p4iTg0iFPY/+DuAnJcVPz4edknSv7QjGbU=;
 b=A0Jzp41pY57ux8IiInqx9omOLLXbbQs6cBJPrgQRiMWaMHZ1vVWELd53YQyd9UphUoc8+C
 kr+Lpa5X/PCS/WFNm8bXyxn79CPmxaPdXgjZ/UDbYjswnZ/wF9gu3yyNleD4iAPf+PACw7
 B66vVN8pJQgYKqpG2znY2P0PUc4sdIc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-TtE7Nu69M3GNFM48Jm-Xlw-1; Tue, 04 Apr 2023 09:17:35 -0400
X-MC-Unique: TtE7Nu69M3GNFM48Jm-Xlw-1
Received: by mail-yb1-f200.google.com with SMTP id
 f66-20020a255145000000b00b714602d43fso32403699ybb.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ8fDN2h9p4iTg0iFPY/+DuAnJcVPz4edknSv7QjGbU=;
 b=1a6f8qy/9XDr2t1dy0jtG2ypYzj29WLVOTGUuc8cWzitgLGmWOEQOow9IVo0M3nmr9
 fP/45r9SkD3yCbsyP4DDAflS+Qa+6PQeNF8UXbXnaJCCgkOXF+EcfwH41b5ZoQ9PeBVs
 RYrjqtN13ECiXGywn1TUufZLmYm8QEdECPZTL2QJPcvO+Xy/NXWJVUqGUIxHzN+9353R
 3NZXZTAnEUhYYj8ywZ6X+KzCf8xqfCTGWdtr4og4yIYgCxo8WJS9AdBAHhU+YZIz9I/C
 dTEwvriN/feFGvI2A04s2VBSjMLFkK3zoAG8ZCsTDJOtmgASXr7FWeF06uhlseG2yiPt
 XDhA==
X-Gm-Message-State: AAQBX9d/ZKLcJtrWGBCbyRkZs3uwTwGBI51RJoXloiVjFv+0yWgKHxcf
 r5f9I1jMKKvDiEdZCypVURLKIz7pf/5qPSNUgKn3UAS3sde/DlL8J3yvENcUSqnO6qXmkZ7TSC3
 GjJ8DT2hMWeLTLGWevKE3TzENlmchO+QN1Pi5n0xO2OCmyPSSqaUo0T7yrXqeg/UibnWor8I6qW
 lySWpcfOEwM2f1US/95wEjEWgZCw==
X-Received: by 2002:a0d:e003:0:b0:544:9cfb:72bb with SMTP id
 j3-20020a0de003000000b005449cfb72bbmr2116772ywe.52.1680614254397; 
 Tue, 04 Apr 2023 06:17:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350bsCle0WG2zzZfNAuJuVeI37DETAsMZmIkB4vwvojUB3+nQyroa9J5emVzIkAjvOma47Ny30A==
X-Received: by 2002:a0d:e003:0:b0:544:9cfb:72bb with SMTP id
 j3-20020a0de003000000b005449cfb72bbmr2116728ywe.52.1680614253971; 
 Tue, 04 Apr 2023 06:17:33 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 v67-20020a379346000000b007460093cccdsm3586891qkd.25.2023.04.04.06.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:17:33 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 8/9] vdpa_sim: replace the spinlock with a mutex to protect
 the state
Date: Tue,  4 Apr 2023 15:17:29 +0200
Message-Id: <20230404131730.45920-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
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
index bd9f9054de94..2b2e439a66f7 100644
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
