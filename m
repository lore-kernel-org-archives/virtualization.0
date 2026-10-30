Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338037;
	b=4o55Crt8s7YEBg+YPYGaNcHJmnCNyHTcrPkY/DgXRMqEBEnud+fv1nBasPwlCQLemEo0
	 EgnViK9DUUKQCwsNxuBPOVyHiTnR/IlUGeGjODZy9VThrZZuod2WfxqSr0SWBxAcKHDr1
	 eRCA0De6Q6vyq1iGFi4kOcsv3/j/3ooeL7bNYYAvKnIAqjgtKb0cm/gjeKI6t1uZVCJ9R
	 ymjaV1h95tj7g+TDx+z8+jgZeW/DL9alXtHXZtbv/jwKzGymSpljOrn1rJ00bakUGKjZv
	 lEjmjzWfhD1rSuW5l5GM1zuh/mTqss0h/rsKE2DTMlsn7Fn/ROxPyqC6voF9Fl0MHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
	b=5etdINDkU27FnCBR/JbLef8kJKkYhpI2tmjSItEaksdzm2Ufl0UqNRsBSaRmcAUrrofc
	 WOawVeA1PDMzDX8LcIZSM8rWfWOCyuTTlGg3NvKGi7NBbprGmkVWo2SD7CnAfZdJ4Nqs5
	 JAf+d/vykfB+/h3/pktPf+dG2snl3WCSqJ0znw2PoPXARBZmTgR04hqdriGJ8QfqAW4VW
	 HH0Q86INWU4bN9Lfwsj0a02Xr8nc6sl1LaTQMUvhSxy7tiqgCgzy+YJR4yTz8tVQYi86F
	 fnTPm9vdaP4SUT/y8oetpWGRWbFzu7wIK6HWF7h87feAoh5My+Ztkt6GKQGpPqn5Y0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPvOVAUl;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B80606A336
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B80606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPvOVAUl
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so144724a91.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338036; x=1793942836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
        b=UPvOVAUlzRFsZVGAfef4Clo86eUXQOG1ePdEn0GxNwUyg/MzwjNDg1Z6rwQ0jY44ZD
         XcogTxOErAaGdq8HN+SSlS5YlhGPTr5oY2n6iuD/mddIPjbN+nyOIe9IS87FwLYxh7R5
         2ejQzH5DNiAYcwwy/AqoydbqO1S0z3ibvx0rh4MqmNC9b0vuXU2fW63qKbPdCNztE+rF
         Tfti5ypYZ8zoxkHn+aNNNzaq8lH0/LMR5Q1iiLKORqqUrRVlGufh8SWqo7QTqkg+awjx
         /4wx6tXywZH1dvMzWxI2zpwkasw6lU8S0CZ4q9LYN8hbwqoEDNoxYJA/cCC3npyc7ILl
         IAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338036; x=1793942836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rpn8KYcVL0EiT/FmqIaIfPQD2S7vrJUUAZEWCZQOS5g=;
        b=WgtagXWTIABCQnfmdfsaLHjqg/W3jD3XnNHxQBO5sxSUuMyTAxF3j7KnOu8t2++2HM
         lkRlj9xBa53Ktsxzm5QQyoHDTy87mHwgWlBzoSGKiTGjsHNZlQJ+x3h8bC3z4aUF4OLa
         vhLODeZFRU/ox8b0aQdQqcmQ0IrW/a1Gk2Hc6eOsIRA2ohEiKefMC4/J4EvIYWBjHrVN
         YzuXtB20FCl43C1Op4FQzgi4dnoVgMNmYI6RAuUT06r2wIBxGZ5qlbacsyKEqKKsDHPO
         ZLGjrURxh1VhoPUeJPa1T64vK2GCZcPVpgdsEieI2mN2EevrUEAbyxSfEkKxUx3N+k7p
         HOhw==
X-Forwarded-Encrypted: i=1; AKwUvByWHbPfWjFnZcrivTJmBV9x3pKHnauvNaUW0bNC+85NdSAxY4EvxRcxvuE33XFGxeHeIcpLoWkrktNyDIJbyw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKwQXB61XD9ZpyouQGKOAutO2cyNA+xmcbg7MEMtiWKaubVMQiO
	wucNRsGmvSqORCaZEanGN/TYII1MweHVZ+vQhCDsH30gF7ukpneIbIOK
X-Gm-Gg: AYBFou3hm9Sb1efYuX28Q2D6YcqvyEakU3zX60w3zXXkctuFQH0yd7Yid4HVhgI6Pux
	/EMkiRfXGFQlYS+lawOKNd/xhxpOttoZrbErDVM2eTelpk9xv6d4CHw2tVB1l6AeTycyM+WCb1F
	Rmx233D5PgTcMwpSBVEiDo0WrvP8hSPQ9rEsLvmDKg/5Wc2rNSycfen/3Ah0OG0Ejfz+1hfsqrp
	mR9Fg9q3Hmv13CJPuMqwUvW/pCr6XsZIdujhnqPoqncFnbBsjwO0ib9Rj4hEnFWr4fMX0rR74RG
	gm+KP9NZ9g7w0oB/DN+snHr0AB1e4B5TMHN5BHNIX+IyWcvHzRVpjt+HDAWiboshEU4IW2ro61Z
	u7wtaG/LpQR4Wbn2fMRlB2yv5g8RN4L+yO+iQfW8eP+oEXpcGYaKiqqvpWHl3Spq8ZWUH0MP7s/
	oQk8wnvwou98bqM6FqYdMljeFD/QKIwHewxei++sgTQVdNUPytIDDFdV2CJzFpDMICayxGyhtWl
	6clJAbNi+5gQ7yy7JiUPDLGH++t55MNEWmuMvcbZY64j+LAFl8J0GpZcdQ4Ubs9IcVaT37w42U2
	5eRF9ylCDoL1HUKjDjO9iN0ymCxNDb3Gjc3E+yS52dCAu7cTKk6J9LtFl+R81XFprH+7Jqm0RG8
	rLp/QtYOEoVB4TLwqTUCr7qG33iN+LGWZzm/EvTlGMxsM2yI=
X-Received: by 2002:a17:90b:3c05:b0:3ad:8963:344a with SMTP id 98e67ed59e1d1-3ae897ef7abmr909898a91.66.1793338036177;
        Thu, 29 Oct 2026 22:27:16 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.27.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:15 -0700 (PDT)
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
Subject: [PATCH v10 12/14] ALSA: pcm: add an optional reset operation under the stream lock
Date: Fri, 30 Oct 2026 14:26:27 +0900
Message-ID: <20261030052629.27742-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
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
@@ -1988,7 +1988,31 @@
 			    snd_pcm_state_t state)
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
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+		    runtime->silence_size > 0)
+			snd_pcm_playback_silence(substream, ULONG_MAX);
+		return 0;
+	}
+
+	err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
 	if (err < 0)
 		return err;
 	guard(pcm_stream_lock_irq)(substream);
@@ -2004,6 +2028,9 @@
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->ops->reset)
+		return;
 	guard(pcm_stream_lock_irq)(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
