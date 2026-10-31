Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412585;
	b=AE1PnIqxtrLBQYm2ZxJTPov0nRJcwE849AwctUSDWh27bv19PahDGrQEoDjo8QZoDIwk
	 Tjso/8YCNxECf2921bx2BKYumVWNKxPfSaHwr9ir/wK2w1CyHsLyoPA6MpX2U7hBaPi9S
	 ZD8D9yDEdSWsqQPRKWfWsubLmpFm7OfdBRK5usNKKCE/DPLZnwzbM6ZwVpHbJ8m54CEs1
	 2jl8Sc8JsmhAlaQ2QGeUk7B/1TmkLwVgiRwSINuUn8GsCQaXvXxmeW1P5vYzvwbSXDcqS
	 WYd9CVLMAZlyoafE0uqYk81dvMLmDDZVRPM3R+DTlTq7Qzo+MJl2N96G3NeE5CJ/fdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bhNDjqO9TvYmvioIqiGGiLqz7fELlYmLdRUXFsLMln0=;
	b=K2mj+AJ94665o31uDYDBV0urlKOirkdggzZ7jkPYKB6reyX2UFjjPvSHJD4CM8MQb87X
	 ASUDkvebjs9e1RP2uqQqaUUD5lhhASvL9Z2UaBk5pG2f83jn56RVWENFTsP3qWw0zLzaq
	 LyfdsVn7pKllkDx6hU1FYjPHtAQQGryxyREKWkHd4eVQ8P1n8q+GPltzgMrAkxI6tSow7
	 x9TtEe4TjYqdFR7eR/jS6aoacQilGVRaeg8MRCv3Qtwd/+eki/scCm9qois5x2bymmzgZ
	 E0pd3AjkEmPWHqfMRwVnAIV5TkbLx2LC7yHJrhdfDd8empPgHezBMe54hHAAUO8lwMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/qXBc+d";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF155606A339
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF155606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/qXBc+d
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-369f3e9e431so1073694eec.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412584; x=1794017384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhNDjqO9TvYmvioIqiGGiLqz7fELlYmLdRUXFsLMln0=;
        b=l/qXBc+dQFcU1i1HB23N0NnuIzOple3GnWP8wBYQfm5n72/5O6SJuD9p+8nK3+pTpV
         A3SidB+zULbshlSd1S4ENYfBCjnlMUpWdkHFIHN/p3RVdR4ITlcoRGiD+SbILrtt9/Io
         Cux7QXDWnqkwFxrkNu+mcir58XdDPUhHSlrj6MQa+VLQwYnwidZfV6wwFjlXae64bPx1
         0rxmEgqE3W5v2LL8laTLtZmHWMCuEv6nGTbeVaPdtJRaueIBh+VqFMe+uOBHrwwYSEvw
         e46S+LiDFN52PfWK5CteLHWUF+DqxjgMFipw1FUNvkFFbxY8PlNfx7Dg/Td5Lj0uLRu1
         KHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412584; x=1794017384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhNDjqO9TvYmvioIqiGGiLqz7fELlYmLdRUXFsLMln0=;
        b=SQhOhieLeD8pe2+G+PZUWy+rtnWl5nPoWLEqV9eaAO7CKjY68N1V6VGk/EGyx6U5QE
         GY9ZD3p8ctoTszGM4eElV6ejVuqZeVQfu7mmwJeq0sR6bWdOweF1DP1+M1/CZYcNlX+S
         Lf6cZMseNDIloNudvPoSycq7TzatS2WD3j5bChOg2SXb/kwXHZSLpUdY+IgG5xE++3qK
         3XbmZfoLXptVMfRqe7N1m7A5MzK1BxOvA8MchZhmb6ajZbhVwGC6ZEOX7ApPk9TKn4la
         eZuqIWJai7FI56zYenwE4TYD0LUBOs3/3TZgANAZR7p9mDRXTxYIoc8brpS3Yh9sumWn
         2BGQ==
X-Forwarded-Encrypted: i=1; AKwUvByPPEYcfpbmDQUsYQfr9ezWqgnA5+xSujFMQomr7q+qLgZSReY0asIr576MLxFaixG5AkoG140hvOP/AinVyw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJxZuk/VhYOGsTwiPoBrLFlbyWeZZ//1WGYO96/MfG4By1fYDnu
	Y1TVFTIec7EExEXK5v9B0OxzwNhE4DE7vvkZ0iRzpt9sl0mTDjWGG42s
