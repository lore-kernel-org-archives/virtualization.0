Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252696;
	b=S4n39Sf0IiGhcfe0klVexmylAHZC+a5iLz5W68G5pvLOFEp6DSlBq+aq02szwiLKdyJa
	 tb9sL3BxrN1iALzXp2CHVubqJn8W7dsIzjbjYwnK5PSJl4A54hg2XYBynTclRX7f/2Jgs
	 M/OhxpwUpMDQkQtt5vT8+R6at/QFE/lb2KTJ5+57Huf13XU3Jwyv0pISNbajCfVMOJ8AK
	 r4ywl1+3MIh1m4sVxZgfxEc1iQbkyBVSAZEHEjXU0XergcKCXICKY88y1ZYCmK9YykHvC
	 V1GsEbfNYNnZK9WUY/vZshDffn6lE438wWn3Ig04zFtsIIvfn3zrXP0bfp2Zo+Hh95g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rn33wo8VGHhjpHEwoQH/m2TS1FP3dM6s2FcxZAOqUUo=;
	b=RhkhyGfQAYcz18FmLziHnEaFPm5yKkvna/nkAOYpn2vijf5z5OWDETQ6oZv9OZLeE578
	 fz8zHFqeoHGft7ODGOtOWO+esfGjm4ZNGlWgpjxmnwP2WWm9P91k94HKdcUzokNLG4/Yv
	 HEpgLEmK48R7jkbXBfe9wvD2FPPUnljUkze7k/1h2v4TvOdTZnroFMKqxiIK6oyLZscTZ
	 z9YwuPT34ULLsCmkG7PcgDSIHcEjcyMvCXS/Gh4scBj3eiBOWLAKQi5P4nPlxStihS92d
	 v4Df3bMHt5/bvIbtsdAV/1L0aPSA7Ifo8ewDHvXDZdh0lLVoNhNIXsdyh8GazE2BAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yI8Ex7Hx;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC6606A321
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEC6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yI8Ex7Hx
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea759cc9b6so7205565ad.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252695; x=1793857495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rn33wo8VGHhjpHEwoQH/m2TS1FP3dM6s2FcxZAOqUUo=;
        b=yI8Ex7HxqiqquRwwvfo7JOA0Ei9KrcxjiYP/6tTe7iYPuyF7slGtE8SVfSkXg69Bdn
         xg2jUuCWd5FuGiP7tjMNnK9xiKhiSDaVS7f7e0R0ECXOMCdLWLcaCmm9mOxoYXKUf3kZ
         qq5lcq83r2r3etzDxSOgQZj2y0HuxVr6+R7vWCO7DahV9WeZohl7VIyNkKjGcEtsBcq+
         Ia13MMxxb1UiqFHCmkjhNw4KrRypSM9TOd5K42oa6xcRDUTHeZ6Jhs5t90xcFCTV9pO0
         AGBxWRY9Tlmj7rIcPx57opkC7f6Wy5/RGJh3Kud+225eYmlO3UVkRAu4VzcfEW60miJO
         nPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252695; x=1793857495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rn33wo8VGHhjpHEwoQH/m2TS1FP3dM6s2FcxZAOqUUo=;
        b=J9Ifcftmr2p0En86zOfLHDSzgoApjdPzGVWjuW/yJFPCo9KD4wORf/BdIrX3Fr50dJ
         lxjqgEOevXZ5mdXNFsvoLgHp2/c3oIotjjS2AQiWAjdWdqOj1sb4WCZiJ5MUfzcd+oJE
         nW1W1sGJGFQT4c/JYkquTqgdLH8W/zmslRan+PHlOTEm21KwkJNodpLHfituH49fqdzo
         8T6/Gp1LliT9sHw2z7ymSY1dXN11cqxOTPyZu5erjl9xdnGVRz3EeETlgyhScJhTZR5v
         lgSDNL5oAjSYOmKIE9+9ijyptQS/3o8SR2uW246fEK2KKUB30Ys7COn11Ucv9N/t5wlz
         RhXg==
X-Forwarded-Encrypted: i=1; AKwUvBxLMnUw6U35QsFQjIv5mo6/oLWfJ2SW5PmFj4NR+Mwbv5za79auIJMPhAk0n00HLa+iO0d2A/jlqe8xvoUcmw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKL/VmX5WiHnp5spvmTgfRtCO69bPjr1mSCYmMmrczGLDWe5q7x
	M6QWrCJLxhP5Kb7YF5hay+DjbX8G67+3LaYOjbQboW9n8AxPNw9iuUgS
