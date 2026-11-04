Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758683;
	b=Bqfne2st9iOesjpS4OhSBP0djDbuqkRL0AytmLtYU/WX9kOfbjuEjyvSX51pHiNXUz9t
	 d0uhtvdZ8F7En3ZfYM1o525T38bCWcjC2F49nDAvc/k9BdcMQIvZ/lGJ+aUFXMFuAOeYF
	 +yTXKrOfdcgNRdirRBdd1dw7KX8ZYCbhyE1/PRXveaxJYloxnwu2hfrKcn3+wGytb94P9
	 /EE7GgObQXSq38qR7d+mUlFwHnnE04H0igYK8QBzdGRqcTXkKhu3Isz6XFBGka0PuMSJ6
	 YUZx/TLsblCd3qGcnx3/peYMn4EUKSAV/8jG0Z1j4glrbaQjNHiSe4/dedNDGPo5xOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
	b=iVUxnThv2tbjSuMpn9RObmCcxl3uE8YGdsqOy7jWsajN4fTzk4vTgWenzt/yq7jfHUWY
	 pbUElDk/uCeXgxE0FNB5J6dmwPUoRUqf95f/Y4uR6wEGyPYVspDcKFi2qsSOpsMRvpyMk
	 yZlynjsBGAXyEZFXnvqMFGy8WXpNh1p6jDHMHC9xw9RhKPiYI2ol6hU93jw1ZUiwVjDzV
	 9XO6Wk49/qJuFzYFkjyVYaISyWJJC+mtXkH3Qkn983IaLk/qNK1lO7ipcFfs70DNGWR99
	 xJ1v39mxAAiEkmJVHTfwzk+qp6BEnLkVKwb0R+FwhMdBaz5hYOjLEfOB1GIbvRcsxhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VS6jsa4+;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC3606A337
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACC3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VS6jsa4+
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8ac1f2ff78dso654806b3a.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758683; x=1794363483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
        b=VS6jsa4+YMiuRBwl1AtWLx4ZuKJqh1y+63Y5/VcweN0eRYONQ6qYi1UqqX/AAHyOcG
         Blu/Zb/w8T5wVODCKxxp0JzWHTCIDastcnJP2gW0fwLTmss1CZrei8EkfT7oUqc4b7VS
         r8YrUKSnTw/82xvlUVCxxeSN7l69nAZ8/bhlFzCvh3mA0qhcKNy3q3/SDDBdd1kd0flM
         5uZasDM4PF/CEEBaNl2xlmsZesBRFqXVGznnqATDDMKvFa7AVpIlhYkQpYzioBpcvI8b
         HxGKKjY/6HIFbQpUbfWNlV/2fYuYMOsl7p2RuazT/1bGGdk5+d+iqpy86P1+Wq9PPur8
         r/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758683; x=1794363483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHKQF6GlsIfczjgrvixXpXdQCWhSz0d2+kn+Pm1nr8U=;
        b=Fme1BMVRWyFFiVErcj4UgRvq22RE5qO2wwXybCbX85HTIZQ2rZbkWRcOiiyQDI87wI
         M/fvmamwtRMk1oPCUKzSVBLV/7a749lB+U5DNbcQFTysVbnXmLpojYobRmpccZEt4rR6
         8tibd3NNaSPzVWcuKoMOKpKoae/6HsfdSamWF2gp1fKfR8kNduVptICohCsZ2lRb2CPZ
         Peyb5AYgQcADeyG8DqWoeEIGGBVoU/oyRKo4PKCz4HmZHN2Rp7/OpbMxthWKAK51jjx8
         4Z4A+h2ts1Vp/isXxUUmDoTcvBhpHwzcnFqoY1TewSgiFPzCKMf3UxecoSzL0jA037kg
         w6gQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7lciuJcdZV0zVNtTRqLfUtAIqncTVn85sTlSlb1Osrc7WOLcJ3Yhv2fghFlnOfjThmNPb9xbXKc2aVWYh4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+DF+ewd2NL/z4uhN1G9p0hDyZ2w9WzpCKIM3wyamaWugNTMFLq
	qjmq2g/TpAjHFThBOeMOnxplN+p6fICJW7qMzWXN2xWrhXBQk3qV7bPn
X-Gm-Gg: AYBFou19nzSpNOyysfuOaxqZ6KdxZMrBiEa6kRxKJUTiN6bEFllQV2VF0ARhZo24mFF
	zbNNWDrU3DWsRv265nEzfi/qydzWW9u81KuD6vpPSYG3EZzeEiItz16uzznpCJRJMMPodsXfVVS
	lQEGQKzcRDgERtfu10L5wlhuo4RTbnnyFLuMNtx5d5Dw6qT3n9M0yY9uaCVH1OssWMdO9BmaRQH
	OpIkQsR+MnnnD7mnzoUGQ8OC3taMrKstCdva1GlfKG8rnXwzHqaEPbMwz3dtw9l5s8JXLnVGt54
	5ORg1yYSROQ/j55+bIGQSVfG5UuM+30tvkvtKc8kObyfDfl0anXxeoMe93nCFBmy4q8s0lbxmXV
	uAQIWxSpRYBJ5ioJX0RizbwqHR4xj7iN3vJ7EwtAghGMk7nwqFJF6qjCyRHGest3sTSLYQIiOEg
	wD6AZBT2eAiK66ZKwpyjH07uON3fdXeldNSdq1bnTOFtuhv0wPoIfygriLxe/ouczALGCfUy5uO
	b8s1m5AtALiaYsvtKeQsSDCgDvojqcHe6w9MKm2GsjX/WRlkGRVudI4tIWjgKyx1WMnjCgB/+V7
	Qoz04I/UEizM5bmud/HHj8FaX1ZNRn1NPjbvD2UjlLqjkmTyH+da7FH0D313tRQ57DTr+Uzt0o1
	4dCEyfDnQ8II9d55DBCIjQlRjAWJa6SBTqmEV0JPEkSm+aOpW4w7sFGJElzPr+X0it1So
X-Received: by 2002:a05:6a21:328c:b0:3e2:2b6c:2e7 with SMTP id adf61e73a8af0-3e913bbc026mr14402422637.28.1793758682701;
        Tue, 03 Nov 2026 18:18:02 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.17.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:18:02 -0800 (PST)
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
Subject: [PATCH v14 03/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Wed,  4 Nov 2026 11:17:36 +0900
Message-ID: <20261104021745.57733-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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
 
