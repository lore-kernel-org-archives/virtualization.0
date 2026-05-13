Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F444D98F6
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691030; cv=none; b=upRTFITAcYyCSoaG/BqInuZDXJ39uvBNLDHr2GgfEjRf72CHeF965OC1Nz3sPq6F7KBmjxoMS4DL/F7nTIMdEWVP1z3pShQD4Wp4eDVDTpKG1KvzGbZgDOp5bbklbKrUHyfDbNSxtgsUKw5Sgo0ikLE+fOl35Z29HMBWbutuecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691030; c=relaxed/simple;
	bh=K9ud04g2GtJZTP7N5+sbsYRFa3+YAwr9aoxLcR+A5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpUoZz7YYp0oymmPTMCy0vtrBVSXdTcZUZSsAVI8Zb4t2pKz4tiDK1n3IqUj9gVcitzK0tFe7nYPzxHSIy57S1TKz4ge1W9QkDi+xO3sMP3/JS+gZou9n+7wPdw4RqOOutomWuvYUL2kEaVzjlyQ9Dw1G6uzQuz/eKh0Cl7S/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=c6skP+PJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="c6skP+PJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fc496c8baso66147631cf.3
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778691018; x=1779295818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpqzNVPBldqpjotoU+BkXiOr5oMwQ73fbPB9arzcGvQ=;
        b=c6skP+PJASM8746sXohdXhxHjIOFHeHH7qZvC0MvZ7qALXTWgUObGqkwgyxGxvpd9O
         7eZEl+GV1dDxHFjzMhDnQo/Uqkq6FnBmiVaUqRyyLP7Nat63R4Pkg5wydzVW0C8ZYfCx
         DDD+OKzn/xq76lpfUGhBUdYbVetuqNaLJitSNsoB0Qe/FMAnhkaUx/ucGMAJ3vaGkFLY
         OGrwJqyk2R6gHxJHTMn+2QJwClwk5AaLjq3e6WOBI3IJ6sOrXd9gQge1HOkeGRL4FG33
         Kn+/ptadxWjOdOtIXsJe/LBNE5RVfTsizlEfD5s0qV70cCgFyRJd5K53aS9NN6NCT7I8
         FQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691018; x=1779295818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpqzNVPBldqpjotoU+BkXiOr5oMwQ73fbPB9arzcGvQ=;
        b=dZs5VLuYy441KOVTSGKlyDuxLh85TxVZInnVQ5Vh6lWJWqbif7lA1j0tIiURMMe0Bu
         w7mviqqn/qdIok6jlqyEkIp20zK4srS7+WuQv4Ze0Y4CvaO2Eo+kKbaf7ZLauHxGPBxE
         WyWCUqKZUfjXlIeTlsJgLw/eXiL32PS1uZrax9HnK9qM2bO3LAm659LhYNnBoicImc4O
         sYXCHLG/Tc7t7EC8GNhHpSOH2DUfqyaoxEjgch+ulO+1jI4xXeUtQcqBiqBNUfHRbQie
         i4XheEv6sZkcDWmI/vcD5MMexrhhE4bcDs1zDOPC2iBiN6S1qhN4/PSo6ztEGd7rzzsK
         iGyQ==
X-Gm-Message-State: AOJu0YypLHZk0lQxdKjGj1Dp/wzGKr5DZGM1GrcCK2COXAGCH+CViZwr
	LttPrjluk8SZVVBACzqu4rkZYSW86IuYbOMTGzbH1Yva9Zch3wPaLU3HvYwaZylWS1DqhWezmGh
	dLArd
X-Gm-Gg: Acq92OHCTpzbME/XyPQFzSvYpUiIKMBeMXi8XY+JvQdPeXMjtxWCxKS2pqYhPMH2x6Q
	DUwiM+Fu7wD3EIqjU5XjZGncm11j1n+0vqtzeC9g64DhrlAvk4mzVpCGddjSOct6DEJzOtP+dNQ
	TVgsXLWh58cMlAxZ8YFoL8MtfzXQF3B3iCutzY+2qEnpS2pB7Pi+PAahGTfbqYONZnAhCMiKLtZ
	OfblBJ6IoUhcjDipn+7zEIMP6+0CPQ3tLu9UGPz6663QNjQp0eZ2UxcVDNpO6tWj9c7IfOKLsZB
	PYt3OL3/qspxOD8oSLHlbGY+YkTNwubxhV3EHdgbHZd22BHhCjM0evpNWqphjfGq9CPaK1kW6Rx
	WiowIK3wE2wgGmB8GdIflxXpCS3u7INBU5HdFv8iZuLHgnDcxb5Sit0UVF/MMq5xjwL/VzgNwGa
	4yu37I97BzzOTL/QikJRVyhlVX4ZOrZDjatUBIdBxRJZbIMfQdejCH9FRDY9Gg2jSt44Ztudj8B
	v3thRTzkp3oguLIIA==
X-Received: by 2002:ac8:5a8c:0:b0:50f:ad91:8912 with SMTP id d75a77b69052e-5162f4aecadmr58343841cf.13.1778691013143;
        Wed, 13 May 2026 09:50:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e677e63sm152498891cf.12.2026.05.13.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:50:12 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mst@redhat.com,
	david@kernel.org,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Subject: [RFC PATCH 2/2] virtio-balloon: add stats push mode
