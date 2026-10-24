Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809163;
	b=BI5zrz0kkazTHn9OF9pPUr3AKryjvWWWIqTLOJnpM5HMtDkkes79VlQipc3R9OToH0XY
	 Lo+i0p9Xm4O5cOLYcQaICIDCLgm+z1npf+zKSGqeKjOTWtV7udrShUasCe626WV2v/zBM
	 m5jy288fnejOmVNch0Y7KacAkO+PG6Oxa9wOPcM25fosbd/Iuinv20OrGk7w6cmYNngvf
	 GifE2D+Gh3CR43HZzZZRKd74NkRNEPOxQYCyATFwwkL4crzchdBNOd7QELWThf3X3Pft3
	 tyn1odiuG/WEfImazCoz3zzyz9efOK+Onj3CF8Jb7w/sY3xNrGXJmGgCIWmctCDygMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7F72u9lGuKmWjfIbijrWQhevi9rtH/ah1WlkZ5PLmgA=;
	b=r5kHEVBeAp+PrLTPz98IV65n6BTNW5BuDBnot9hH5pMp1aSCt2agwI9Dm3maIODjUMux
	 Dzsrf13q48zdEX4MSs2Mg82tcG7rfeHMBi5CUVW40TCeWERZzdrPTNNcOhXc+t6J/b7JN
	 EWrMq1QJ+aUQgAsafL1uAUxHC41CxhlvwAWt36DHm/E+g7gmmcm+OXWZqYnSvIhQUm0Nk
	 6RUUgODEVdx+lnNMNU2Y/NrKo9EmuvJtF111aZsDtZkT0qSMcBqa01HI8x0BHxGaYlJiC
	 mmCwLg2cR17qGzxV6HBB2p+zKpNIeq7m6ZFtMa+nBdQK3E8g57Z+Y3xXzDf7bAkzLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N44NgpZ4;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E1606A338
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 02:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D09E1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N44NgpZ4
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438d9363fbso1023510c88.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809162; x=1793413962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7F72u9lGuKmWjfIbijrWQhevi9rtH/ah1WlkZ5PLmgA=;
        b=N44NgpZ4ZNs2aprrzSF6ka2cXQ+BbewxwLahtwBlV9qJsJcbVn4Q12+kHqe5n2HuVV
         2GAp97gEidEZ9A9jNsKPsHjxVx/Ch8qkeTSGFMWGk8pWyaB4ZFTjvoZxX3HNKv2TomyL
         KFGMBRcAGVoZKLSb3j8yOad3AeRIY/bLM29OJR0xoIsXGxGiMQ3AT3vql8RWO9VSbJMi
         69FFqFSaxMdhmni/OrJ1ySiWM3pDTkdzKmhZr5F/tdPK3wWQLFyxY3Kcrsd5erNg46X2
         vMgvGqXIJVW7solzjyU3JGm4N9B+dTK+ZW9rYrBZaZRa7+NsU4C7QpvOuIZeo5vrp3QO
         Ka3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809162; x=1793413962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7F72u9lGuKmWjfIbijrWQhevi9rtH/ah1WlkZ5PLmgA=;
        b=2k//7viIXDpBgYTYCgiEN2eKpmkEIAHBtdmjWr96IjPPUv2Ma67fEaNgejtGNMYlfO
         K07Jx3C+qbHyTnGdwmwnu5pIyXmzQBYxq0cdDIUirCB3rLwxBcFyKVf1GGNfRGPv8dq9
         8ctD1DPmJ9or6PpPYRiO8oiO5nieEg07qyqbFJjX32KyfEeFtYh1pEOB/R1nEA/QaM0U
         CUDbHCyxgMvSbAkrMSokSSzsMlxa5XyFxvDONKiKWGTKXzdYdJvIOm0cfPNZgSBj9Qgw
         Fu9DPXm/UVSUMoq9jbTrkfF5/ARZdqAP2CRTzH2JPulQ665WXKPJAAFruwHr7h1+J4yI
         N5qg==
X-Forwarded-Encrypted: i=1; AKwUvBwbyxh0jeBEsSFlsvgJMA9mQRn5Y2R9zn+fql6B6MQ2u7PN2GHZOMAyjwp8x1hcjhTPDFUe6KpWaMTgbzDnIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLM7EfBSUjTuB51sqZd7oQrPQC/Yx7Hom3We0m+MylOFnKMwOyw
	xxPoPm7xoGAXOwVT+pz0DrvNeQMPia9dTm0qDgtPyS36v7uTFdzzVK9b
