Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444442;
	b=OrawtjwL4mBoR+gUEYgKqwkTmFl4sub4eO67HtRvJozPtjMDR2YLBFXEPleoK1Nl+943
	 RTq6IfW4/gUHGDCLYFPnhzLNstfbWF9EbIk4BqJuFQ3gWPfiQXPpAgC9tFgvCrbXdbcdB
	 u38ELJyigTgl0BoIT2bs1shC8WJoq+cIkY0ZNYG+BgTD5la85o5BAFbm454taU1lMcnq5
	 Vjl3SOt1MrhbEVgfF5nfCULSEoO0xICPSzOOLeGzKkXaqNP5KdlN6HlI+YpsKmavYMRGP
	 gwcgIXd2Ibxsanku/AMcALpBB7M5I1yJHEaG2qytg5GIr2I5nUwd3i2Kn91bzfrajnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=e4cZrIqp4dCfn4a9NWtO8j/KbJ6ITWn4vzRxOFlblqDGItb92h3fUmEj7jEUt5Mmzkou
	 lkaVs+nl8v5SCMZ7L/TSbZe26tIJ4owhtGZIPS/+iK8d6k0xiXzRR36ij256XTtyeK4IB
	 joVMs999GO9bMzmB9J6HpnYyR8FPvpH/Bcf44GNizNCCYZuB2OrNzpaDMDpAnXA0k6ThV
	 FCBWoWK4fy1SAlbMa+fxBBAEW0Hv+yHY2eGU8VxkGQp77iDQ5+uvBDidT3YG4NAoVkK56
	 ESXY8oKCW7r6RuHSV5LMLdq9KASvUEPzL+tOfy7G3M22U2PLjBJG1Nepvtp4xw6mT5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqmB9iWK;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98660A380B
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A98660A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqmB9iWK
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so5008391c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444441; x=1795049241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=YqmB9iWK/hoAmPPHfAlhY5wyzdZ+IBqdCrdNLjteNE79sKZC3eycTMLZGV/B7CeqDm
         YN+XNkOdUmSqpr5E+MndSPPziNWD1/w2TURXYmo8OtUWFXtvhYXHw1pQYkuRxR8sS2g6
         vDSU1A78NsTKkzm4WYXWnXBKFyLL3JP4fc97jFx/60ioi903AaJAjBh3/SMZR4S0MHJs
         K10EF4hHriqbmCoLxoOX3ZTr1Nt6gAqksGB8xEYNuW6SDUsW6syIczo+sQnG9nzXlp66
         ZoltbJ0qSE5qcBygfT3Mn/Tqz9sR8H4sonUHa9mSgtpaC28q7PkYbSvOUEZzfA2ftAfn
         BWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444441; x=1795049241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=n2bRwYLPzR/K2x6OV7UITJmzzb8HNKjH/V5P/rYO46SAQnPaDA77ouvqj1tdusnp0J
         PH2lAKtfYtEgpMVJXpGEGh+y79UGbWdl0QyY93iCBi4GqEX8ppwpW/LiATyA890xa71v
         OJKXkCOCDGSm83gaEdWxnBMRlTn2QY/N340TUI93yi0fvwq6cvYT6HlU7Em5ea/7ntXv
         kARv3nAV8WBfcvDFST6RS1Cjl+ReLxuBEOFp1cgeYZNp4ghFSrNhIvWYkvNdkLaq1Uqx
         3iUiEE1YmKT225uChY+HggIxpSR2VkoaFLtNIV38QphqrMCJzNha+BhAAg82K8t9lzAu
         lM9A==
X-Forwarded-Encrypted: i=1; AL+hErEWdUAa17WtzCZ25z9lyMnrqfpLdadQIuPr0LN2II3LRELnd6xisMW71ofdmRuWKihl7PYaBb9AIJkbrukViA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4G681CfBtf52Nnka7f+B86SayiPRpfmvEAWzRXstgsnSa81Jf
	HIGRKKtJtM64f8zqNB0xpMuEUl2hdpXuauJY2SoTz1njlCeK8XlEOyF9sC5f9Q==