Date: Wed, 13 May 2026 12:50:06 -0400
Message-ID: <20260513165006.2790857-3-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513165006.2790857-1-gourry@gourry.net>
References: <20260513165006.2790857-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing aggressive overcommit of VMs on a single host, a pull
model of stat retrieval is problematic if a guest becomes some form
of unresponsive.  In particular, it's difficult to discern the
difference between a hung guest and a slow guest - and why the
guest is experiencing that.

Add VIRTIO_BALLOON_F_STATS_PUSH feature that allows the host to
configure the guest to push stats on a timer instead of the default
pull model.

The host sets stats_push_interval_ms in the balloon config space:
  0     = disabled (pull-only, default)
  N > 0 = guest pushes stats every N milliseconds

The push mode reuses the existing stats VQ, same buffer format,
same tags. The host can change the interval at runtime by updating
the config field.

Push mode provides two advantages over pull:
  1. Guest liveness detection: in pull mode, the host cannot
     distinguish a slow guest from a hung guest without implementing
     its own timeout tracking. In push mode, the absence of expected
     stats buffers is an implicit liveness signal; if the guest
     fails to push within the expected interval, the host can
     conclude it is unresponsive.
  2. Latency-sensitive consumers (e.g., memory pressure response
     loops) receive fresh stats at a guaranteed cadence without
     the host needing to poll.

STATS_PUSH requires STATS_VQ; the driver clears STATS_PUSH during
feature validation if STATS_VQ is absent. When push mode is active,
the pull callback is suppressed to avoid racing on buffer submission.

The pull model remains available and is the default.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/virtio/virtio_balloon.c     | 71 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_balloon.h |  7 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8fa33aec4ce7..47bde1d2b388 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -112,6 +112,10 @@ struct virtio_balloon {
 	/* Memory statistics */
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
+	/* Stats push mode */
+	struct delayed_work stats_push_work;
+	uint32_t stats_push_interval_ms;
+
 	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
 	struct shrinker *shrinker;
 
@@ -463,6 +467,13 @@ static void stats_request(struct virtqueue *vq)
 {
 	struct virtio_balloon *vb = vq->vdev->priv;
 
+	/*
+	 * In push mode, the push timer owns the VQ. Ignore pull
+	 * requests to avoid racing on buffer submission.
+	 */
+	if (vb->stats_push_interval_ms)
+		return;
+
 	spin_lock(&vb->stop_update_lock);
 	if (!vb->stop_update) {
 		start_wakeup_event(vb, VIRTIO_BALLOON_WAKEUP_SIGNAL_STATS);
@@ -558,6 +569,20 @@ static void virtballoon_changed(struct virtio_device *vdev)
 		virtio_balloon_queue_free_page_work(vb);
 	}
 	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_STATS_PUSH)) {
+		uint32_t interval;
+
+		virtio_cread_le(vdev, struct virtio_balloon_config,
+				stats_push_interval_ms, &interval);
+		if (interval != vb->stats_push_interval_ms) {
+			vb->stats_push_interval_ms = interval;
+			cancel_delayed_work(&vb->stats_push_work);
+			if (interval)
+				schedule_delayed_work(&vb->stats_push_work,
+					msecs_to_jiffies(interval));
+		}
+	}
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
@@ -581,6 +606,32 @@ static void update_balloon_stats_func(struct work_struct *work)
 	finish_wakeup_event(vb);
 }
 
+static void stats_push_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
+						 stats_push_work.work);
+	struct virtqueue *vq;
+	struct scatterlist sg;
+	unsigned int num_stats, len;
+
+	if (!vb->stats_push_interval_ms)
+		return;
+
+	vq = vb->stats_vq;
+
+	/* Reclaim previous buffer */
+	while (virtqueue_get_buf(vq, &len))
+		;
+
+	num_stats = update_balloon_stats(vb);
+	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
+	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	virtqueue_kick(vq);
+
+	schedule_delayed_work(&vb->stats_push_work,
+			      msecs_to_jiffies(vb->stats_push_interval_ms));
+}
+
 static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
@@ -967,6 +1018,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	}
 
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
+	INIT_DELAYED_WORK(&vb->stats_push_work, stats_push_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
 	spin_lock_init(&vb->stop_update_lock);
 	mutex_init(&vb->balloon_lock);
@@ -1094,6 +1146,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_STATS_PUSH)) {
+		uint32_t interval;
+
+		virtio_cread_le(vdev, struct virtio_balloon_config,
+				stats_push_interval_ms, &interval);
+		if (interval) {
+			vb->stats_push_interval_ms = interval;
+			schedule_delayed_work(&vb->stats_push_work,
+					      msecs_to_jiffies(interval));
+		}
+	}
+
 	return 0;
 
 out_unregister_oom:
@@ -1145,6 +1210,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
+	cancel_delayed_work_sync(&vb->stats_push_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		cancel_work_sync(&vb->report_free_page_work);
@@ -1199,6 +1265,10 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_STATS_PUSH) &&
+	    !virtio_has_feature(vdev, VIRTIO_BALLOON_F_STATS_VQ))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_STATS_PUSH);
+
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1210,6 +1280,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_STATS_PUSH,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 37ec8a8466c4..90e9b5247e5e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_STATS_PUSH	6 /* Guest pushes stats on a timer */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -59,6 +60,12 @@ struct virtio_balloon_config {
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	__le32 poison_val;
+	/*
+	 * Stats push interval in milliseconds. 0 = disabled (pull only).
+	 * Valid with VIRTIO_BALLOON_F_STATS_PUSH. Host-writable, can change
+	 * at runtime via config updates.
+	 */
+	__le32 stats_push_interval_ms;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.54.0

