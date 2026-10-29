Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263906;
	b=CjOhG/L+aly0l/H9EadMkdbtUdijAJRH1HG601l1fbWolMsGtBI4WYcddlMgAAiG7QZW
	 YAt2YWfgAHXdvzEj0KAMNLbps7ud+uiAfxBrXeUBlWcK1cyHZiODRnbGKvirkjHfBmkgL
	 KqT/BBQ4+d+UKgFkyerGzzRH43TgfUbUw3geQNTYH+2w2mEs01bDmlGTq3s/4zeabK9tk
	 uw3xnOK7ffDFJ6r4xZ/R/eAzG3VoNthtd/uRibrppmq2EqJpDqByg9kAkeu5xwCjtaGhD
	 GmUjhcEd+fDr0kdoqCb0KhB7djII+93uH/kboPzLHUZDHldGO0v8XfqXOJVnFIpHQrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qJtB5Nvv2DaUdrJ0GdmD6/1pS/UrSmPqffjERrQCjsg=;
	b=Hnw1oBePr2vDy3RpuqxwGj/3oNhPDfItiaypusUGNjECCjMXSv0Ap3VKxZesRZYZ/oah
	 mWSUMOc6/PaqmbWfHFzQLEHtAVm/OI4zM1xX2vPOHG/vBc3bvjbXFj2pSZyraZrSwPfMq
	 nMuNdG3RfBRK2SvnJXJAfM2hzMGLtnUDsmYJTODG44IUGKhAc1MkUYU2N+Jhs3OK3E/yq
	 nw5z+Uu7rP/TpTkzAXqJ/LxGwsv5B01AAzJkJMG5oF961KVUTdN3mZ1zvm49elTvxBlDk
	 g4vt/go6Oh0zlypsYcXu1bXbDfZBWr4gk317eqOMv1uu7CPl4zhDNrTcjevXfaAQ5bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vp/2ch4W";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F9606A32D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC4F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vp/2ch4W
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e946155442so14850285ad.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263905; x=1793868705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJtB5Nvv2DaUdrJ0GdmD6/1pS/UrSmPqffjERrQCjsg=;
        b=vp/2ch4WjwUJsy27m+C/vFe/W92+36sSOKtAw7fL0472fCOAURDPUbteSm+NqorhhX
         rnG2gapNwIYfcaNrrUg3TNPztXzzm/QrgrsEdjkpjX076zfTTLhh+85Crd6WRl90A3VG
         3lkYIkD2J0grJvwS09xCLhM6D99dWclm/Anf233/MLXYD9RppqvDU2iLRM5pEoA8yJxy
         +iJYEon3SlI51iHAOIbDChWUeWG8lwtXiFP0UOgPjYGghP6gfF2VI8jaJSEx2ER/lroq
         4Fgz3Mjmfnp5TScHTqOaHYhGV7N3jqEMIAj/zbl8gxJIUIThT1I8iwb8xPbwHDgbeuFK
         ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263905; x=1793868705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJtB5Nvv2DaUdrJ0GdmD6/1pS/UrSmPqffjERrQCjsg=;
        b=kmEz4nsLzDzNF8LgBUY2NlYGJgb7HkiaX1VfGl6N7PJyZGx9fO+uTlNLQY/TBpIYNi
         moRd2n8B+yRuf6UrwEKK775PUtEtLY+IjCrGjP5eOFrKW1TJE10pFPq34D5ajakn6fSl
         yYPekuUi+IVyMVd+STqcJSKdI+n+KMUe9vVyPOHT2Bj1miryRHbRKEv7rSOAhuFO18yy
         +SDXetcugoR9YJMB6MuXPDoGCy09s9zPpFv+NuiwDEWflM93zo0SoJYfbOSG8bZs5d3N
         TXhFZr7GlhTV/AEFezeXxwb/79zBNcm6a4+dwdZgDuqkyoI0yjuBfax2DnMtzT4LZhBX
         dNDg==
