Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461755;
	b=5hrvhWgNPdZ+kC2u5dl/BLTdJSHmb1thXRIeMA8NdMz/A8R1PuYYdBhffrs/oiaiITUE
	 BmWnb8pONFxv7gxqHxwi9uEgW7yOZQRrXoJ0d3epGrlB4rVn/EJKmJf1gXS7+U8yA18C5
	 DPGwI8pMRvuUhtmPj4nASm8kZRBSKGIME3bUJydvVfLBXbNZaE3Vw8+1BcExy8nfG1t8x
	 n3Oyp3wS0XVk+XwOdnfeFDHtOeLjsEPa0OTa0HcMyRROaDZz4YmhJhwOudsrRgirs30gO
	 4jjucJcwjshf8h9m9t64Qd8gmnohbdmHAk9uC0x/2K+Idqj/O61xM/0Zvp3haCF8K2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=STeEkttv3YJNNONebll50Y3FQZPr4qX7dcO5WrAPVr0=;
	b=174TjI1z6J7AQr2HhpP/u9o+svqls2R5Nd/et2/2Sjithle1k8QYme91cWuj7ysNChT/
	 uK53dQsbhFSNBtkT6RA4YSJjHBb5QFuf69f5qezu6IXBYeuUdmWvGu5dtnnFwJ4XTpuxk
	 R5kEsLz2KcpVtK1WwQxqOIRhW1D66sJG1b9T4z4NQ+MGZzamkiWsiAMiizztQ3I9SI953
	 Afz4OvOvaiF6IHlArmhIfREFpv3U9VQ/8QywD1V/0ihkpeKLb1rUOYbomUaEcIN+ZV6a7
	 wLEOLhIU1JcbY/0c2blYST2AjNChPVYg500sE44+kcoYuY8k+b3TjLrSUn3RTEBMb1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qO/6e0rY";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E760A6F73
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C8E760A6F73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qO/6e0rY
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438d9363fbso319099c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461754; x=1795066554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=STeEkttv3YJNNONebll50Y3FQZPr4qX7dcO5WrAPVr0=;
        b=qO/6e0rYHqbTE6vwY+Oo2G731O+AF6wBIX1EFYOsuOO4F1rPcWOVaLAWmtZr/zjrhZ
         ToFp/gGT2NAo7y++foFFLnVRkHk34MRoDvdByLDEyOXlIoPpjpWNx4/MBc8hPPwvHLjn
         OQB9XPvxdeIN0LHBCdIHn+/eY1WMrkVmn2ePCshbLhalzP8qUoR2u8TUenhX39g0j+Ly
         9dL9zdZSSNhnLmtYcRWUdsjZe5EoFOtiZlm5vCyAo8QDJ9GRTUj2k+TeRuool1RTUwPf
         +aVS4JIuxwMoE6iDhPzdiBz6s8DhG1+Ul+mlAAMuMK6khnx68xfK935huY5NZize1TNN
         TbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461754; x=1795066554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=STeEkttv3YJNNONebll50Y3FQZPr4qX7dcO5WrAPVr0=;
        b=rXmrftN3TN5sACTtj0KcJf5xaS2JsRP94/HAjuoAHp2lUlP61y2KSgmhuQ+TsZcnKR
         huSBcFCVwhxq3y6KPKoK5mpAyYUKuv/vajH7RaxRu4V+Ks92cA+XEVsBqXVJ880arZ+b
         sM8V/Ykc4q+MAGV7ClvtGUfd0lQZTAjA1BU8djpgqRkV2zykNeWpJeOl/gss0Yq0CzwJ
         X70/XRPfu6h1kBytdTAgNna5eJbiE2VT/IzPkcosoedq5HEtfbz3SSZtt/VRoo7vkBsb
         EYOQDYgwgOvv2IXSa+vIw5z3bgaRHjBdANcFmrYL4dXM+Aa4t4dL8BHDBh9j6Ek/qHKd
         jCXQ==
