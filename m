Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156039;
	b=W6TjoM1T64+r+blhqiJW0HQXXktHfZ+i9eLA/237HZTBFMhCAkp895qEkuC/bp4opq18
	 yuLDZ2ZNOLAjk8XKlcziCbpsg2VLGqGme9hf+GD30LxIykskKHiVteWdjSuu4MTVw6vk/
	 eA7pnrkOFKWolIbRawMlXz2XO9e4rdZvEyKUCsc0WMNUeHZVi+pwnU5vxriWYJDCCkR+J
	 n3zz/pI6pDWZ4lXaFYSqXO94x7pgPwBIQZd+Xlma1806j4qqAPXKiXVVuODBdQFJufOy7
	 gFISHh+ps6flrIBgS6rHKcZKb0UPsM4CTPniGo/BsJsh88O6LTPLKSca9hsCjHBLNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h6EDD+wqeFPatnIY75r59I+JXe+hDBGTfDeQYoy9Hng=;
	b=VQR0dJLArVe3Mic91RAzkT7qiouKLRJOhzpBKxPPFgKIbOttBM4xjeDG3OqwXIvsqxbD
	 FRe8HdE4sVM3QylroVDNSbn2LU9KyPmhf61OJaE6TY5bOnbPesmArrogLY+/FvvuL8+3o
	 z7NZXAMsfiMRvAD/mzHtq8lkdq0nNw9lU1mVvoS3Ue/Ng1qtevFYMXqNzLbiKDNwJd54T
	 +ZF5UyzISUV2zrmodO5L5e0ktVZOHiVRiyOm2KOfS8Ut6X+pDuQKa3BpXjIaTHfFhq5Xl
	 r9kFPzDzqHmceAggkbK9w3GhR6L/vSp6Yqg4VwougCfO3KXcHP3DmffhxpAEeILmQWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfHhOrg1;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F1606A32C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390F1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfHhOrg1
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so815005eec.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156038; x=1793760838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6EDD+wqeFPatnIY75r59I+JXe+hDBGTfDeQYoy9Hng=;
        b=QfHhOrg1WIoy6kL48chkb06RpVCs/3pxlWXsP1u4JAbVXtKn6ExcyUemdez8O80cU5
         Mph+SgDvf9j1PtisMN+b70cwQxBtPNNN8lUzK9MH0hD685I7OE/M3+dQYgIj3vQOpFM/
         kmdvj7CcNsPamlWQ1UDCy/1/ne2vHJyoYeiZqPe3SjlhnqbpxDH81q3pT6+X2VKDQxnK
         QdkLUehQgAWbVuMzPeqgF0ztHTXIC7TqOc+9iLM7tab8DxcXrdYpAkiOwlBAW1E5bunm
         cTvxXDF5i7ljNuH06UllZddEJczYMXH8AHNXNa31U8GJqNfWfkIp9QrQ6kgcivuwzAW0
         HffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156038; x=1793760838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h6EDD+wqeFPatnIY75r59I+JXe+hDBGTfDeQYoy9Hng=;
        b=dqeiXuAmKChSriNeDRDwYBxKoEYWgT6PdmyyjgF7M07ahJdaGSrhcKfJtbIbb2fEmG
         Vo5NwwIeCRHuOclBch3x9Ix4BKnJUl20CyQTDbVV+MjfSF0f/YjMDIdIjofm1lFg9TNI
         mrZa2jl/3JNhckd6ciK8XxKWK5aH+Bu1T3TrozfPe+8jnE1LP67J62+AsRs8XBgWPDiG
         U5JoCZ3X+AoR3sHUiaW1OcgbsG3Saq5xrEXDf0TCBohFydnBjQyAdWr4OlpdsKk5WaUc
         hKXgS5QJiOlk/hGRIEAR1n8wiJgHqiEACVQjTEHrUxDGTiM0TmEm/f5etwpthrF/ayAt
         MYSg==
X-Forwarded-Encrypted: i=1; AKwUvBwftYqy6UbAn6gSbyTWv2ocKLagAEGqj9w/rMYDynRJWtNtrY7YF5Ys6nJPmn+kL3aRrjrIIs53fjGd6wER0w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1sgs5cydSJi7HE7ZiccAvktxBYXAGZl989OeRobXvB4//KYec
	ZNSq0GUesN2MywHDQzMZfFzIIKvIh3OVds2h302atpBpFdzQ4FpIvBwz
X-Gm-Gg: AYBFou0j+B1PTCb5sQK1/Hc1MJj4UyAtGRbzmFXU+7W9Jv8f5spNGEuebzLKB0ftGyC
	A+OcFpCbMj5wF82lYwuEk/9EU9eVY5B+eDKiwPsMynjHrSrnlcq+FuaTvnr7eW4GCR7iwrU2xE7
	7BHI5mWSTPHojemeWU+tFeDQBqGJKuH5stEFAl4djOeWG04/VWGbHq41PfVIv/zxN4G6Ohhsuko
	41RbKriy7h2JhyM1J8zJ8Brjha9jcq8e3ODofNzBK2Ra6z0rddPgiBek4THnZCCSbOgirKniFEh
	Prqz3kAHA7m3K4OfTCijWolHcGDt8zcdx+9hplwvYfaCJC64YEEv4+M2OlsD3rblsRF1yshGcdc
	m7Kqaun5ANvmIkaH00zrzrw7JhRCik1PoyBLgsCwlcWkCNuTBE7NwozrDQJAMymgL1uJ2i0oPJm
	duu7Ng+0vEI6kDabrJ/WndGt6obXoa9VsLGQVQQw/hwHKE6Ryz2Cbo+nHQZB/fr0iTXYFIJPM98
	1tJhkqc8piE0nLDC4UG3aPobkAQWQAInJzy4tSwYN5HI71mkg3NcMEKa1ijcoz5ugj0lXssN5Tu
	p+M4Ruwa4T6q3Fotr3mjohzFD/yXSNBfi/qqDrpI7NUDMksFGLUzLIX44OlU6D0oIQ0nPr0L2OU
	8Z/YTMSyz17Nh+dP1II6vwiMuCX0KxV56eNBfWLBVWGwh4uY=
