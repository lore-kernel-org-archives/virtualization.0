Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252678;
	b=kEn3Gi9RZgwKYh2/c5jDLRDHVRiTfHUkzEGdOm06HZqgEWpjwxsrQmMWs3qfusomLydv
	 Y5lL09wQRtq9A8rfKhpkoW8xuFLngSqEEJo3RPMZkcQFCyprWgpjIhboEG/lOw096amwQ
	 UyecfWbWZK7JK4nnsFbPgQBoeeUzvzqguRH/kndRXrRjX2sTs4AVcaqhem+n9vtrb+APG
	 7I2HxtlAFcx5ZRsIKzm5KMA4nSNBqVrJN9ByvUxrMD0bZI+7KlZ0iVJfx8cme8r50+3l8
	 udVa65/8SNygAtpztzaaFXiFk2ez83pfvWaND1db+Bprgq7SBy7AuS7DiMsyE/K4r5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DCqGTneaUlFJcxuKCSscPu5pafufETEvIi4p78uIRd8=;
	b=tXNxckehp/rG0CGvhEHmzu9lv2USsG+xDMTB3/kXfWiqS8Vjz47XCzPKw4sSLYEUxSke
	 IDPqg1C68Kte5XASJIahhGMgMTWoH3s0nhmTUazPcyGutRo9KmQw5BjOpOAD1V2O+jOeX
	 pmoPFf1HGROKWCE4uM0gVGWz6O6B0DklS5flifasHlbvheEZ7vcpocN5Qrm2onYUhH1cn
	 jCwsrxpIq4CCWyQbSlQShdDBgYO6W28t1jneEmcE6YCSIjy1kIv0O6fBMvpKABudKRxZA
	 R+Sglv//g6lMlCXCyNwHVNcfS/kNT0n8wXJXefFtBe8Nhz/h/rs2Ber0pvWQrBwNIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRSLzG+T;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33776606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33776606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRSLzG+T
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1040682a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252677; x=1793857477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCqGTneaUlFJcxuKCSscPu5pafufETEvIi4p78uIRd8=;
        b=oRSLzG+TwzSNSB/bs9zLnJg9ZpoUtCY9LjX11hGbvU8xaKy7urZo47qUOSvfhW3wle
         +g1GmNVpZK7dQJwwH5h4+wTK6c4Ac34ObCW1cKli0uRggrV1vM9H+Gl/yzX/7qStI1UM
         UlGX8W1oXCmKCvyI3TFQqVoEP1mQWkWm/jsdpHSJ464TXHOn2pyzRM1DXwbiVvu0KrGF
         BHkXQnyUX1ze1opW3jvdVzX+G2c4J3ipbvAzvYSaAMmYW6u3BEVObfFg2XLVoPdKWjpe
         7bGaFkNyVNq8ng+NEG43/OtgQJtU/ENYP/34DSE6xzkHlE2RXV7INUe8u/bVLdF1/kiE
         k3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252677; x=1793857477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCqGTneaUlFJcxuKCSscPu5pafufETEvIi4p78uIRd8=;
        b=h7dmffmH1fEjF0HKLgvs8WHGHa8lkaQCAUiolTwf7UtcnEvj9kWiHOjGcRAeBaf9QU
         d0gilSsEWc9uhFPypcijspu4pMxcvBb6G2DzGgwgBYJI7xM8tRx99p+WZ7mp/ZHE5nul
         oXTqjGxWgN/W7rQvGuaQ2++bIKo4SVcvikfNCRARyISaAlyTAC3YEbP3MNs9LUrYbdt5
         FTzt7kgK/QUNryjeeUeH7GEKFeZq5JZ3SnndHaYXKodnezTlSxitOu+EJEaXO6VtYIWX
         18s8KMqzBBI5k2SSAP4Ij8r+esGc/+oD+XXEmQcszZLAAG+XM9Jmu8/kIsr3yAlhzUzj
         FxZg==
X-Forwarded-Encrypted: i=1; AKwUvBzxmCvmGSAye/miVxd0KIHQzjBBzTp9f6nvP7NwMxCcn8CohO1HMOxTVLyAXUDIqw6Lv/xB5MGiJo9DXm+Zog==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbryE+nhVRqIF2oslRAN8C9sq17Q11WWuh8QhV9vNzdSSpukiR
	r+RLPPXMP7X5ffg6zgr7ASudff0Ke5NkujbgZGK9lKWDVfsnWcHNzm2X
X-Gm-Gg: AYBFou1d2p2ab8thglEupPZ4Wk4OANieNK+Fkl6poZfvT0wTUnP9Fal5mCfleiYrRCl
	ds8MJNGoDvbmkxtNxZwWitx162XLNfJKKJj1PQuoSfXa/iku3DrvSar4zR/L6aMxBfLOQXnb4OL
	dU7vGqismA0/1+K0wdBnU7ioFGUR6LAnRbSM2+RMGgH4onPWIDXsmA0s/L2MG2fqjqN1XgC/iPC
	4XWt0GfNCBaB9CARcEJQGUaJ1yUJvITDFRqNn7/GldoGJGqOWS2E/eI7mujNpiUcy1xDHrPANGx
	qQCq96sGK6LRW7vuMHKdtKUC9Z+hTzYW8nG0biWyJhgNnhmnZkSDE/6M2ruD0TaHQJ+JxKHQe4s
	7Ocor1+7lCHz6LLjDuf5Dx/ArHlSe+sZC5fU+CHnaOi/nXHvaYJcfOxQhT0KhcExa/FWHUwHyxh
	nYQ9KMw9wMLJB17nOKm+/ySwcw5iO2NU7+Cz/jta9z2f23ReTkqpqIuu/XS0SXPUIYQiL3Q5lf6
	B/fbv3AHoxMDU9pO0dnUMxrxsH2S8yN/3HzmNKIhwwQ8e7GPps8q3r4Vu92xFpuG4nHEUYmYxEP
	XWCFJiwbFtO89K8SpswW5m4SOZTwyyE2lpcdrCTjq2FLPsl7H4Av+JCROSNeY+MTm+TFkuUMAk1
	w5d9+UuxhuMWNKbWbaoXcrZftvJjgDu5otjQee5xIUAjuR5U=
X-Received: by 2002:a17:90b:2f4f:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3ae57f631ebmr3479361a91.10.1793252675994;
        Wed, 28 Oct 2026 22:44:35 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:35 -0700 (PDT)
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
Subject: [PATCH v8 09/14] ALSA: virtio: add staged capture accounting and lifecycle recovery
Date: Thu, 29 Oct 2026 14:43:49 +0900
Message-ID: <20261029054354.2931-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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

Staged capture needs request-owned DMA storage and capture accounting
which remains valid when dsnoop sets stop_threshold to the PCM boundary.
A managed-buffer acknowledgment policy alone can exhaust the RX queue
while shared capture clients are still reading.

Introduce staged capture with separate produced, observed and consumed
positions. Select free-running capture policy for boundary stop thresholds
and synchronize policy changes with RX completion and acknowledgment.
Keep ordinary capture and playback on their existing transfer paths.

Serialize prepare, sync_stop, hw_params and hw_free with a lifecycle mutex.
Track submitted control transitions, distinguish uncertain completion from
an immediate rejection, and reject stale software completions after a
virtqueue reset. Revoke prepared and runtime access before cleanup. Keep
DMA storage until device ownership ends, and preserve readable capture
tails without refilling released streams.

The pause-restart option uses STOP/RELEASE and SET_PARAMS/PREPARE/START to
support backends which cannot resume their capture requests after pause.
The short, packed and empty-response compatibility options are independent
and remain disabled by default. This consolidates v7 patches 7, 8, 11, 12,
13 and 16 with the subsequent local review corrections into one coherent
state machine. It supersedes those revisions.

The RESET callback conversion follows separately with its ALSA core
prerequisite. Notification priority is also a separate patch.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -348,6 +348,18 @@
 	struct virtio_device *vdev = snd->vdev;
 	unsigned int i;
 
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+		struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+
+		guard(spinlock_irqsave)(&queue->lock);
+		guard(spinlock)(&vss->lock);
+		vss->reset_epoch++;
+		vss->resetting = true;
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+		vss->suspended = true;
+	}
 	virtio_reset_device(vdev);
 
 	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
