Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338043;
	b=tQ/MKInWURmf7qCzBiQ35zpn+yeEhHxKmLmLcWJcGDXWIhuZbEhGKZGhxRcIEOanDPI4
	 me/YnyFVJHPjPHJIk5V0dzsCQdwqOIpy6HTAplmVQnji7w8z+fyhjU6DCwEIgGLmSlUMn
	 2382PzxEk30jYIcIPA8rf0utMT+vv0ZDDRQKZNqfJGjGs4AUdBOAQatO6g+g3BMVMrSYP
	 BFl7SeORLJhdqI0OqOjkQ88XkDyI+CsEojckQ/regh5XRRwSA/fYG4Bd+b9lYvK8Smkfq
	 AgiLhDTw7lJIxCJA/DHLpCg6KpVP2hM2JQ0lWzQaNYnJ1wNTHDl9z0WFjP/Hsx/lycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cXakcM7uJiGRXE7zC/KyEFKX2jN6HI+h/+RXq73D/F0=;
	b=i+ECZu6T5MB2S/tJ27hNpC+jOng68/ji8BQ59p9cV/7jQ3gJQ2UHXy9hRNqQSGTjc2Ia
	 9zQuWFBAwW1hJX/2K4okaVIyhB4n9LuuBJNLpxFGTRWZCxZlD0BHYCLFic7wyVmAjJLte
	 6/CZaLp6I2OnT5cvLPIAkrTvC1TH6jVqOL+JAk5eu7l7Io/EEQ1T1ZOwEXMOpX6QLpBRA
	 t5Ui8Ouat3rPp7EGMjjC8JBNZikFX28IOKaDd8sqD3WqCPIhMqTs3KwcZHhLlUz/1SF+Z
	 XyRMryLEPF9i4VgFmrnSUKWzTQHuc4m2yEkUI1CxtmvFLmRW/S+IKT5LSvcHLwgOGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxfvvvdt;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA860A380B
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61DA860A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxfvvvdt
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso181083a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338043; x=1793942843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXakcM7uJiGRXE7zC/KyEFKX2jN6HI+h/+RXq73D/F0=;
        b=oxfvvvdtTuzqOrhwhp/DjanV5YCAg4HV2kvN1GqR65eufBEwj2J14tqC+jTo/0YMup
         DFfuA9TOW8DEr/tKhGPx/ql6MQjfPj2LDePKaH3bROkTyoyeHNrAG2r03r9aZD8HhpND
         RzyoMkLFhKzUe45KMtMAgcmZUYghnb0K5Hi07mJryTgYGCe0jlU2gKsPnYgpDX3bj29E
         vF/j8yisgSWtEbMJdFn4a4VUcB9J4wEhFd4V1N8HAl7Wxhgp5zhOG3ED+7zA3Xyg1djc
         FJKAMHxTcvys92ubFqh+FjtdGA/w4YjRxdoC/fT1OFwPcEi47eIMkcNOlyIy0EcuwLDY
         X7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338043; x=1793942843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXakcM7uJiGRXE7zC/KyEFKX2jN6HI+h/+RXq73D/F0=;
        b=eShauEeZmkWmWXF2qxHAEWLFz4kRBREGIo8F1rpMHc49ZKHrs1bkcUxiN9+Gy4E881
         pkSBF8i97x9iJmZAb44z63JBr35Hrj6TzFhMENip5T1NpHYD96+1xeuV/olG5lmgaQR5
         Eh3vYZ80kql6pGsih9gpjQrVFzamKnl0Gw6aP0hOmY8nruj5lF5xbL/M0bfxODRoExrU
         3deQhyKaH+A/CbSGa4Cdg93KxKsrRlH8ey3cKyu177y8BKxbgnYiG20yGq15QozMqDlp
         2P1tLdg0mIwVj2FgZDZIaj3nG88kMQs9zpCbLuC8f7AjUUxf3nkmRywCDP2riJBzbh+t
         ExrA==
X-Forwarded-Encrypted: i=1; AKwUvBxAHfx+aRkpL0HE7RibvWZCGvlD5W9GZ1n1iVYQHioc9AdQUEuZokZtIRigp7PDJYIcYRe1zArNN48+EzyT4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLONEeh6VaA1qDNWTNygVraiVsYvrmK646K9T3LNEfTHFxk+SKa
	F3fdKQOllZgaQs93GMkx2Gma4yFv6B4FxVeDufgIrt3yhnCE8BahdqFS
