Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263900;
	b=YEzxuCYExMuc/oNc9+sxEkvbhoIFfmpFR5diRce9zk3baPIUe/i5KA9348VFf/ptQn4+
	 y3jVq52tdlaOpvWoS8ZZMExdAu60oj2/ndKMcPvDrwUFFpW5DUVD72KPgkyZj++0ozhie
	 4WcmqL3kkOl4NUcmfCAfuJ1yOzVRqdirMRGpmX37+1V2S7qC+9wDgVJHM1+HYJjxv8x6t
	 vH8deF1AtgXk4stSw1YjmZD9TkW6wQpNk6Ni4JfjJg52xg5NnyryzhzOkQmEgQbzpwRO/
	 Y6q/4ZUVCz91CyvfYbUgSPUPhcfvqhsL7NjkBtvmpL/Lrnx4/hTtxhTN5gzTMUA54Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gu64q4Vrpm6v33wr+KjZ/SbqqwGqHiw0oJu04YH4us4=;
	b=NtmjUrrz++e0/n2NPhKgDpiPrYOtDCHLKONegnMHtCKEoe4Xl1K1rxyaSiQq9eegcO0F
	 cfPOgTjPFziRfD9FU2lrEKCNa18TuUBFpzEWVaW50+0hDSQgoKeCDd5piqICS4B+JEzc1
	 ljBT7zRQdDOmVa6oCpThJU3wMAt8Vs3v19/m37OBf0n88tlSjGagVL/iO8vkICgxv2l+L
	 +aLonTbAoRYOv8v+S6ya6uiNYnca7hta1LQUyzrHkTkAijURQt8w5MQ7nBBxHLiT2P8CV
	 fAKuxgwLmcQqLw3zbKaKbEjri+JMA5TF53laKlXxiG4Cl937l3TCGWZlLs46y/kY1FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="us/j5fwt";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3B60A2605
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C3B60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=us/j5fwt
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d1114320so14195135ad.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263899; x=1793868699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gu64q4Vrpm6v33wr+KjZ/SbqqwGqHiw0oJu04YH4us4=;
        b=us/j5fwtqaSJXRXCgjrtY6ErcU+HNMDHlkdmNihJ+m0CvMJyDh/lPhijBkmi7X6r8Z
         drMsCMRDhTQK7v+DX3OusnjgE7PaAkZZPDxSo3hWZBJuXF41Fd13PFuZPPqwBIl5dl0k
         7OOLyZFYnLst7vE2QAPz90EK3pt1hiJrCgLJUrSs3lEfx5ePhjF+CmVEW5Z4z6C1LD5h
         XYF2P71xMdXLV5f70Kr3UcLQ7CIxvB/awktHQPc90r0Iks47TlVwTrZw7F2lmXiKyvor
         76GZF0OK5e9mNKVUwGfDAXxTOwPELeR8sdlxRef7xEOSCZ0hIzkQO5GwmeCBj/ew8T+9
         oN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263899; x=1793868699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gu64q4Vrpm6v33wr+KjZ/SbqqwGqHiw0oJu04YH4us4=;
        b=srszd79zkvLJxtKhJW+eg5nAUBzpZHJ5KkoW7wrXsnxLyboeOZ1aAO4IS/vmhn4dFh
         DPjs3EMnTmUjxde5YvYUx7nFoPY6y/zU7AhORGIlSWu8gyBX6/znHc01VDmbJf19rrMM
         iKkkvKHo/hrP/fYly6ulUc+1xCW8DWPVVxJ+tz7bxrEkZfr8rz/OlvI4uQLRbAvtvNKW
         oXi86f4io1OhD0vTjqoAp/C54uPjp81UYV3de54kdNU1gmRA9h411Szi3FNc5BVDugbi
         Ue0SGpDCpoQ9fyhA5Hg3lJDNd0RD4nX9vnQa7E16eXgRq2qOlLmPDWOzYvRbHi3NyMP0
         bloQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7i+WId01IRKhHtPwNKTY1JKZdA9qy+X0PEtKe9CbtcnzkLMTY79tEFKXG67hSKoW0RmkTGTGULi+YlYNxXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYL57E29oAZ5XGToLHRlRnoJ1cWpGBW9bXM3nNq01ib/BsaGdgD0
	ttNf8wTBWywGm4UGokyubxJJmsIfoCQ4hxyGdxIV0wYWUBb+BoWJIb+V