@@ -364,9 +376,20 @@
 		spin_unlock_irqrestore(&queue->lock, flags);
 	}
 
+	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
+		guard(spinlock_irqsave)(&snd->queues[i].lock);
+		snd->queues[i].vqueue = NULL;
+	}
 	vdev->config->del_vqs(vdev);
-	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
-		snd->queues[i].vqueue = NULL;
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		cancel_work_sync(&vss->elapsed_period);
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->stopped = false;
+		vss->xfer_xrun = false;
+		vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_NONE;
+	}
 }
 
 /**
@@ -439,6 +462,7 @@
 {
 	struct virtio_snd *snd = vdev->priv;
 	int rc;
+	unsigned int i;
 
 	rc = virtsnd_find_vqs(snd);
 	if (rc)
@@ -447,6 +471,12 @@
 	virtio_device_ready(vdev);
 	virtsnd_ctl_msg_enable(snd);
 
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->resetting = false;
+	}
 	virtsnd_enable_event_vq(snd);
 
 	return 0;
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -23,6 +23,7 @@
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
+ * @submitted: Request was handed to the device.
  * @cancelled: Request canceled during device teardown.
  */
 struct virtio_snd_msg {
@@ -37,7 +38,17 @@
 	struct completion notify;
 	refcount_t ref_count;
 	bool cancelled;
+	bool submitted;
 };
+
+/* Caller retains a reference across the synchronous send. */
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc)
+{
+	return msg->submitted &&
+	       (rc == -ETIMEDOUT || rc == -ERESTARTSYS ||
+		READ_ONCE(msg->cancelled));
+}
+
 
 /**
  * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
@@ -296,6 +307,7 @@
 		rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
 				       GFP_ATOMIC);
 	if (!rc) {
+		msg->submitted = true;
 		notify = virtqueue_kick_prepare(queue->vqueue);
 
 		list_add_tail(&msg->list, &snd->ctl_msgs);
@@ -315,11 +327,14 @@
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
 		/*
-		 * Teardown must observe completion even with a pending signal.
-		 * Otherwise a subsequent open can retry RELEASE while the device
-		 * is still processing the previous teardown request.
+		 * PCM state changes must observe completion with a pending signal.
+		 * Otherwise recovery can issue a conflicting command while the
+		 * device is still processing the previous transition.
 		 */
 		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_SET_PARAMS:
+		case VIRTIO_SND_R_PCM_PREPARE:
+		case VIRTIO_SND_R_PCM_START:
 		case VIRTIO_SND_R_PCM_STOP:
 		case VIRTIO_SND_R_PCM_RELEASE:
 			rc = wait_for_completion_timeout(&msg->notify, js);
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -11,6 +11,8 @@
 
 struct virtio_snd;
 struct virtio_snd_msg;
+
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc);
 
 void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg);
 
@@ -47,7 +49,7 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
- * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * PCM state-changing requests wait through pending signals within this timeout.
  * Other requests remain interruptible. Device reset cancels and wakes either
  * kind of waiter.
  *
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -159,12 +159,12 @@
 	struct virtio_snd_ctl_hdr *hdr;
 	struct virtio_snd_ctl_value *kvalue;
 	size_t request_size = sizeof(*hdr);
-	size_t response_size = sizeof(struct virtio_snd_hdr) + sizeof(*kvalue);
+	size_t response_size = sizeof(struct virtio_snd_hdr);
 	unsigned int i;
 	int rc;
 
-	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
-				    GFP_KERNEL);
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0,
+				    sizeof(*kvalue), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -179,8 +179,7 @@
 	if (rc)
 		goto on_failure;
 