X-Gm-Gg: AYBFou09o2y7tW/5wAIXMZFut9S94uc6ed2D6LuemPnZfxA6wFcJnEqii/OVVJs3oPR
	x/I6Tu5DJIRtW76dMPb2aZnmDVmKcrbEAP98Ij8j7KDZOiLrWgADcjE3oRD5aAWNDKfDAltQBnt
	fU7XbEwmLbUlzqJoblQtf5crmBHW5x8wxZr5girr6K5RZ1EVLjJuCkh/b73eCDfec+weiWFOQ1G
	2mPT2P1u+Vv4uxIegGWeU0+0gSqQD8XcWDkZz+RvC3U6/J/y1nLVk2LeIgCmE8mMAALJCpLY1O9
	lqo21lzE71WWfiI+E5N2i9MXrCYmjbxybo4WCG4p5Gfybg7+lw6kI01dfP09jT2PZo4xJUDHyDs
	plQTox7QKMnL9lyhtq/RbNcbZ0b41p5+nLdNA4G6KTS24YWktBXMrmRPOX1C+2gAStC5DhjeB3A
	47LNUW/JQhFXhWXj1cBLKqnSaeb+oSdXBv91fE0sbRKMxYRYtCmlSUt+HGOijUIkRFsBYukPcH/
	Ki33ymIsF6oStsDbDdclo7m9yMj+K3LUGxDDfb52jz5TdX0XUjRESQLR5fIcaBfu/TDvqN4g0X0
	0cfIcXBZoVAFhj0K7Uw4q28MCfMZn/RgmBy0EBZXC1s8Z+r1fQvU7YVwa38qVcGTvNyDR8Qr
X-Received: by 2002:a05:701b:21c5:b0:184:40db:6bb9 with SMTP id a92af1059eb24-199344ccebfmr936966c88.8.1792809161701;
        Fri, 23 Oct 2026 19:32:41 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm3958542eec.23.2026.10.23.19.32.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 19:32:41 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH 2/2] ALSA: virtio-snd: fix dsnoop capture with staged buffers
Date: Sat, 24 Oct 2026 11:32:32 +0900
Message-ID: <20261024023232.84448-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024023232.84448-1-mynameisjune111@gmail.com>
References: <20261024023232.84448-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsnoop runs its hardware slave with stop_threshold == boundary and can
consume the mmap capture ring without advancing the hardware application
pointer. Staged capture currently treats every stream as a bounded
consumer: capture_ready grows until the completion capacity check fails.

With a 48 kHz mono slave, 960-frame periods and a 7680-frame buffer, the
baseline dsnoop reproduction stops after 6720 frames with -EPIPE and a
ring_capacity rejection. Direct capture continues to work.

Cache the prepared boundary and recognize the free-running policy under
the substream lock. Keep RX requests supplied in that mode, while retaining
payload, frame alignment, counter and pointer-window checks. Sample the
policy once per completion so validation, copying and refill agree.
Refresh it separately in the ACK accounting and refill critical sections.

On a return to bounded capture, reconstruct unread occupancy from the
copied and acknowledged totals. If outstanding data fills the ring, the
policy helper returns -EPIPE and preserves the cached mode and counters.
The detecting RX, pointer or ACK path reports XRUN through its existing
error path; this does not make sw_params fail synchronously.
Reset cached policy state during prepare and teardown.

In MOTU/VZ comparisons with one and two vCPUs, the baseline failed all
32 shared-client captures. The candidate passed 48 capture cases and eight
recovery diagnostics, including 70-second CPU-saturated shared captures.
Synthetic QEMU dsnoop data matched 2160000 reference frames across 12
files. Forced policy transitions passed KASAN/KCSAN checks. Aggressive
KCSAN still triggered dsnoop client-threshold XRUNs with a 160 ms buffer.
The physical tests checked frame counts and nonzero mono input; exact
sample continuity was checked with the synthetic source.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -47,7 +47,9 @@
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
- * @capture_ready: Captured bytes copied but not yet acknowledged by ALSA.
+ * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
+ *                 always zero in free-running mode.
+ * @capture_boundary: ALSA boundary captured for this prepared epoch.
  * @capture_copied_total: Monotonic bytes copied into the capture ring.
  * @capture_acked_total: Monotonic bytes acknowledged by the capture client.
  * @capture_pointer_seen_total: Last capture position sampled by ALSA.