X-Forwarded-Encrypted: i=1; AL+hErGP9iaSLm3X/hkrfLub+7uF7krODetkF6Z4fqyqb7fqRN0pcSNUxjKMNRkgC04zrRkA0UbEUoLoDEl1l8SEZw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pTjTAk10LYbxTi2NtPGt1cxkBpqD59qamnjuxsX6obU9U/rxw
	hWrrHf3N+0r8yE7BSZC4KtPr30cWSGJbHnhhlblZHM0aEmeEpa5NnQRB
X-Gm-Gg: AYBFou3dX4EBrlPI/4U6T5xTy0sZhVd5He1/IUQASe3O3fwZMIXGLGDp8SNoSO98OsL
	qgh1vc0D4ukVdl0P1aHwYYclLEmwCkj7HdoY80+VZ3qIz07b6hWiQWo25PT/1QmzGwFTtJgXoBQ
	Vx+Q+zxbNP0t1OeVBwkMWzvMbOMRuKfkpRX3c3QO1f6hic/vWvogNdxdXFed/QErB0MlOQznqiY
	UltYLYLa7MGc4tmU18QMXiI6ZM6ga2yVMQ5T+U2suDG+lHalaOQQkapGgkLhZU3ALvZDIfpqGeZ
	Va6HPC1ozJ+AwZ5cxY3P0HXGQZdXls+0t6iR7yy7y9DXY0awZ1hML9Pf5GfPO14pYgPP2O3Xhvu
	WeNo8NDf+dDuSKPhAvmgIiMSHX2i2XrGeWOD2R6qkpayhpChXtOTfwhZ3pR33bxXkAmyQbhq33K
	gqFF8Ku+Cbu1v3u/BC8P4ywRH4us9tDsrmUzzL+kLcSPQvJAEQvtZVdJcY7HcT9hkuC4aRTdEwD
	LFerVg60+uJvDzV8+BMJ6nZJV4LlEvGbr7uNZK9XDW+mIu+sTqblynH8u/YUm4kijlQme8FnRrP
	PiKHNezmXTwTWWy04RgTshnWE1ePkkMX7C+LBlIeLKOpf2RF2L5ZaBG3Bkoz4gbDjo0tKueAk5D
	bj7EulZ6WKJAO4dOrOg6unn/Rtwgj6FxNBF6px4b+R7ksj4o=
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr1360633c88.10.1794461754170;
        Wed, 11 Nov 2026 21:35:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:53 -0800 (PST)
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
Subject: [PATCH v29 17/17] ALSA: virtio: preserve playback progress across pause and buffer access
Date: Thu, 12 Nov 2026 14:34:46 +0900
Message-ID: <20261112053446.73504-18-mynameisjune111@gmail.com>
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
explicit-pointer helper from patch 16 for the refill. If
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
period can be queued. Worst-case scheduling tolerance needs
qualification.

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
unsupported. KASAN and lockdep had no diagnostics. KCSAN and physical
audio were not tested. The tree through patch 15 was inspected but was
not run as a separate control. Full-series runtime is not claimed here.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.c     |    3 ++
 sound/virtio/virtio_pcm.h     |   13 ++++++++
 sound/virtio/virtio_pcm_msg.c |    8 ++---
 sound/virtio/virtio_pcm_ops.c |   69 ++++++++++++++++++++++++++++++-----------
 4 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -338,6 +338,9 @@
 	}
 
 	if (vss->direction != SNDRV_PCM_STREAM_CAPTURE) {
+		/* Ignore stale work after RESET rebases the playback cursors. */
+		if (!virtsnd_pcm_playback_progress_pending(vss))
+			return;
 		snd_pcm_period_elapsed_under_stream_lock(substream);
 		return;
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -53,6 +53,7 @@
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @playback_latency_bytes: Device delay cached independently of the ALSA runtime.
  * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
  *                 always zero in free-running mode.
  * @capture_boundary: ALSA boundary captured for this prepared epoch.
@@ -84,6 +85,8 @@
  * @capture_reset_observing: Reclaim staged samples during RESET pointer capture.
  * @indirect_reset_observing: Suppress ordinary ACK refill during RESET pointer
  *                            capture; protected by the PCM stream lock.
+ * @playback_pointer_active: Internal playback ACK context; protected by the
+ *                           PCM stream lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @pause_restart_state: Device-side state for opt-in pause compatibility.
@@ -113,6 +116,7 @@
 	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	u32 playback_latency_bytes;
 	size_t capture_ready;
 	snd_pcm_uframes_t capture_boundary;
 	u64 capture_copied_total;
@@ -140,6 +144,7 @@
 	bool control_uncertain;
 	bool capture_reset_observing;
 	bool indirect_reset_observing;
+	bool playback_pointer_active;
 	bool suspended;
 	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
@@ -179,6 +184,14 @@
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
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1033,12 +1033,10 @@
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
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -770,6 +770,13 @@
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
@@ -1200,7 +1207,8 @@
 		}
 
 		if (running) {
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss))
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			return 0;
 		}