-	kvalue = (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
-			  sizeof(struct virtio_snd_hdr));
+	kvalue = virtsnd_ctl_msg_response_data(msg);
 
 	switch (type) {
 	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -310,8 +310,98 @@
 {
 	struct virtio_pcm_substream *vss =
 		container_of(work, struct virtio_pcm_substream, elapsed_period);
-
-	snd_pcm_period_elapsed(vss->substream);
+	struct snd_pcm_substream *substream = vss->substream;
+	struct snd_pcm_runtime *runtime;
+	size_t period_bytes;
+	u64 period_floor;
+	u64 snapshot;
+	bool staged_capture;
+	bool paused_xrun = false;
+	bool notify = false;
+	bool requeue = false;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		staged_capture = vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+				 vss->capture_staging;
+	}
+
+	if (!staged_capture) {
+		snd_pcm_period_elapsed(substream);
+		return;
+	}
+
+	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks. */
+	guard(pcm_stream_lock_irqsave)(substream);
+	if (!substream->runtime)
+		return;
+	if (!snd_pcm_running(substream)) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			runtime = substream->runtime;
+			paused_xrun = runtime &&
+				      runtime->state == SNDRV_PCM_STATE_PAUSED &&
+				      vss->runtime_active && vss->xfer_xrun;
+			if (paused_xrun)
+				virtsnd_pcm_capture_arm_paused_stop(vss);
+		}
+		if (paused_xrun) {
+			/* Stop paused transfers and wake blocked readers. */
+			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		}
+		return;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		runtime = substream->runtime;
+		if (!vss->runtime_active ||
+		    (!vss->xfer_enabled && !vss->xfer_xrun) || !runtime)
+			return;
+
+		period_bytes = snd_pcm_lib_period_bytes(substream);
+		if (vss->xfer_xrun) {
+			notify = true;
+		} else if (!period_bytes || period_bytes >= vss->buffer_bytes ||
+			   !virtsnd_pcm_capture_counters_valid(vss) ||
+			   vss->capture_notified_periods >
+				div64_ul(vss->capture_copied_total, period_bytes)) {
+			vss->xfer_xrun = true;
+			notify = true;
+		} else {
+			period_floor = div64_ul(vss->capture_copied_total, period_bytes);
+			if (period_floor > vss->capture_notified_periods) {
+				/* Reserve crossed boundaries before the callback. */
+				vss->capture_notified_periods = period_floor;
+				notify = true;
+			}
+		}
+
+		if (notify) {
+			snapshot = vss->capture_copied_total;
+			vss->capture_callback_snapshot = snapshot;
+			vss->capture_callback_snapshot_active = true;
+		}
+	}
+
+	if (!notify)
+		return;
+
+	/* Pin the callback position while completions keep updating actual totals. */
+	snd_pcm_period_elapsed_under_stream_lock(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->capture_callback_snapshot_active = false;
+		vss->capture_callback_snapshot = 0;
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun && substream->runtime) {
+			period_bytes = snd_pcm_lib_period_bytes(substream);
+			if (period_bytes &&
+			    div64_ul(vss->capture_copied_total, period_bytes) >
+				vss->capture_notified_periods)
+				requeue = true;
+		}
+	}
+
+	if (requeue)
+		virtsnd_pcm_schedule_period_elapsed(vss);
 }
 
 /**
@@ -353,6 +443,7 @@
 		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
 		init_waitqueue_head(&vss->msg_empty);
 		spin_lock_init(&vss->lock);
+		mutex_init(&vss->lifecycle_lock);
 	}
 
 	info = kzalloc_objs(*info, snd->nsubstreams);
@@ -486,7 +577,7 @@
 			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
-		snd_pcm_set_managed_buffer_all(vpcm->pcm,
+		snd_pcm_lib_preallocate_pages_for_all(vpcm->pcm,
 					       SNDRV_DMA_TYPE_VMALLOC, NULL,
 					       0, 0);
 	}
@@ -517,8 +608,11 @@
 		break;
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		scoped_guard(spinlock, &vss->lock) {
-			if (vss->xfer_enabled)
+			if (vss->xfer_enabled) {
 				vss->xfer_xrun = true;
+				if (vss->capture_staging)
+					virtsnd_pcm_schedule_period_elapsed(vss);
+			}
 		}
 		break;
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -7,13 +7,32 @@
 #define VIRTIO_SND_PCM_H
 
 #include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/math64.h>
 #include <linux/virtio_config.h>
+#include <linux/workqueue.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
 struct page;
+
+enum virtio_pcm_pause_restart_state {
+	VIRTSND_PCM_PAUSE_RESTART_NONE,
+	VIRTSND_PCM_PAUSE_RESTART_CONFIGURED,
+	VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_PREPARED,
+	VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_RUNNING,
+	VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_STOPPED,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASED,
+	VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED,
+};
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -26,16 +45,35 @@
  * @pcm_indirect: Kernel indirect pcm structure.
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
+ * @lifecycle_lock: Serializes prepare with synchronous release, outside trigger.
+ * @resetting: Device queues are unavailable until restore completes.
+ * @reset_epoch: Invalidates control replies from before device reset.
  * @lock: Spinlock that protects fields shared by interrupt handlers and
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
+ *                 always zero in free-running mode.
+ * @capture_boundary: ALSA boundary captured for this prepared epoch.
+ * @capture_copied_total: Monotonic bytes copied into the capture ring.
+ * @capture_acked_total: Monotonic bytes acknowledged by the capture client.
+ * @capture_pointer_seen_total: Last capture position sampled by ALSA.
+ * @capture_notified_periods: Highest full-period boundary reserved for notify.
+ * @capture_callback_snapshot: Capture position fixed for the period callback.
+ * @capture_callback_snapshot_active: The callback must use its fixed position.
+ * @runtime_active: ALSA runtime buffer may be accessed by the staged path.
+ * @capture_staging: Capture uses request-owned payload buffers.
+ * @capture_started: Non-empty capture data was received since prepare.
+ * @capture_empty: Consecutive empty startup completions.
+ * @capture_free_running: Cached staged-capture policy, protected by @lock.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side; protected by @lock.
+ * @prepared: Device PREPARE succeeded; protected by @lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
+ * @pause_restart_state: Device-side state for opt-in pause compatibility.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_count: Number of pending I/O messages in the virtqueue.
@@ -56,12 +94,30 @@
 	struct snd_pcm_hardware hw;
 	struct work_struct elapsed_period;
 	spinlock_t lock;
+	struct mutex lifecycle_lock;
+	u64 reset_epoch;
+	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	size_t capture_ready;
+	snd_pcm_uframes_t capture_boundary;
+	u64 capture_copied_total;
+	u64 capture_acked_total;
+	u64 capture_pointer_seen_total;
+	u64 capture_notified_periods;
+	u64 capture_callback_snapshot;
+	bool capture_callback_snapshot_active;
+	bool runtime_active;
+	bool capture_staging;
+	bool capture_started;
+	bool capture_free_running;
+	unsigned int capture_empty;
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	bool prepared;
 	bool suspended;
+	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	unsigned int msg_count;
@@ -74,6 +130,64 @@
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
+/* Use one notification helper for all producers. */
+static inline bool
+virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
+{
+	return schedule_work(&vss->elapsed_period);
+}
+
+/*
+ * ALSA may observe a subperiod tail before its period callback. Keep actual
+ * unread occupancy separate from pointer observations and notification state;
+ * free-running streams account occupancy from monotonic totals instead.
+ */
+static inline size_t virtsnd_pcm_ring_offset(u64 total, size_t size)
+{
+	u64 remainder;
+
+	div64_u64_rem(total, size, &remainder);
+	return remainder;
+}
+
+static inline bool
+virtsnd_pcm_capture_counters_valid(const struct virtio_pcm_substream *vss)
+{
+	u64 outstanding;
+
+	if (!vss->buffer_bytes ||
+	    vss->capture_copied_total < vss->capture_acked_total ||
+	    vss->capture_pointer_seen_total > vss->capture_copied_total ||
+	    vss->hw_ptr != virtsnd_pcm_ring_offset(vss->capture_copied_total, vss->buffer_bytes) ||
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
+}
+
 /**
  * struct virtio_pcm_stream - VirtIO PCM stream.
  * @substreams: VirtIO substreams belonging to the stream.
@@ -104,6 +218,11 @@
 
 extern const struct snd_pcm_ops virtsnd_pcm_ops[];
 
+extern bool virtsnd_capture_staging;
+extern bool virtsnd_capture_packed_status;
+extern bool virtsnd_capture_allow_short;
+extern bool virtsnd_capture_allow_empty;
+
 int virtsnd_pcm_validate(struct virtio_device *vdev);
 
 int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
@@ -127,6 +246,11 @@
 int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			  unsigned int periods, unsigned int period_bytes);
 
+int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss);
+
+int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream *vss,
+					    bool *free_running);
+
 void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -3,9 +3,11 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/overflow.h>
+#include <linux/vmalloc.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
@@ -16,14 +18,16 @@
  * @xfer: Request header payload.
  * @status: Response header payload.
  * @length: Data length in bytes.
+ * @data: Request-owned payload for staged capture.
  * @data_offset: Offset in the driver-owned PCM buffer on NOMMU systems.
  * @sgs: Payload scatter-gather table.
  */
 struct virtio_pcm_msg {
 	struct virtio_pcm_substream *substream;
-	struct virtio_snd_pcm_xfer xfer;
-	struct virtio_snd_pcm_status status;
+	struct virtio_snd_pcm_xfer *xfer;
+	struct virtio_snd_pcm_status *status;
 	size_t length;
+	u8 *data;
 #ifndef CONFIG_MMU
 	size_t data_offset;
 #endif
@@ -228,6 +232,8 @@
 	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
 			       &buffer_bytes))
 		return -EOVERFLOW;
+	if (vss->capture_staging && periods < 2)
+		return -EINVAL;
 
 	if (!vss->substream || !vss->substream->runtime)
 		return -EINVAL;
@@ -236,14 +242,19 @@
 		return -EINVAL;
 
 #ifdef CONFIG_MMU
-	rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area, buffer_bytes);
-	if (rc)
-		return rc;
+	if (!vss->capture_staging) {
+		rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area,
+					       buffer_bytes);
+		if (rc)
+			return rc;
+	}
 #else
-	vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
-	if (!vss->owned_dma_area)
-		return -ENOMEM;
-	vss->owned_dma_bytes = buffer_bytes;
+	if (!vss->capture_staging) {
+		vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
+		if (!vss->owned_dma_area)
+			return -ENOMEM;
+		vss->owned_dma_bytes = buffer_bytes;
+	}
 #endif
 
 	vss->msgs = kzalloc_objs(*vss->msgs, periods);
@@ -255,32 +266,54 @@
 	vss->nmsgs = periods;
 
 	for (i = 0; i < periods; ++i) {
-		int sg_num;
 		struct virtio_pcm_msg *msg;
 		u8 *data;
+		int sg_num;
+
+		if (vss->capture_staging) {
+			data = vzalloc(period_bytes);
+		} else {
 #ifdef CONFIG_MMU
-		data = runtime->dma_area + (size_t)period_bytes * i;
+			data = runtime->dma_area + (size_t)period_bytes * i;
 #else
-		data = vss->owned_dma_area + (size_t)period_bytes * i;
+			data = vss->owned_dma_area + (size_t)period_bytes * i;
 #endif
+		}
+		if (!data) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
+
 		sg_num = virtsnd_pcm_sg_num(data, period_bytes);
 		if (sg_num < 0) {
+			if (vss->capture_staging)
+				vfree(data);
 			rc = sg_num;
 			goto err_free_msgs;
 		}
 
 		msg = kzalloc_flex(*msg, sgs, sg_num + 2);
 		if (!msg) {
+			if (vss->capture_staging)
+				vfree(data);
 			rc = -ENOMEM;
 			goto err_free_msgs;
 		}
 
 		msg->substream = vss;
+		msg->data = vss->capture_staging ? data : NULL;
 		vss->msgs[i] = msg;
-		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
-			    sizeof(msg->xfer));
-		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
-			    sizeof(msg->status));
+		/* DMA payloads must not share cachelines with CPU-owned fields. */
+		msg->xfer = kzalloc(sizeof(*msg->xfer), GFP_KERNEL);
+		msg->status = kzalloc(sizeof(*msg->status), GFP_KERNEL);
+		if (!msg->xfer || !msg->status) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
+		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], msg->xfer,
+			    sizeof(*msg->xfer));
+		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], msg->status,
+			    sizeof(*msg->status));
 #ifndef CONFIG_MMU
 		msg->data_offset = (size_t)period_bytes * i;
 #endif