X-Forwarded-Encrypted: i=1; AKwUvBz1VuHWyp6V0hpjmQjMvMCgyzc96AhTgtIuBCUWivvkZZgRUTNQ7h2SAylQCu9BT4zEiMOyklr4Vry2BFHKbw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI2T3Gnb/anC/3PzqsENlNV0IkKsRrdTVjHwnJ1zSRUvHIMyG1e
	CAhvflJNNyi+X9p+7MRTj8ESTAdZXQvSCALuqE8TBK3jAR68jzvbYHDR
X-Gm-Gg: AYBFou1J4e7UQp8oCkaC+dM4ElSu3lyxs4LS+oBan0kKT53NHMzXoVhl5d6mob1uBbT
	plu8MCcIspgaQzez7qwHZ6G4z0m4WDBx+l9SzuX5QeObYZRJoR8BYitVAvFhpEykP1+gYaX9UvS
	OYBHl7Z6LTmDpPu9m8DQK4J8vTl9BHAAC2evHHACi3DDJkL6Em1pjd71iQtrCylgeHi3yUAqLgO
	pVdViBJw76oORdm9bzo8PNDEC+AzPzUDnHnpQkZKs3Ld653x0LkQeg6P12BM8FZ9jap+LBs7KaD
	gp1Nx66xz4LUWcf1ZnkzPFP+4pL3SKmYBNTNVIWDfOMbprQIqi81Oo4JbOnWP5yQ5jqo2rYBCpK
	bPBpgU1Q5PIco7JON0Hrd00JSgEVTPq505EdRjPaPfDrYVrleAyA2C1SY4KZpD84oP6gxtsGF4l
	xNLIjPTjUn6CZQKFwejA4C0o4eEIlkUxfUN1sHFapRV7BRLFdJ7mezRxNfWx3/aVEpdNPf/z8ko
	/hIXT8NftClcDqgAc0qLMrLLbw9MGJomPN13W1Ha+pZZStc9sxDlmq72A9fp+oSnXFn9EOf72Ku
	ZUEPTxrkZ48CgoHybG1AVMJpTANVCpdOeR03NmGbW/E7amRSHGZN+jefpYI6OXKd4rBG7np/AQA
	eVcU1fff+3BW+3dIESB4XKsY2UUnB+Li+nQ6PyQ/iyQ==
X-Received: by 2002:a17:903:b07:b0:2e9:66c4:1717 with SMTP id d9443c01a7336-2eb005b2f5cmr44424035ad.61.1793263904985;
        Thu, 29 Oct 2026 01:51:44 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:43 -0700 (PDT)
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
Subject: [PATCH v9 14/14] ALSA: virtio: rebase ordinary capture accounting on RESET
Date: Thu, 29 Oct 2026 17:50:32 +0900
Message-ID: <20261029085032.70689-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085032.70689-1-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
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

Keep ordinary capture's indirect accounting in step with the core RESET
positions while retaining device ring offsets. Select the operation for
ordinary capture at open and preserve the staged capture operation.

A refill failure after the common pointer mutation must allow the core
to finish its matching rebase. Latch XRUN, stop further transfers, and
report it asynchronously, including when the stream is paused. Returning
an immediate refill error here used to skip core completion and leave
inconsistent positions.

RESET therefore returns zero for this late failure, with subsequent I/O
reporting the error. With the worker held, the first nonblocking read can
return -EAGAIN; later reads return -EPIPE, and paused resume is rejected.
Prepare or reopen is required for recovery. An earlier error returned
before pointer mutation still follows the normal negative-return path.

RUNNING and PAUSED, managed and free-running refill-failure tests passed,
including delayed workers, 48,000-frame recovery and reopen. Deterministic
MMAP capture tests cover position continuity around RESET.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
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
 
@@ -1691,6 +1695,62 @@
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
+	int rc;
+
+	rc = snd_pcm_lib_reset(substream);
+	if (rc)
+		return rc;
+	if (!snd_pcm_running(substream) &&
+	    runtime->state != SNDRV_PCM_STATE_PAUSED)
+		return 0;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting || !vss->prepared || vss->stopped) {
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	/* Pausing does not move the device's fixed DMA buffer positions. */
+	if (runtime->state == SNDRV_PCM_STATE_PAUSED)
+		runtime->status->hw_ptr =
+			bytes_to_frames(runtime, vss->pcm_indirect.sw_io);
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
@@ -1790,3 +1850,17 @@
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
