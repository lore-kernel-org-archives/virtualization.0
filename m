Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458133;
	b=bZlh3Yi6BcNyHx+3M1w8X8p8+yzYmojHWgp2cMEAlT8xRpjSYl15AUasP/V66TGaZtY/
	 ZK8YS15ImVC6ckeGhnJ0VpUmWItiJVCZ4Zpjx5ytR8sXsL/034DDXgg8iemGx1yhT97rT
	 epUUTWE/RK6FuxJojK1GdCIP3fRGGdZ+f2by08kQscDOJY90WK2QLADIMN5mLqeTn693r
	 8LRw4UeejqmAusUF8WvR1kgFJC75SrPrfdAl0YzQSOMXmSTYpR6LuW0f0e/iAdQ42Ax8t
	 GUKfIdCAOuGzhtvFaML1jlbeErirKPFTf6j0ijdO6xwVI2EoLI6yvW0cPhKBuL+WbDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=5l8tauWCQg3G1WSpHp7xmtO5uRGr/mKguDjA+lXI6elDH6r8ES1eZh9+LOPLpzlgRZ1p
	 BHgFvCbGeiMD9a/IFrokcPbrJ0XCkCJhh+TQoS/clYGrc6MZ8LP9lDR5fJ7fzpOC147A2
	 yqAT5Q9U9fcADSpkbBXjUCigSMHxzXQfl6IMTAF/DGKgxigKKI18QzEAeZkxcXy/VFYW7
	 pUi9CfH13ZtJhNshwMJ85rI+SjhhTPy5HpuO37NQSWbjgeM81NnjQerSqxnv8bAJ6jSfC
	 J1R2okwsYL7foDnCK8JczmhynB65pg8qgJYyIw3tZ7pqga2vo97LywdGYHzsZzCyIKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPdFipX5;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E78606A8A7
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E78606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPdFipX5
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1980941a12.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458132; x=1795062932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=rPdFipX5Jm5jrIK79eajVarAjDdd/ZKBTH1LqNPK6yZppDOZt80NRcjOmC/vZEwK1O
         yt/bWg8fvSSZL1PW0hN79sAJcYkbC02XmKgcBpDaieXAl5M+tELOZgbC87QkPTKQ/X8M
         Uus7d+Jfk9BL2SnZ3yAQ5qXWiu02J/JcHw+P6tOjc97/0aZlHBbLd/RP9hoOPHZco+vN
         AzHMzlzhpfg5XGSfuFKqOYD5n1XGFdwJFjSeE+L6qMkwoX5UKMxWqeB75ofxswMVsJvT
         lM0I5henDKpa3l1jv44wp0B3qU/w4NHdp1XlzUwOn/PpJ+MSvfa6weOxAgskCIj5eAs4
         LhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458132; x=1795062932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=WQJXeFpSZJereRvjenhudLGr8mhFUiESrnGBFhFoCclN+QGjahEMZ4bkbBSjEI8tRD
         sYilee9CjmaQ4F56oTwoZ9xfF+EoeN9Xjo+YaXBqDMGhxAP098eWgmZfO7OJnAno+9s6
         BXLg8ae610bOyqUNt6bDdiiqYgaH48DInLewF9tpaRvQKGlo3+alyLDqE80l3hztPdUC
         bt+ySNxuAWjsmW1O1VY7M+ijt0JsJukcRgU5q60psWiDiy2kKQClcGlO/3LvRmU0PLj2
         4aVTy0EXHdQonceQ211akxm9JscCRlGTT2CGQ37OMDnqMjGH3ignOcE45F/0BoI4kj9d
         Fq7w==
X-Forwarded-Encrypted: i=1; AL+hErF/fOAcKfEb/dGhnCGxH5HWUKu6LsYrZrL6vSLCdDDf45sSM2raUZHxmi7xuLIDIZ4Grp+8+dHqAlMCyR+rRQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+DHQnUvWU0iif7S1AJhcz26L0Wq5h6E7bGOt3foMRWT2P2sQDs
	I/kwcK+XbSp2qEv5uksUtSiW4TCpHn+FFFXdwMfSDg9hPxuJAPnLI7y2
X-Gm-Gg: AYBFou0Ck9MnnXYELG6ZjkUg9aAausFZUDF2oBPmPMivxUwUpPOGFlfEpM8yH+L50Dn
	eHQ7pFwOGptFnpLGpIVKgsQBn4urQNBTh6i7kEeGH7r3rgPr9etlkf6c0EK0ga2/TlnWqsY4cx2
	Q+fWeNw8Tuhpus39pc1TtbHa3GZxhgEh3ob1/nbtWfiMpW4ZkyTZRz+jdAQEOFFObg1faXNXk+D
	b2zHcC0AHoD5rGPfJgZVAyYYtg94VAPrL2C59oBhuYvIYksJGYyTHKOwLdehi0rHwx6QqCwSqe9
	BS9DtPSztjsJLbyVHr4YX4c7EdsVzETcHQlttyJrgLMk2eOdcJ4O4DYMx+T3MCWPEX89xBOOj9J
	d6CMxCfDRD6mw9FagSAL8DhSJomCT58B3MUicMi4ypl+PGdq8pXg+uWpQF50PSodPue4P1++ybl
	g5zq3YHYSYtKsYwMdJh+P75Pv5D5/eR5Bhlbtq7PViEkjl1nCyebZEkiOhlkYtrreRBWXkJa0MZ
	LhbfQViBtjsOHUCzW/r7eN9ARgsWINnljAf5A13uUrC3s+Zg+aPEZp+9h3krPHXunwRsM+x0TTH
	mrALbijjYnQsDi8n2vUTlZxtUvcF/jCf7gnv558bTazdvuUd4eg/Wt82y8NrOEqM/YBsxk73hA2
	w5YUW1e64Gdb1s306VGHb9SnsDl+bgLuAW5f45aXOR+Ub0gg=
X-Received: by 2002:a17:90b:2e46:b0:3b0:c22e:9460 with SMTP id 98e67ed59e1d1-3b182deaa09mr4052634a91.2.1794458132310;
        Wed, 11 Nov 2026 20:35:32 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:31 -0800 (PST)
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
Subject: [PATCH v28 03/17] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 12 Nov 2026 13:35:02 +0900
Message-ID: <20261112043516.37010-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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
 
