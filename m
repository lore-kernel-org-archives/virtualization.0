Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862550;
	b=QYRT3ZMWYa92qX6IzbhnydfbFwAeFDuwLYKLT4Tla1Ix+qNtMDxmd0yDp2nrkg4dXhky
	 xmKwldGiQoHYk1H6HpcydNMQ/yjftX2vBOi6YLpTlpvbZDnG7sC3CF5dz8tEX2ha5DoMc
	 gK6DKHldskW3+xxybMrnerT4qm/AbV7wGwfRdsLH1hKxcAApgO3wRkH0j/7UGtALOqi6v
	 9n7YUU31Rl1c+FwUZKiGNifE9gbuPHYAxSHrO+v4ImPJbcVmhNnfhWH109X0btHSrlY4L
	 wqAh+7gO6TSUBhRKLaG9bIiAihodKMI0n+IrGcDcVybTwats01bDYkxdYkg+/UrzCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2proTelXa9qM30uRTcFiAguoDF7UEfWpXqF9ZbhovBs=;
	b=yLotGBKVXe3nf5zKbRzR6sVzrafwqib6drlSoQVFA54/GNDkJBvoe2k1jliRuJZsSwtJ
	 uM3DNoYYFotilUG0UvHpBiyd0bSYwppK8lcU9pFSYligDBk6jRd/QqmhPslUQXBTjguXa
	 8aLxecbNdo8FcNnhsCSSc4Xrs+KHOQ6nG3JRyWDp7FjI+ovdz7cz8iiOMWrlAga+CZT4r
	 ywbJiychSd8/QIQbfq4KBPI7jiLjWOCBBfA3SMyiNqFyEguk4/iY0urBACoqQ7U1oQ10e
	 B5Zj7THzZ6MiGTx8NixSsG1NRQo6oAZsAYykSI9P6EZNk/fvZDlmN4hM4yziGZBYtyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cfyeel8A;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA08606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA08606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cfyeel8A
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e795af1d4so191012eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862549; x=1794467349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2proTelXa9qM30uRTcFiAguoDF7UEfWpXqF9ZbhovBs=;
        b=Cfyeel8AcNQW3tXyKbVHLYUOclpyHumXi5pBrwpTaFqeB5RaiTK265A5BsRrPj2YVg
         x5WXVbMJ6JJCeb276KhZVyb9a7G9hv/g9+8+geMDk5mbrs3HLHsVVe+CaLRjeeaNzrfM
         cZ0eb7dJtpHz5mO4miNM3Ud06rLwWkv6T/z8PBS/cfx/RFBMM3//rFwZpJ2ViMZpPb2P
         fWdlENiUH1dLXRovEdgFH7YzYjkovDt6Opd60w3g3LBOHUI53cTLNauVNMs8zlXxh34k
         C7oOwDBhvJkj/Vh50zjYRICL4z4UGlrZ6do6HWXid+Joh/BMInsMum+HST45byQYZ45n
         n7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862549; x=1794467349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2proTelXa9qM30uRTcFiAguoDF7UEfWpXqF9ZbhovBs=;
        b=ytCdwlEmO00HGWanSiRucplbwY47u0A3TAdQ0W7LOWuSqwzDjx80oLhyegpO1EnICl
         5kp1nnNujM4aEwXp31q2qHxKvQS09lmnpCJiylwoVBtEbcJ5nGsw1zfqpysMqwrBJjiI
         2deTXpVSRsU/M4Q8ahvFNCRex0pyTFvP/7k8OVEaaAbgFDVJde3A94+1FrhhHeuUH9KR
         B2js5NCeWi4xhHLaUG7pTaTS0qbQGGzMoJhqhgppFcpHnZzEJeDmaF5hRBdkUxkqrSzz
         qi+3u4RAcxWENq2Nfkj5QyEBDd4p+ERX8xHE0bzHJYd6KYgS81OOtabbxyLos6JbASXZ
         2Q+w==
X-Forwarded-Encrypted: i=1; AKwUvBzgVBzEzFYh/ZGw26HCE2NW/rfDF/SQ/vrwbdmDuKbALrdXTE8Vn1soD1f395QzRpPvLeDZh7Mu6Irnm/P++Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/eQnyVbr/tgQad7XAyJrlEebmON9AsXzuHPodnBxMjyDizkI6N
	JJVWVCsl/Llymp8kJ7CPeStewjh7BF3wARmqCWjeRh00uXrDgSe5sHdX