@@ -316,8 +349,14 @@
 {
 	unsigned int i;
 
-	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
-		kfree(vss->msgs[i]);
+	for (i = 0; vss->msgs && i < vss->nmsgs; ++i) {
+		if (vss->msgs[i]) {
+			vfree(vss->msgs[i]->data);
+			kfree(vss->msgs[i]->xfer);
+			kfree(vss->msgs[i]->status);
+			kfree(vss->msgs[i]);
+		}
+	}
 	kfree(vss->msgs);
 #ifdef CONFIG_MMU
 	virtsnd_pcm_dma_pages_put(vss);
@@ -339,15 +378,26 @@
  * substream was stopped are never sent to the device, so their length must be
  * cleared before the substream is started again.
  *
- * Context: Any context. Takes and releases the VirtIO substream spinlock.
+ * Context: Caller holds the VirtIO substream spinlock.
  */
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss)
 {
 	unsigned int i;
 
-	guard(spinlock_irqsave)(&vss->lock);
+	lockdep_assert_held(&vss->lock);
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		vss->msgs[i]->length = 0;
+	vss->capture_ready = 0;
+	vss->capture_copied_total = 0;
+	vss->capture_acked_total = 0;
+	vss->capture_pointer_seen_total = 0;
+	vss->capture_notified_periods = 0;
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->capture_boundary = 0;
+	vss->capture_free_running = false;
+	vss->capture_empty = 0;
+	vss->capture_started = false;
 }
 
 /**
@@ -377,6 +427,10 @@
 	bool notify = false;
 	int rc;
 
+	if (!vqueue || !vss->prepared || vss->suspended)
+		return -EBADFD;
+	if (!bytes)
+		return 0;
 	start = offset / period_bytes;
 	end = (offset + bytes - 1) / period_bytes;
 
@@ -395,8 +449,8 @@
 
 		msg->length += n;
 		if (msg->length == period_bytes) {
-			msg->xfer.stream_id = cpu_to_le32(vss->sid);
-			memset(&msg->status, 0, sizeof(msg->status));
+			msg->xfer->stream_id = cpu_to_le32(vss->sid);
+			memset(msg->status, 0, sizeof(*msg->status));
 
 #ifndef CONFIG_MMU
 		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -470,6 +524,290 @@
 	return 0;
 }
 
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
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtqueue *vqueue = queue->vqueue;
+	unsigned long period_bytes;
+	size_t free_bytes;
+	size_t request_limit = vss->nmsgs;
+	unsigned int i;
+	bool added = false;
+
+	if (!vqueue || !vss->prepared || vss->suspended ||
+	    !vss->capture_staging || !vss->runtime_active)
+		return -EBADFD;
+
+	period_bytes = snd_pcm_lib_period_bytes(vss->substream);
+	if (!period_bytes || !vss->buffer_bytes ||
+	    period_bytes >= vss->buffer_bytes ||
+	    free_running != vss->capture_free_running ||
+	    !virtsnd_pcm_capture_counters_valid(vss) ||
+	    vss->msg_count > vss->nmsgs)
+		return -EIO;
+
+	if (!free_running) {
+		free_bytes = vss->buffer_bytes - vss->capture_ready;
+		request_limit = free_bytes / period_bytes +
+				!!(free_bytes % period_bytes);
+		request_limit = min_t(size_t, request_limit, vss->nmsgs);
+	}
+
+	for (i = 0; i < vss->nmsgs && vss->msg_count < request_limit; ++i) {
+		struct virtio_pcm_msg *msg = vss->msgs[i];
+		struct scatterlist *sgs[] = {
+			&msg->sgs[PCM_MSG_SG_XFER],
+			&msg->sgs[PCM_MSG_SG_DATA],
+			&msg->sgs[PCM_MSG_SG_STATUS]
+		};
+		int rc;
+
+		if (msg->length)
+			continue;
+
+		msg->xfer->stream_id = cpu_to_le32(vss->sid);
+		/* Do not let an absent packed trailer reuse old PCM bytes. */
+		memset(msg->data, 0, period_bytes);
+		memset(msg->status, 0, sizeof(*msg->status));
+		msg->status->status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+		rc = virtqueue_add_sgs(vqueue, sgs, 1, 2, msg, GFP_ATOMIC);
+		if (rc) {
+			if (added && !(vss->features &
+				       (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+			    virtqueue_kick_prepare(vqueue))
+				virtqueue_notify(vqueue);
+			return rc;
+		}
+
+		msg->length = period_bytes;
+		vss->msg_count++;
+		added = true;
+	}
+
+	if (added && !(vss->features &
+			(1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+	    virtqueue_kick_prepare(vqueue))
+		virtqueue_notify(vqueue);
+
+	return 0;
+}
+
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
+static int virtsnd_pcm_capture_status(const struct virtio_pcm_msg *msg,
+				      size_t written_bytes,
+				      size_t frame_bytes,
+				      size_t *audio_bytes,
+				      u32 *latency_bytes)
+{
+	struct virtio_snd_pcm_status status;
+	size_t max_written;
+	size_t first;
+
+	if (!frame_bytes ||
+	    check_add_overflow(msg->length, sizeof(status), &max_written) ||
+	    written_bytes < sizeof(status) || written_bytes > max_written)
+		return -EIO;
+
+	*audio_bytes = written_bytes - sizeof(status);
+	if (*audio_bytes > msg->length || *audio_bytes % frame_bytes)
+		return -EIO;
+
+	if (virtsnd_capture_packed_status) {
+		first = min_t(size_t, sizeof(status),
+			      msg->length - *audio_bytes);
+		if (first)
+			memcpy(&status, msg->data + *audio_bytes, first);
+		if (first < sizeof(status))
+			memcpy((u8 *)&status + first, msg->status,
+			       sizeof(status) - first);
+	} else {
+		status = *msg->status;
+	}
+
+	if (le32_to_cpu(status.status) != VIRTIO_SND_S_OK)
+		return -EIO;
+
+	*latency_bytes = le32_to_cpu(status.latency_bytes);
+	return 0;
+}
+
+static void virtsnd_pcm_capture_xrun_locked(struct virtio_pcm_substream *vss)
+{
+	if (!vss->xfer_xrun) {
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+	}
+}
+
+static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
+					 size_t written_bytes)
+{
+	struct virtio_pcm_substream *vss = msg->substream;
+	size_t audio_bytes = 0;
+	size_t next_ready = 0;
+	u64 next_copied_total = 0;
+	bool free_running = false;
+	bool got_audio = false;
+
+	guard(spinlock)(&vss->lock);
+	vss->msg_count--;
+	if (vss->runtime_active && vss->xfer_enabled && !vss->xfer_xrun) {
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+		size_t frame_bytes = runtime ? frames_to_bytes(runtime, 1) : 0;
+		u32 latency_bytes;
+		const char *invalid_reason = NULL;
+
+		/* A full ring is modulo-ambiguous, so fail closed before copying. */
+		if (!runtime || !runtime->dma_area)
+			invalid_reason = "runtime";
+		else if (virtsnd_pcm_capture_refresh_mode_locked(vss,
+								 &free_running))
+			invalid_reason = "policy";
+		else if (!virtsnd_pcm_capture_counters_valid(vss))
+			invalid_reason = "counters";
+		else if (vss->hw_ptr !=
+			 virtsnd_pcm_ring_offset(vss->capture_copied_total, vss->buffer_bytes))
+			invalid_reason = "hw_ptr";
+		else if (virtsnd_pcm_capture_status(msg, written_bytes,
+						    frame_bytes, &audio_bytes,
+						    &latency_bytes))
+			invalid_reason = "status";
+		else if (check_add_overflow(vss->capture_copied_total,
+					    (u64)audio_bytes,
+					    &next_copied_total))
+			invalid_reason = "total_overflow";
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
+
+		if (invalid_reason) {
+			virtsnd_pcm_capture_xrun_locked(vss);
+			dev_warn_ratelimited(&vss->snd->vdev->dev,
+					     "SID %u: staged capture completion rejected (%s)\n",
+					     vss->sid, invalid_reason);
+		} else if (!audio_bytes) {
+			unsigned int limit = min_t(unsigned int, vss->nmsgs,
+						   UINT_MAX / 2) * 2;
+
+			if (!virtsnd_capture_allow_empty || vss->capture_started ||
+			    vss->capture_empty >= limit) {
+				virtsnd_pcm_capture_xrun_locked(vss);
+			} else {
+				vss->capture_empty++;
+			}
+		} else if (audio_bytes < msg->length &&
+			   !virtsnd_capture_allow_short) {
+			virtsnd_pcm_capture_xrun_locked(vss);
+		} else {
+			size_t ring_ptr = virtsnd_pcm_ring_offset(vss->capture_copied_total,
+						  vss->buffer_bytes);
+			size_t first = min(audio_bytes,
+					   vss->buffer_bytes - ring_ptr);
+
+			memcpy(runtime->dma_area + ring_ptr, msg->data, first);
+			if (audio_bytes > first)
+				memcpy(runtime->dma_area, msg->data + first,
+				       audio_bytes - first);
+			vss->capture_copied_total = next_copied_total;
+			vss->hw_ptr = virtsnd_pcm_ring_offset(next_copied_total, vss->buffer_bytes);
+			vss->capture_ready = next_ready;
+			vss->capture_started = true;
+			vss->capture_empty = 0;
+			runtime->delay = bytes_to_frames(runtime, latency_bytes);
+			got_audio = true;
+		}
+	}
+
+	msg->length = 0;
+	if (vss->runtime_active && vss->xfer_enabled) {
+		if (!vss->xfer_xrun &&
+		    virtsnd_pcm_capture_enqueue(vss, free_running)) {
+			dev_warn_ratelimited(&vss->snd->vdev->dev,
+					     "SID %u: failed to refill capture queue\n",
+					     vss->sid);
+			virtsnd_pcm_capture_xrun_locked(vss);
+		}
+		if (got_audio && !vss->xfer_xrun)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+	} else if (!vss->msg_count) {
+		wake_up_all(&vss->msg_empty);
+	}
+}
+
 /**
  * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
  * @vss: VirtIO substream.
@@ -521,9 +859,9 @@
  * allowed, then each completed message is immediately placed back at the end
  * of the queue.
  *
- * For the playback substream, @written_bytes is equal to sizeof(msg->status).
- *
- * For the capture substream, @written_bytes is equal to sizeof(msg->status)
+ * For the playback substream, @written_bytes is equal to sizeof(*msg->status).
+ *
+ * For the capture substream, @written_bytes is equal to sizeof(*msg->status)
  * plus the number of captured bytes.
  *
  * Context: Interrupt context. Takes and releases the VirtIO substream spinlock.
@@ -532,6 +870,12 @@
 				     size_t written_bytes)
 {
 	struct virtio_pcm_substream *vss = msg->substream;
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging) {
+		virtsnd_pcm_capture_complete(msg, written_bytes);
+		return;
+	}
 
 	/*
 	 * hw_ptr always indicates the buffer position of the first I/O message
@@ -541,10 +885,11 @@
 	guard(spinlock)(&vss->lock);
 #ifndef CONFIG_MMU
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
+	    vss->prepared && !vss->stopped &&
+	    written_bytes > sizeof(*msg->status)) {
 		struct snd_pcm_runtime *runtime =
 			vss->substream ? vss->substream->runtime : NULL;
-		size_t reported_bytes = written_bytes - sizeof(msg->status);
+		size_t reported_bytes = written_bytes - sizeof(*msg->status);
 		size_t data_bytes = min_t(size_t, reported_bytes, msg->length);
 
 		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
@@ -561,8 +906,8 @@
 	}
 #endif
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    written_bytes > sizeof(msg->status) &&
-	    written_bytes - sizeof(msg->status) > msg->length)
+	    written_bytes > sizeof(*msg->status) &&
+	    written_bytes - sizeof(*msg->status) > msg->length)
 		dev_err_ratelimited(&vss->snd->vdev->dev,
 				    "SID %u: capture length exceeds I/O message capacity\n",
 			vss->sid);
@@ -572,11 +917,11 @@
 	 * the actual SG payload capacity before accounting them.
 	 */
 	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK ||
-	    written_bytes <= sizeof(msg->status)) {
+	    written_bytes <= sizeof(*msg->status)) {
 		vss->hw_ptr += msg->length;
 	} else {
 		size_t data_bytes = min_t(size_t,
-					  written_bytes - sizeof(msg->status),
+					  written_bytes - sizeof(*msg->status),
 					  msg->length);
 
 		vss->hw_ptr += data_bytes;
@@ -595,8 +940,8 @@
 
 		runtime->delay =
 			bytes_to_frames(runtime,
-					le32_to_cpu(msg->status.latency_bytes));
-		schedule_work(&vss->elapsed_period);
+					le32_to_cpu(msg->status->latency_bytes));
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -3,9 +3,40 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/moduleparam.h>
+#include <linux/overflow.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
+
+bool virtsnd_capture_staging;
+module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
+MODULE_PARM_DESC(capture_staging,
+		 "Use request-owned buffers for experimental PCM capture");
+
+bool virtsnd_capture_packed_status;
+module_param_named(capture_packed_status, virtsnd_capture_packed_status,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_packed_status,
+		 "Read staged capture status after the actual audio payload");
+
+bool virtsnd_capture_allow_short;
+module_param_named(capture_allow_short, virtsnd_capture_allow_short,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_allow_short,
+		 "Accept non-empty short staged capture responses");
+
+bool virtsnd_capture_allow_empty;
+module_param_named(capture_allow_empty, virtsnd_capture_allow_empty,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_allow_empty,
+		 "Retry bounded empty startup capture responses");
+
+static bool virtsnd_capture_pause_restart;
+module_param_named(capture_pause_restart, virtsnd_capture_pause_restart,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_pause_restart,
+		 "Release and reprepare staged capture streams across pause");
 
 /*
  * I/O messages lifetime
@@ -97,14 +128,238 @@
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
-
-static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
-{
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream);
+static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream);
+
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	bool notify;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
+		notify = vss->runtime_active && vss->capture_staging &&
+			 vss->direction == SNDRV_PCM_STREAM_CAPTURE;
+		if (notify)
+			vss->xfer_xrun = true;
 	}
 	vss->substream->runtime->stop_operating = true;
+	if (notify)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+}
+
+static bool
+virtsnd_pcm_pause_restart_enabled(struct virtio_pcm_substream *vss)
+{
+	return virtsnd_capture_pause_restart && vss->capture_staging &&
+	       vss->direction == SNDRV_PCM_STREAM_CAPTURE;
+}
+
+static bool virtsnd_pcm_pause_restart_transitioning(enum virtio_pcm_pause_restart_state state)
+{
+	switch (state) {
+	case VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int virtsnd_pcm_send_sync(struct virtio_pcm_substream *vss,
+				 struct virtio_snd_msg *msg)
+{
+	u64 epoch;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting) {
+			virtsnd_ctl_msg_unref(msg);
+			return -ECANCELED;
+		}
+		epoch = vss->reset_epoch;
+	}
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch || vss->resetting)
+			return -ECANCELED;
+	}
+	return rc;
+}
+
+static int
+virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
+			       struct virtio_snd_msg *msg,
+			       unsigned long allowed_states,
+			       enum virtio_pcm_pause_restart_state submitted_state,
+			       enum virtio_pcm_pause_restart_state success_state)
+{
+	enum virtio_pcm_pause_restart_state state;
+	bool uncertain;
+	u64 epoch;
+	int rc;
+
+	if (!virtsnd_pcm_pause_restart_enabled(vss))
+		return virtsnd_pcm_send_sync(vss, msg);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		if (vss->resetting) {
+			rc = -ECANCELED;
+		} else if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED) {
+			rc = -EIO;
+		} else if (virtsnd_pcm_pause_restart_transitioning(state)) {
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+			rc = -EIO;
+		} else if (!(allowed_states & BIT(state))) {
+			rc = -EBADFD;
+		} else {
+			vss->pause_restart_state = submitted_state;
+			rc = 0;
+		}
+	}
+
+	if (rc) {
+		virtsnd_ctl_msg_unref(msg);
+		return rc;
+	}
+
+	virtsnd_ctl_msg_ref(msg);
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	uncertain = virtsnd_ctl_msg_uncertain(msg, rc);
+	virtsnd_ctl_msg_unref(msg);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->reset_epoch != epoch || vss->resetting)
+			return -ECANCELED;
+		if ((rc && uncertain) || vss->pause_restart_state != submitted_state) {
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+			if (!rc)
+				rc = -EIO;
+		} else if (rc) {
+			vss->pause_restart_state = state;
+		} else {
+			vss->pause_restart_state = success_state;
+		}
+	}
+
+	if (rc && uncertain)
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: PCM control state is unknown; device reprobe required\n",
+			vss->sid);
+
+	return rc;
+}
+
+static void
+virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
+			       bool reset_required, u64 epoch)
+{
+	bool notify_xrun;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return;
+		notify_xrun = vss->runtime_active;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		vss->xfer_xrun = true;
+		if (reset_required)
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+	}
+	if (notify_xrun)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+	vss->substream->runtime->stop_operating = true;
+}
+
+static int virtsnd_pcm_dev_prepare(struct virtio_pcm_substream *vss)
+{
+	struct virtio_snd_msg *msg;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
+					GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED),
+		VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_PREPARED);
+}
+
+static int virtsnd_pcm_pause_prepare(struct virtio_pcm_substream *vss)
+{
+	struct virtio_snd_msg *msg;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
+					GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED),
+		VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_PREPARED);
+}
+
+static int virtsnd_pcm_release_wait(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	long waited;
+
+	waited = wait_event_timeout(vss->msg_empty,
+				   !virtsnd_pcm_msg_pending_num(vss), js);
+	guard(spinlock_irqsave)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	if (!waited || vss->msg_count ||
+	    vss->pause_restart_state != VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT)
+		return -ETIMEDOUT;
+	vss->prepared = false;
+	vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+	return 0;
+}
+
+static int
+virtsnd_pcm_pause_release_flush(struct virtio_pcm_substream *vss,
+				unsigned long allowed_states)
+{
+	struct virtio_snd_msg *msg;
+	u64 epoch;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+	}
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
+					GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	rc = virtsnd_pcm_pause_restart_send(vss, msg, allowed_states,
+			VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED,
+			VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT);
+	if (rc)
+		return rc;
+	return virtsnd_pcm_release_wait(vss, epoch);
+}
+
+static void virtsnd_pcm_pause_restart_failed(struct virtio_pcm_substream *vss,
+					     u64 epoch)
+{
+	virtsnd_pcm_pause_restart_fail(vss, false, epoch);
 }
 
 /**
@@ -119,23 +374,34 @@
 	struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
 	struct virtio_pcm_stream *vs = &vpcm->streams[substream->stream];
 	struct virtio_pcm_substream *vss = vs->substreams[substream->number];
+	int rc;
 
 	substream->runtime->hw = vss->hw;
 	substream->private_data = vss;
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->capture_staging = virtsnd_capture_staging &&
+			vss->direction == SNDRV_PCM_STREAM_CAPTURE;
+		if (vss->capture_staging) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+	}
 
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		vss->stopped |= !!vss->msg_count;
-	vss->suspended = false;
 
 	/*
 	 * If the substream has already been used, then the I/O queue may be in
 	 * an invalid state. Just in case, we do a check and try to return the
 	 * queue to its original state, if necessary.
 	 */