@@ -58,6 +60,7 @@
  * @capture_staging: Capture uses request-owned payload buffers.
  * @capture_started: Non-empty capture data was received since prepare.
  * @capture_empty: Consecutive empty startup completions.
+ * @capture_free_running: Cached staged-capture policy, protected by @lock.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
@@ -88,6 +91,7 @@
 	size_t buffer_bytes;
 	size_t hw_ptr;
 	size_t capture_ready;
+	snd_pcm_uframes_t capture_boundary;
 	u64 capture_copied_total;
 	u64 capture_acked_total;
 	u64 capture_pointer_seen_total;
@@ -97,6 +101,7 @@
 	bool runtime_active;
 	bool capture_staging;
 	bool capture_started;
+	bool capture_free_running;
 	unsigned int capture_empty;
 	bool xfer_enabled;
 	bool xfer_xrun;
@@ -128,23 +133,29 @@
 
 /*
  * ALSA may observe a subperiod tail before its period callback. Keep actual
- * unread occupancy separate from pointer observations and notification state.
+ * unread occupancy separate from pointer observations and notification state;
+ * free-running streams account occupancy from monotonic totals instead.
  */
 static inline bool
 virtsnd_pcm_capture_counters_valid(const struct virtio_pcm_substream *vss)
 {
-	return vss->buffer_bytes &&
-	       vss->capture_copied_total >= vss->capture_acked_total &&
-	       vss->capture_copied_total - vss->capture_acked_total ==
-			(u64)vss->capture_ready &&
-	       vss->capture_ready < vss->buffer_bytes &&
-	       vss->capture_pointer_seen_total <= vss->capture_copied_total &&
-	       vss->hw_ptr == vss->capture_copied_total % vss->buffer_bytes &&
-	       (!vss->capture_callback_snapshot_active ||
-		(vss->capture_callback_snapshot >=
-			vss->capture_pointer_seen_total &&
-		 vss->capture_callback_snapshot <=
-			vss->capture_copied_total));
+	u64 outstanding;
+
+	if (!vss->buffer_bytes ||
+	    vss->capture_copied_total < vss->capture_acked_total ||
+	    vss->capture_pointer_seen_total > vss->capture_copied_total ||
+	    vss->hw_ptr != vss->capture_copied_total % vss->buffer_bytes ||
+	    (vss->capture_callback_snapshot_active &&
+	     (vss->capture_callback_snapshot < vss->capture_pointer_seen_total ||
+	      vss->capture_callback_snapshot > vss->capture_copied_total)))
+		return false;
+
+	if (vss->capture_free_running)
+		return !vss->capture_ready;
+
+	outstanding = vss->capture_copied_total - vss->capture_acked_total;
+	return outstanding == (u64)vss->capture_ready &&
+	       vss->capture_ready < vss->buffer_bytes;
 }
 
 /**
@@ -207,6 +218,9 @@
 
 int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss);
 
+int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream *vss,
+					    bool *free_running);
+
 void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -3,6 +3,7 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/overflow.h>
@@ -384,6 +385,8 @@
 	vss->capture_notified_periods = 0;
 	vss->capture_callback_snapshot = 0;
 	vss->capture_callback_snapshot_active = false;
+	vss->capture_boundary = 0;
+	vss->capture_free_running = false;
 	vss->capture_empty = 0;
 	vss->capture_started = false;
 }
@@ -508,24 +511,54 @@
 	return 0;
 }
 
-/**
- * virtsnd_pcm_capture_send() - Queue staged capture requests.
- * @vss: VirtIO PCM substream.
- *
- * Queue full-period requests while the outstanding requests fit the remaining
- * ALSA ring capacity. The final request may exceed that capacity by less than
- * one period; completion validates the returned payload before copying it.
- *
- * Context: Expects the RX queue and substream spinlocks to be held by caller.
- * Return: 0 on success, -errno on failure.
- */
-int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss)
+/* Caller holds vss->lock. */
+int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream *vss,
+					    bool *free_running)
+{
+	struct snd_pcm_runtime *runtime;
+	snd_pcm_uframes_t stop_threshold;
+	u64 outstanding;
+	bool new_free_running;
+
+	if (!vss->capture_staging || !vss->runtime_active || !vss->substream)
+		return -EBADFD;
+
+	runtime = vss->substream->runtime;
+	if (!runtime || !vss->buffer_bytes || !vss->capture_boundary)
+		return -EBADFD;
+
+	/* Validate the currently committed policy before observing a transition. */
+	if (!virtsnd_pcm_capture_counters_valid(vss))
+		return -EIO;
+
+	stop_threshold = READ_ONCE(runtime->stop_threshold);
+	new_free_running = stop_threshold == vss->capture_boundary;
+	if (new_free_running != vss->capture_free_running) {
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if (new_free_running) {
+			vss->capture_ready = 0;
+		} else {
+			if (outstanding >= vss->buffer_bytes)
+				return -EPIPE;
+			vss->capture_ready = outstanding;
+		}
+		vss->capture_free_running = new_free_running;
+	}
+
+	*free_running = new_free_running;
+	return 0;
+}
+
+/* Caller holds the RX queue and vss locks and has sampled the policy. */
+static int virtsnd_pcm_capture_enqueue(struct virtio_pcm_substream *vss,
+				       bool free_running)
 {
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
 	struct virtqueue *vqueue = queue->vqueue;
 	unsigned long period_bytes;
 	size_t free_bytes;
-	size_t request_limit;
+	size_t request_limit = vss->nmsgs;
 	unsigned int i;
 	bool added = false;
 
@@ -535,16 +568,17 @@
 	period_bytes = snd_pcm_lib_period_bytes(vss->substream);
 	if (!period_bytes || !vss->buffer_bytes ||
 	    period_bytes >= vss->buffer_bytes ||
+	    free_running != vss->capture_free_running ||
 	    !virtsnd_pcm_capture_counters_valid(vss) ||
 	    vss->msg_count > vss->nmsgs)
 		return -EIO;
 
-	free_bytes = vss->buffer_bytes - vss->capture_ready;
-	request_limit = free_bytes / period_bytes +
-			!!(free_bytes % period_bytes);
-	request_limit = min_t(size_t, request_limit, vss->nmsgs);
-	if (vss->msg_count > request_limit)
-		return -EIO;
+	if (!free_running) {
+		free_bytes = vss->buffer_bytes - vss->capture_ready;
+		request_limit = free_bytes / period_bytes +
+				!!(free_bytes % period_bytes);
+		request_limit = min_t(size_t, request_limit, vss->nmsgs);
+	}
 
 	for (i = 0; i < vss->nmsgs && vss->msg_count < request_limit; ++i) {
 		struct virtio_pcm_msg *msg = vss->msgs[i];
@@ -585,6 +619,25 @@
 	return 0;
 }
 
+/**
+ * virtsnd_pcm_capture_send() - Refresh policy and queue staged requests.
+ * @vss: VirtIO PCM substream.
+ *
+ * Context: Expects the RX queue and substream spinlocks to be held by caller.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss)
+{
+	bool free_running;
+	int rc;
+
+	rc = virtsnd_pcm_capture_refresh_mode_locked(vss, &free_running);
+	if (rc)
+		return rc;
+
+	return virtsnd_pcm_capture_enqueue(vss, free_running);
+}
+
 static int virtsnd_pcm_capture_status(const struct virtio_pcm_msg *msg,
 				      size_t written_bytes,
 				      size_t frame_bytes,
@@ -638,6 +691,7 @@
 	size_t audio_bytes = 0;
 	size_t next_ready = 0;
 	u64 next_copied_total = 0;
+	bool free_running = false;
 	bool got_audio = false;
 
 	guard(spinlock)(&vss->lock);
@@ -651,6 +705,9 @@
 		/* A full ring is modulo-ambiguous, so fail closed before copying. */
 		if (!runtime || !runtime->dma_area)
 			invalid_reason = "runtime";
+		else if (virtsnd_pcm_capture_refresh_mode_locked(vss,
+								 &free_running))
+			invalid_reason = "policy";
 		else if (!virtsnd_pcm_capture_counters_valid(vss))
 			invalid_reason = "counters";
 		else if (vss->hw_ptr !=
@@ -660,18 +717,28 @@
 						    frame_bytes, &audio_bytes,
 						    &latency_bytes))
 			invalid_reason = "status";