X-Gm-Gg: AYBFou07votkzAHTSI3tidCx4OUYfCr4Dm2y77fuvt13bXOo8ZQ6LRE/Po3ZsTuEPwB
	hYUNIwbmh8VOJ8cuV3AE+RUcbBT7rg8omlaeApXTeWzt6VH8IsQHtXbUjWTNLZEgbkh02bqPP2I
	C6uS1yPyFTji4Y8/NuPQ8/cQpaWb4o9pxbJOeCy2bOUiOEOklLO3egi9rdVZU0n3ty7Hzqk+knF
	i88DB3bjV0vt+86wzxCxZdPJlgpAgycRMK3Uy8t7xF3GfW1KsLNbJKn5z1ge2hCTVMkKNgWBMO2
	e5G6On3WbOfx+4kHzw5HW2Nb7Pf92+4fOZihAxZ8ySruPekZ71/20y3VzKIgNUJfrscApRJbKVe
	UGyZEIKpvZRMF6/JGEXx+XIraJSyHN2Ej2j3/tnoPChy1pNc6JdpxW75YYKUnOYA5Ao4/lU8c13
	wFIq+hM6sI5RVK+mLqeD1rTvmGsSWOAlrhXyeu0I84MFpW/lHMqVcaTRjxt+00sLWEePtINXlXP
	d7PQCHCikv++tC6y8PRNHmX5js4BbxbWHMn3ewO4NzF+1qx9/zVdJMlJuXCxgu+OYCiPQbFURQL
	e5yE8qumseK8xraOMLbzSID//+k7SgdfBPjVDyriT/8m2yR/45nPivaO4w0UDlZMKO7B3oOxiy9
	YaDoIt4Bzj0gwy++NFGGC66n1y8eQ9x4zA84s+masVRkMq4g=
X-Received: by 2002:a17:90a:e7d2:b0:3ad:fb12:9bf5 with SMTP id 98e67ed59e1d1-3ae583152ffmr3612053a91.62.1793252695309;
        Wed, 28 Oct 2026 22:44:55 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:54 -0700 (PDT)
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
Subject: [PATCH v8 14/14] ALSA: virtio: synchronize indirect capture positions on reset
Date: Thu, 29 Oct 2026 14:43:54 +0900
Message-ID: <20261029054354.2931-15-mynameisjune111@gmail.com>
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

RESET rebases the PCM application position without updating the indirect
capture accounting. The next ACK can interpret that change as a backward
application move and return -EPIPE. In a QEMU reproduction, the PCM
application position changed from 24000 to 2880 frames while the private
position stayed at 24000. Both running and paused capture failed with
free-running and buffer-sized stop thresholds.

Use a separate reset operation for indirect capture. The PCM stream lock
covers the common pointer reset, private accounting and core completion.
Discard the observed unread data and return its buffer space to RX. Keep
the hardware and software ring offsets so in-flight completions continue
at their existing DMA positions. Set the private application position to
the position core will publish on completion.

A paused device retains its fixed DMA positions. Keep the observed
software ring position as the reset position in this state, instead of
making userspace read from offset zero while the device continues at a
different offset. Completions after the observation are retained.

If returning RX space fails, stop further transfers and return the
error. The caller must drop and prepare or reopen the stream after this
partial failure. The existing staged reset operation and playback are
unchanged.

This patch depends on the proposed PCM reset operation and helper in
patch 1. The series diff applies after patch 2 because both touch the
operation tables. The indirect reset implementation also applies on top
of patch 1 alone; an alternate local diff is supplied for that order.
The reproduction uses the pending virtio-snd stack with local follow-up
corrections described in the cover letter.

The earlier RW capture tests covered running and paused RESET, both stop
thresholds, a 240 ms read backlog, refill-error recovery and reopen. The
core-only plus indirect variant also passed the four RW reset cases.

Additional direct MMAP_INTERLEAVED tests used 48 kHz mono S16_LE in
ARM64 QEMU. The pre-fix running and paused cases failed after RESET with
ACK -EPIPE. All 13 fixed runs passed, including two 1-vCPU 70-second
captures, refill -ENOSPC injection, managed overrun recovery and reopen.
All 9,072,000 captured frames matched the deterministic source at their
expected positions. RESET discards observed unread data; verification
starts at the resulting position. Recovery and reopen checks start at
the device's new START position.

KASAN and lockdep reported no errors. These MMAP runs used the combined
local stack with staging disabled. Physical VZ/MOTU, other MMAP layouts,
multi-channel input and concurrent RESET between mmap_begin and
mmap_commit remain untested for this candidate.

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
@@ -389,10 +390,13 @@
 		}
 	}
 
-	/* Keep the legacy RESET completion policy outside staged capture. */
+	/* Keep RESET operation selection fixed for the opened runtime. */
 	substream->ops = vss->capture_staging ?
 		&virtsnd_pcm_capture_staged_ops :
 		&virtsnd_pcm_ops[substream->stream];
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE && !vss->capture_staging)
+		substream->ops = &virtsnd_pcm_capture_indirect_ops;
 
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
@@ -1596,6 +1600,54 @@
 			return 0;
 	}
 	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+/* The PCM lock covers both indirect accounting and core completion. */
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
+	if (vss->resetting)
+		return -ECANCELED;
+	if (!vss->prepared || vss->stopped)
+		return -EBADFD;
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
+		return rc;
+	}
+
+	/* RESET discards all samples through the observed software pointer. */
+	transfer.indirect.sw_ready = 0;
+	transfer.indirect.appl_ptr = runtime->status->hw_ptr;
+	vss->pcm_indirect = transfer.indirect;
+	return 0;
 }
 
 /* The core holds the stream lock through the matching appl_ptr reset. */
@@ -1691,3 +1743,17 @@
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