-	return virtsnd_pcm_sync_stop(substream);
+	rc = virtsnd_pcm_sync_stop(substream);
+	if (rc)
+		cancel_work_sync(&vss->elapsed_period);
+	return rc;
 }
 
 /**
@@ -147,6 +413,16 @@
  */
 static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
 {
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+	}
+
 	return 0;
 }
 
@@ -213,7 +489,14 @@
 		request->features |=
 			cpu_to_le32(1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
 
-	return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_NONE) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED),
+		VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_CONFIGURED);
 }
 
 /**
@@ -233,6 +516,22 @@
 	bool stopped;
 	int rc;
 
+	guard(mutex)(&vss->lifecycle_lock);
+	/* Drain the previous buffer before ALSA can replace its mapping. */
+	rc = virtsnd_pcm_sync_stop_locked(substream);
+	if (rc)
+		return rc;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->prepared = false;
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+	}
+
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		msg_count = vss->msg_count;
 		stopped = vss->stopped;
@@ -248,6 +547,11 @@
 		substream->runtime->stop_operating = true;
 		return -EBADFD;
 	}
+
+	rc = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	if (rc < 0)
+		return rc;
+	substream->runtime->buffer_changed = rc > 0;
 
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
@@ -263,8 +567,14 @@
 	 */
 	virtsnd_pcm_msg_free(vss);
 