-		else if (audio_bytes >=
-			 vss->buffer_bytes - vss->capture_ready)
-			invalid_reason = "ring_capacity";
-		else if (check_add_overflow(vss->capture_ready, audio_bytes,
-					    &next_ready))
-			invalid_reason = "ready_overflow";
-		else if (next_ready >= vss->buffer_bytes)
-			invalid_reason = "ring_full";
 		else if (check_add_overflow(vss->capture_copied_total,
 					    (u64)audio_bytes,
 					    &next_copied_total))
 			invalid_reason = "total_overflow";
+		else if (free_running && audio_bytes >= vss->buffer_bytes)
+			invalid_reason = "payload_exceeds_ring";
+		else if (!free_running &&
+			 audio_bytes >= vss->buffer_bytes - vss->capture_ready)
+			invalid_reason = "ring_capacity";
+		else if (!free_running &&
+			 check_add_overflow(vss->capture_ready, audio_bytes,
+					    &next_ready))
+			invalid_reason = "ready_overflow";
+		else if (!free_running && next_ready >= vss->buffer_bytes)
+			invalid_reason = "ring_full";
+		else if (free_running &&
+			 (next_copied_total < vss->capture_pointer_seen_total ||
+			  next_copied_total - vss->capture_pointer_seen_total >=
+			  vss->buffer_bytes))
+			invalid_reason = "pointer_window";
+		else if (free_running)
+			next_ready = 0;
 
 		if (invalid_reason) {
 			virtsnd_pcm_capture_xrun_locked(vss);
@@ -713,7 +780,8 @@
 
 	msg->length = 0;
 	if (vss->runtime_active && vss->xfer_enabled) {
-		if (!vss->xfer_xrun && virtsnd_pcm_capture_send(vss)) {
+		if (!vss->xfer_xrun &&
+		    virtsnd_pcm_capture_enqueue(vss, free_running)) {
 			dev_warn_ratelimited(&vss->snd->vdev->dev,
 					     "SID %u: failed to refill capture queue\n",
 					     vss->sid);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -543,6 +543,8 @@
 			vss->capture_notified_periods = 0;
 			vss->capture_callback_snapshot = 0;
 			vss->capture_callback_snapshot_active = false;
+			vss->capture_boundary = 0;
+			vss->capture_free_running = false;
 		}
 	}
 
@@ -565,6 +567,7 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	bool pause_restart = virtsnd_pcm_pause_restart_enabled(vss);
+	bool free_running;
 	int rc;
 	bool stopped;
 
@@ -622,6 +625,15 @@
 	vss->suspended = false;
 	vss->msg_count = 0;
 	virtsnd_pcm_msg_reset(vss);
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->capture_boundary = substream->runtime->boundary;
+			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+								     &free_running);
+		}
+		if (rc)
+			return rc;
+	}
 
 	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
 	vss->pcm_indirect.sw_buffer_size =
