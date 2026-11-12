Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461704;
	b=NyVqCdyrguVZsiBRuSoZw9eSae55igj683c+pPPGtNDjFR1aTy76C8b91D5xO1MyUHY0
	 wxKQ8tAjy0l9+UK/uzWdvyaCMHboSwOwP/MFxSBwvHPBr6kPlKqjWeiJHuWgOyR8T2omb
	 SAlCTfgWtKCt/vS13+Y8dU4E1h9ET+Sv8sdEGrEDc5p888skty/vMW9LDjkR1Zs0Or6OL
	 QA+qmA1ub54hksmB4FYcYnnbgPit8OrFkYkCgIWnDdQBKUIpup8OdJFsyZNUSWa5cmQJU
	 cGT3VpHUBp2f6SV5S2EJOM7XYrluE5BOdPqufZBtMKZ18Pt2UHlnkeAQwHV9jYqB6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=uqKinlif0Jndlu4P8n8nqLDjDqxhZh74QmOnXZBQjuMjydHq80dBZk/Q4Y6/zgVeMikS
	 OF0Ban2bj9D2uSHK0bbL1aZDubTw5PW6OS0PEF7VqfJfSuqoem8MozGh1V33oRcDOrxuR
	 MbHEFUqcEFpEPV0AXTSlapRTI8Xxyh8cfjjsCxSn4tlZrdg8seOLjjmz3pWPgSExsXLNZ
	 SOV3+cNW8j1qvIYFbEEGF/U5ZvorFRpRM2XHYdAeoCdQ4aG9+FRkNbi4ijFvUu4CZ5z7h
	 BUyl7dtFC7HyE0Z6Pn1pWTng8KLTgfORuA6UjOpM++zJklZT1uXgLuMPM68C89KSUQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDHAzVXE;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D9606A331
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8D9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDHAzVXE
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso6798246c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461703; x=1795066503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=zDHAzVXEkkuHY0ShkNvSCtsPCs21w1nCz19/rH6spm8cMDzCEoBsQj6pOlFR+Ba0wo
         Ry4xcybK969FD+SNXMuv9C1QDAZcjJAb+vzI707DtI2ZQGEHOBkY8Jqh26TczgBtGSGf
         Y2WbEqHZ52Rqmdo9PrX5UAoKqC082Bja6ljjkiMF9mQQaQRsW/Fr0xi28gE9R11H5Avg
         ujaEgJedER68qSKRlEI+d5VJoIerfLRJBt6M4MgMlWANy2Mau0kAJRipXWNg6b/2Eb4z
         /Y4Dyq5pEGyWq1n4ytJI1GnjENnegaiHeB+IAKJPnnEM2eUy9d6EnL9q/KQQMhIg/1DE
         r5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461703; x=1795066503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=durwlX8myzhhNhIA3gxaM5THlSvBycHA8U32FsoKsMY5tYfIoXFS4cEXAd7l16zo5A
         5W8SpfFTopTG1mTj8xmy49pIpQQHJaWkO3yNTwptRhb+r4bfxCenSSNMMkvci6vIdhXA
         G3e1Yfori+KQ+S8VgYJ4fpX8hKJVZ8tnXZ6py7bfa3CsE63wgWG1qm4qgzzoKSiqUqwI
         sMq7z6OhCOu+cL96LqKx01Fe4UNJdPWZ6QnPwlCVu2fs1MqDyjmflMSgAlR1D855x0eo
         Zibso9ulavnONPBzfqzIZq78M3y+URQjM3PshlRwdZftZVWEWDm3ccM4GkW7C/rJsmPU
         MQPw==
X-Forwarded-Encrypted: i=1; AL+hErHdJryoYmyor7lul6ptbysdpk3+9Je+8dnSDRC5KRtfjRSKCej7uLbwLjAUW3lxjTofk6HJ1J9ze+mcHNrWbA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9UqiRtNVTP+opx+B0n3C7exK5KcSDKP9CxiKeGnoVBrO8vndus
	gs6ci3voRtzhd85Sh7LbWlWvWU0qfgLn696Ktb8Uj6I+3JJNlBhiyAfK
X-Gm-Gg: AYBFou3G4o4yw87VKWYrsVZ1h3eXWmOGARMfh/XEPYksqzTaQhnLJjldoSlaOLm3wKp
	6bujnjwwec8o/Mwdf5YxuH1j1+Wv6EWrIgvULnHdEU/WSQtTWjv27M/QM+VUPJIF+qN6rFO/cF8
	jC8XkPPHv4tEtbiNM3JlMP8y1mDYY8cXdomn0UHf/lmuxwEvDTktygkL4u8HPDZnPAGnn9GezOV
	tVBxZRm/5dN5179coGtmDHHfgX+uovMtdyA2KeRvGtKf2W6gGYkvIOCqgYoGJHuUyakb7wCUw12
	4PPwhw+PFXtFPOww51NcsM4U+xP9aKiqFE6k858OxmoYOd0y+3YxhF+/qG23VHb8n+G77BSI6Nd
	60XG1UD5Em4CWKtBHoEuWoUpi9ZKCQ5PiAR+/vonjiX6jBGhhCvnWiHS3TJID3h3bfZp95lVt2V
	tz1OzJUH9gIHvwaM/KGGOIe06vRJpbFgebLp/QOJoUa6rSPuzKig8gerhRlP6tEnHH6YC6T/4x9
	Uk9Hp0jdEiuNt+rHQrp7FOdwCXOyCUJ/zBdukx+UcGqtmcINGgFRKd6ogR7fWV91R7ExkBAl2jy
	mFJ0KGF8vZ36RJS3bP0PCOq5FSKVq1Re3BcOEbHA/cyzVjgke6cgmHmRRaVgudVOGOtFDqrfWws
	/TmS62C0rTr1S2rBnDONF5y0ppONQ/P0DUP0vsXieTn2smChcqaYGy3yhyMZeXb3jqyxl
X-Received: by 2002:a05:701b:4554:20b0:177:9a5b:a89 with SMTP id a92af1059eb24-1b3c0325732mr4560857c88.29.1794461702806;
        Wed, 11 Nov 2026 21:35:02 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.34.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:02 -0800 (PST)
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
Subject: [PATCH v29 03/17] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 12 Nov 2026 14:34:32 +0900
Message-ID: <20261112053446.73504-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
 
