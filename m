Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552120;
	b=mz38q7BwaMQUBsB2iY0P+2hHgeK0t4uTh4HXy1hjNk/otxKw9jGsMHYkIT1hBtQBBY9C
	 TnNZiVelLhLeMQZCmi0Fsgt00PNMRMKJn76UExtnDY0uKObvpZFf9FrI2uB4ARoU1wsHc
	 JKDIW2wSt7AkaPy6JSSntupeNOd4q1AiaIslC8fqIYOnma3UNGmluNtFyAMZCcvUmh4rf
	 mhRif83y0UNQvGTG9bzB8UraSEtiBIFnXF5BI+edVAZv2K2pvOrkYTsG23uq1vcCo3JXA
	 vlAEll+SXT6me3OKqL1RAZ4dnCDzaxgl/vCiS7sVvZmRbDVvR1og/jlr6Aid9cHHX3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552120;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vpMZdlcyoh0GcqZuPlSqHKiKfF6eNhvd7bd4XpqmOwE=;
	b=xAn66yWbT14qkKa4adbbBAP3SfGJML4cu82w/AoayrhyxbBpYIkuRY/3c2CLlV7YCC2d
	 Pgrzv5siGGXjl6YTckCBzJ1dHD0QCYdkm77R7auYx40W/J4hGO4/IpzaNKucmgFZubU5q
	 eV2ep7JDNIzVjEIWCm9QxkwPTGGHHvxwXv1AOmMvL5oE0zc0wMvkvyMd2Al13MkOwOCSy
	 ZDjdGS4Nl2pZ35LGJj0YCVCe36h/a0G69adi0GW2BFXY1X3HGquSuvh/tAdm/43IzEE4D
	 ln/pWmi2gGBtblz5DgMSKilAzCCdQ0WyDcHeYjSLWYMA5OO9USqUq6Mp+nwo9zXU3oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCmkmg9m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799660A5BC0;
	Fri, 13 Nov 2026 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCmkmg9m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552120;
	b=zlMjkQ+CU/NTuv6OAMML0DIlyE/LHFV/yrtyfu0d0XPCn61VnjHgkAafffcfwEfYiKwY
	 ZPimbLKujhwL3UOhFEGHfScJotxr8MRkxTqDOpALEBD4rDIV+KK0WFgh0G0MHXw1jfxwX
	 2cx1Wzhbb2hvaqf/3Xjc7MA+CPz11nZxhChOUJs951+yLW/suj82rp1nZDRYwjcRtVp3n
	 sazp1S8PZtJvfFalPSaVUyBw1oExIiXkIapoECp13vWLiqKmYauH/85HaFLHZg21zGx3E
	 SPsUloH8NOT2xenuLfqBxKNVS/RoYTx6oS2hoTGzBb2Jsmtu0yk01HqfVst/JnCH30w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552120;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vpMZdlcyoh0GcqZuPlSqHKiKfF6eNhvd7bd4XpqmOwE=;
	b=jZ0hNCIpGkphTnb0PsB1tzka5CfLtHlHAY5K1suTVoZjVfrM5hkyGQB3G85TPT3bNgCH
	 vpBCd3nGwBP7cqurAGCBHRmTyUS6IEEDVXuNdtxmBEgtHg3vnF475gIUbLCjasmKe0tZX
	 XkZjagMTmC2z16zRSTdBTV1EQdya8l1EHIbpBWDrpO2mahGJEnuNx3UWSZJX7lLiK6G0x
	 xVR+9xZ4eEZz7wKqgbPwx1VhJAEAg1WIXeURu5Q5+gDzT0jhfWQDKHikYouAE3GDeQY5W
	 rzZYbuhBbCDNeoQtVu9QflAktM82mBSn3EoKhIIPE/jVR3WCDU7ADbU3ftWJ+vDfDjA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 751AD1F000D4;
	Fri, 13 Nov 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552120;
	bh=vpMZdlcyoh0GcqZuPlSqHKiKfF6eNhvd7bd4XpqmOwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dCmkmg9mseaNDu73RrT7r2BxOpVedNn7uhYP11T9hn6DR6izGkB9dg/B87pSl8IES
	 Wqbo6ukE0uWv53qdu0hhkRoWNHj0HggX52v7msRXVykDdcKMw93FohFm63iaOUIYVx
	 XuFSjGmcSa7Qe2vw04MRQ28RtAzHoOCwiO6UmNGZOrzsSPxZbXQpJjmSGwiE6VavRn
	 dWW1bJukR5THYGfkvqwi3PCc5P+nV9qDVo6Zr4C1Hd7lp/dAfj7ddYadO8YAcSzEWZ
	 g7WFNiSyoCjFNwrax8tYYvg3aUcJKRqGoSeVndngrRAiH2Y6dXYsIUDex2Up05noBu
	 ztMAOnzlqXcng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 444634767A;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:42:01 +0900