X-Gm-Gg: AYBFou24o65gCA0jFCVXsuJWmxWth5G3VXF9BUQ9RumVxUy0cVqxAk5KLdX83eYmF80
	WZ94BJDWrDzB3ZB8Kd0ZrRKqZ/uQesuA0fAueXcMTPK4429sbdIDmzF3MPzkCaUHHS3hq6h/CjE
	HYBlkp506gtFT2fswS7Ccma8p55O1vxJ+Xgj+R80ZABiTBsptQ17SOeqYEmktq5jeFnvkLmjlJr
	9sYn1vRoOOYtD27b7c21KRk0OsUCE2GcSd7rotimB7Ks3iNcIUBsoYDSmvjR4PNL61XiWnAIbhf
	wTsseEufEMM+DftfhYptJNHOLawI/zY9i3hxhpLehPYAzMHlqfZ/uoqtYJqFTKAaN8Wu6A0v+9B
	JVnH6FiWuDcNvZNPxtZdOH9S6VDqdaxYyQvZs3WR7KBhQcNWrnN7JBmYl+YW3REruWI+ZXqvWfw
	y3pRWdCT+E3yerFN5gwzwdyzKdk7hEAvi0vPbpTBZbOaOth2Lt+ZuFTLNpPUmlcVf7yftR1J1eW
	8V0L8NS3UZHAcE+tz/VJE7Bqx7F/q8ZLchM4E3WSSw19QmGgLl2eK9ZgnAnZTLEEg5av4rHHc9d
	2ESYBYzEKJPxmbuNW1J/Q/SyLynvwVWuBpaQzWwEk/Qj97ta7H/mi9HQ4z+/NHI54CYeuYfa6Uq
	NEVa4Y8kl12f6wD1+xZQ2QYcGg6Xgge8ucL5MV0AsZ1QeT8k=
X-Received: by 2002:a05:701b:454f:10b0:143:2719:f800 with SMTP id a92af1059eb24-1b3c039a6fdmr3462458c88.40.1794444440977;
        Wed, 11 Nov 2026 16:47:20 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:20 -0800 (PST)
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
Subject: [PATCH v27 03/17] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 12 Nov 2026 09:46:50 +0900
Message-ID: <20261112004704.49758-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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

A driver may need to synchronize private capture accounting with the
common RESET pointer observation and the core's position rebase.

Add an optional reset operation called under the member's stream lock.
Expose snd_pcm_lib_reset() so the callback can retain common pointer and
time handling. On zero return the core completes that member's rebase
before unlocking it. Drivers without the callback retain the ioctl path.
The operation is also used after a successful prepare.

Zero permits the position rebase; it does not promise XRUN recovery. A
negative return skips the core rebase, so a callback returning an error
must leave coherent pointer state even after partial work.

Linked RESET and prepare stop at the first error without rollback.
Earlier callback members may already have completed. Legacy members keep
the existing post_action policy. Applications must recover the group
after partial failure before relying on shared positions.

This adds an internal kernel operation and no userspace ioctl or layout.
Out-of-tree modules using snd_pcm_ops need to be rebuilt.

