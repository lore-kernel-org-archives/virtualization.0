Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923621;
	b=ZlvspfIoL7hsyKKwGocyAlEBhQKj7IZn1N5W6lbMdh4JV9Bim3bd+osMMizJVtFG4rEP
	 5nPvcLeIHVXsglcm/grWZwpsKczr0Pzt23mGWhz1h+NMMod0KGmWTY4O5oZHezJNWOI/0
	 MxeFO7HeQY2nqydA8WgSGWG+gM+gArJMBTJPZ1PE8jwg+pxqkrOowtYEKeAzUIfRGM8iN
	 LPBr9m3ILzJshRF+7bcHXqWTvq+KgmHgoVJ7v23DDRuhhs0RCDzuEbjtEf1Fh4zW8gx42
	 mUK0Mt/IkWnaK/sniCUV/exSXEkMEiLZ5IdX4bGa2eGoiYl8kaoeaEK5UZiMbar6sVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
	b=A+yoM2Fammi7+s9YwB5hQjexdmGnzlyHOX7yCg4AgToi5W1gOXtNPcU2rQdn/h3jASLg
	 tGdqDlTTomTQTzegTVYmk6VRBGo8Bd0fWzTUAT9NUHKExST5z5XwW/kJBmVhUFk5jdDB0
	 RH98rk7vXQFgvSM3vPyHVwGEqgXUEKjTVwUJ+fKwvRbeqVswuBzxt2HtLryO0KgDFFUl+
	 SmJ9OK+iMhI86gZk57C1YXJl6jzoVc+1gEr/2SXoqh2h0F2iEpgoaLlQa5KdOMwlD0FAv
	 SZu+FiOuIhXSGv5PSi2Q03b29HfxzZtLwDkYqwd1mlR3LTmjR8GBN1mJmhT7jbW9ecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkpXayWY;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59589606A32C
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59589606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkpXayWY
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso137298eec.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923619; x=1794528419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
        b=kkpXayWYZEbXBl+CbcQb2ebfdqFJ89mowOe9j6prPu+kZfhr7+l8uJJrI762SynPvC
         8oOupV+1u+ZnWb93WA4QJroH0QaILG60g7V2QbV4URGaFJfXvDoU1LsqPOMLGKVD5nNR
         Ffk3HwDz79CEcBVx4eLpRylwnxlDdAyEn3+MzEIcOtdh67WM3nn/cpuvrjGnbydH47XU
         bleaNMTknkYG7l26i3yUlnGiIqPa1m6ulZpnDaTRg6Gk2zAP6TXbVzRTa2QqIqkb2cPe
         LaanG5MzPAc+gvMHWf/JxcSSZ5oQpx2rEtEe7M5LePd5qRag+bELOrZOrpqa9xGGpqvx
         SLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923619; x=1794528419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
        b=A0awmM4RQEYWTCX7fJN0l9TyXiW7VJlMFry7RHGMuZmT3NwmyNKEmYPKKE/uMOVndP
         mNcLykCs0qfnYYEG09U7NJ2gBDzGtVEOaKTh2uOHRiIGuQSPCUFIzWddPPUlarexYuhR
         xOgjSkRVz6S1B1s4fJCPSmw+kvouedp3pDDZmce1EGfqC3tPRTWs1jljYPFFXmyb2ffI
         BY4rHiTg19VyxXQwrPwolUYBTls5gxJyUNDtsQUTzEHUNtxArSAurZAJ2R1iEsuE52wO
         e/hbdEEA0yelKXQVf+YUl6BmaeU5pUWOyaVpn/uS+1n7b5aqCJYy28V4VKDuZ5NY/16f
         rVEg==
X-Forwarded-Encrypted: i=1; AKwUvBzSwyV36CncinqUHyS120Nx19YCS1tU/ZDovsJe8/3pvEmgyY7fsFdIXxAzdH/hNCUa1Mi2ZBiluYHy7uTunw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8KO1uf9eIdyMW2pRYYYN+txTyxQO+haMfbYwyETTb89/9Y5caL
	T36aL4nOKUOMBy9MvAspSDvkgpbiM+5Dy//mJ0cVUFfBUUQ05IGj7W3F
X-Gm-Gg: AYBFou2YHp+YDR9NutnZdQXO52IWmEyu8QPpLAgGF3UwFowyjlUFzi0Zp5L1RWkCSK9
	7+l/aQIOJ8XL6sncM0ULQufnR3hqPGzvWWwS+8VoThynshcPu1yQvmIi/miJxs8ouCvaxgyDIjm
	Y9AjE1lm/iOdxpSnXbR0Oq1L9z6llsKJT+RIh+3mjCRJCl2twIkJzPDcJZHHJG4OICZzEA9gpYp
	CcssRd7JTh6hwV0WWPlcwNhlP+/WiijdulviiTbjzRy9j0cwkduDQTvkA0R1O4pG7WYVxvOOks2
	VxKrfgV6Csp4la6ntFmtXL+qBMm0wJd7MeZeIw0pG9M3Vvni/sRScueWtijWccIDi5tBhO+RHmm
	X3noPw9dya1fkPT2sGSbumu4vbJFyeWl/ekUUDSPjOmrsReT7NByHaxk5HVfme2HLbdyoirGpuV
	OkXdcqxSGPHYstSF5k8nP+zzw9uwMtzIzG2eLerEvetxnhzX5+B1GYlqvM9m07bSfCLY2tbVcrh
	9Q6OrTVgv9QwhslgJFXf5NX2hIuZJCpYjOCPoQU/lXUFoqLocvmEUsBSnI+K79zobDQGwca7sim
	ElN5BCdIDcRXnrYLXW51PFhXqEmF4OfdIyfW2kEXyvvK/pRdnJFkNv8J5nkg008uXNUXcRI0Db1
	iyw/nPzyqvmtfjH8CEU0rgg6g8ONHx9Ppu7MuC+zEecikk0Q=
X-Received: by 2002:a05:7022:29b:b0:1b2:3b5b:b80b with SMTP id a92af1059eb24-1b25d31548amr729779c88.8.1793923619323;
        Thu, 05 Nov 2026 16:06:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.06.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:06:58 -0800 (PST)
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
Subject: [PATCH v18 03/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Fri,  6 Nov 2026 09:06:35 +0900
Message-ID: <20261106000644.20460-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
 
