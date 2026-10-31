Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412579;
	b=tMqNdhQbEzCn6Icbucr1VFp5FMPsqerWvl1OFS+9OfXMWWBoLT1TUj4BOn9CLHVP2Std
	 MFfA/+qyJRePiQ2bT0sVkWyjIVXEJGsMRphaFu6sntEqzB5GnbHqqZAWo58hO2uSXySDU
	 /77e1mb52XdtBpt6OROBoQOnS+hSLcBqpFNZPmo1o6LwTjWDxWn/Kkc6NXFeBuAL/D3pK
	 GOWZAIo4gFrw1LWL31XPzp+La1juAkICI325MhMGADKs+JFYk2OGxacs8zoGygbQELzrm
	 bROwZlWpu/Jl1fYHug7P7hDymA23mtl/Avp/ZCOAvkH9ODumAIgGXqy+2JOeRUFRWoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
	b=mAZLlV1OdnAahu61UN+719rXjI/9IoEv91Nl8cEgseKkqjuIYQOGebpNS04ixB7xHUIM
	 i4uUY163GCafnad3AXJm+UgOUhgnRh7m4rAbRsJSIhciuYepabZ++0JeDUvBYHF66x1hG
	 xbLDV0Zfn7ot/VZmpTDjRgi4XUT7Bq4QgOwcKyAdGFru0a5GMf75PdjK+jWagkBY7AbAd
	 +sRfG7H1Yq5iIVg6tuMSxkc3peL+PZJkDs6ebWu4PDpZQmaKLeZVfbGsBF4EYQ/9O/Lzr
	 gq+iPRPVbSW1oCctkI9FAoRJddziV/dxnGnrLpH8Pmso0hD+WztgVoX65TvBQ2vzDKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrVMBG4C;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228F606A326
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8228F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrVMBG4C
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso2077099eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412578; x=1794017378; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
        b=BrVMBG4C+ip92nG/79SPFvwlFeV2y4RioQV/cBpFxO7CaylxFiQLCu0Vww4y7pSq6k
         Ro3ILCgy7CT/n7yNSwd8JTOtW8vMfthsEXL7Oa6e956yznQipKakVrQP8tl6Stlrl3YP
         XpRGBBgtL7g/Oxx6Rg3HM/Cdhvaae1WYJiZkL7neLo8RN13WoeDvLlR5/j+hCDOHGr30
         Hx5RB6ZkWcH9BLoDrareb/pki0QcV1IiQohx0CkheXOXfz46vrEy1pCg5/G20fPo2Icd
         zcpVz2H5rMAoOAhpeC5wf/rsnuP++lKAz071CscokB26uNidBdv69U+fBnZpHNWkRLlM
         ECjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412578; x=1794017378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CjRxkr9Cimnlv+APvVZeyFM8wm3KwgOOTlk4v5ZLSo=;
        b=0a3PhuxDEZnFinfhLckyoUHLrPAKToW9oY+lz2PXwaod4H5EkMKtumjBeb6FdDNoC4
         OJMeH7WxZn06aOqp7XPPWYe4zGl/PzmM2CTd4pdOMGctYQAhhAOAxiwFVSf01XgS49B9
         vveqYkdFAGbPkKhys+wsGgGn+ysn8HMwJkyAn/Ik/TSMXUTgn0ownnFg40+8ba+G6e7P
         Pn251oERpgdV6a9soPDfJrLnsXh4cwvCjI3yHthB65pDpy1HCxtfNsQ4ljhuffvCaSwo
         vzmmkGhAHV5wNH4vlV9SLCThs1jTkk1nkoZwexqlF6VzslnMiJk9Ix6o+f5PnksRqZ1a
         uPgA==
X-Forwarded-Encrypted: i=1; AKwUvByYDKqa2Cx58xcsMFAhqBjMVIozFUfBGNME18FMgycGXq9bCBPXXP08+6rtyThNC2Svg1YN/MQNe2pMAKerxw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJYyJySCQOPneUSFoyLbZqH4mjlx43rUY0eGTW6qUBNPAAYO17w
	l+nmtvS08/E+GZMGEX4NKIs2mEoPK6d+viJag97X6/bV3tkVfO8WjJnG
X-Gm-Gg: AYBFou25l/FvrOwNJJhZ5RfSmxwi2ZE5oU5JRmAD/pD3nrwUc3RcGnTzmZWnbhsJhwc
	tparWVxnTVu4oppLcfbjMpIGQjb4jU3dNQP8hnFwSYhTtQs0i+hSsAcAc81ohJZBYYW79gF6H5o
	qU7lzCM22LyD5TFZ2ZbqC0zsa4AfmUCeRs7g2eyL1wmQH732j90+3CvIQZkzIqktfJoxxnGCdWY
	Cd5+ARvQrsiwBgWS0Z8UOM3MC+VnkbxgYBFcD9jfKsCaFGkkAnY+f4d3qNOg/wxUPb49shPDql9
	8vKvUG10gNXS3COnibxx7SvdNby+F4uFdPhnMKkj2P61rKY2VmWEB1ZaIS2f2ut8dRHd+shzOrE
	lLPfBpMTpuJtP9AeqrBiWZ2dINiY9cph7fEtHsRZowKQC6HxWKa+VjpSpj2tPVXRt/HRVVB31bl
	6KzPyJWUtt9hL0c3A21yhrLsDgQvBkz9IeEvMSAP34WLlT5nNDW4mgFPO8KRQvyelzxR+kbMpeN
	+aLvI6naYqbi3+pEdKB06AfT13SiI3Q8ZeBtua3Cz0RbVG05BtkhgPb3X/134jLsDBR0STNgnWI
	YjOb9cvdMOnc45MdQjIatxzpcO/kca7y5josbP+Bl0F4rDsFeBN9mdaSkAxqE5iqu7p6qtqi2t5
	ztLg2wSWWfCE90FfVYsvQdK8sCsT9gn9CmS8roYBeVQVjZA==
X-Received: by 2002:a05:7300:c00f:20b0:36a:4ea9:19ad with SMTP id 5a478bee46e88-36a4ea91fd1mr2670326eec.9.1793412577544;
        Fri, 30 Oct 2026 19:09:37 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:37 -0700 (PDT)
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
Subject: [PATCH v11 12/14] ALSA: pcm: add an optional reset operation under the stream lock
Date: Sat, 31 Oct 2026 11:08:53 +0900
Message-ID: <20261031020855.2402-13-mynameisjune111@gmail.com>
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
 