X-Gm-Gg: AYBFou39H5CWoDdgD9xv0ZroAW6ImVxr7rHU2WBWv0TQHJbl0dXxzf9bQipv43U2viO
	bXPV8zF2U0TO2m767orBExGiVULb+tRMIU9DsxVd34jofh+BFH0oopk1vcjDfXg89N1NFclmT1h
	Wj9JE8EBLfu3q6Mn7CKlCqvIQ2WppMzjDdinyj45qrqScdI2d/08KCAVsx2EPyhmE3wDmbyPESx
	ATRaVc5JAvjGlUzZ2vXPt17ZzvrdZtV7sU3zx/C71+dbxGeMhUcWKC7AivhCbG+06Mudb+vys0n
	hjt+6MXUzrZxJHQ30LjWm9AhVNlLvI/5SE8oZYg9rb5aqFTgMF845Ed686uQpi6CWR99wD9CjRA
	2NHFRO4AjZR8IxkhEnfKNhpX7+jFrlnkx3y/eMt/KuQauARGTzpvubWPFJTGpU6jVcvUeD1aTvS
	0Y0GL3KFlXvgeYJKGVCTO4t8suXVTInAQihSxHY4HCMqlnYEI5pwYrl/CIpDvQNYIyOoxmw8HbK
	DykaccuO8/sDpf1L3b2nLEPtKv1NtxsqWjUz4FU1EC+pnvc3ilq0FNNm140TdSv4IOJcrPiALDS
	gCsYgSMxCgWMrkitChEPHSBPxn3FqXIUF96hDqYiKfGQ63u54Uf2YIEHwV17JL2vt3KCZMXHCow
	BgOcZgA+GN6868xzCXFPmggfsO58NyNpH0V2dEVEejv/46A==
X-Received: by 2002:a05:693c:4088:b0:36a:2f6c:490e with SMTP id 5a478bee46e88-36a30009ecemr10595948eec.6.1793412583676;
        Fri, 30 Oct 2026 19:09:43 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:43 -0700 (PDT)
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
Subject: [PATCH v11 14/14] ALSA: virtio: rebase ordinary capture accounting on RESET
Date: Sat, 31 Oct 2026 11:08:55 +0900
Message-ID: <20261031020855.2402-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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
observation while preserving the device's fixed DMA ring offsets. Select
its reset callback at open alongside the staged capture callback.

Suppress nested ACK refills during snd_pcm_lib_reset(). For paused
capture, hold the RX queue and substream locks while checking lifecycle
state and observing the latest completed position. Update a local copy
of the indirect state, return discarded RX space, and commit on success.
This also keeps the observation boundary consistent with a late RX
completion. Data arriving after the committed observation remains unread.

Honor an existing XRUN before changing private paused accounting or
refilling descriptors. On a refill failure, retain the error and complete
the core rebase; the worker then reports XRUN. RESET can return zero while
the error notification is pending. Prepare or reopen recovers the stream.
Device reset suppresses fresh notifications until a usable queue exists.

Set the ordinary notification floor to the RESET observation so queued
work cannot report a discarded period as new progress. Native resume
preserves the RX ring ownership established by the earlier patches.

Fault tests covered late completions, existing XRUN, nested refill and
refill failures with recovery and reopen. Ordinary and staged 70-second
RW and MMAP captures matched the deterministic sequence, including
PAUSE, RESET, resume and the intended discard boundary. The paused
interleaving test verifies the atomic observation boundary; it does not
establish sample loss in the original implementation.

Link: https://sashiko.dev/#/patchset/20261030052629.27742-1-mynameisjune111%40gmail.com?part=14
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -76,6 +76,8 @@
  * @release_required: Successful PREPARE still needs a successful RELEASE.
  * @control_uncertain: Native control result requires device reset before reuse.
  * @capture_reset_observing: Reclaim staged samples during RESET pointer capture.
+ * @indirect_reset_observing: Suppress ordinary ACK refill during RESET pointer
+ *                            capture; protected by the PCM stream lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @pause_restart_state: Device-side state for opt-in pause compatibility.
@@ -127,6 +129,7 @@
 	bool release_required;
 	bool control_uncertain;
 	bool capture_reset_observing;
+	bool indirect_reset_observing;
 	bool suspended;
 	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
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
 
@@ -1724,9 +1728,13 @@
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
@@ -1759,6 +1767,89 @@
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
+	int rc;
+
+	/* Only PCM-locked callbacks access this observation flag. */
+	vss->indirect_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	vss->indirect_reset_observing = false;
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	if (vss->xfer_xrun) {
+		virtsnd_pcm_transfer_failed(vss);
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+	if (!snd_pcm_running(substream) && !paused)
+		return 0;
+	if (!vss->prepared || vss->stopped) {
+		virtsnd_pcm_transfer_failed(vss);
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	transfer.indirect = vss->pcm_indirect;
+	if (paused) {
+		/* Observe and reclaim paused completions in one queue transaction. */
+		vss->capture_pointer_seen_total = vss->capture_copied_total;
+		vss->indirect_reset_observing = true;
+		paused_ptr = snd_pcm_indirect_capture_pointer(substream,
+							      &transfer.indirect, vss->hw_ptr);
+		vss->indirect_reset_observing = false;
+		if (paused_ptr == SNDRV_PCM_POS_XRUN) {
+			virtsnd_pcm_transfer_failed(vss);
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return 0;
+		}
+		runtime->status->hw_ptr = paused_ptr;
+	}
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
+	{
+		size_t period = snd_pcm_lib_period_bytes(substream);
+
+		vss->capture_notified_periods = period ?
+			div64_ul(vss->capture_pointer_seen_total, period) : 0;
+	}
+	return 0;
 }
 
 /* The core holds the stream lock through the matching appl_ptr reset. */
@@ -1858,3 +1949,17 @@
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
