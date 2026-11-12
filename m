Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461715;
	b=z3rBLZwbY8eAZHjL/LyN6Egtyh5y2R/a9GzAnrkW5NNc9YAyX8BfRE5Io2W/fOQC8rey
	 /SoU5ooteGLhIsifsdd9phxk2zjsoB8CaYhQVfoprd+Ig6adER+tjGqgKH8Z/ERU+ZPeM
	 BwaY1VvbUKGI/SyCDhWrKhUFRU2nnQAYenA56nJsXckPSQUshRArwc7Nk+khgu1GdPUEF
	 XfwEV62u964m0hRF7snm7+5ost1qIHlJ4QTEbeClqu/B1raGgfua9xRdqZYLJw8r+zAlU
	 Qlo2uxFVNAeutCMBCY9Mw7oqP8nHp0WdcVSlOmk7Y4GTce5y8b/rSV1Z1tUCbxfj3qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+F52bmHA0YPZtsmxGOVRSP0y4qFlAaBYlea7RyACx8E=;
	b=a/tvsouV6FqyrGGmNj3fEQHAeRMKcXZ8UTvZ7STSOEP5jxX2X7L0/IVKUOT5g5I7dSsG
	 5XJM1XD8YXwA+JCxdqtR8GFvuCuGjqzJmztikVQnjYkt+7Z8h//NAAHvAub1t0BswBzmK
	 /NIa+ldxJoxb1EEbYJ0wBKGUKFDHebHFDpQp3V9qnmzzAMIOISaT+mpVWzY3hhAo8V4mB
	 kJ0nZSvVjehBrTnVWbOKmjH5emo0MFy0jGTAiPeQoXH6A0LZTdD/bSFajBnFjiJ67EJCH
	 5WW1RMUpgwgot4o3TrNfdGbswUj+TokKnZk21vsmfipUP1t388Na8KNBUc0Znxo8+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcipfsfK;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2660A2614
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB2660A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcipfsfK
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso5496043c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461714; x=1795066514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+F52bmHA0YPZtsmxGOVRSP0y4qFlAaBYlea7RyACx8E=;
        b=AcipfsfK/3MeOcJvgSpfuApirVuSe5J+H7+OhRC3q80m3F0WgIrMFKVIlOcHXt3hQG
         rqrZdaV5NForE6poet5/qKP8xLcpnCxco9MJXKgk9FJeE8s18R7Db7cR77nKXDN3g3tF
         hzZxhgtZzFpzBLxmuLbOF6fxFr/NVQcvjStE5+JYLsiXgJiaWNubJ7D3RN2TiCeIcMcp
         eyp5rcoNwJPdrpk+Tnk7IArIG4daUM3ed+wRHzdZhXE5L/AD0W36a+4eCoExrRdmAaBT
         5PUvUjhxASO+d6GtH8XudxpOuzGnx76Ll+N+hV3fa9WHJbfGGkYNurSw83DI4e98xxt0
         FQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461714; x=1795066514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+F52bmHA0YPZtsmxGOVRSP0y4qFlAaBYlea7RyACx8E=;
        b=OM/lj4qQEsHMV0bLfleH9rvXJ7z1QIS7zYUCULOdVhixXdzFJPBvR0hifv9ZAbwGvQ
         MJLiJ2RVAPCctGBYSXAH3xkpxcgbly/a8NZd3Md59s1TM+ZUA3nO1qxq7NHYbGg4o7ZN
         g0NGbG531bzCi90TT0+D1cNGPe56rEts0O47v6mn+1bPuhaU7rvMKN6YbUaLuSr/HXMu
         sRQy+Ko/s5QjOO1rj9aeyqPdqZeNUduDsg7tPmH/ydbi5mrqFFbuauwjCCQicl4xkSOD
         YgozBBxt9npQScpCExvLwECS6MqVgx3JjV2qbSWWPSKgPIAO9F33FXfl0Kyno7X5GyY7
         T7kQ==