Complete appl_ptr rebasing once in the callback path. A later linked
member can sleep in prepare while the earlier member accepts SYNC_PTR; a
subsequent unlocked post_prepare assignment would overwrite that
acknowledgment. Keep explicit RESET playback silence processing and
leave prepare-time filling to the normal START path, preserving samples
written and rewound after prepare.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h     |   21 +++++++++++++++++++++
 sound/core/pcm_lib.c    |   29 ++++++++++++++++++++++++-----
 sound/core/pcm_native.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -77,6 +77,26 @@
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	/*
+	 * Optional RESET operation, also used after a successful prepare.
+	 * Called with this substream's PCM lock held; atomic streams must not
+	 * sleep. Do not reacquire the PCM lock through snd_pcm_lib_ioctl().
+	 * snd_pcm_lib_reset() provides the common pointer update under this
+	 * lock. The core completes the position and appl_ptr rebase before
+	 * unlocking a successful member.
+	 *
+	 * Return zero to let the core complete the position rebase. As with
+	 * the legacy RESET ioctl, zero does not guarantee recovery from XRUN;
+	 * callers must still handle the stream state and subsequent I/O errors.
+	 * On a negative return the core does not finish the rebase, so the
+	 * callback must leave coherent pointer state even after partial work.
+	 *
+	 * Linked RESET/prepare
+	 * stops at the first error without rollback. Earlier callback members
+	 * retain their completed reset; legacy members retain the existing
+	 * post_action policy. An error does not guarantee unchanged state.
+	 */
+	int (*reset)(struct snd_pcm_substream *substream);
 };
 
 /*
@@ -1179,6 +1199,7 @@
 {
 	substream->runtime->std_sync_id = true;
 }
+int snd_pcm_lib_reset(struct snd_pcm_substream *substream);
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1766,20 +1766,39 @@
 }
 EXPORT_SYMBOL(snd_pcm_hw_params_bits);
 
-static int snd_pcm_lib_ioctl_reset(struct snd_pcm_substream *substream,
-				   void *arg)
+/**
+ * snd_pcm_lib_reset - Reset the pointer while holding the PCM stream lock
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held. The caller must not hold driver locks
+ * acquired by the pointer or XRUN callbacks.
+ *
+ * Update a running stream through the ordinary pointer path. Other states
+ * start at zero. Pointer errors keep the existing RESET return semantics;
+ * a zero return does not imply recovery from XRUN.
+ * This helper does not update appl_ptr or acquire the stream lock.
+ *
+ * Return: zero.
+ */
+int snd_pcm_lib_reset(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	guard(pcm_stream_lock_irqsave)(substream);
-	if (snd_pcm_running(substream) &&
-	    snd_pcm_update_hw_ptr(substream) >= 0)
+	if (snd_pcm_running(substream) && snd_pcm_update_hw_ptr(substream) >= 0)
 		runtime->status->hw_ptr %= runtime->buffer_size;
 	else {
 		runtime->status->hw_ptr = 0;
 		runtime->hw_ptr_wrap = 0;
 	}
 	return 0;
+}
+EXPORT_SYMBOL(snd_pcm_lib_reset);
+
+static int snd_pcm_lib_ioctl_reset(struct snd_pcm_substream *substream,
+				   void *arg)
+{
+	guard(pcm_stream_lock_irqsave)(substream);
+	return snd_pcm_lib_reset(substream);
 }
 
 static int snd_pcm_lib_ioctl_channel_info(struct snd_pcm_substream *substream,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1984,11 +1984,35 @@
 	}
 }
 
-static int snd_pcm_do_reset(struct snd_pcm_substream *substream,
-			    snd_pcm_state_t state)
+static int snd_pcm_reset_substream(struct snd_pcm_substream *substream,
+				   bool for_prepare)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
+	int err;
+
+	if (substream->ops->reset) {
+		/*
+		 * Complete this member before releasing its PCM lock. A later
+		 * linked member may fail; RESET has no group rollback operation.
+		 */
+		guard(pcm_stream_lock_irq)(substream);
+
+		err = substream->ops->reset(substream);
+		if (err < 0)
+			return err;
+		runtime->hw_ptr_base = 0;
+		runtime->hw_ptr_interrupt = runtime->status->hw_ptr -
+			runtime->status->hw_ptr % runtime->period_size;
+		runtime->silence_start = runtime->status->hw_ptr;
+		runtime->silence_filled = 0;
+		runtime->control->appl_ptr = runtime->status->hw_ptr;
+		if (!for_prepare && substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+		    runtime->silence_size > 0)
+			snd_pcm_playback_silence(substream, ULONG_MAX);
+		return 0;
+	}
+
+	err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
 	if (err < 0)
 		return err;
 	guard(pcm_stream_lock_irq)(substream);
@@ -2000,10 +2024,19 @@
 	return 0;
 }
 
+static int snd_pcm_do_reset(struct snd_pcm_substream *substream,
+			    snd_pcm_state_t state)
+{
+	return snd_pcm_reset_substream(substream, false);
+}
+
 static void snd_pcm_post_reset(struct snd_pcm_substream *substream,
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->ops->reset)
+		return;
 	guard(pcm_stream_lock_irq)(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -2053,14 +2086,16 @@
 	if (err < 0)
 		return err;
 	pcm_qos_req_update(substream, period_to_usecs(substream->runtime));
-	return snd_pcm_do_reset(substream, state);
+	return snd_pcm_reset_substream(substream, true);
 }
 
 static void snd_pcm_post_prepare(struct snd_pcm_substream *substream,
 				 snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	runtime->control->appl_ptr = runtime->status->hw_ptr;
+	/* The reset callback path already completed this rebase under the lock. */
+	if (!substream->ops->reset)
+		runtime->control->appl_ptr = runtime->status->hw_ptr;
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
 }
 