Subject: [PATCH v32 17/20] ALSA: virtio: preserve playback progress across
 pause and buffer access
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-17-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=14790;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=o1QwpIeuJHnytrturKOJEq0RXPRI0TQq3DL32w2TIHg=;
 b=3IUK59ka4vVZ6c6/1WVxSfWQPrle7XH2waE0xatOGbWJYVhrRqeBe0Io6BREJT0R0/RjdSGqm
 mPVEhpx9HS7AjYQ6wdXJKSufkbKuTGvMQ1SFhpLAg27VlPDBaWgaPev
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

TX completions can arrive after PAUSE closes transfer admission.
Preserve that progress and schedule catch-up when the stream resumes or
a rejected pause restores RUNNING. Cache device latency in stream-owned
state so a late completion does not need to dereference the ALSA
runtime. Clear both the cache and runtime delay on prepare and before
RESET observes the hardware pointer.

A playback pointer callback can also invoke ACK while the core has
closed buffer-access admission, after the pointer helper has already
accounted for completed hardware bytes. Track that callback context and
refill only previously committed data using pcm_indirect.appl_ptr. Keep
rejecting other ACKs while the gate is closed, and use the
snd_pcm_indirect_playback_transfer_appl_ptr() for the refill. If
runtime->control is absent, route the condition through the common
playback validator and XRUN error path rather than returning before
transfer failure handling.

Use the existing indirect hw_queue_size to keep outstanding TX below one
physical ring: buffer_bytes - period_bytes. Equal modulo cursors then
mean no unobserved completion, and a non-interrupt HWSYNC cannot consume
a hidden full-ring wrap before deferred period work. Continue using the
ordinary ALSA pointer update for silence, drain, stop-threshold and
wakeup policy.

Check for pending progress or a latched transfer error again in the
period worker under the PCM stream lock. A queued notification can
outlive a paused RESET or an earlier pointer observation. Calling the
period helper without new progress after resume can turn equal cursors
into a false wrap when the core has backdated its pointer timestamp.

This reduces queued buffering by one period. With two periods, only one
period can be queued.

The final candidate was tested on ARM64 QEMU with KASAN and lockdep.
RW/MMAP boundary pause, release, HWSYNC/poll, drop and reopen passed
with two- and eight-period rings. RW/MMAP also passed accepted RESET
from PREPARED followed by DRAIN and reopen, and accepted RESET while
RUNNING after the full 2,048-frame buffer became available.