X-Forwarded-Encrypted: i=1; AL+hErGemaq1wOlMj8X8XceyOy+ddd+ZbmmniWCDeCamJ3puERrwUNlezwo87rYU8ov1DDZGAK1q6fiB2m1vgsYETw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/kwiRoZSAVS2IYe+wBcbdGNbFhnJUm2pwb/qgdUClAItq0qU2P
	Fj8LWbR2NZlDWpAvRDtt4Mu2SSgUVVM+Q1nIGPaIkocf1NLiymyOD8cO
X-Gm-Gg: AYBFou0Ckt6JMSWUqKoQi3i3W6AeZIbvZo0hjoD+mLMdVzYKh0gw/ItBlUQRxhkfjCC
	V4zbPoiV3fI04NICOXOOqnICcUpSH4x32dkdWIbW0tNjNqWjgSomsdBU3NtPbCnl85txImt91au
	7rl9Uww/P5yZlXL2Kch1F8eyyVoEmflLmbzITUDNchGfTLbh9+KQORuJnwdRs0HpPwkK7z4MRpM
	WaByCs96iuZD4xW3TIggVLCvGttQuBYozZiSmQnMXM8XyPDd1L+zCxeTINQKY+jRpV6kEWnZZL9
	RdoMJSNMu2jxB/BwwWZ6P3TEUTUJNZT03LXlKdyZ3hQgBaYQFa1xIyyYIqLIXe0jsvYBqkIjcaV
	jhqmzyD5KgOSvQu4fW33CcUIsf8zIWdTa5Zp//oohwJIOBq7VnfMZRWW3MwWceGx3hCqKgvm3E3
	Ew29ZjDzQNlisetuePyqMJ9Idw0Pml5q0E8uvaeFSrJZ7kXBZrrYjer/LokwLiQSn4NK7D00kaq
	RDjj289o0wFuvWdtYk/nlkMP9S4oj1OyCHXhliBk7hJgoBAMLvwnpwCOSFXP5Fd9P77o1e8pJB7
	1OxXAln45ov7g9gJO1gRv9+9HXhhEMyc6WNSYl1TYx9ybcQ0APdWKxxo5HxWgpNoJetbpDQjFJv
	PuJrsasCxEQa+v9PqfdbH8hXluHm+VT5bjuNfNrAqivlE8xM=
X-Received: by 2002:a05:7022:282:20b0:183:e993:7901 with SMTP id a92af1059eb24-1b3c0311ac2mr4178250c88.17.1794461713410;
        Wed, 11 Nov 2026 21:35:13 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:12 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
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
Subject: [PATCH v29 06/17] ALSA: virtio: propagate playback send failures through ACK
Date: Thu, 12 Nov 2026 14:34:35 +0900
Message-ID: <20261112053446.73504-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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

Propagate playback submission failures through ACK and commit indirect
accounting only after transport submission succeeds. Keep the PCM state
and buffer-access checks synchronized with playback transfer admission.
The existing capture ACK callback and initial queue reservation behavior
remain together until the request-owned capture conversion in patch 12.
That conversion introduces RX reservation, validation and refill as one
contract.

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |    6 +
 sound/virtio/virtio_pcm_msg.c |   12 ++
 sound/virtio/virtio_pcm_ops.c |  237 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 228 insertions(+), 27 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -33,6 +33,10 @@
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side.
+ * @prepared: True after device PREPARE and the core pointer reset succeed;
+ *            protected by @lock.
+ * @preparing: ACK gate through teardown and prepare's core reset;
+ *             protected by @lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @msgs: Allocated I/O messages.
@@ -56,6 +60,8 @@
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	bool prepared;
+	bool preparing;
 	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -260,6 +260,18 @@
 				dev_err(&vdev->dev,
 					"SID %u: failed to send I/O message\n",
 					vss->sid);
