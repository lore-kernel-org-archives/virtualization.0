Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693339;
	b=sIYFxj1yBpyrpfKCcAEJA1G8t+yDbSEeSvHh59O7KTO6eaimQZ2YP6tJzXMkbYvtI24L
	 Q5mWQJtWX3FojiK0OZ0TDp/ap1pwfsbY+3vXbRnb4tigavFLzNFsTiOd6FSlQgVn35HaC
	 9Dbq4QWNCC/9Aiq1Aga6eFu5rugzt7kflMJD1lvEaiBplAXgliwO14xXGDIbchDvVvr5x
	 t5LjjaDHZX1O23/g8nqTEytc3M3pznDCfeOiOiTZx8A+qhyBLaL7C33nb5SvshN9YanO0
	 8bxYuGsORqMfE2u8osY2JlB4z77VZOcYQ91dcRc/BivCM2fjuG/0GjrhLgYmnSh4+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hucEkfetCBC1eNxJx4T/MsrsrXcFb1G1sPDreCwELqE=;
	b=xRRGTmhE9vypgkNcaeqd8ck+0MOPkkqeRkopJATnDau5m+fxxLAem8t9ybIgGxdgcHgb
	 kuNJV05zOUAdiRoTV+ZWEYOvBvUUf3sdWBXA/Jos4964qQ4MhOQ6WAnUBcxsZmrZFonvp
	 OEFL3FlXpI3GW64Zq+i1G6mcMUmEW94OeaGOwcJQWrrwWOtGxXhYLyOZVU8//8nrAFe4C
	 Mh54QO/k73hSIRNTMB2k5oESSX2awBLQzl84DrRacM0tKUJN7UI7wep1RlXdwR9VaHVe8
	 g9ZFwpMXd4n9ov64xbyDIWmyzo14Pv/3dolj6J7vavXv23EcT3vfSLQDzT43TH1BiUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PomtMchh;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA0606D814
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CA0606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PomtMchh
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso6816301eec.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693338; x=1794298138; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hucEkfetCBC1eNxJx4T/MsrsrXcFb1G1sPDreCwELqE=;
        b=PomtMchhi4NvCRxznh+R0eiXa4vQxKlJWxFp8ktgUu57x5KuZJ+z1ZIjenMmWvG0Dr
         Wa0SurPuBOEBeLDCw05caMTOGrQGEsGYaos9xK0+FUQDPDEOBBVlmctP4gnlWmZ/lFUP
         cXcf0hIyHryRSUDdHnohHNDQuTqw614K57cXVoVvhYsdkZI3D2tZUCVePwm+NkTX56Qn
         yfTET0iVnv3qn/7zX0nUVl06qdjnUpD2sZD3JSadVaYrBM9d8lIqF56Uu/wDmAi+PAM6
         BodqdWQzyGOPBkqOBdbsvDt4wVd/HJhMd+4hyYzxCRXhIbrqwleW4tugjwPnOYoBohS9
         acRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693338; x=1794298138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hucEkfetCBC1eNxJx4T/MsrsrXcFb1G1sPDreCwELqE=;
        b=e0HC1FhtOX+knHUgEL35K1VLMQNdedgh8jKqJ7CYKaDOHfgGoJE4eagH4A4CZ0Q9FI
         OUMj4KMfHfbkhKrHN+AnevNp7nwifCFGVxxhWIWDf9KZ2OELSgax9z1ul3+Ecfs2IQ5m
         l0XWvlrbd+gkSyvPbNWE94xGMkTAt9+MzAJ+qb3RSA+sk5Xw6XewZrpsLP73RmYSe2dh
         8+Wykuan0TACBYhr2QZFtgavlcsLUI3e+6pgOqumJ9IjokHUHGCLCBK8YKn4KZWuRxY7
         aqK+9YVhrdgI7TjxIWJxEKH54QSakOp+Mc4da3tA1gjA90yO9Z7sIZjUL6bOZPNPLfv5
         pckA==
X-Forwarded-Encrypted: i=1; AKwUvBwXeDk5CMwAx/0OyImXr1XKEEkG0EKxfyMHcujvNmn5zTjCMZTWtlk2apbTwZfy4lD+aD6IGhbu3DCoUmX6VA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yZVHCruN1EDpgm7y2vKxxZgB/C0jBmWkzeGG066lo9LX+sIc9
	0jsOYOSTyNNIR06DOzKITlbkuglnYH0qIFm+AvfcU3tke5DG65R9sYuS
X-Gm-Gg: AYBFou106Inxli/vDXUOpqcJHTzOQudHyJpJP7KL/0A8voF8/xV4Vp0YmBOKvvjrABq
	dJ4cvDGCjOuDWReSTMXiT97NIehcYGKXjhyHs710Ohj0gM9nW0JdAdgSqTJsB0MZXni7QDdlU0C
	wMqBK+X/sr73rGudp29N04OvGIUs+1rdpqnr3pionluKtj4HKbhd6le3CARYRcW0NdBcHTDIkRA
	R+qfT2UMj9R3ARiOGssEliZrAozFS1UXeHjB1tiX8agqzY8P2PaaWv72ky9oqIEKu6kTHfuMnBb
	I3R78Wk77FiDaaZ0GCOIAuEyxiyucKunkuC3tKX3ZB9/Cv8CW6iFTlzfecOh+urKCil1DGAfF8E
	fuMi2uzBAqYzS4RUNiGbSWgxjSBWMWRFyGyWF/3KxYSakOOqLcOd6PGiBOn2k5Llu3C7NJelIw7
	XEvkvAWAW5i5wT2XPQ+2OaqpmYq0+6lqpayu5kYY/jSh8DdxpwOtuS/Af1DZ42ojX2uvl1pm+Be
	B+uTHEC0g7QnzBTb09hYioqZJnZYVYiQbnOO6pYR8L+JdftoSePMANBlxdU8ese4eWrX2NbDt8F
	i2H+VbZuj4ZdSGp9gQSFTPdV+w/xpeCDTb6UUo5zQ1d2cTUQQ2ozKyJpVn8MyY5jro4Zr6eKeeA
	jmRJnFCBcwJqoCSFQkhiuM0TymcJpksG8/fx5/tiDMLmqpAs=
X-Received: by 2002:a05:7300:ce97:b0:35d:8c3a:38a8 with SMTP id 5a478bee46e88-36a42437327mr17179370eec.39.1793693337840;
        Tue, 03 Nov 2026 00:08:57 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:57 -0800 (PST)
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
Subject: [PATCH v13 09/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Tue,  3 Nov 2026 17:08:18 +0900
Message-ID: <20261103080821.16983-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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
 