X-Gm-Gg: AYBFou3QXF4v0X37rM9plyVbObNwswYKz5J1xgTTet92PnPOMVZCph6WckLlRKjUyPX
	Gsdl49bXz1rycnQkn4HMmbNBaTNXDHN4h43tH1cAIxFpLr0OFS2xxvfCB94BZYvlAfoickNqvtZ
	vU68qfttPDKFRdehqE35vK2SVXb0vRYV3l03QEnKIWH3dTVPdzPfM4G4fQ/KWW8J2Rpw855StWR
	ycuGED1WObzDpIXBBtX538qjzInjpb/TrGk4/jVTdnqs/z8NqnoEF5ERWnd9zncv1TR1WWDXq1x
	Bzx9XLbGuUBj7cXh8qJKhzan5SGRF066+UwgzjobN6dZVImYUMnW1ItmHRXcLpW4CwlxEXSoC4W
	zTWWmA5nEWaz7bOh1jdFiVbdJEAfYAl/85q+/Qrx0YVOqc1pPL3MVBE/Ir6S3P5oLxKd1KGyH9l
	2DpPAD1h6eFOOr/gzi4buuN/GYTcJq4q+F6+XtSv8yXDc7xxWLSjt9jI4CERZ+6uT4TuPGeqjsH
	H2A2oOugahYG7203j5d143yKRm2k8vqjwat4bqWhqUTL5XEmryZYRxUHcXaVWqOBFXulP6OGu4i
	xcHX3MaeHp8UG7j6gVslCbnFAvWn6WLP2a7+RFlG2pp3AvJesIYyjZoUI3rqdHoVwBVT0L/Q/vm
	9qEsf/BTOBqWzX4ivk/97kdhzYtu+T+NxO3sctYk+Kw==
X-Received: by 2002:a17:902:e80b:b0:2e9:5829:9b41 with SMTP id d9443c01a7336-2eb0041f925mr46273925ad.37.1793263899253;
        Thu, 29 Oct 2026 01:51:39 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:37 -0700 (PDT)
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
Subject: [PATCH v9 13/14] ALSA: virtio: synchronize staged capture accounting during RESET
Date: Thu, 29 Oct 2026 17:50:31 +0900
Message-ID: <20261029085032.70689-14-mynameisjune111@gmail.com>
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

Use the locked PCM reset operation for staged capture. Reclaim RX space
at the same locked pointer observation used by the common reset and keep
completions arriving after that observation. Rebase the notified-period
counter there to avoid replaying old period notifications.

After common pointer mutation, finish the matching core rebase even if
refill fails. Latch XRUN and schedule notification. RESET can return zero
before the asynchronous error is visible; userspace still needs ordinary
XRUN recovery. A nonblocking read can initially return -EAGAIN and later
-EPIPE. This avoids leaving core and driver positions partly rebased.

A forced 90 ms RX interval reproduced -EPIPE with the earlier accounting.
The corrected sequence matched the next 48,000 deterministic frames and
passed reopen. Linked RESET and prepare partial-failure fixtures also
passed with atomic and nonatomic stream locking.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -9,6 +9,7 @@
 
 #include "virtio_card.h"
 
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops;
 
 bool virtsnd_capture_staging;
 module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
@@ -392,6 +393,10 @@
 		}
 	}
 
+	/* Keep RESET operation selection fixed for the opened runtime. */
+	substream->ops = vss->capture_staging ?
+		&virtsnd_pcm_capture_staged_ops :
+		&virtsnd_pcm_ops[substream->stream];
 
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
@@ -1686,6 +1691,61 @@
 			return 0;
 	}
 	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+/* The core holds the stream lock through the matching appl_ptr reset. */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	size_t position;
+	size_t period;
+	int rc;
+
+	/* Reclaim RX space atomically with the pointer observation. */
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = false;
+	if (rc || !vss->capture_staging)
+		return rc;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	/* The common reset has already handled a pointer-reported XRUN. */
+	if (vss->xfer_xrun)
+		return 0;
+	if (snd_pcm_running(substream)) {
+		/* Keep completions arriving after the core's pointer observation. */
+		vss->capture_acked_total = vss->capture_pointer_seen_total;
+		vss->capture_ready = vss->capture_free_running ? 0 :
+			vss->capture_copied_total - vss->capture_acked_total;
+	} else {
+		position = frames_to_bytes(runtime, runtime->status->hw_ptr);
+		vss->hw_ptr = position;
+		period = snd_pcm_lib_period_bytes(substream);
+		vss->capture_copied_total = position;
+		vss->capture_acked_total = position;
+		vss->capture_pointer_seen_total = position;
+		vss->capture_ready = 0;
+		vss->capture_notified_periods = period ? position / period : 0;
+	}
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	if (snd_pcm_running(substream) && vss->xfer_enabled && vss->prepared) {
+		rc = virtsnd_pcm_capture_send(vss);
+		if (rc) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		}
+	}
+	/* Complete the matching core pointer rebase before reporting XRUN. */
+	return 0;
 }
 
 /* PCM substream operators map. */
@@ -1715,3 +1775,18 @@
 		.ack = virtsnd_pcm_cp_ack,
 	},
 };
+
+/* Selected at open; the staging policy remains fixed for that runtime. */
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