X-Gm-Gg: AYBFou2LfNh0ByB4hop1V9cM0Ut2LuCvzTtbOdfLWLdazUV6cuUnZeKfW3/81IRovsN
	PZFyc0uihIEn1odWs2tykBSrPCRaYhYu1e2QEkA8DIABcUT1TwJFGgYSIrb3QkwffGmfgSVNoVE
	HmsnBaEap9/+cgqnfKeKAqHbyWtLvaWgUmQtrW31iZlx6GeUnFkQF7sHaPymKttQ8/0k61xI6Ne
	9Q2ikkphHr0wOchK/85UD6UgPVueXAbfHtW8BCc0rNfa8e0pQSyGgzwYjKyN2iq8odOPrhBx3Ec
	JSxNkIgRRwUmOiQRHG/BmxtY8TU86r1/Hm00Rqvo7BPMCv+A9EBG1SadvSslmPacl+NTBUW2hVQ
	pGVGAweexoOdMYFoHlIcYkbIoeKJ2JFKb44oENfKio29VOcp6QbowMvdB2c3/78RUhycOvTfWpr
	X+wGzNr/CF7BKxQ2UE8W4l7VPSL5dMrYTJHXLgKybivstOPLh6shEUeyiLw/Sz/PWh5KBOwqYEe
	bnrZuiFPaMTEggWDTzDkhFwhHvceoUfHOkGHYGgdo7OXVHOJY8XKuIRUUGj5qNMoD0hq2aBXLjy
	cRbyDUdAIyzfjtVIFKi/8svGTnEcUQFw68k3+GswEOcDVjqtZU/5MvDgVTk9hzJ8/sOxsSZPwDy
	zvJexIjhbNmKMpkXpQSUWtWci8a+MrfhLmcXlySZdSBwNlyA=
X-Received: by 2002:a17:90b:53ce:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3ae89835706mr940154a91.50.1793338042791;
        Thu, 29 Oct 2026 22:27:22 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.27.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:22 -0700 (PDT)
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
Subject: [PATCH v10 14/14] ALSA: virtio: rebase ordinary capture accounting on RESET
Date: Fri, 30 Oct 2026 14:26:29 +0900
Message-ID: <20261030052629.27742-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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

Ordinary capture's indirect positions must follow the common RESET
observation while retaining the device's fixed DMA ring offsets. Select
its reset callback at open alongside the staged capture callback.

Suppress ACK refilling while snd_pcm_lib_reset() observes the pointer.
Refilling from that nested ACK can fail before the common reset returns,
leaving driver accounting partly advanced while the core rebases to zero.
Observe the latest device pointer while paused too, since completions can
advance it after the last ordinary PCM pointer update.

After pointer observation, return discarded RX space and finish the core
rebase. A late refill failure latches XRUN and stops transfers while RESET
returns zero so the core can finish. Preserve that error across late I/O
capture completions. Playback keeps its previous successful-completion
behavior. The notification worker reports capture errors to paused streams
as well.
Do not schedule fresh work while the device is resetting.

With the worker delayed, an initial nonblocking read can return -EAGAIN;
after notification it returns -EPIPE, and paused resume is rejected.
Prepare or reopen is required for recovery. An earlier negative result
retains the existing core completion policy.

Fault tests reproduced nested refilling and loss of the latched error.
A playback XRUN-event and pause/resume check also verified that limiting
the latch to capture preserves playback completion behavior.
Paused pointer tests reproduced a stale reset position. The corrected
paths passed recovery and reopen. Ordinary and staged 70-second RW and
MMAP captures matched the deterministic backend sequence, including
reopen and the intended RESET discard boundary.

Link: https://sashiko.dev/#/patchset/20261029085032.70689-1-mynameisjune111%40gmail.com?part=14
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -75,6 +75,8 @@
  * @release_required: Successful PREPARE still needs a successful RELEASE.
  * @control_uncertain: Native control result requires device reset before reuse.
  * @capture_reset_observing: Reclaim staged samples during RESET pointer capture.
