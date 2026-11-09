Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201395;
	b=5lJDDx9VaB8iWPIUadQrIeJGyQgaJdsx0j10PC7fFBEQNNmW+AFrhWJdD3yKLsDweuxB
	 MeLWxXiGOs6UCIHxvhvVXOHcQeRIYBcOGRgQV3rL9zyrAx4lKRlJxTbFGNPXGiU1o93TQ
	 OMzgreOEAyzzd7tLHjEOSrgogybzAw0pjsYqAzB06fQTrPWFa4pZytN343puvxt4ekMrC
	 Jp9+1SAHseES+AB9zEUgmPcuOcgfY/r/UpSsCLSWLcxk2NpOILAIMqtH9AVm2j+90rwL2
	 /jQITvHGQ+Hk9AzlBz2ucARXK+PDRXgUyb6yyFXIiRnZTIEFLp6iJ99Mg3gNPCAsr/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
	b=z3t4btdfjP5Vo0JDMIuSjefz4+tRRz8Z8bTKfkqn8xuETWnzQfNIeTKvxRqq2/THJoUO
	 P3cgp6y5sx7YIfhQq1ISvHuK7PxOH+8Ak72G8zCUt/rSg2cfANU0uFTXC/5/X1th7Jj6/
	 mxzvpujBVugBIn65rjrT2VfzRGp6Lpm7guLdka14c573TmnIMH7SuUafYkKNMuiQR0IrE
	 2Nl6VwKRxiT26OWOY4FzH2Nb38iMOhe7LNyq3FfN62eETa7JEyhoqIuZGbAtlyIpe568W
	 6Fuq489y1IFgLvOHBv/cX68tAbbJMNHVJMgCafJ3kpINf+5voVULIBGQHujpw5AqfNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6dbeqyQ;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C9606D809
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 614C9606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6dbeqyQ
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso774090c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201393; x=1794806193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
        b=P6dbeqyQyf8zwjEUX2hFHv38bR4vKBs1Qa/gOd/OVcRpR69TCkkZ5D8s5blcKuau/p
         OtqvFXxFuQdwLQgRrpjz30lWu1gr2NmrBJhwzbLsxA+dkO7l3rFrC4LeVL7bSd4PV3T6
         sbzJDb3Y2qV2qR5nrN3n/VTJ18NYcbeNWwwtPJhXlYXDNHHO+D9PUOPrrCpyuLH39Ou1
         2zDF4JVc4lfZwtkn2KZjero+QjBz2sLjsPgb/7RDiKJKNJCkE5IAw9X8un24HALEHxV6
         ZME23sxIq584LlT+bU0/g+EjOy80o3nehuxhTAT4QDW5QH4mcPP8eeO9/QI2qAbPQ3y4
         87Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201393; x=1794806193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg2vIzMEdybNIlex02QZ7Vn3MXaakx+B0gxwqcZG4aE=;
        b=R5mzHC7RU6MVAn/NLmoxJDBlO5T86cf1wU+DOAnWmtWTkV72fqoBU9H/F8hKrlfoNg
         nPGNEPAoTERF01JQRM72+wVZ3/288zf47GM8PK0WYWxbRs4LvkUSLgRLZaAk/e6yRWOM
         6S83JirnqLp0BytQxTSQw0CZ1jJLlZgzdDttTe5NUH3iC9ndxOb4T5drt9eJ+jlkXAz7
         GfQwOXKjKJXefQYekewYu5eXa2l2+AZYxRF4gMYqNF/0Qc2JxNxn4/y7jz3LyRaQfi+k
         7/xNPBKO39G2tJTlAG3IYw4g/hG/iU374lxbek5dPc+4Lufwfh101rZI7u6PmoAL4pzZ
         xwNg==
X-Forwarded-Encrypted: i=1; AL+hErE9ltluQJrfVtdxZfq9KvkpKpm1Au3ZwSa/L6QVZ4qfhC/ext1g3VDL1M+SI2T71zvbEHxxeHA/HY1Gb2eejw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9NHdLF5ATQ/X9Svgli0dq+yOfi20gUNyK+9xRrWPwsFxs4Hs92
	2rNBe47WBz39a/3X/DMaETqWSz6XWPM27bF5BQsRBz6ha1x29DjSWPiR
X-Gm-Gg: AYBFou2aSBCNAC8KT1QPLxEWf3rlVkFofB4v5SJmk9yiEKxd+2h33Tavw4SEV2dZahz
	aVBo2bECejmchv3C4N2iD5ce7ch790wRVexuHOJ5sDn0ROm5UdknjWZlcrfavjTmJYcdd3YtYiX
	eqgfH9hUrzdYw0p0Qx0/wF8+KFWQfHcieZTWqjSmq9g4ufmJCrh4DUzR51nukgl7YsZ0vYTUEAO
	rqluTv0SJ8je+luEzUWxLRFZ5g3K/1pEsJo9BpJ4UoqMwfCkWFO8RiSfGskslMFm4Bjb+aFpliy
	MzYIf/RXP4nM/c3ZIO/7I5GkG09XuGDZjhwSzuXuvFpbXlJOFM/P2kU/rJtxWztUk3bGW2vjqFW
	z0cmUL8y1w1U/p4NCw7W9l+DDDfmyhrlaEOlzK+bpAZxEpRup/YbUEqiV50ffkWGseROI0qbzmQ
	xu7jSkSpz37fK+OJwHr+vkPTV02gXKXhb8EpFdr+P7nH602zmvXBlSQb4ErBTCMyXEMqWqZ2v1J
	6nIYx7iBzlgqojCAounLk0xAypHA1001aFM+/+BN+EUffkEObL2Kxk4rw6lgiis6dWNofma/8WR
	3WNKYJgsSgi8Qs+LHV/DRSMCAWDB5Gsp7q/nRuby7KnmDn0vBPrOUYRAoVO3G5VXTo8fOrUJPuS
	1lQPOfMbldEUyRoPOnNKyz1p9lXza4lPPwmHa3lMT+SkRjE8=
X-Received: by 2002:a05:701b:2705:b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b39fe946b5mr5229948c88.19.1794201393273;
        Sun, 08 Nov 2026 21:16:33 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:32 -0800 (PST)
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
Subject: [PATCH v22 03/13] ALSA: pcm: add an optional reset operation under the stream lock
Date: Mon,  9 Nov 2026 14:16:08 +0900
Message-ID: <20261109051618.22506-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
 