-	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
-				     params_period_bytes(hw_params));
+	rc = virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
+				   params_period_bytes(hw_params));
+	if (!rc && vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->runtime_active = true;
+	}
+
+	return rc;
 }
 
 /**
@@ -277,27 +587,90 @@
 static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	int rc;
+
+	guard(mutex)(&vss->lifecycle_lock);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->stopped |= vss->prepared;
+		vss->prepared = false;
+		vss->runtime_active = false;
+		vss->xfer_enabled = false;
+	}
+	rc = virtsnd_pcm_sync_stop_locked(substream);
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->hw_ptr = 0;
+			vss->capture_ready = 0;
+			vss->capture_copied_total = 0;
+			vss->capture_acked_total = 0;
+			vss->capture_pointer_seen_total = 0;
+			vss->capture_notified_periods = 0;
+			vss->capture_callback_snapshot = 0;
+			vss->capture_callback_snapshot_active = false;
+			vss->capture_boundary = 0;
+			vss->capture_free_running = false;
+		}
+	}
 
 	/* If the queue is flushed, we can safely free the messages here. */
 	if (!virtsnd_pcm_msg_pending_num(vss))
 		virtsnd_pcm_msg_free(vss);
 
-	return 0;
+	snd_pcm_lib_free_pages(substream);
+	return rc;
 }
 
 /**
- * virtsnd_pcm_prepare() - Prepare the PCM substream.
+ * virtsnd_pcm_prepare_locked() - Prepare the PCM substream.
  * @substream: Kernel ALSA substream.
  *
  * Context: Process context.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
-	struct virtio_snd_msg *msg;
+	bool pause_restart = virtsnd_pcm_pause_restart_enabled(vss);
+	bool free_running;
+	int rc;
 	bool stopped;
+	bool suspended;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		stopped = vss->stopped;
+	}
+	if (stopped) {
+		rc = virtsnd_pcm_sync_stop_locked(substream);
+		if (rc)
+			return rc;
+	}
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->prepared = false;
+		epoch = vss->reset_epoch;
+		suspended = vss->suspended;
+	}
+
+	if (pause_restart) {
+		enum virtio_pcm_pause_restart_state state;
+
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			state = vss->pause_restart_state;
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+		    virtsnd_pcm_pause_restart_transitioning(state)) {
+			virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+			return -EIO;
+		}
+	}
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		stopped = vss->stopped;
@@ -308,44 +681,320 @@
 		return -EBADFD;
 	}
 
-	if (!vss->suspended) {
+	if (!suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
 			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 				vss->sid);
 			return -EBADFD;
 		}
 
-		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-		vss->hw_ptr = 0;
 	} else {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
-		int rc;
 
 		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
 						runtime->channels,
 						runtime->format, runtime->rate);
-		if (rc)
+		if (rc) {
+			if (pause_restart && rc != -ECANCELED)
+				virtsnd_pcm_pause_restart_fail(vss, false, epoch);
 			return rc;
-	}
-
-	vss->xfer_xrun = false;
-	vss->suspended = false;
-	vss->msg_count = 0;
-	virtsnd_pcm_msg_reset(vss);
-
-	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
-	vss->pcm_indirect.sw_buffer_size =
-		vss->pcm_indirect.hw_buffer_size =
-		snd_pcm_lib_buffer_bytes(substream);
-
-	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
-					GFP_KERNEL);
-	if (!msg)
+		}
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch || vss->resetting)
+			return -ECANCELED;
+		vss->prepared = false;
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		vss->hw_ptr = 0;
+		if (!pause_restart)
+			vss->xfer_xrun = false;
+		vss->suspended = false;
+		vss->msg_count = 0;
+		virtsnd_pcm_msg_reset(vss);
+		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
+		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
+		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->capture_staging) {
+			vss->capture_boundary = substream->runtime->boundary;
+			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+			if (rc)
+				return rc;
+		}
+	}
+
+	rc = virtsnd_pcm_dev_prepare(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch || vss->resetting)
+			return -ECANCELED;
+		vss->prepared = !rc;
+	}
+	if (pause_restart) {
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		} else {
+			scoped_guard(spinlock_irqsave, &vss->lock) {
+				if (vss->resetting || vss->reset_epoch != epoch)
+					return -ECANCELED;
+				vss->stopped = false;
+				vss->xfer_xrun = false;
+			}
+		}
+	}
+
+	return rc;
+}
+
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	guard(mutex)(&vss->lifecycle_lock);
+	return virtsnd_pcm_prepare_locked(substream);
+}
+
+static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
+					   bool resume)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	bool reset_required;
+	bool invalid_state;
+	int rc = 0;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		reset_required =
+			state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+			virtsnd_pcm_pause_restart_transitioning(state);
+		invalid_state =
+			vss->xfer_xrun ||
+			(resume &&
+			 (state != VIRTSND_PCM_PAUSE_RESTART_RELEASED ||
+			  !vss->stopped || vss->msg_count ||
+			  !vss->runtime_active)) ||
+			(!resume &&
+			 (state != VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+			  vss->stopped));
+	}
+	if (reset_required) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+	if (invalid_state) {
+		virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return -EBADFD;
+	}
+
+	if (resume) {
+		rc = virtsnd_pcm_pause_prepare(vss);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch) {
+				rc = -ECANCELED;
+			} else if (vss->pause_restart_state !=
+				    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+			    vss->msg_count || !vss->runtime_active) {
+				rc = -EBADFD;
+			} else {
+				/* Preserve ring accounting, restarting only startup grace. */
+				vss->prepared = true;
+				vss->capture_started = false;
+				vss->capture_empty = 0;
+			}
+		}
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+	}
+
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->resetting || vss->reset_epoch != epoch) {
+			rc = -ECANCELED;
+		} else if (vss->pause_restart_state !=
+			    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+		    vss->msg_count || !vss->runtime_active || vss->xfer_xrun) {
+			rc = -EBADFD;
+		} else {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (!rc)
+				vss->xfer_enabled = true;
+		}
+	}
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START, GFP_KERNEL);
+	if (!msg) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
 		return -ENOMEM;