X-Received: by 2002:a05:693c:41c8:20b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-36a2027e717mr2164295eec.3.1793156038268;
        Tue, 27 Oct 2026 19:53:58 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:57 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v6 11/14] ALSA: virtio-snd: fix dsnoop capture with staged buffers
Date: Wed, 28 Oct 2026 11:53:14 +0900
Message-ID: <20261028025317.92450-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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
A native pause release can also detect this overflow during queue refill.
Its trigger error leaves ALSA in PAUSED, so mark the staged capture as XRUN
and schedule the period worker before returning the error. The worker takes
the PCM stream lock after the pause action and wakes readers from XRUN.
A paused ACK can reach XRUN before that worker runs. Arm synchronous stop
before returning -EPIPE from staged ACK, and before the worker stops a
paused stream. ALSA skips trigger(STOP) for paused streams; these paths
must preserve the RELEASE and pending-RX cleanup needed by prepare.
Reset cached policy state during prepare and teardown.

Before the pause revisions, MOTU/VZ tests with one and two vCPUs failed all
32 shared-client captures. The candidate passed 48 capture cases and eight
recovery diagnostics, including 70-second CPU-saturated shared captures.
Synthetic QEMU dsnoop data matched 2160000 reference frames across 12
files. Forced policy transitions passed KASAN/KCSAN checks. Aggressive
KCSAN still triggered dsnoop client-threshold XRUNs with a 160 ms buffer.
The physical tests checked frame counts and nonzero mono input; exact
sample continuity was checked with the synthetic source.

The native-pause regression reproduces -EPIPE followed by a persistent
PAUSED state and a poll timeout with v2. With this revision, the same case
reaches XRUN, wakes poll with POLLERR and returns -EPIPE from read.
Prepare recovery and reopening also pass under ARM64 QEMU with KASAN
and lockdep.

Paused read and forward ACK errors reproduced a failing first prepare
with v3. This revision passes 16 recovery cases across native pause and
pause-restart with one and two vCPUs. Each prepare recovery and reopen
captures 48,000 frames. The existing 13-case mode suite and native-pause
regression also pass with KASAN and lockdep. No new physical-device or
KCSAN results are claimed for this revision.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -338,6 +338,8 @@
 			paused_xrun = runtime &&
 				      runtime->state == SNDRV_PCM_STATE_PAUSED &&
 				      vss->runtime_active && vss->xfer_xrun;
+			if (paused_xrun)
+				virtsnd_pcm_capture_arm_paused_stop(vss);
 		}
 		if (paused_xrun) {
 			/* Wake readers without sending STOP for a paused stream. */
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
@@ -115,6 +120,22 @@
 	wait_queue_head_t msg_empty;
 };
 
+/* Caller holds the PCM stream lock and vss->lock. */
+static inline void
+virtsnd_pcm_capture_arm_paused_stop(struct virtio_pcm_substream *vss)
+{
+	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+	lockdep_assert_held(&vss->lock);
+	if (!runtime || runtime->state != SNDRV_PCM_STATE_PAUSED)
+		return;
+
+	/* ALSA skips trigger(STOP) when moving a paused stream to XRUN. */
+	vss->xfer_enabled = false;
+	vss->stopped = true;
+	runtime->stop_operating = true;
+}
+
 /* Keep non-staged PCM notifications on schedule_work()'s normal queue. */
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
@@ -128,23 +149,29 @@
 
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
@@ -207,6 +234,9 @@
 
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
@@ -893,6 +905,13 @@
 			if (rc) {
 				vss->stopped = true;
 				substream->runtime->stop_operating = true;
+				if (vss->capture_staging &&
+				    vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+				    command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE) {
+					/* Pause undo leaves ALSA paused; wake its readers. */
+					vss->xfer_xrun = true;
+					virtsnd_pcm_schedule_period_elapsed(vss);
+				}
 				return rc;
 			}
 			vss->xfer_enabled = true;
@@ -1132,12 +1151,18 @@
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
@@ -1244,14 +1269,18 @@
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
@@ -1270,7 +1299,11 @@
 
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
@@ -1280,7 +1313,8 @@
 		}
 
 		vss->capture_acked_total = next_acked_total;
-		vss->capture_ready -= bytes;
+		if (!free_running)
+			vss->capture_ready -= bytes;
 		vss->pcm_indirect.appl_ptr = appl_ptr;
 	}
 
@@ -1314,8 +1348,14 @@
 	struct virtsnd_pcm_transfer transfer = {};
 	int rc;
 
-	if (vss->capture_staging)
-		return virtsnd_pcm_capture_staged_ack(vss, runtime);
+	if (vss->capture_staging) {
+		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
+		if (rc == -EPIPE) {
+			guard(spinlock_irqsave)(&vss->lock);
+			virtsnd_pcm_capture_arm_paused_stop(vss);
+		}
+		return rc;
+	}
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