A separate paired RW/MMAP gate fixture reproduced the baseline failure.
The generic ALSA indirect helper invokes ACK for each pointer callback
but masks its internal -EBADFD. Once hw_ptr == hw_io with no completion
outstanding, virtio period-work progress suppresses further callbacks,
so there is no ACK to retry the refill. Baseline stopped after 3,072
completed bytes with 1,024 bytes in sw_ready. The candidate drained
sw_ready and completed 4,096 bytes without any further client ACK. A
test-only hook changed appl_ptr to 2,560 while only 2,048 frames were
committed; the candidate refilled only committed data. The hostile
mutation used a test-only kernel hook because ARM64 control-page mmap is
unsupported. KASAN and lockdep reported no diagnostics.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm.c     |  3 ++
 sound/virtio/virtio_pcm.h     | 13 +++++++++
 sound/virtio/virtio_pcm_msg.c |  8 ++----
 sound/virtio/virtio_pcm_ops.c | 67 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 7b332c9476f1..38795c4acb01 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -338,6 +338,9 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
 	}
 
 	if (vss->direction != SNDRV_PCM_STREAM_CAPTURE) {
+		/* Ignore stale work after RESET rebases the playback cursors. */
+		if (!virtsnd_pcm_playback_progress_pending(vss))
+			return;
 		snd_pcm_period_elapsed_under_stream_lock(substream);
 		return;
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 987105145205..0c625df1f4e4 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -53,6 +53,7 @@ enum virtio_pcm_pause_restart_state {
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @playback_latency_bytes: Device delay cached independently of the ALSA runtime.
  * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
  *                 always zero in free-running mode.
  * @capture_boundary: ALSA boundary captured for this prepared epoch.
@@ -84,6 +85,8 @@ enum virtio_pcm_pause_restart_state {
  * @capture_reset_observing: Reclaim staged samples during RESET pointer capture.
  * @indirect_reset_observing: Suppress ordinary ACK refill during RESET pointer
  *                            capture; protected by the PCM stream lock.
+ * @playback_pointer_active: Internal playback ACK context; protected by the
+ *                           PCM stream lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @pause_restart_state: Device-side state for opt-in pause compatibility.
@@ -113,6 +116,7 @@ struct virtio_pcm_substream {
 	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	u32 playback_latency_bytes;
 	size_t capture_ready;
 	snd_pcm_uframes_t capture_boundary;
 	u64 capture_copied_total;
@@ -140,6 +144,7 @@ struct virtio_pcm_substream {
 	bool control_uncertain;
 	bool capture_reset_observing;
 	bool indirect_reset_observing;
+	bool playback_pointer_active;
 	bool suspended;
 	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
@@ -179,6 +184,14 @@ virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 	return schedule_work(&vss->elapsed_period);
 }
 
+/* Caller holds the PCM stream lock so RESET cannot rebase these cursors. */
+static inline bool
+virtsnd_pcm_playback_progress_pending(struct virtio_pcm_substream *vss)
+{
+	guard(spinlock_irqsave)(&vss->lock);
+	return vss->xfer_xrun || vss->hw_ptr != vss->pcm_indirect.hw_io;
+}
+
 /*
  * ALSA may observe a subperiod tail before its period callback. Keep actual
  * unread occupancy separate from pointer observations and notification state;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 9c67a8bf15f5..44761dff3e0d 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1033,12 +1033,10 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 	/* Keep latched errors until prepare establishes a fresh epoch. */
 	vss->msg_count--;
 
-	if (vss->xfer_enabled) {
-		struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+	/* A queued request can outlive the ALSA runtime after hw_free. */
+	vss->playback_latency_bytes = latency_bytes;
+	if (vss->prepared && !vss->preparing)
 		virtsnd_pcm_schedule_period_elapsed(vss);
-	}
 	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
 }
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 442169a51667..4a10cd3cc57c 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -770,6 +770,13 @@ static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substream)
 		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
 		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
 		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* Keep unobserved completions below one physical ring. */
+			vss->pcm_indirect.hw_queue_size = vss->buffer_bytes -
+				snd_pcm_lib_period_bytes(substream);
+			vss->playback_latency_bytes = 0;
+			substream->runtime->delay = 0;
+		}
 		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
 			vss->capture_boundary = substream->runtime->boundary;
 			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
@@ -1200,7 +1207,8 @@ static int virtsnd_pcm_trigger_inner(struct snd_pcm_substream *substream,
 		}
 
 		if (running) {
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss))
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			return 0;
 		}
@@ -1222,7 +1230,8 @@ static int virtsnd_pcm_trigger_inner(struct snd_pcm_substream *substream,
 				return -ECANCELED;
 			vss->device_running = true;
 		}
-		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE))
+		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss)))
 			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -1272,7 +1281,8 @@ static int virtsnd_pcm_trigger_inner(struct snd_pcm_substream *substream,
 				virtsnd_pcm_trigger_failed(vss, epoch);
 			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
 				virtsnd_pcm_trigger_failed(vss, epoch);
-			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+				   virtsnd_pcm_playback_progress_pending(vss)) {
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
@@ -1605,6 +1615,7 @@ virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t position;
 	size_t hw_ptr;
 	bool paused_pointer = false;
 	bool defer_work = false;
@@ -1622,6 +1633,7 @@ virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 		}
 		if (!paused_pointer)
 			hw_ptr = vss->hw_ptr;
+		runtime->delay = bytes_to_frames(runtime, vss->playback_latency_bytes);
 	}
 	if (paused_pointer) {
 		if (defer_work)
@@ -1629,8 +1641,11 @@ virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 		return virtsnd_pcm_cached_pointer(runtime);
 	}
 
-	return snd_pcm_indirect_playback_pointer(substream,
-		&vss->pcm_indirect, hw_ptr);
+	vss->playback_pointer_active = true;
+	position = snd_pcm_indirect_playback_pointer(substream,
+						     &vss->pcm_indirect, hw_ptr);
+	vss->playback_pointer_active = false;
+	return position;
 }
 
 /* Caller holds vss->lock. */