+ * @indirect_reset_observing: Suppress ordinary ACK refill during RESET pointer
+ *                            capture; protected by the PCM stream lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @pause_restart_state: Device-side state for opt-in pause compatibility.
@@ -125,6 +127,7 @@
 	bool release_required;
 	bool control_uncertain;
 	bool capture_reset_observing;
+	bool indirect_reset_observing;
 	bool suspended;
 	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -937,7 +937,9 @@
 
 	msg->length = 0;
 
-	vss->xfer_xrun = false;
+	/* Preserve a latched capture error until prepare recovers it. */
+	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		vss->xfer_xrun = false;
 	vss->msg_count--;
 
 	if (vss->xfer_enabled) {
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -10,6 +10,7 @@
 #include "virtio_card.h"
 
 static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops;
+static const struct snd_pcm_ops virtsnd_pcm_capture_indirect_ops;
 
 bool virtsnd_capture_staging;
 module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
@@ -398,6 +399,9 @@
 		&virtsnd_pcm_capture_staged_ops :
 		&virtsnd_pcm_ops[substream->stream];
 
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE && !vss->capture_staging)
+		substream->ops = &virtsnd_pcm_capture_indirect_ops;
+
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -1701,9 +1705,13 @@
  */
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int rc;
 
+	/* RESET observes the pointer before returning discarded RX space. */
+	if (vss->indirect_reset_observing)
+		return 0;
 	if (!mutex_trylock(&runtime->buffer_mutex))
 		return -EBADFD;
 	rc = virtsnd_pcm_cp_ack_locked(substream);
@@ -1736,6 +1744,77 @@
 			return 0;
 	}
 	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+/*
+ * The PCM lock covers indirect accounting and core completion. Once lib_reset
+ * changes hw_ptr, complete the core rebase even if refilling fails. The latched
+ * XRUN rejects subsequent pointer/ACK operations; the worker publishes XRUN to
+ * paused streams too. RESET success therefore does not imply stream recovery.
+ */
+static int virtsnd_pcm_indirect_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	snd_pcm_uframes_t paused_ptr = 0;
+	bool paused = runtime->state == SNDRV_PCM_STATE_PAUSED;
+	unsigned int hw_ptr;
+	int rc;
+
+	/* Only PCM-locked callbacks access this observation flag. */
+	vss->indirect_reset_observing = true;
+	if (paused) {
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			hw_ptr = vss->hw_ptr;
+		paused_ptr = snd_pcm_indirect_capture_pointer(substream,
+						&vss->pcm_indirect, hw_ptr);
+	}
+	rc = snd_pcm_lib_reset(substream);
+	vss->indirect_reset_observing = false;
+	if (rc)
+		return rc;
+	if (!snd_pcm_running(substream) &&
+	    runtime->state != SNDRV_PCM_STATE_PAUSED)
+		return 0;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	if (!vss->prepared || vss->stopped ||
+	    (paused && paused_ptr == SNDRV_PCM_POS_XRUN)) {
+		virtsnd_pcm_transfer_failed(vss);
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	/* Discard completions observed through the paused device pointer too. */
+	if (runtime->state == SNDRV_PCM_STATE_PAUSED)
+		runtime->status->hw_ptr = paused_ptr;
+
+	transfer.indirect = vss->pcm_indirect;
+	transfer.indirect.sw_ready = 0;
+	/* Consume no application delta while returning discarded RX space. */
+	transfer.indirect.appl_ptr = runtime->control->appl_ptr;
+	rc = snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
+					       virtsnd_pcm_trans_copy);
+	if (!rc)
+		rc = transfer.error;
+	if (rc) {
+		virtsnd_pcm_transfer_failed(vss);
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	/* RESET discards all samples through the observed software pointer. */
+	transfer.indirect.sw_ready = 0;
+	transfer.indirect.appl_ptr = runtime->status->hw_ptr;
+	vss->pcm_indirect = transfer.indirect;
+	return 0;
 }
 
 /* The core holds the stream lock through the matching appl_ptr reset. */
@@ -1835,3 +1914,17 @@
 	.pointer = virtsnd_pcm_cp_pointer,
 	.ack = virtsnd_pcm_cp_ack,
 };
+
+static const struct snd_pcm_ops virtsnd_pcm_capture_indirect_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_indirect_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
