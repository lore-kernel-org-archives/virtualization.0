Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664280;
	b=DHwQjUW3jMyE/XPbKwpFNSLmxmuN7GLWnhNlDOD7c9q5PINxEPP3EXrtLP2WF/HIa97R
	 VbHYwyn5aOWFZzwAku/J6Mpsq6S3TYidcAh/6XUUBiL0LQhTySwIYsSYJdSRl4y4Jb8WK
	 yDai5JoA/W61n9vUky9xAiKpRbHGhLMrHk6sCb1Alkw8nG9kxbeu1vFMbyl6q0L5w6G74
	 6lmgeJx5gB0YzCpSuiyfsy3/GPVFfZQEvvr+GObbNAloC0mu0WiPuWyDEvZgP6TXWvqmd
	 qU3w8Q1f49ZGJ1nJOqyKe1r1f9sJAcQh4CCoWLgxNRv3JOuG4WdSJCAnUEX4akupiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
	b=JVTuXLebAhkor5OsiPm0nqn2y//doBYFqpP4VV1lRTQfgIR44woD/HQGKCz96Jt2Ofad
	 tk1DZFEwloyy+/9x3YEhrTBLeaTpzRpB3qDH23dAUEQhYfVfpCahK/L1XUDGZJGAqEZ+d
	 pcI3v9WDoyfTxZ/sF+1y8kCJHNKXl5PBv21tMH6mX16UUQY2RY4kAstYzKGpxMb+u7Xcm
	 Wzf6NOrb4yqTo2jtA29KSCzpcmO8RuMR3C8W3yxDdzLWvn2nj5RxjbzkZA++2fX8w1k87
	 WHZB5/pVRU3Xdi61eE5ZIMDbkpkQhBEtWrell3ml6eSQJm8LXyJaDp96Q28JFnuZNDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaNyLSfD;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC08606EEAF
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC08606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaNyLSfD
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc758830601so2185093a12.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664279; x=1794269079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
        b=zaNyLSfDPjuMHQMrmb/xuOj3wa7sX8NgpUdGWnuQU1D5XEzXgAN59d+IFPDTSVFGdH
         Vt+XseQn0Xuz65hHCKHzwaR6Om8WY9wreO2Ba0326Dvwe8yPkGlS+m/mLM1F7qOs8TWO
         u4OxmMnTbj6g3Kpy1+71mktR/v/SeShm5VtpCvzL78C0hMQ+z/0m9W2WImQKSW0hgdXf
         oqEyTrrXUL/kzDHfxDBXTddQx3QI5xw8s+mOCUcjwPaFrTsSARx4NJQMTceyNySXk4t2
         +s/IuTQb8jwr6+Ooz/tlkseVuEIreKpwxxeFqNx/2FA+bj7rwlj3bZK9t5rw2yF6nCWz
         xQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664279; x=1794269079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
        b=L8aE1QP+uNo3dF7AlTWMFq8QlfYU3HGBA4FyRnUZ89nKpARya+yXazOkUi2C9+T5Ck
         xnIQHOXGf55p/hK9Jm8pgrPa1zGD80IuhgcMPlM2Xdyb9DHxu304jfG9wlLseZohAhhr
         1Fa5YhDV0qmbcCj5voSVrvFgJzMp+sddPWfHOruN3/2ssm9USNA4dUSdQN8vQMArUzgA
         3KZvLjW0w2EPf2erkrBS9tkVBGPpmulOW1ti6qQ+SvbDfO5QzCX0fkZO8LbLI+ZazRQS
         HdvRa6f10YDok93yE97hUq5xGVcpTEZirTZbFCIowWbhrtPg56EGNckGXTIveyzlmpgO
         sIIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAOm6oy4MEp6s3ed/kpHoswrOOFfYOxT1BDSKzqyvSrTKWxSJE97osuAxiZGT4Ny+nttjD9iaphHfnUZXeZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ckh4iwOGoxa9MiIrbQiFUY/5WIAiwuFqgLI4KyFztcwMdxmib
	+P0j3JZUTZ/12VIbIlJLVXW7i1C/LqSHLkP+P6B/mz/x5BNOUXoLmbjX
X-Gm-Gg: AYBFou2/NSly9n7LUYuz48Tba8fAknKOm7wSzx0FdejAjGp3Ghk7ayXZhjjW/iLGZSZ
	Of4SWD83bUcvCzHjIx03eJHFHkFETfbQxe/Y9kR8bDQXFW4OYoEcxHwYoqL1QtLt8/eNeadq4Y7
	/QL4Yf4nieteyLbDnuAOyQcangEM9akdrxwMFN+Eg3gpBtCmZlI4h3D/vdgE6qoqVCEVSCAsVCU
	PsRdHxVdYdrNKVwmf8bOG/+pOrAd5ugIQ/M8HOeIKoTfjU4sgTyyjf3O1cA+EKCdkXs4C58wsLB
	jCGleeiL2+GfS4HDo3vjab70bRuATWURtgV0MYG6nd3zhBdPZEKNDJpCN5XJKRWKFXPXMtjDItO
	KjQVplWNSsKSBnYloh5P53KA/d52xtVvwETI4fhMCBmUiTUalYT7cRobGxZMepPGcOE1ek0bhKt
	TbP4SVZjghq2O/4lqeoosU7OBIrvEHuLHdRA8f4rkQerOGIzvYAkG0wvuRyKzNqkWW+/6j5X39k
	A8C+YYGfbcf1jVyZx+SXU1VrixYK0x1w63oHNVAdpTD3AEQm+0QBtCz1FSSeOdCBF+4LSY2fq/Z
	KztzFDfaGNY7pcg8INPhDhbiG/uJ8cJTRbgLx10jzMUwzW9q3ptjO43w1aM5wJT3KW0u0MwgVRT
	YkEpwiUl1KjeGHD4vp8M4/1IYxFiuM+8HedXDfD2kjDdDk0M=
X-Received: by 2002:a17:90b:3c90:b0:3a8:bbc2:5551 with SMTP id 98e67ed59e1d1-3ae8918adcbmr9133017a91.0.1793664279142;
        Mon, 02 Nov 2026 16:04:39 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:38 -0800 (PST)
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
Subject: [PATCH v12 09/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Tue,  3 Nov 2026 09:04:00 +0900
Message-ID: <20261103000403.67106-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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
 