@@ -1745,9 +1760,9 @@ struct virtsnd_pcm_transfer {
 /* Caller holds @vss->lock and the PCM stream lock. */
 static int virtsnd_pcm_playback_ack_validate(struct virtio_pcm_substream *vss,
 					     struct snd_pcm_runtime *runtime,
-					     const struct snd_pcm_indirect *rec)
+					     const struct snd_pcm_indirect *rec,
+					     snd_pcm_uframes_t appl_ptr)
 {
-	snd_pcm_uframes_t appl_ptr;
 	snd_pcm_uframes_t appl_diff;
 	snd_pcm_uframes_t signed_max;
 	snd_pcm_uframes_t back;
@@ -1761,7 +1776,7 @@ static int virtsnd_pcm_playback_ack_validate(struct virtio_pcm_substream *vss,
 	unsigned int hw_queue_size;
 
 	if (!runtime->control || !runtime->boundary ||
-	    runtime->control->appl_ptr >= runtime->boundary ||
+	    appl_ptr >= runtime->boundary ||
 	    rec->appl_ptr >= runtime->boundary)
 		return -EPIPE;
 
@@ -1776,7 +1791,6 @@ static int virtsnd_pcm_playback_ack_validate(struct virtio_pcm_substream *vss,
 		return -EPIPE;
 
 	/* Match the indirect helper's appl_ptr boundary-wrap calculation. */
-	appl_ptr = runtime->control->appl_ptr;
 	if (appl_ptr >= rec->appl_ptr) {
 		appl_diff = appl_ptr - rec->appl_ptr;
 	} else {
@@ -1868,7 +1882,8 @@ static int virtsnd_pcm_ack_xrun_locked(struct virtio_pcm_substream *vss,
 	return -EPIPE;
 }
 
-static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream,
+				     snd_pcm_uframes_t appl_ptr)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1892,13 +1907,13 @@ static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
 				return -EBADFD;
 			transfer.indirect = vss->pcm_indirect;
 			rc = virtsnd_pcm_playback_ack_validate(vss, runtime,
-							       &transfer.indirect);
+							       &transfer.indirect, appl_ptr);
 			if (rc == -EBADFD)
 				return -EBADFD;
 			if (!rc)
-				rc = snd_pcm_indirect_playback_transfer(substream,
-									&transfer.indirect,
-									virtsnd_pcm_trans_copy);
+				rc = snd_pcm_indirect_playback_transfer_appl_ptr(
+					substream, &transfer.indirect,
+					virtsnd_pcm_trans_copy, appl_ptr);
 		}
 		if (!rc)
 			rc = transfer.error;
@@ -1937,8 +1952,6 @@ static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PAUSED:
 	case SNDRV_PCM_STATE_DRAINING:
-		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
-			return -EBADFD;
 		return 0;
 	default:
 		return -EBADFD;
@@ -1949,6 +1962,8 @@ static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t appl_ptr;
 	int rc;
 
 	if (vss->indirect_reset_observing)
@@ -1956,7 +1971,21 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 	rc = virtsnd_pcm_ack_state(substream);
 	if (rc)
 		return rc;
-	return virtsnd_pcm_pb_ack_locked(substream);
+	if (atomic_read(&runtime->buffer_accessing) < 0) {
+		if (!vss->playback_pointer_active)
+			return -EBADFD;
+		/*
+		 * Pointer accounting already consumed completed hardware bytes.
+		 * Refill committed data without admitting a new application
+		 * pointer while a buffer operation has closed ACK admission.
+		 */
+		appl_ptr = vss->pcm_indirect.appl_ptr;
+	} else if (runtime->control) {
+		appl_ptr = READ_ONCE(runtime->control->appl_ptr);
+	} else {
+		appl_ptr = 0;
+	}
+	return virtsnd_pcm_pb_ack_locked(substream, appl_ptr);
 }
 
 static int virtsnd_pcm_capture_ack(struct virtio_pcm_substream *vss,
@@ -2087,6 +2116,8 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 	rc = virtsnd_pcm_ack_state(substream);
 	if (rc)
 		return rc;
+	if (atomic_read(&substream->runtime->buffer_accessing) < 0)
+		return -EBADFD;
 	return virtsnd_pcm_cp_ack_locked(substream);
 }
 
@@ -2229,6 +2260,8 @@ static int virtsnd_pcm_playback_reset(struct snd_pcm_substream *substream)
 		guard(spinlock)(&vss->lock);
 		if (vss->msg_count)
 			return -EBUSY;
+		vss->playback_latency_bytes = 0;
+		runtime->delay = 0;
 	}
 	vss->indirect_reset_observing = true;
 	rc = snd_pcm_lib_reset(substream);

-- 
Git-157)


