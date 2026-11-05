Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845919;
	b=s+DmCJ2dBJN5PEkJGp3HPc3FMJduJupOhTqhcyYGW+oBo1Ki5OGeNhVtRxI99tiF/41c
	 ke0hGb5YSpjqkSJxx9+4AWjH0szEu7obUJ1MZxxppIV6UpYhKyUEB15Ie++kFiK0jPU43
	 5HXaYhHorQ2RFlp8PwVNSIi9zhZxoTUajZy6fLqoNOOffTzCR2/GSbzC2WSwu51e/iTfp
	 qpa2pOXNc/eP8yKCbQUswKhgn1nwt1mqo9OKdY/vCFQ0VPzv3LbLhqzR8AKObCNGEvMxt
	 rmNPPiCzx8NIj4DmeO9yYXQnHaSQo6AeC0Uvu9ddQrrym5j2biXHnyFGBe38Dh3tAmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Q2wSKnVNfn+0m2s/5+0NXziIvo2kKlyTlann6b/3WQ=;
	b=lGgCnikx8tGcT2/4vXqS7V1ZBstzx1qj7pec2W7TzSURiPvTreS/aeYfu+J3DV1q0cMn
	 adVwLfo5iESNhpJcePaD08w9LJOMsnRVHAIarcC2XkvEUB8k5tv5mzmky2OamXTwI8siU
	 6W443k0Eq58+kVPlNd8/lo9eo+Y5ev5lTUiLLd5jmncVhvIOWxzqQ+nZV+6FmJjg/gfHu
	 uOXEHf/r421RpCUour+h7qXxS7UocBIX/T6Q8ek0hR5o2A2Qmp+ucggOvgHdXemtAChBJ
	 3rkGFcXfbtHYafvD+JsSILqZAt4ZXwnRWk7+GCTeMtKXyRpRmozQf22JY24wx2HdedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bR10jhs;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4649606D815
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4649606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bR10jhs
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so587086a12.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845918; x=1794450718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Q2wSKnVNfn+0m2s/5+0NXziIvo2kKlyTlann6b/3WQ=;
        b=0bR10jhspJtGeP1SLwfGe4GraE033DbzH14ZC6/K++VoROITuxkQoN29XrHSq+ytTk
         b8+p34nL8R5z+3Z3aPAFUm8+FL0BL2e0zGvnCuKub6tHhtT0pcgRpN281MNWCjfgs2BG
         kK91aYRylockV7KM0d8V/b7aKrBngxgrwESiuOWkHZ5rf4C0gyeDsuOIdW8ixWPO3uM9
         38rDnmrWMygknKSoeaVDpsCXadOmtQDTkd1LYKSnB93uE6/IftCbqdhSCKQeDlC2O7fn
         cAoPWEfLP9YF5hw8IH+0dF0x836Tq4r55FIgcbPZruJwWd8tZqdTjQT/SIlso/y1Z6jF
         nSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845918; x=1794450718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Q2wSKnVNfn+0m2s/5+0NXziIvo2kKlyTlann6b/3WQ=;
        b=FEs8KxRF99G+zPsZIPNFrq42Bs+FX0FnQSomnYl/wQJDh2fk0uIU7p3zszzKImhlp0
         8n+e8ZmZnulvgVVczY12M3FS7XQMTXTB5Y1SKlh7xtTX+KTuKRwkY9h67MoIl+eSWRii
         phy5g4JTODMAnXdVKSsxvHn/s61pkEUDNGnwl6+Bt6KhmwjuQI2MmJlW9fOizMuIasIw
         f6k1C8TD/qBZVFYO4YRCaHLFGLLfBHrtUyCWZUqR7IQ2GxICO/IW8HW78HI/0bxXSsjm
         lsdGP0BqQmw8ms5xufbQbhtD/pOOChYrPYt70Rdsa4HvhQXQzfp7KjWNk1MaCInIesCM
         NR3A==
X-Forwarded-Encrypted: i=1; AKwUvBxYT3b0c2UWgmwB41AsqX6PGCrHrKXeGJrUTFCsmMy5ZP9BRcPilo6g6s/7ZARKYm5qQYBQqLjpbifeV/45Hg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+4Njvd/AiICFGONed4RRezPcyORrT12J0Pb6+Gly4RoQhG/u6U
	E18p2euVJkBp1GhTZxzWs3sS+XWGv0lhKj/pb00rRftFGMh/Q13Pd64w
X-Gm-Gg: AYBFou0YVakv2GX6lgb1y03PgvteOaWbImhp2emqdtqrqiNPQKsiAsTvmWRkIqfedD+
	s7apKlfYrGDnBoKxluWxoJtKEIb7HoZyhzjFZ+oBbKb2aKOzb3YxlekGQCCCngo8KIBijtaJIEA
	qqTcJE9pgfbVHF39qfAGGG9tYqF5ze5KXf8BUxcV+PFWfYH2cxO4VxIZKEef0/iLRbCJxQ+fO38
	ZTcld3WiyBNiMlQEyDXLnrcTy40+ANQfthcfn4kLkksNJeH6tf4IYRL4Xg30vcCOSnbYj4DpKUG
	IHeT5KldKl73VYRfmi/ymsHdVrp4mL6DTyJ5y717t6nGX0YwStYz+awEW1naybZAdCZnbNEYtfY
	1zi/l/NBmW4Ni3cnv7UE/j+cYLSOcEzJHvIuGnOkuVkFU4CWZCFxWJ1tMUrFuB5hsPa1vxZycTc
	s7BA9FvGoZ+HOfOi6p0dlo9mdbux8byYrUuLJa771wohqantsMQmdY0pGR6DcHoMB8sh0y/W77U
	QmJwKZcSSYPSPQy3XjdaOQIu1kxdZ9jrFZLWIZ61jaa1ogPIbtHV60J1WZoRS6NXMoMco8X/pwM
	OVIRovmeaOUNasDO5yG/8CnqRzzGvhFBBSwZ/C//4GDupbiTZg1zOnSeDjiEVp5b4EnSfeggSkV
	aejp7sVxdvhqOobdWff2V4OhICYKCvEwvJ7TXsL3fG457CL4=
X-Received: by 2002:a17:90b:3e89:b0:3a7:9045:fe29 with SMTP id 98e67ed59e1d1-3ae895362e9mr15653376a91.4.1793845917957;
        Wed, 04 Nov 2026 18:31:57 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.31.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:31:57 -0800 (PST)
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
Subject: [PATCH v16 03/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu,  5 Nov 2026 11:31:31 +0900
Message-ID: <20261105023140.18373-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105023140.18373-1-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
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
 