X-Gm-Gg: AYBFou3hvzrKWis8KGKRPPqgDC+W1AzVNekESxnB/QxYGgJDouOFr7O57q9dPZJ0YEU
	JccsLw67vVyy6pk2GujHYig3+4Jl7pVI1Qde4omcTCIK4JjkQwnXfJonU6Jrc4UjUeDu8Uu2mHF
	Bs6MxohEj7vt/dP5l769vkp+XJMn/ZbEgdmBnkZPA3QAykGzQCDFISIo4mY+6iJzI0IJCAAl4EM
	bN7dMQexodM92zjpbxWGqXWe7mS4ufgAHArbUiP7FJCpsRm37pIazG5QblejbcLY4jybeJAs1yQ
	ULzIX5gpUN1KHLQLzsUyZum2YHiexchT+uPo4mWDgaBCUPeNUwfcQFQKl2fhxJDoXYKcMTWqOjU
	WYuG4vpKa2kNDso9fRrlNDiHhLmgH5rHaLZSDz5xN0L7cd6K3NTwPqNZSsmYKB85QEhjYlp1wcC
	MJRNpvb6AD7bUTYM29QHY9sABlCkHRPo3KiPUv/AirmcB0SkFd1YHMQ9QEuaos7tgVqABGCBYN7
	l4657jwcPqrv08NZc6X4pCfWbURNTvH8w/8E6+D7UuuoevhLBTbLrXGwTK5/K4cU/gz36e1VCH1
	zhFcDEIWRrYKcAh0vN6MYMOrXuVPZnFaPqO6gDjKCz7HQz3Cw5XmhLt0JJo4fNLsH5/vbKbErfw
	hNFgNiACIxleqFt1RdnsrKIJ5g+6glAwJVGjbJSstg33t5goo
X-Received: by 2002:a05:7300:841c:b0:36a:2473:9b2f with SMTP id 5a478bee46e88-36de743530bmr2291726eec.23.1793862548359;
        Wed, 04 Nov 2026 23:09:08 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:07 -0800 (PST)
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
Subject: [PATCH v17 04/12] ALSA: virtio: Propagate PCM send failures through ACK
Date: Thu,  5 Nov 2026 16:08:37 +0900
Message-ID: <20261105070845.6449-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
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

virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
failed message's length and notify the device about earlier messages
queued by the same call, so they do not remain stranded.

Propagate errors through the indirect transfer callback and commit its
private cursor only after successful submission. Genuine transfer errors
arm stop_operating and return -EPIPE so ALSA can retire the stream.

Close ACK admission under the PCM stream lock before sleeping teardown.
Keep the prepared state protected by the substream lock and reject ACK
through prepare and parameter changes. Reopen admission in the reset
callback while the core holds the PCM lock for its pointer rebase. An
ACK racing with teardown returns -EBADFD and preserves stop state.

Keep the polling feature path unchanged.

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")

Reject a stopped playback ACK before the XRUN path can rearm
stop_operating. For capture, allow the ordinary stopped tail only during
DRAINING and only while no transfer XRUN is latched.

Keep ACK failures associated with the transfer that failed, and preserve ownership of requests already submitted by that ACK.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |    6 +
 sound/virtio/virtio_pcm_msg.c |   12 ++
 sound/virtio/virtio_pcm_ops.c |  249 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 241 insertions(+), 26 deletions(-)

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
@@ -311,7 +347,26 @@
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
+	int rc;
+
+	virtsnd_pcm_close_ack(substream, true);
+	rc = virtsnd_pcm_prepare_device(substream);
+	if (rc)
+		virtsnd_pcm_close_ack(substream, false);
+	return rc;
 }
 
 /**
@@ -338,6 +393,8 @@
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
+			if (vss->preparing || !vss->prepared)
+				return -EBADFD;
 			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
 			if (rc)
@@ -356,10 +413,12 @@
 
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
@@ -393,11 +452,16 @@
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
@@ -425,7 +489,8 @@
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	vss->stopped = false;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = false;
 
 	return 0;
 }
@@ -442,6 +507,10 @@
 virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		if (vss->xfer_xrun)
+			return SNDRV_PCM_POS_XRUN;
 
 	return snd_pcm_indirect_playback_pointer(substream,
 		&vss->pcm_indirect,
@@ -461,41 +530,167 @@
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
-
-	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
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
+	vss->substream->runtime->stop_operating = true;
+}
+
+/* The caller holds the PCM lock, also used by DROP and state transitions. */
+static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
+{
+	switch (substream->runtime->state) {
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
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
 }
 
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
-
-	return snd_pcm_indirect_playback_transfer(substream, &vss->pcm_indirect,
-						  virtsnd_pcm_trans_copy);
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
 }
 
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
-
-	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
-						 virtsnd_pcm_trans_copy);
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
+		/* Keep only the post-STOP capture tail available during drain. */
+		if (vss->stopped &&
+		    (vss->xfer_xrun ||
+		     substream->runtime->state != SNDRV_PCM_STATE_DRAINING))
+			return -EBADFD;
+		if (vss->xfer_xrun) {
+			rc = -EPIPE;
+		} else {
+			transfer.indirect = vss->pcm_indirect;
+			rc = snd_pcm_indirect_capture_transfer(substream,
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
+			"SID %u: capture ACK transfer failed: %d\n",
+			vss->sid, rc);
+		return -EPIPE;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_pcm_reset() - Reset PCM pointers and complete prepare admission.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: PCM stream lock held.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	int rc;
+
+	rc = snd_pcm_lib_reset(substream);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->preparing) {
+			vss->prepared = !rc;
+			vss->preparing = false;
+		}
+	}
+
+	return rc;
 }
 
 /* PCM substream operators map. */
@@ -507,6 +702,7 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
+		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_pb_pointer,
@@ -519,6 +715,7 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
+		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_cp_pointer,