@@ -1222,7 +1230,8 @@
 				return -ECANCELED;
 			vss->device_running = true;
 		}
-		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE))
+		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss)))
 			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -1272,7 +1281,8 @@
 				virtsnd_pcm_trigger_failed(vss, epoch);
 			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
 				virtsnd_pcm_trigger_failed(vss, epoch);
-			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+				   virtsnd_pcm_playback_progress_pending(vss)) {
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
@@ -1605,6 +1615,7 @@
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t position;
 	size_t hw_ptr;
 	bool paused_pointer = false;
 	bool defer_work = false;
@@ -1622,6 +1633,7 @@
 		}
 		if (!paused_pointer)
 			hw_ptr = vss->hw_ptr;
+		runtime->delay = bytes_to_frames(runtime, vss->playback_latency_bytes);
 	}
 	if (paused_pointer) {
 		if (defer_work)
@@ -1629,8 +1641,11 @@
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
@@ -1745,9 +1760,9 @@
 /* Caller holds @vss->lock and the PCM stream lock. */
 static int virtsnd_pcm_playback_ack_validate(struct virtio_pcm_substream *vss,
 					     struct snd_pcm_runtime *runtime,
-					     const struct snd_pcm_indirect *rec)
-{
-	snd_pcm_uframes_t appl_ptr;
+					     const struct snd_pcm_indirect *rec,
+					     snd_pcm_uframes_t appl_ptr)
+{
 	snd_pcm_uframes_t appl_diff;
 	snd_pcm_uframes_t signed_max;
 	snd_pcm_uframes_t back;
@@ -1761,7 +1776,7 @@
 	unsigned int hw_queue_size;
 
 	if (!runtime->control || !runtime->boundary ||
-	    runtime->control->appl_ptr >= runtime->boundary ||
+	    appl_ptr >= runtime->boundary ||
 	    rec->appl_ptr >= runtime->boundary)
 		return -EPIPE;
 
@@ -1776,7 +1791,6 @@
 		return -EPIPE;
 
 	/* Match the indirect helper's appl_ptr boundary-wrap calculation. */
-	appl_ptr = runtime->control->appl_ptr;
 	if (appl_ptr >= rec->appl_ptr) {
 		appl_diff = appl_ptr - rec->appl_ptr;
 	} else {
@@ -1868,7 +1882,8 @@
 	return -EPIPE;
 }
 
-static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream,
+				     snd_pcm_uframes_t appl_ptr)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1892,13 +1907,13 @@
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
@@ -1937,8 +1952,6 @@
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PAUSED:
 	case SNDRV_PCM_STATE_DRAINING:
-		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
-			return -EBADFD;
 		return 0;
 	default:
 		return -EBADFD;
@@ -1949,6 +1962,8 @@
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t appl_ptr;
 	int rc;
 
 	if (vss->indirect_reset_observing)
@@ -1956,7 +1971,21 @@
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
@@ -2087,6 +2116,8 @@
 	rc = virtsnd_pcm_ack_state(substream);
 	if (rc)
 		return rc;
+	if (atomic_read(&substream->runtime->buffer_accessing) < 0)
+		return -EBADFD;
 	return virtsnd_pcm_cp_ack_locked(substream);
 }
 
@@ -2229,6 +2260,8 @@
 		guard(spinlock)(&vss->lock);
 		if (vss->msg_count)
 			return -EBUSY;
+		vss->playback_latency_bytes = 0;
+		runtime->delay = 0;
 	}
 	vss->indirect_reset_observing = true;
 	rc = snd_pcm_lib_reset(substream);