-
-	return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	}
+
+	rc = virtsnd_pcm_pause_restart_send(vss, msg,
+					    BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED),
+					    VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_RUNNING);
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->stopped = false;
+	}
+	virtsnd_pcm_schedule_period_elapsed(vss);
+
+	return 0;
+}
+
+static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
+{
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+			if (vss->xfer_xrun)
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			return vss->xfer_xrun ? -EPIPE : 0;
+		}
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
+		/* Trigger holds the PCM lock; this helper never cancels work. */
+		rc = virtsnd_pcm_release_wait(vss, epoch);
+		if (!rc) {
+			guard(spinlock_irqsave)(&vss->lock);
+			rc = vss->xfer_xrun ? -EPIPE : 0;
+		}
+		if (rc && rc != -ECANCELED)
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RUNNING) {
+		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+						GFP_KERNEL);
+		if (!msg) {
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_pcm_pause_restart_send(vss, msg,
+						    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+		state = VIRTSND_PCM_PAUSE_RESTART_STOPPED;
+	} else if (state != VIRTSND_PCM_PAUSE_RESTART_STOPPED &&
+		   state != VIRTSND_PCM_PAUSE_RESTART_PREPARED) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -EBADFD;
+	}
+
+	rc = virtsnd_pcm_pause_release_flush(vss,
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED));
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
+					  bool suspend)
+{
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		if (!vss->prepared && !vss->msg_count)
+			return 0;
+		if (suspend)
+			vss->suspended = true;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		state = vss->pause_restart_state;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+	if (state != VIRTSND_PCM_PAUSE_RESTART_RUNNING)
+		return 0;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP, GFP_KERNEL);
+	if (!msg) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -ENOMEM;
+	}
+
+	rc = virtsnd_pcm_pause_restart_send(vss, msg,
+					    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+					    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+	if (rc && rc != -ECANCELED)
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+
+	return rc;
 }
 
 /**
@@ -360,10 +1009,31 @@
 static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_queue *queue;
 	struct virtio_snd_msg *msg;
 	int rc = 0;
+
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		epoch = vss->reset_epoch;
+
+	if (virtsnd_pcm_pause_restart_enabled(vss)) {
+		switch (command) {
+		case SNDRV_PCM_TRIGGER_START:
+			return virtsnd_pcm_pause_restart_start(vss, false);
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			return virtsnd_pcm_pause_restart_start(vss, true);
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			return virtsnd_pcm_pause_restart_pause(vss);
+		case SNDRV_PCM_TRIGGER_STOP:
+			return virtsnd_pcm_pause_restart_stop(vss, false);
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+			return virtsnd_pcm_pause_restart_stop(vss, true);
+		default:
+			return -EINVAL;
+		}
+	}
 
 	switch (command) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -372,38 +1042,51 @@
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
-			if (vss->stopped) {
-				substream->runtime->stop_operating = true;
-				return -EBADFD;
+			if (vss->resetting)
+				return -ECANCELED;
+			if (vss->stopped || !vss->prepared || vss->xfer_xrun) {
+				rc = vss->xfer_xrun ? -EPIPE : -EBADFD;
+				goto start_failed;
 			}
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
-				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
-			if (rc) {
-				vss->stopped = true;
-				substream->runtime->stop_operating = true;
-				return rc;
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+				if (vss->capture_staging) {
+					if (!vss->runtime_active)
+						rc = -EBADFD;
+					else
+						rc = virtsnd_pcm_capture_send(vss);
+				} else {
+					rc = virtsnd_pcm_msg_send(vss, 0,
+								  vss->buffer_bytes);
+				}
 			}
+			if (rc)
+				goto start_failed;
 			vss->xfer_enabled = true;
 		}
 
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
 						GFP_KERNEL);
 		if (!msg) {
-			virtsnd_pcm_start_failed(vss);
+			virtsnd_pcm_start_failed(vss, epoch);
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
-		if (rc)
-			virtsnd_pcm_start_failed(vss);
-
+		rc = virtsnd_pcm_send_sync(vss, msg);
+		if (rc && rc != -ECANCELED)
+			virtsnd_pcm_start_failed(vss, epoch);
+
+		if (!rc && vss->capture_staging)
+			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		vss->suspended = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (!vss->prepared)
+				return 0;
 			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
 				vss->stopped = true;
 			vss->xfer_enabled = false;
@@ -414,14 +1097,136 @@
 		if (!msg)
 			return -ENOMEM;
 
-		return virtsnd_ctl_msg_send_sync(snd, msg);
+		return virtsnd_pcm_send_sync(vss, msg);
 	default:
 		return -EINVAL;
 	}
+
+start_failed:
+	virtsnd_pcm_start_failed(vss, epoch);
+	return rc;
+}
+
+static int
+virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	enum virtio_pcm_pause_restart_state state;
+	struct virtio_snd_msg *msg;
+	long waited;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		state = vss->pause_restart_state;
+	}
+	cancel_work_sync(&vss->elapsed_period);
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: PCM state is unknown; device reprobe required\n",
+			vss->sid);
+		return -EIO;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_NONE ||
+	    state == VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) {
+		if (virtsnd_pcm_msg_pending_num(vss)) {
+			virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+			return -EIO;
+		}
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			vss->stopped = false;
+		}
+		return 0;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RUNNING) {
+		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+						GFP_KERNEL);
+		if (!msg) {
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_pcm_pause_restart_send(vss, msg,
+						    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+						    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return rc;
+		}
+		state = VIRTSND_PCM_PAUSE_RESTART_STOPPED;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT ||
+	    state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+		waited = wait_event_timeout(vss->msg_empty,
+					    !virtsnd_pcm_msg_pending_num(vss), js);
+		if (waited <= 0) {
+			rc = waited ? (int)waited : -ETIMEDOUT;
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return rc;
+		}
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			if (vss->msg_count) {
+				rc = -ETIMEDOUT;
+			} else {
+				vss->pause_restart_state =
+					VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+				vss->prepared = false;
+				vss->stopped = false;
+				rc = 0;
+			}
+		}
+		if (rc)
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return rc;
+	}
+
+	if (state != VIRTSND_PCM_PAUSE_RESTART_PREPARED &&
+	    state != VIRTSND_PCM_PAUSE_RESTART_STOPPED) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+
+	rc = virtsnd_pcm_pause_release_flush(vss,
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED) |
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED));
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return rc;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
+		vss->stopped = false;
+	}
+
+	return 0;
 }
 
 /**
- * virtsnd_pcm_sync_stop() - Synchronous PCM substream stop.
+ * virtsnd_pcm_sync_stop_locked() - Synchronous PCM substream stop.
  * @substream: Kernel ALSA substream.
  *
  * The function can be called both from the upper level or from the driver
@@ -430,7 +1235,7 @@
  * Context: Process context. Takes and releases the VirtIO substream spinlock.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd *snd = vss->snd;
@@ -438,10 +1243,17 @@
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	bool need_release;
 	int rc;
-
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+	u64 epoch;
+
+	if (virtsnd_pcm_pause_restart_enabled(vss))
+		return virtsnd_pcm_pause_restart_sync_stop(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
 		vss->xfer_enabled = false;
-		need_release = vss->stopped || vss->msg_count;
+		need_release = vss->prepared || vss->stopped || vss->msg_count;
 		if (need_release)
 			vss->stopped = true;
 	}
@@ -456,7 +1268,7 @@
 		return -ENOMEM;
 	}
 
-	rc = virtsnd_ctl_msg_send_sync(snd, msg);
+	rc = virtsnd_pcm_send_sync(vss, msg);
 	if (rc) {
 		substream->runtime->stop_operating = true;
 		return rc;
@@ -468,7 +1280,7 @@
 	 * Thus, we consider the absence of I/O messages in the queue as an
 	 * indication that the substream has been released.
 	 */