+				msg->length -= n;
+
+				/*
+				 * Do not leave earlier messages queued without notifying
+				 * the device when a later message could not be added.
+				 */
+				if (msg_count != vss->msg_count &&
+				    !(vss->features &
+				      (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+				    virtqueue_kick_prepare(vqueue))
+					virtqueue_notify(vqueue);
+
 				return rc;
 			}
 
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -97,6 +97,38 @@
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
 
 /**
+ * virtsnd_pcm_close_ack() - Update PCM prepare admission state.
+ * @substream: Kernel ALSA substream.
+ * @preparing: True while driver prepare and the core pointer reset are active.
+ *
+ * Context: Process context.
+ */
+static void virtsnd_pcm_close_ack(struct snd_pcm_substream *substream,
+				  bool preparing)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+		vss->preparing = preparing;
+	}
+}
+
+/* Keep completed RX data valid while RELEASE drains the device queue. */
+static void virtsnd_pcm_block_ack(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->preparing = true;
+		vss->xfer_enabled = false;
+	}
+}
+
+/**
  * virtsnd_pcm_open() - Open the PCM substream.
  * @substream: Kernel ALSA substream.
  *
@@ -115,7 +147,8 @@
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
-	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = !!vss->msg_count;
 	vss->suspended = false;
 
 	/*
@@ -219,6 +252,8 @@
 	struct virtio_device *vdev = vss->snd->vdev;
 	int rc;
 
+	virtsnd_pcm_close_ack(substream, false);
+
 	if (virtsnd_pcm_msg_pending_num(vss)) {
 		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 			vss->sid);
@@ -254,6 +289,8 @@
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 
+	virtsnd_pcm_close_ack(substream, false);
+
 	/* If the queue is flushed, we can safely free the messages here. */
 	if (!virtsnd_pcm_msg_pending_num(vss))
 		virtsnd_pcm_msg_free(vss);
