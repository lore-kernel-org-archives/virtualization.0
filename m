Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837374;
	b=pQprMfw/o+ZVHrjfbovNvAC69ikMl3201aDrYYX24WXlQZOfrHb6c3gflwsmDgcLakMr
	 BQv1R2nWoEivf0y1m/C0d5kf3RuhEtpaQ/e4JT8dgX1NWHIqCzcW/bOwsgvoH7cLPRFJh
	 E68edie4TiEXVT2iNoxmB+4oj6w9RJ/GHtBVs02RErNNN46TRMqjQCDmCYH+CpwXk5n2Z
	 Y4Vr1OCuCV/F3CGAkoKa2ND7js34yTvG6BouC/u16er991+9UABSaGB6djP/K2A/sQFTO
	 nXofad1OLrGbKWJbCt0E+NmmZqJ62aqiGTcqQqoP4sZPVKp0hJTBUFjEdQeAX0xU5jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
	b=oFgCByANHUl4YOPFw61QdUBT0YC4YMddpitoz1r6H7efD34hKFjDkNCsAm9rbmbhywd/
	 h2WQP7+BAk76Pi4tCnIWTw+Irk4AuOYTeKWzirz3+iG9XxBWirE2Pg3Rgwemk7d+OHcTI
	 mSbOWCMAW0lmI0VvEYwQoZR/DoUvX+XyfWZ14U6YOWG2JVSkWwzunxNTm3r5gp38Yqw1+
	 SO+sCWkbMbDhtrXSWSj2R+qXKdWXry8+8UHlYONelDd1AbhMDwW40ek3QMqD9z8LlMrMr
	 pA/OkMvbFV+bFP0tpMAD02BTe7VzKy/L4YxF84iu+jMKpqFziM0Ekjz3EPco8z5NKhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpdNdisY;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492D606EE87
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E492D606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpdNdisY
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so587166a12.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837373; x=1794442173; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
        b=tpdNdisYSr0jO/mmjvWGz6xXDkZABRI0gcT6riW1EZ4oOmsLUIPMJbL5n/VocSKL1B
         N3luDZ//qU2OA1y7Id+oAk3e5NE6GdI+BQrpVw/yBZDcMY8X5tHN1Z1ObO0wLN+Szz/f
         w1gSjxtpvLWXkfY1v5W/PNkkWxhsPH+KaDEuuWhbV7ooxLyrS7PUEdTr7Lzsn8AI8RMP
         NTco8A0h9uiHiH5TxS9lSyXNgFXp3ofmJ27hK4XHGZNdComC3dIwTe7QdSnQTYcb2NZy
         +FON81RIpHOvglfN8MTumDckCj2Oj8JKY5Z8VV86mAPyTMSFDZcneKeiz4TCJ9Cq04nm
         32bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837373; x=1794442173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
        b=l73XHNXFD5tgeJlBhx81Arjltm68RflXzndlfDytH63ldmb3vfFuWUPtUCNMR0IBA1
         P2cIXWaovqkOPWTlNLs8a2BAhOef2iL75N/qQRdwMKCLBF2PTs1drgx8WquXb3igzA9C
         Qr8PP3pj0UBw3GsqwUM/vs0vcJ2XEkxw8r/7TaJedUKpx/eDF0ngWU7tDaKXy/JKZVwx
         6jvjgw5N5suBWAHTVCEPM46QGTxdnSSlz5SNi7Uq6p2wMDUoBvBUPQxky90o/FZ/H6S+
         8aoExRrdDiM3aA3f+jmftQk+uLjapb0cjC0YLagScx+6YnVWxAErNhB0b/qDXj6ZbVdd
         FS+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwGQXkf6pHWzzkqeY2wiTrawaDTjZquMB+BVrUWa28ZClsNDx8hR9uP/VsRaloFGxxIcfFDO5ZQJvRwk3apmg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9NNFuE7kcVkzpFLgqhfkgmbdzGecDIW9XGeoe6T8tN1+0PneJw
	w5bnine6yoFwkRV7nHAVUBmM4NaYFnIWRagS0ELqpCzZlwD4jDmOTZuh
X-Gm-Gg: AYBFou0zP6h9dGb1FumGix7nmYxoTuUZ8YT6fq3nCvRNow0rSEHO/Qg6SdVeS0z6X/u
	P7N2Ybsq4J8om0ueWKWEYInAxx8z8oF/GfzcK1nsjInlkQuqST4FfDhDW34qV8F9hTljXyAFDND
	pYtEJj2+zue9H5K6qaCwlgbvozqbtlKQY+S8kdIghBJ0AudnaWJUNAmvZTixIKQOq9i9hst64lT
	HVtyBDwpOSqECW1myWSJMLxZFT7LNB7xJR4bGicHg8/z6F98uMSKiKOlZg9T/9UqVmT4Aai3vTq
	1YzQBwapJ2pEG2AONmVldwLwe07LYa90ZGnGcr4Krx57HOu+5dQ1in5futm5XWTcFCvqeynW98/
	Ir09pp55kdJaY2Q65IysgFz4xczzXodWrUahVQJ/Q2RiOdezoh2B4AoJ/F0PINzpU5aSZeC2ZoP
	L0spiyqnTIRW5pu5QXeujgQ40r6iuTiz+CYExM/m83WK+Ama5aG+FjHderL09OR28ss1690K4mJ
	yc0YdTb4sSW+dc/hg+vnz9GAy6dBxVAsO6zpYkyYVLLiEQlwrsK/k3gqB+vNV/sfRLaSw4+qe4v
	NgihrSZi9QHW7QLdLqRg4vnA2DsjboYN448Q9fltZuhzGLfb4TFK8YkxjXYnb4eoIN8dzMWIfPr
	e9jQsofSaF2MywHpxCto2C+i+isSWxo1o5iCFzhi/K8uJwC8=
X-Received: by 2002:a17:90b:440d:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3ae89829890mr14773097a91.60.1793837373127;
        Wed, 04 Nov 2026 16:09:33 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:32 -0800 (PST)
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
Subject: [PATCH v15 03/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu,  5 Nov 2026 09:09:06 +0900
Message-ID: <20261105000915.15177-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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

Zero permits the position rebase; it does not promise XRUN recovery.
A negative return skips the core rebase, so a callback returning an error
must leave coherent pointer state even after partial work.

Linked RESET and prepare stop at the first error without rollback.
Earlier callback members may already have completed. Legacy members keep
the existing post_action policy. Applications must recover the group
after partial failure before relying on shared positions.

This adds an internal kernel operation and no userspace ioctl or layout.
Out-of-tree modules using snd_pcm_ops need to be rebuilt.

Complete appl_ptr rebasing once in the callback path. A later linked
member can sleep in prepare while the earlier member accepts SYNC_PTR;
a subsequent unlocked post_prepare assignment would overwrite that
acknowledgment. Keep explicit RESET playback silence processing and
leave prepare-time filling to the normal START path, preserving samples
written and rewound after prepare.

Atomic and nonatomic synthetic-driver tests exercised both callback and
legacy members, mixed linked groups and later-member failures. The
callback retained an acknowledged appl_ptr of 64, and finite-silence
playback kept the written prefix while clearing the rewound tail.

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
@@ -1760,20 +1760,39 @@
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
 
