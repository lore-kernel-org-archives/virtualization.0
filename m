Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355562;
	b=JT0OWga/GV5J3aDcQc5oxz2WTvJSETUz3Ew/7SFaiIrv31+4Dybg2bIA0ueuuUpBvRup
	 oe+GrHJFSGia36SnJPZU/qv29sfEb9z+LtqNlEgVs8U0Umx/blXgxZmDKZWXFWzDR8MvC
	 sTs5OHmKBUTBYdErh/sK9Z36fo/WYYet0K738uM5R63C1A9cTKCnk0dXpuJ8RgZFDUPQW
	 ZlZcl/e638QFujK0ietW1mUcCiLrjnvTZA3AgIX57XN3rKAwesBVhaNlO0xtjLPvBybG/
	 Lq40X/ZGCNsIwd++eD5wIQDAXrbNECN8R48mM6aZIA43DzCXET6YEkVO8lyQ1UxBBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
	b=h4EptbGv+ul0Mp+9fvsZb1M2fzYy8Pb9HDmiM0o9ZBizLKwjDidtuOnNKDRUy4U95pP9
	 wc0vBbWiDOewFYZ5LwT+UR+I2oyDf+nTjjM73KlSn09Vab+8wb9eYdx48Gh/1JVdl9uqW
	 vwedO8FrCcnCCIHRo+i7Q9KYAjG+Yt+hgLcQLwTKXlOBeZsizANdWv2FYlMFWEqAZUaTA
	 i5XK8YQf4QWWnwsA5OIuN8iGTT8qavcs2cvZX8rbeDJ6Td3v4m1HCPtoaCy7bHb3WLL9D
	 D1njWL6cfCUWciZrhil8bHuLreMf6zt5/EyByheHVVjBNn05wc3VyFlMsWXrRjl6z8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8XUJyCz;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C75606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C75606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8XUJyCz
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1482323a91.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355562; x=1794960362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
        b=n8XUJyCzlslyv8KdCYqEVOz+ZJlSnkQ/GO1YYPcVCJRcwEe1EiOJpefLNvYF8u/gt3
         NTx9bwiMW7DxxfxyfZWhOKBslHPJ6UMd2V9liDEv3ShqOliuOAj8os1v+fevkANKsDnw
         zF7RUMRRgU8NprbQfO3vaOWbXe9UekyWXvQRxf4me/a27ikvimZDO0++WQt3jsU9BQvS
         HKlU/LK925qGZvHrrot2ZO8SFmHjE1XXhfn7bRK5RN2Xf+Z9EPjHkQw2SE1cFeXjMRko
         aIeUuyqCxpHmUfJCVLM2LILbBNocdk56h8nWWadPUChbDiesafLKRQIs06yfi3gwgqfy
         owwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355562; x=1794960362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
        b=gxBkDC/dHz5B9RzFRyN6PAJiMEVIrN7tIyR9s0WBQbdPZj7hBYWKeTxAHkBZdQRZhF
         gNwoYKk1ByYQGMDJN/7iPxYAG3WeACt7g/eIGHsXgZoY9tJm+29mrPkM9Z3kgbmgsLKV
         1beK0AOcWrC/4ybqTu3SX6QQYhWmR3Eu3LtUIUbr3fyaPsM/0yVPTGr6J6taW8tZjPzI
         anKFiuvgo1YEysM1F7qxlEujrMel6pF22v4kFC646iPQ3ERqjWfQBikmmfxdtDbQKSVH
         9twRdPfaRbgNnzjtJKICTpWg/GL1ZstWIj7ErfGIPPKyGlQUAPDY3+Z1V6xwkzA88QcI
         rH7A==
X-Forwarded-Encrypted: i=1; AL+hErGTH0/CCFN7FfHrr1V3bN5irM7u/VLPMF02VKqpWRYMh6IQRU5yOqRX8qFubSNIkQa+98FOghvvyCha5Bna7A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9IbooNQ3GvxzuuKWChO6wmN+G82bhPnbyv5qOaYOY83t+ETCOU
	O/eAbITv6mjaVeugdDid6urklKSt2Jgu6923/AZZXq8xxe7/mjyNlGku
X-Gm-Gg: AYBFou2NbabO/cfxoOU5hSj3ko3QrffLyomWppuay8+kuhziEyXoqs4td7vTg3wnzUV
	x3kF9U70i9gkc2u4qA1J7eKpD/Edt7UrgV8q/KBb2RSj2GliuxDhzn50HZdQZFEwQuXeZ8VCr5e
	8CiDLTE0eAK5NTIPrIpa5CVoZ0gz336VORHMDi6gC1Y1ZtyRsP24zIMI8G9mRvRpaeitSsL4Bb4
	baX1QhsSDenTZg64MpeMnOzCFnfnvWl14xhCLl08Xv7jwge+ENUqEt6r9yL3pcHXc1r66p18WMG
	u9RK1lY3XizGoNTxnP0Cs93jukoSwABJvUQ6QIt7e7OoCSzoBngE419iKfJitjkmIf529IzJ3ql
	DEhMMY9SdGgrFluZ52PIYGu6u4k6nxt0wXAxkibQfrvW5nnFptoYDyVtApRNLlvmmcNueyw+CaN
	aXDhBzyzT0XRIQbB8c9DSSSm53sLj/fkRyeTdQpPC8HtxAgm589v63/mgyGb1Za7m2oqdUYt9IB
	o8P6/b99+G7DK7Fvb9zBfLOa6yijoaYCybndws6PsbIpWXTdYyqhCsaIBTmMrnWrK7+3y2jV3gF
	xoC7lNd+Vh/3bQHcUwRIPQsFKmtGJ49jY4IuX1GunR9qdEjXJI/MyFmjyxnwF3x81jTWf3AWVwJ
	RBORTbyanK06mMqGObP6Ri8gac6eOiM6ffWTDhlUcvjv89d0=
X-Received: by 2002:a17:90a:e185:b0:3b0:9e2f:cfc7 with SMTP id 98e67ed59e1d1-3b182f6a71cmr602868a91.44.1794355561646;
        Tue, 10 Nov 2026 16:06:01 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.05.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:00 -0800 (PST)
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
Subject: [PATCH v24 03/16] ALSA: pcm: add an optional reset operation under the stream lock
Date: Wed, 11 Nov 2026 09:05:30 +0900
Message-ID: <20261111000543.28550-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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
 
