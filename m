Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263894;
	b=TlpRnXhaYQ9GLe8iBFYe5MhO8JDe2V/NdfhARXiXn1UgV8nkW7cFEorciyCvEkoNwaVI
	 ALTp8IP6VYnzX0GHoA8k1ErQcaGooEfJne/uIc29SRBcBST6hTofY8wDFPgbBDj/hGusI
	 MJ1mk4zjwcBNb98aHPxY0BrdkXaUQg7XoI/9IV5D3/qfSfE1Kleg4h9TeUcffyvP8Kde5
	 QJ7p3O9u1PJeMiitKR6E/7TZu8BHEV1bIp4wGDtNJmN/dmPgfXaB7xxoBWRu6lF6Hwybd
	 nwjtC7u2dOeSfMnx39WIfXcwsONRGen4ddnnqBBNRgYNxyIJoFQF7vZik23u7QpN+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
	b=OcUhZs5Ef4U/RHVkZNnhK2+EYtChUUoE17O5Yk2XOUuEraviurcxQWeHv3UFQ6LooCaC
	 TRkunZM2CXlhaNlQwNIt886ywM0fUV3v1F5yXAWb7gLqCRUJNNLpnmzuZHwpPWm+N0gdd
	 GiPzUtrLvlq+VkN/WjQzA1+j0qQA+N/JdsIb7Vk3mO4p2fIuu64mNtyOsmK7oya13V2Sv
	 HBKC/ZcDopcutCBTbMIYQCRu9eVFLHXLQwg4nHl6/G11m+Qr1xPtN2SYYqLGhUpCJe616
	 yPqGI4ytGy6IF3Dh7+eBGryEulGPYTzpoXANm8VB3LJ/FNGzikEjlPBPL6Jx/WSz1uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrUEWXdS;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55860A2626
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D55860A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrUEWXdS
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2eb0f1b592bso4563295ad.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263893; x=1793868693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
        b=FrUEWXdS/NIsw5YlGvpho9h+BfOkVSjHkj0ZSdGb6G30MHint4R+osAl4UL9jUhywe
         HoeWaMvjGq1hujbRonoLKG8hklpGADjwEAf6gfPvyf7NPTGRH70A5rhMWYf9Bgb2BJvV
         u1EWjhuIKGqYrNBZ13Hb0KSXvzQTT1oM0AZ1rc4Cq8KVr0XeaogHlyTGbLoBMisBBFNZ
         aVwbbjxqold53EWLJbt52ojc6n6vzSFHU9ae8re3ihgHf54az6hqYA2UohF9r02DMbxg
         NlVyNox+2kHkg8Sc/gw+IZU6hPPd74boIqCwMFB8ETs7FxCprKGymPKXdU01BG/qIwHQ
         PtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263893; x=1793868693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
        b=eiLLBS9r2Iwq4ErnwEZvqG8U9Zz/MURZSFRszULYtZXP0LFmeUqEgB2PZcBkWzhYjW
         +0HGJDgUy4JhWAgYM3h0by+UoB3NRvRudw9Kof/bod2C8oHacliH08htTJt80y/FEgVV
         IabcSC/S2deDqiyYykxowFYj9RAWAs97jNFHPx10zzyeiBDdpBICsF60o8RLcKYvVktk
         n6lmNoAN+ud6fNLYj880jZBYUQIVFo+7No4Veatmg1x78Xot391LVYmfQCVvMPOnXcGK
         KRay2W/FXfVoV9hHtXrRQ6n3EIi49cMDeyLlJG1nXUzKH8RYpwp4C9SjSfj1eQ/78YMg
         0bNA==
X-Forwarded-Encrypted: i=1; AKwUvBytMVUdVkwXbJqCGVSrG8YZoZMh9tMkBloFXE9LiQg3hLowDhkXwRwM0EG6F0F4EQ3vFtvlqQOW2/mMlxSPbw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCLoN/jmQGLMWKs1E8eP/jezzZmFEqWaPjtcdD0e5K4e6mfwT6
	kufFBdMG3Nlu72EqzdFQpfDaqMQdTycG21vvLsTsR8tOtOnAVrRgszXH
X-Gm-Gg: AYBFou0TRiW5IgcYQyhIsEXYd3KISz+Y5PISzJxjDGORU0al2uX1SS0yGe0cJ8ulhDe
	5DndsRGdTKhtsHMU6+UPdI978zdepZLvG3+n6zpr4P/a+BV0IpJgN4jdbuJaUCJ7J8cDr/RA1u4
	V1IjmFui3iGufkkiUdFieN9zx3oCQ0FD+nFR9jHdN/CZvusM8ZFcwv25j/fZvogp/qiE7eT0cCY
	/SEJORsQHbxOTcU9iBmglrndejjHJ6UBDC9SVwbj1GO+5ErrZIvyrRky+rz+z7NuzrAuegRNKkS
	1rmJ1l3OwJmbMsyabi7nlvdh1TZLCK989d4iQkLflm5jmBvUDBbPymLZn/O2yv5lOM0dYPWhHme
	KRe12ECaMfqc7BJh+xYe5kH9Zo4g1DuYIkEfdsRKNyV45aI8xwk6Fj7W9dxeVqDRwQhVWq16vio
	9RFONh0YgnRTdwuADOOiP7BONYgqClIrdeeDjLFGK366TN7Eru6A2ppvB7VQ3/ucOR+IAmUN4fL
	956YzOubstDaThVXdQHzAZ19pW++oSGnj9wlU22EVa3R0tkpj2rnBl7IFnyLRl+lmJlXI7NZHns
	JViNZsUbPcxnk1qRmfVL6iVwIeiQFPLuEu6fuJjPkSSCxrD4v8noHxW5KMoL4JNAfCYFr0hR4ad
	gkrNESBhhp4FLaq6PbeAyoLQMS5sK7ojVJD7e6T3opQ==
X-Received: by 2002:a17:902:c40a:b0:2e2:d02d:a173 with SMTP id d9443c01a7336-2eb00542986mr43647935ad.49.1793263893503;
        Thu, 29 Oct 2026 01:51:33 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:33 -0700 (PDT)
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
Subject: [PATCH v9 12/14] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 29 Oct 2026 17:50:30 +0900
Message-ID: <20261029085032.70689-13-mynameisjune111@gmail.com>
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
@@ -1988,7 +1988,31 @@
 			    snd_pcm_state_t state)
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
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+		    runtime->silence_size > 0)
+			snd_pcm_playback_silence(substream, ULONG_MAX);
+		return 0;
+	}
+
+	err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
 	if (err < 0)
 		return err;
 	guard(pcm_stream_lock_irq)(substream);
@@ -2004,6 +2028,9 @@
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->ops->reset)
+		return;
 	guard(pcm_stream_lock_irq)(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
