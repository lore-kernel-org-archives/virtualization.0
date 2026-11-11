Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365833;
	b=wMDgWFrvO5hYL1c2OuRKY8SUQf3MAULdbei4wsrbKBF4S/d0xGU9c/BRt7th1qLSDdhf
	 5JsCsJykZ5ZeXeF5sDDW75N6DqN7AEDmKxj2vixk0HArss3yDllf3ic6Xxk8BGvSIaeh3
	 fuVc0U2o/1iJ3Z5AnpsEl1msnCEpw4oPmm5SPwmcsQ2NsbAr69jBVbXorJFdhqW6s2ei/
	 HylwTvvm1qm/UGZbXxELmtWPRFjjIP/NH8hoci65SNjDXRlXm86ArnjBim3mTVEdYDYwn
	 sF3wmg14/a/qUHd18XJydZgLB76dTTUfhBvCXGBLQL5mAyfEDi+UW92H5j6cfabtGfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=RGItthsMAdtKedZWOKG2WiguYoiXrJQ6FLexE2ODvqDQhVFxxD+mUmMj6Q4oz2frKstK
	 fgOKbXnyq8hLKLF51RwB3YPuckJSljGs8lsNVQXtl7XAOxmyK9fP0xSU8/zpme4qRLR2p
	 9PYzWa6+rAw1iuXNj9+ffwKdea6AJ9A1nNcqGtCfer3jMPv+rrtTclKrAWWjY6gVGXNJI
	 7yj+qEWsJnOtlosE8967X4nMMGi9glK3R4L+M8xl7NKEi9/hMoy9R9517q/IPul1BzSfW
	 kfwewJmuz0r7yqMMKn9HNo7oir3Ogxja+ME7yrwHCyEQvaKc12NmcyNH2ONmby95KAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBdtMN0m;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F6606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBdtMN0m
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so5398429eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365832; x=1794970632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=xBdtMN0mKfJ68fAaPySF7KEHmDflWjfYYMHe0R3UdTdjrKug1IXbJb58nwV5k+VHrX
         FDKFAdRQCkgJOVuHyFizdZMyL9iN7IlunuP3vOdEt2YfMnGe3NVLqHlFpI7leIvybomS
         P+a32uDXJMgn+sMtvcOTHtnz3ZpsOpgVnVoUnz2hJ1HWR6k0xLIHca6GqbxVuXCfkwsV
         SSnJSlcaRBGIEOl2t6V3rls5yIlFd8DsBcGmI2xCX3kzeNlzcz8RWBNl+MJFCYNHercJ
         ooT4QIXcd6p7adKtyRNAb2y7Q2YLB64Tg3obyUmLL7HcfGYLadT3v1+5SRMEUW/6X+CA
         cRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365832; x=1794970632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=NMZn1PohYZp0eu9ESzXrPSbn1zZxQzixQAohE9UT1DvTtZbKoJYxjL63e83Bz6hayC
         J5ctOTjBbETTuD5uGvT3w5/QM4hiVku7Nb0GKIFhz9OdrCgEDu0UnviXyIR2rFNwvlmm
         Qu6Y0y/MCzBkcMJy/k0pudy6XOpld0gKkB757ok9sc1tFbLRJNOFNnBbgXlNI+0ruvt8
         mrdi8ZxyEE29mzlhMneDZh6HUcbl+/teXxbLjQVXrge14Abp1jtcjkx4vvlMZePNjWOB
         9614e5ZNtdZxPEWyq+37mABJjn3npeXck9Ry2P3fxaCVHENXuFunkxBR4098FieTbLBK
         uEpw==
X-Forwarded-Encrypted: i=1; AL+hErFbBZqK3oKaMeW605oRGiEx56ziIKBMsomq0Wi31oPjju7OnuQBHkkQKbVgH0OwNbR14L0zvH6B4QGCN4aRFA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+4S/TeE32SVEqYOWR3+ZKA4eJ/aDhCKQBLiqFOhPaS7qhyXIHU
	H+4bMOki4rMYvvc04yE4lBCJkOFULSsIj3+zHfGNTZ9RdC52LPSj34ZW
X-Gm-Gg: AYBFou1CFMuT46J7U/7aRjWS6LoxNAey3Gfefhvf1y7kAv4KShqwLKEiFCOCsdBMvEQ
	mJWNo+bkJVwJg3WCfdnn+IsG7xHqcIwuUgT8sGre/yuuNwCb40vk8xfq92sfE3rzueSeAfxtJcW
	Ex5ONCnv/nyMGjccWqdKkfI7nnNWuQA38ZiFPRR//TvFbYFZjc/PJHQIkoHJY8QNNl5GQi+Sl2J
	53o1uU1mt3jNukH7Nl0lTZ4RTOAeDVB0Yx6vOx4kOAZGwtNkRHJ+GVC+oob5Z7DeKh9YLT7TuU2
	dFUlQU5L2W+OCQ+Thet9I1m0fiZ+A75q6KdA2nbuFATHmATTrM3srKNs7y9OHFiiUzaqlOsvYbI
	+Tes4/z7MZDkrXIvkeSNOyt02t63ZzlF6fFHudu2pU5wiUIBk4kdV9o39xCEnbjR251KE5EZeBZ
	KEzJrYlvKGL4BI5z1tK/OQwDehLS1A5IxXQVTApum5IfIDJ0wFVsyRuyWyG1NHCZpX8QL1YhlOa
	50GOL5JolpxtdbQlTV6yWB1uPOxP9OlfJSB1e1gjxnzCJGrCrjExYy1qD4KwrhYK1m55RCqbV9f
	sH+QR/mvYW4RBdm7PMvZALJgEDU+ZM0ydSIfTMGy8cIHYBH7lRJ900rkzl5mNt+S1tKnaOs+Vf0
	xQyOIhWOUt7M9vZYMvxNSIzFAYqTPAIk9DEDOKrmlQfGS0MY=
X-Received: by 2002:a05:7300:e7b0:b0:36e:aa5c:7851 with SMTP id 5a478bee46e88-3768675e462mr2401785eec.27.1794365832271;
        Tue, 10 Nov 2026 18:57:12 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:11 -0800 (PST)
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
Subject: [PATCH v25 03/16] ALSA: pcm: add an optional reset operation under the stream lock
Date: Wed, 11 Nov 2026 11:56:42 +0900
Message-ID: <20261111025655.63951-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
 
