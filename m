Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464704;
	b=XPfZw/wgqXGB+ffxBS6+2AeLs1rMzDj57pkanOJQHrve7zdqITPBzXzMaIWbXozMZW5R
	 Z2jZom31rft559TfNaYZJz9lnwLCpjBJ0lkMiAclPSMjjH61PJ6U0uGx+5IRu6dEhIs3v
	 usHoxrnv4avh2JIa6oUrZIHovn+nT7zromtjKOB8QTCCPY2tOPwJDKWNbukOSJ1ho5xLU
	 dkoWenqOXI//cg/8NXX5UVvnujQcGRbX7gJJVrMvWJsdgP3Kp0ZfOwdzUXgYQumFMMcPo
	 UzQnSYfbc5u8jgdsH9HfNOudErHgKR6/5pEAEvfJIYl59q5EpLv+OF785f7LHFNupdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
	b=c09lEN/dLONNsDB+o1JXmav2YPmWmZNtTrjvmsVIZ9/5B96Db0GbbF/ZKC+fM/c0rV1d
	 d+6tjU9v+7F9w4nhZqef/8V7OIkIgSCSKZV3OOFsfbZT4rzQLb470Ik8YfW8vg70upB0U
	 L3KkTq4DYBYdoLCwacYQkRljqMJfuPWASREi90rT3KvWEgnWzF6g3TZIk9BABfRI7sJi/
	 gZUANaqJS2i/+/yQEQCjYxU1ktyExa3tUk5nCBrt35yQz703HyjdMTveLt1LsQf1furLj
	 U+MNdEF8sMAkkOjmyqAla94uRdbK/zUzR2VakrNcFJ8cuTZRfZgT3uH/JF40TbC05yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqnuVJQi;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFE606A89C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FFE606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqnuVJQi
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e95bd1c14cso34864885ad.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464703; x=1795069503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=VqnuVJQizPtS/Ad+lmP/nDbEF/lPkACCZ9tbHsfE/FNshU+w/yZHTU3O/2dHMjYO6H
         uM9NOKpgfV52glceTHAdk3156ZHy42CZ/xnbL1Vt8WiLJsDNDOpXxyWyKsg5fzCp6RYZ
         qrnoI6B4V2M3Nuh8md+zrUyyRmMSvj2K0zzNwkdU8IwX26yXgjpbLG7YF8MHHrgQ1cUS
         AMHVNP3F1ZaUQ4itdxigxdu9W0fB9a8Lt3P8zvhDTMrHemHKkKavqgrVgBcZRPloumuN
         f2j4awx/CgbZijkGIrAmMwREvBqzxqkPybno8bmU4G70hIG4PcWp0bMEI3cLhn4YO9rD
         HELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464703; x=1795069503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p3+pqMhjDImkIJEr0R5v0U340Sy0+dzECuu9p3HETc=;
        b=He913Cm4s9mMsjDAMlk7+dbNIdxhaQ2EQNUw4ljj9oXBf3IwNYLWd2lmuDP+Rjo7RK
         CFu7Pp93xJbJTz8nW2QYs96mQWVM+vkHx3Tpv1qMqJM+1DrWD38kz4Q3F1GuSlHrlMFY
         DwgZh5FDYecQiUK1YG46EHe9yLp5+fN1W0cjuBtwTelwnD2m1bJssx3ciW8TUA+OWyBa
         oHqijqui1fpiP/yV/BmV5ArqMTe/NEV2qGd6RtzgOCnF2/3/tqkuha+StczNj6p+2daa
         cmvV+WDq5VkLFc/Fm4k8yBjzlwBUdlIGUfcUaAQpCJvAoPV6nOuiq/aTa9HFYd11GgQ3
         bU9g==
X-Forwarded-Encrypted: i=1; AL+hErEVS5MYYWe6Qp3u86lkiBEb3sxsfCJyslvNDxAJSq3QXLbfLow6fMIqNwedscJp3fUTAsWvoDXO4zMYNenMOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gxiR6j+RhTzzbKUVvWExcAhskNhgJXQiWSV1Wwb/K/yFqYKbS
	jjOlnpn2B1NLB3tpXsE0Ci0YQeJ+yUNm2ZvoaBEn3Um76ekI9Gx6RFrQ
X-Gm-Gg: AYBFou2n/ByYVM1N+hWO9p3qZbUP5NzU0CAb1Tsw+UzyNzyr0VVhx/IsINKn1Ot647N
	j63zcHDb4Eemncm71XRsxaJbV/fcbAYrv5/QRHXwz5dfJiwtwtiewh1+68YkrkCWHGRDuhR6CC2
	NohoF4AYuNh4ft5k9zzWUgxlRaINpD5Uo5hAllWbHc4769GwuMVdFhPZAsEuUr7DIwz3275QeMK
	y6Mw0aMCcPhbMD/M87QIld8Q1L144drUlF7H2OQ1pgLtiFzSue0zwXcb1q6nVuKaKq/00p4NMQJ
	kQXltrnIup18JaStrVH8m62FoAqev7LRwrCiS7heL5Qa72xUk+SKx7zhHEMKVLQ2dnD0wJK5qSs
	jOaDJ4lCdWZUGydXnHFV95dHoi/SiK91sEkCwp/IS0dRsRqBnk5JwkcRPpW0ft1Mt339GghL6tc
	Wu7gQeRPmrzaYU5HxDoehxdvqxo/q9/IYu1Jz7VQ5KxsjCXBqxNRFdY+i0JUehqCdS+Tk3T0Q97
	St5bm7ThXiB9/H/fL52RZeq/8W+OmmipShb2hu3u59yX9B7UPtygSf6fsBLZyp+Vt16CfNfe8Ea
	J99Wta4wAbNEYxi2GLpDNKLvkGotKGCRvOWRHaCnd/OScPeMFENoluVJL4STITxaXLG6391g1iM
	IxKIPzCtfF9NYomPdAlqKpmiZL5sEe1jUxrkIX55QGIK7I2A=
X-Received: by 2002:a17:903:2282:b0:2ea:41ad:e310 with SMTP id d9443c01a7336-2edd7ae7a40mr50230395ad.46.1794464703254;
        Wed, 11 Nov 2026 22:25:03 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:02 -0800 (PST)
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
Subject: [PATCH v30 03/17] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 12 Nov 2026 15:24:32 +0900
Message-ID: <20261112062446.159-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
 