@@ -262,17 +299,18 @@
 }
 
 /**
- * virtsnd_pcm_prepare() - Prepare the PCM substream.
+ * virtsnd_pcm_prepare_device() - Prepare the PCM substream on the device.
  * @substream: Kernel ALSA substream.
  *
  * Context: Process context.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_prepare_device(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
+	int rc;
 
 	if (!vss->suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
@@ -287,16 +325,14 @@
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
-		int rc;
 
 		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
-						runtime->channels,
-						runtime->format, runtime->rate);
+						 runtime->channels,
+						 runtime->format, runtime->rate);
 		if (rc)
 			return rc;
 	}
 
-	vss->xfer_xrun = false;
 	vss->suspended = false;
 	vss->msg_count = 0;
 	virtsnd_pcm_msg_reset(vss);
@@ -311,7 +347,33 @@
 	if (!msg)
 		return -ENOMEM;
 
-	return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	if (rc)
+		return rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_xrun = false;
+	}
+	return 0;
+}
+
+/* Keep ACK closed through the core's locked pointer reset. */
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	virtsnd_pcm_close_ack(substream, true);
+	return virtsnd_pcm_prepare_device(substream);
+}
+
+/* Complete admission only after the linked core prepare action ends. */
+static void virtsnd_pcm_prepare_complete(
+	struct snd_pcm_substream *substream, bool success)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->prepared = success;
+		vss->preparing = false;
+	}
 }
 
 /**
@@ -338,6 +400,8 @@
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
+			if (vss->preparing || !vss->prepared)
+				return -EBADFD;
 			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
 			if (rc)
@@ -356,10 +420,12 @@
 
 		return virtsnd_ctl_msg_send_sync(snd, msg);
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		vss->suspended = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
-		vss->stopped = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->stopped = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
@@ -393,11 +459,16 @@
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	bool stopped;
 	int rc;
 
+	virtsnd_pcm_block_ack(substream);
+
 	cancel_work_sync(&vss->elapsed_period);
 
-	if (!vss->stopped)
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		stopped = vss->stopped;
+	if (!stopped)
 		return 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
@@ -425,7 +496,8 @@
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	vss->stopped = false;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = false;
 
 	return 0;
 }
@@ -442,6 +514,10 @@
 virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		if (vss->xfer_xrun)
+			return SNDRV_PCM_POS_XRUN;
 
 	return snd_pcm_indirect_playback_pointer(substream,
 		&vss->pcm_indirect,
@@ -461,41 +537,144 @@
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		if (vss->xfer_xrun)
+			return SNDRV_PCM_POS_XRUN;
+
 	return snd_pcm_indirect_capture_pointer(substream,
 		&vss->pcm_indirect,
 		vss->hw_ptr);
 }
 
+struct virtsnd_pcm_transfer {
+	struct snd_pcm_indirect indirect;
+	int error;
+};
+
 static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec, size_t bytes)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct virtsnd_pcm_transfer *transfer =
+		container_of(rec, struct virtsnd_pcm_transfer, indirect);
+
+	if (transfer->error)
+		return;
+
+	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
+}
+
+/* Caller holds vss->lock. */
+static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
+{
+	vss->xfer_enabled = false;
+	vss->stopped = true;
+	vss->xfer_xrun = true;
+	vss->substream->runtime->stop_operating = true;
+}
+
+/* The caller holds the PCM lock, also used by DROP and state transitions. */
+static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
+{
+	switch (substream->runtime->state) {
+	case SNDRV_PCM_STATE_XRUN:
+		/* The member is already XRUN; avoid stopping its linked group twice. */
+		return -EBADFD;
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_PAUSED:
+	case SNDRV_PCM_STATE_DRAINING:
+		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
+			return -EBADFD;
+		return 0;
+	default:
+		return -EBADFD;
+	}
+}
+
+static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
+
+	rc = virtsnd_pcm_ack_state(substream);
+	if (rc)
+		return rc;
+
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->preparing || !vss->prepared)
+			return -EBADFD;
+		if (vss->stopped)
+			return -EBADFD;
+		if (vss->xfer_xrun) {
+			rc = -EPIPE;
+		} else {
+			transfer.indirect = vss->pcm_indirect;
+			rc = snd_pcm_indirect_playback_transfer(substream,
+							       &transfer.indirect,
+							       virtsnd_pcm_trans_copy);
+			if (!rc)
+				rc = transfer.error;
+		}
+		if (rc)
+			virtsnd_pcm_transfer_failed(vss);
+		else
+			vss->pcm_indirect = transfer.indirect;
+	}
+	if (rc) {
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: playback ACK transfer failed: %d\n",
+			vss->sid, rc);
+		return -EPIPE;
+	}
+
+	return 0;
+}
+
+static void virtsnd_pcm_legacy_capture_copy(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect *rec, size_t bytes)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 
 	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
 }
 
-static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
+	int rc;
+
+	rc = virtsnd_pcm_ack_state(substream);
+	if (rc)
+		return rc;
 	guard(spinlock_irqsave)(&queue->lock);
 	guard(spinlock)(&vss->lock);
-
-	return snd_pcm_indirect_playback_transfer(substream, &vss->pcm_indirect,
-						  virtsnd_pcm_trans_copy);
-}
-
-static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
-{
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
+	if (vss->preparing || !vss->prepared)
+		return -EBADFD;
+	if (vss->xfer_xrun)
+		return -EPIPE;
+	if (vss->stopped &&
+	    substream->runtime->state != SNDRV_PCM_STATE_DRAINING)
+		return -EBADFD;
 
 	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
-						 virtsnd_pcm_trans_copy);
+						 virtsnd_pcm_legacy_capture_copy);
+}
+
+/**
+ * virtsnd_pcm_reset() - Reset PCM pointers.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: PCM stream lock held.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_reset(substream);
 }
 
 /* PCM substream operators map. */
@@ -507,6 +686,8 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
+		.prepare_complete = virtsnd_pcm_prepare_complete,
+		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_pb_pointer,
@@ -519,6 +700,8 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
+		.prepare_complete = virtsnd_pcm_prepare_complete,
+		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_cp_pointer,