-	rc = wait_event_interruptible_timeout(vss->msg_empty,
+	rc = wait_event_timeout(vss->msg_empty,
 					      !virtsnd_pcm_msg_pending_num(vss),
 					      js);
 	if (rc <= 0) {
@@ -479,8 +1291,12 @@
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
 		vss->stopped = false;
+	}
 
 	return 0;
 }
@@ -515,6 +1331,44 @@
 virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	size_t hw_ptr = 0;
+	u64 total;
+	bool free_running;
+	bool xrun;
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			xrun = vss->xfer_xrun;
+			if (!xrun &&
+			    virtsnd_pcm_capture_refresh_mode_locked(vss,
+								    &free_running))
+				xrun = true;
+			if (!xrun && !virtsnd_pcm_capture_counters_valid(vss))
+				xrun = true;
+			if (!xrun) {
+				total = vss->capture_callback_snapshot_active ?
+					vss->capture_callback_snapshot :
+					vss->capture_copied_total;
+				/* A full-ring observation gap is modulo-ambiguous. */
+				if (total < vss->capture_pointer_seen_total ||
+				    total - vss->capture_pointer_seen_total >=
+					vss->buffer_bytes) {
+					xrun = true;
+					vss->xfer_xrun = true;
+				} else {
+					vss->capture_pointer_seen_total = total;
+					hw_ptr = virtsnd_pcm_ring_offset(total, vss->buffer_bytes);
+				}
+			}
+			if (xrun)
+				vss->xfer_xrun = true;
+		}
+
+		if (xrun)
+			return SNDRV_PCM_POS_XRUN;
+
+		return bytes_to_frames(substream->runtime, hw_ptr);
+	}
 
 	return snd_pcm_indirect_capture_pointer(substream,
 		&vss->pcm_indirect,
@@ -533,7 +1387,9 @@
 	struct virtsnd_pcm_transfer *transfer =
 		container_of(rec, struct virtsnd_pcm_transfer, indirect);
 
-	if (transfer->error)
+	if (transfer->error ||
+	    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	     substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
 		return;
 
 	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
@@ -556,6 +1412,8 @@
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped) {
 			rc = -EPIPE;
@@ -582,17 +1440,120 @@
 	return 0;
 }
 
+static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
+					  struct snd_pcm_runtime *runtime)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	int rc = 0;
+
+	/*
+	 * The RX callback holds the queue lock while draining completions.
+	 * Account ALSA's read under the substream lock alone so completions later
+	 * in that drain observe the newly released ring space.
+	 */
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		snd_pcm_uframes_t appl_ptr;
+		snd_pcm_sframes_t diff;
+		size_t bytes;
+		u64 outstanding;
+		u64 next_acked_total;
+		bool free_running;
+
+		if (!vss->runtime_active || !runtime || !runtime->control ||
+		    !runtime->dma_area || vss->suspended)
+			return -EBADFD;
+		if (!vss->prepared && runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
+			return -EBADFD;
+		if (vss->xfer_xrun)
+			return -EPIPE;
+		rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+		if (rc || !virtsnd_pcm_capture_counters_valid(vss)) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		appl_ptr = runtime->control->appl_ptr;
+		diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+			diff += runtime->boundary;
+		if (diff < 0 ||
+		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		/* ACK includes any subperiod tail already copied to the ring. */
+		bytes = frames_to_bytes(runtime, diff);
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if ((!free_running && bytes > vss->capture_ready) ||
+		    (free_running &&
+		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
+		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
+				       &next_acked_total) ||
+		    next_acked_total > vss->capture_pointer_seen_total) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		vss->capture_acked_total = next_acked_total;
+		if (!free_running)
+			vss->capture_ready -= bytes;
+		vss->pcm_indirect.appl_ptr = appl_ptr;
+	}
+
+	/* Preserve the queue -> substream lock order while refilling requests. */
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun) {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (rc) {
+				vss->xfer_xrun = true;
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			}
+		}
+	}
+
+	if (rc)
+		dev_warn_ratelimited(&vss->snd->vdev->dev,
+				     "SID %u: failed to refill capture queue after ACK: %d\n",
+				     vss->sid, rc);
+
+	/* The ACK is committed; a refill failure is reported by the next XRUN. */
+	return 0;
+}
+
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct virtsnd_pcm_transfer transfer = {};
 	int rc;
 
+	if (vss->capture_staging) {
+		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
+		if (rc == -EPIPE) {
+			guard(spinlock_irqsave)(&vss->lock);
+			virtsnd_pcm_capture_arm_paused_stop(vss);
+		}
+		return rc;
+	}
+
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared && runtime->state != SNDRV_PCM_STATE_DRAINING)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
-		if (vss->stopped) {
+		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING) {
 			rc = -EPIPE;
 		} else {
 			rc = snd_pcm_indirect_capture_transfer(substream,
@@ -617,7 +1578,19 @@
 	return 0;
 }
 
-/* PCM substream operators map. */
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	guard(mutex)(&vss->lifecycle_lock);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		/* A prepare may already have consumed this stopped generation. */
+		if (!vss->stopped)
+			return 0;
+	}
+	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
 const struct snd_pcm_ops virtsnd_pcm_ops[] = {
 	{
 		.open = virtsnd_pcm_open,
