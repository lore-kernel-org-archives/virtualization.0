Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466187;
	b=UKrL9l53x2X9EzyMF2tNeMdWwueBOM63tsMz56/VSfBXDwcQPqs5bQRde+tzbFUmFyJj
	 p+wv5fEtM8KMsuNbj3OoPIwGVqjtLeaQPknDJcZE/VqhH5rVnR45cdfMb/ueVwXf1NQRO
	 H8uKe7roGkAmUl7zDI2tX7Vfgkl22IcIXQOXCcpH3I6qxGIF9jJKCwNvFxOKzJL/3yvMd
	 VfAA1alCFtbSA/np1PFpj3FRW3JDLlcyzNd97hi+URuGlhxZaKdCA8FKf9QRdytJFg/6a
	 MTpmOlO+Thy5Nuvpv1wkCy3Za/FiYrwtFYiI+XUYPsh0rUcGoVegMx/9y0uFpr7OknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=2nrHXGLKoQmPwYlaHAvjRFQ4+Clv2TyVEbFFzuaNpzb+G/eSXWF4SFqlY3N1LwRfETp7
	 fDEO8ZHz2MOYcvQdUQfocf8+LgFPuBv2w/XGf83srGMIU8AVhyGU1oMTXfAKaN3eTIh6/
	 /uIyeK8IB/Nk+buJV8DmervROcFzp7YKNgVeot3f225DSB9Gk5+w8mu+3hgP4s5CaTbO/
	 1yjRe/c/4LT3J9ZhTQzFxXcDctEoUWEqC3dzi6P6LwijnkRoQxUlzDmvRv5/cC1mUUe5f
	 91Ct2zhmF5nP1pVCx22emCapK87EwJ1vS15HXoEnxJ/+ljWnpE5h/f2BleUeMy4jszQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dHfhTKx;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A2606A893
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5A2606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dHfhTKx
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a594d313a3so2345816b3a.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466187; x=1795070987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=0dHfhTKxyv40jIluKkismv8PFvBwsNZOoffWXtaFKF5JxW6uheMG7XdEf/H9300KmK
         UzwD4lmP9d+NF/Ur/q+PovV8RIhdWWSdg8f27k0atuy/Hkd6B1hLqC1HjUEgdfpG1ELX
         QitTu6bbTiaWTD7dcVQgUziYZSfK8UU+RWmeHZeUyXZWY5jmpCqB01PREDmO7L5MvoJ0
         LzKtkiAlAz4ImWJuW3Ry6qO8tYr6or8xN3pSNZw1Xnr/+DhE9t/dBIH4T4tbNl7J54Xb
         1WiNUWBw5hTQkYF6ctoTJpynUriHKsvJKmcLoxGDLeFTMHGMpeYs0EquOmNwS8UMVty0
         UsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466187; x=1795070987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=ws/PLxYa0ztOovLcoLdlsecxbECv9oG0NQisTyh1wQn5hjuEEhBv7Atfj33z2H9Y8A
         YPsvVZk22PEkfXPq4egBtwA07iFoxqTC1oa+eJ7S4d2PelW5qZsqAno5aC61yjkrpNuo
         XabflfIO8QstkGspCEXfvkchLouYafyUcABPNHLZMluoed9HLq7gDDyX4qjaV2h/7Ur0
         udST3DGXVW0xQ54E6ug42FKqMnns3wPtuzRSiet8xZgKD2Xh1wuROAW28k6m+Cff5cS2
         hzk8mPaEhQ7VwKAXd0I1JOtdtksy/pBsLqbCz6SoUBU2eZGdT2WCkfSTLbqqKp3EcAbT
         2eJw==
X-Forwarded-Encrypted: i=1; AL+hErEMuEumV8jrn7bDPRLgmXhdQLitQCR0umYKCHCAtgsgtTUKFyFJzB3+tgt4COrn1EhOqnODBw9rn5nPu5PZPA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+qgMT+qU0NMIXK8TnAlbXDTKYmzDg4CPN14A4oWl2YohqyxiBX
	MIaP3+auvAaLr+DLwla4PMkYu5oS7gtFqe+9Iqrstfah9AP+THRDM9Wh
X-Gm-Gg: AYBFou2kZkhun1KyE7b+naK/by8U56WXgnIdF/Hqec+aQJt1qojhe1wNilD0gSFTuCP
	exSwhZMnhW0O0QQ0byTXAJWgGH+Otf71w/Ba2k/YTv0CRB21h7h4JuQ0a7fSiIFTt0srNtWCGal
	OgGqtg8XyBhQUiOc5Veb04iTQKrUWDmJBfWqX1FsVeAhj06nP6YUgfOhMY0qonXKZ9VsqmZor3v
	4F/PdREQkvRNq01QVyGRyM44A0Uoz9ZyMwZIZ5+aIyIVpMArAKFHOxFSHgNJqY4NdkRb7qDR8Ew
	lU9l8eaqJI2Rb7/NWN76r/Ih0LRMk0pjIeNUsB3KrlfxW6kXhruQopOykj7O6+XvhxmWQjtYvOp
	I3WlZ9nEHKHq2I6rWquJ6R2HNVUWbVlS/0M4/Zy4KgQIihMdW5MLW/iYQ4xdPeGdVWkUOV2JHQI
	w6vXCCGm3y1IHAeiXVgC+iiBrYeE/Rv5ZlDxV4Dbthp3+F4hwJbcffv/fflxYQPEeIrxIrFU9OZ
	3VYUUVThzeNKKW2Yd7QZ2GP+w0cf5AA6LLtZ4bQtM4TKJcKeW4kLz0ap0LpjjT8a0DqhSv+QjH2
	9vQQowvvHc9+zkMChDWX7vjkIKpv2uDepTywOPupr/I30ZF6Mti/EXkdRA8HVzEhgcSifkYHij3
	DArQQUVp+OfeNLxkZVuYqCwzOCOb+lIBDcP9FgQX8d9DNQR8=
X-Received: by 2002:a05:6a00:84a:b0:876:194e:b8fe with SMTP id d2e1a72fcca58-8bc1bcd3153mr4592079b3a.26.1794466186637;
        Wed, 11 Nov 2026 22:49:46 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:46 -0800 (PST)
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
Subject: [PATCH v31 03/17] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 12 Nov 2026 15:49:15 +0900
Message-ID: <20261112064929.11211-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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
 