@@ -1132,12 +1144,18 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	size_t hw_ptr = 0;
 	u64 total;
+	bool free_running;
 	bool xrun;
 
 	if (vss->capture_staging) {
 		scoped_guard(spinlock_irqsave, &vss->lock) {
-			xrun = vss->xfer_xrun ||
-			       !virtsnd_pcm_capture_counters_valid(vss);
+			xrun = vss->xfer_xrun;
+			if (!xrun &&
+			    virtsnd_pcm_capture_refresh_mode_locked(vss,
+								    &free_running))
+				xrun = true;
+			if (!xrun && !virtsnd_pcm_capture_counters_valid(vss))
+				xrun = true;
 			if (!xrun) {
 				total = vss->capture_callback_snapshot_active ?
 					vss->capture_callback_snapshot :
@@ -1244,14 +1262,18 @@
 		snd_pcm_uframes_t appl_ptr;
 		snd_pcm_sframes_t diff;
 		size_t bytes;
+		u64 outstanding;
 		u64 next_acked_total;
+		bool free_running;
 
 		if (!vss->runtime_active || !runtime || !runtime->control ||
 		    !runtime->dma_area)
 			return -EBADFD;
 		if (vss->xfer_xrun)
 			return -EPIPE;
-		if (!virtsnd_pcm_capture_counters_valid(vss)) {
+		rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+		if (rc || !virtsnd_pcm_capture_counters_valid(vss)) {
 			vss->xfer_xrun = true;
 			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
@@ -1270,7 +1292,11 @@
 
 		/* ACK includes any subperiod tail already copied to the ring. */
 		bytes = frames_to_bytes(runtime, diff);
-		if (bytes > vss->capture_ready ||
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if ((!free_running && bytes > vss->capture_ready) ||
+		    (free_running &&
+		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
 		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
 				       &next_acked_total) ||
 		    next_acked_total > vss->capture_copied_total) {
@@ -1280,7 +1306,8 @@
 		}
 
 		vss->capture_acked_total = next_acked_total;
-		vss->capture_ready -= bytes;
+		if (!free_running)
+			vss->capture_ready -= bytes;
 		vss->pcm_indirect.appl_ptr = appl_ptr;
 	}
 
