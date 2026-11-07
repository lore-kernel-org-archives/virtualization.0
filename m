Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062079;
	b=ifHRRI/+gCoVzYfQsxtlNvSTRIg23jV8Qi9GNKJ7/tWPKwTb4aiJMZZ55WQMueyvE/XC
	 +f5YW0H1FIF8tn/RJKZ8iHXe+jbrzR2cgJiyUuDbPNQqyP5yJUCDo4gZm6rNbXyKusn+h
	 nJ12RNxmEo28s9SBtihOKo5oclNUMI7+MGum+X2Nhvempc0eMr6/L6DGRPwQKBP1hrcML
	 qCopNmqvIwQ42XaivYOkPN45Zoh/no1q1M+H6BRxM1v1DXPbbDC4QPBuY8/GA2gKgAEDk
	 WSY53VstsVeQiml0OWC4ula1LAqgDJ3gHPT7kdl737Ic+2O0ZiY7hG0kg9ARp1VRWXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
	b=aGZDtbxICNMPTB/x5H0RoDZzTBpMUtlNPu+YC64lXJBE9Z4BASoWpiynU9BIp2t5BZwa
	 fFuPkd7cm39wvImgq1FqZXed5+/iA6daifuWsjV/BUFTMYz4K9H6jlamm0oZ1HxvgZpaG
	 ugziqj7Q3e9mP9UmipsNbCGSEPTOGGuQEOLR8kmclakkMHGbkFdU1miFfWnz19r1CwXrT
	 l/C6nzU9FfSVw9poNC0WPdKZM3MksqCQox0T61fSKNsv7sCDuXMItnnMRGxco4iGRjwtg
	 4QZZXVCkF8uwjVo0kgRJGnY3vIXmzja5aYeo/ubqoMAO+g2bK4ISejBLmMYN6P4y7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prPjMkFS;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90492606EE98
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90492606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prPjMkFS
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37071c0f42aso2156042eec.0
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062078; x=1794666878; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
        b=prPjMkFSPQhENA/x7BOrod5893WYpNBE0CvT4T5OB1NVAv7VsBtiz9lquGYPrhms3V
         V1Yron0VIQNUUKjALu6VFc2XTk0m8MOT9+X6NSN19jL0Wg5AYcMtlzaOqz+10CXIXWUI
         ngHoANtH0c+tRORtxyoZoI0+6VUt6f4lfC+68GDMCOfrq1vlSOs8aEeZOEwzLum+4Alm
         MLUEzI6HE7TLYCz7Ty7apVMvN5cV55xpL0tA+3sguon7CiYFNrCRYiuIJjap0LF9RNRC
         vk04uRRb3SNHtke2CgPDQkA3dAYsM6jHs3Buv/WkU+qexBbRzIsMu2lt0boapWPBQyg/
         ZpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062078; x=1794666878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9g1EmpJPl3VsiiyXPfTHGa4seP6cTbErFussR8Q6f4=;
        b=GqyrdA0ZkYr82HaZuvx7eRJwSqvtMhdqhOFJl0wrTEwqlZVdIa/hgFz9/YsqfK58wj
         WYyR+vkuhX+vNXtCwroqg4rxTQF1gfiCG/S/076s+bTpL7o2PtHtbMT0bg7EyKE2KQ+C
         VUOTVc/Wlo+/nHl74g+5tqcOUS/YPbizr8i+dlpc8zaQdELnkZxufpEKv+BCkXN/Ntp9
         Ajl3qHAFVRprtWY7xVAynR5WwGwK7BEfNQrEiNAV8Pw0jyCg0+6PMrnkAuaIxmxFMdg5
         9yrM13j+g0/byIWeeDrnOiasE4P5SVwVCIc8UNCRXrLWL5aMTobASxc53Oc033aEPktr
         9I+g==
X-Forwarded-Encrypted: i=1; AKwUvBwUmNihnWTtTkaOma/oOOjC4ktjRWGPAwfTzNikpN6zKVKhvNV6M4nluz06g62nbdLuvulDSbB19Au6H2aW0Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+0BqyROKPt4JFj0TZ6vwU6cr8hxrdnMxERzB6+ekcAg0BN1gOU
	IyZ7qkYYdYEgvE/u2YU0mARhSc+22bYqtsgpTYJ9JCM2bxfUtAQiakk9
X-Gm-Gg: AYBFou3yFkFnzNjHRFdRDgDo54iVtmqgihJtv/IKLM0fdV7Hp0K2gIy8i+x+AJyAz5b
	o959O/A7fiJYgp1CCKAAUuQPhPvqGrc8O7PbR2eJrsMk+GC4FWh+moLoZ6IpvECnwz+z13vRKJp
	410uwrrE4zq3zpGhwhnpu8KW4RYkkSCo7JzRPpLZAskZX3Nr4jn4DQd5yRR9aiUrxUg7lv4adGm
	MtvBdneWv/iBuac9wTDzVzfH9uUqzVo7ZXc8W4VZA/sWIcSd4ezVDfZXUIf7aarsA0Y2C9BkXr/
	+J8oOW+I/duJRFwXxgE7/ufQ8QHCmzQbw9R8x50xlAh7cMA0bxEmlE1VeXpmgz3ErM6x/xGZbIh
	AXwi91FUtN4/UiMCOAEFbbVu1+nQ3N1ikUO2FeCIoiRR+veoOmHmYZzuql1DWqZqBHupFajpteb
	jXPval5qDl6vrc5UXj0NfQxNWcFwz3vY7Uw/Aj4csACB0nFGAEs9uxKOC0WvqA/Nt7yA0Rj5gk8
	Yeuu8cKuXY8EPA6EnHrhu1yoMD8J2TqKELn/jugiLK2Agqn/wLdDVpxlJHZ3WGeX/KcV0aVyRBG
	uzS1vG3hgGMaTdqO5qmpct1BGOVertPEm18gOnVqz2Ar/mnOWMc3yXKNyeR7bkmduZm6qE+NIBV
	oy1gO97xd9b4dP34NowrUIJl0OuzkEL8Jf1SAKMDWJljuad5qu0Qgq9fCdv1FaWxuUFs=
X-Received: by 2002:a05:7300:7b27:b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-36f75d205d8mr7653486eec.28.1794062077471;
        Sat, 07 Nov 2026 06:34:37 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.34.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:34:36 -0800 (PST)
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
Subject: [PATCH v20 03/12] ALSA: pcm: add an optional reset operation under the stream lock
Date: Sat,  7 Nov 2026 23:34:13 +0900
Message-ID: <20261107143422.29319-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
 
