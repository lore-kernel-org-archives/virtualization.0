Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252688;
	b=JEAVboe3zB88ubweK/ryVFW3ZYWVydSMzsERjx6SPttq0YhMXl0jF6wy7nq/Vc2UQe2l
	 pyDxDNJCOuUFGp9OaKpXUnshr4WU6Ol8W7r3kpr+MJ2AxEtv3VQ5kEuHS2X/ayPmzqwge
	 PdNjEs1XOTsZ6iHO4AgfP5ke9HRCAKUEiaDhPwPb4qQMoHBWd+Cywm7ajZYGUtmdG0cHq
	 OF770CO4lbTCB7aTjbXf7za/k8Ud+M/zWr898U10t98QXeTIKxaHnLP9hA3rrf1h5cX5G
	 9sXNSPmDeyOJgyhgQRYjYuGPEQBodom2+mKvy9XaXbCb18Rm0rQu3Yyr544Mdbx73iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fs/ZgjrW0cZrAbuUtL5SEnJbOMz43SREcKUWySyyyzY=;
	b=bupc8n5kK+MrA0BXFRmu8TV6pTHlR4hq/eX72+yDZ/XWeLjMLv1nCwYCgLxf4m0FHL23
	 cRakb5+29iyiWr3RwHCsy/IFrw2qS25FafiDZK3kgZwt7UeTSknKSJLulii71ipGK11YA
	 N7ah95fiofDy5BrB6o4WNW8WBX6pyyFyhl2GLGCG4vkFZk//+cp1IBnBIeNOTfXg0wkHh
	 cIijm8oZA2coZ6N3ukpQ6Q25WGOr8+BTdXuVenccqsPut0hezZAN2yADmB3r53xMfTzI5
	 6tpz2H3fEbVlSmuSPYK/7S9+P7oyYqTwWU9CCjwP77PfHO7hQQp8RMjJTxvv1Rg3D6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FIVIaYza;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C2606A325
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590C2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FIVIaYza
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1102589a12.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252688; x=1793857488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fs/ZgjrW0cZrAbuUtL5SEnJbOMz43SREcKUWySyyyzY=;
        b=FIVIaYzagszl9mAdBtnrxgw9GLinSVxiNc0Sa8MtiQzj/x4U/s8A5PkCnTxBSZBAkH
         l8MhKpvn5kL/QBW/YRBQxxh/jgJkgKEJDiw/IKWXPRECaCpFmmhrbnsQM98yzfH4O0e1
         KTNEE8gKf1Xy0VbdmC2uIibarj4pQJ/A4OnKlnOGbIZymDNiqUJRZ4Xf7KlKK+T2xH2a
         kWJl1o9Q4NsuOj2nzE3PmuRZMelytje19VNXBHz7JdElLKC6rKlgnLWh9QHG3aSOPrsR
         SyGD4Vx7imskiVHNx12IEPLdo7AkObKMicQJbCtA93PgTGihW1jbMJZ8e4ru1dbGeEL7
         WtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252688; x=1793857488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fs/ZgjrW0cZrAbuUtL5SEnJbOMz43SREcKUWySyyyzY=;
        b=n7pQx5HSUtIHozgEtq3MJgIN4hjRxWMsdgMxRBqKswkN4P3BsAsBQjPSbo9Mbl4URk
         ZEFWmjWjN1AH+TrbhTLvGoz5Yi+UfBCLONs2uFQvtLfvRQtg93jn4O0cAsXpPlG+LCyZ
         u9qtzu247sPiJxRXUPYv8r3QOBD/DkLh5fD2uoOvEU8isEn/VeEYQ+uu8vxYeQCDBzjX
         GyAh23OhZGcjH2qrvpuKGpgPKLrFju4P73fSGmaUGB8LC3sLh1osg8tWI8m1VSaNG35F
         OghuX45TpzDy+OuD03vwJ4SYGxf0I+n7Et2ukf9vGwvpwpveu84PuGFUTazmSnorclvt
         H9+w==
X-Forwarded-Encrypted: i=1; AKwUvBx5xTy8fCzgTmEiAQPHJNDyOWjtuT4cG4d4CWbSr7D5Ha0M2PV+ZlJs/R09WMIoCc+jvV3mJAa2gb7VNGOvtw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI9GcE9ETqGdnVBjaNZNi2agnA893QzTUHr8YxcHaNrsGlHuHRj
	KQM2S8iGG8CqtXHUkPlA4ukoSqzS1vramG0tgf8caYu72x5toOM+Q45M
X-Gm-Gg: AYBFou303bj63jQL+upJ8JnPNKQUeZC7IUCq/Ve9vXHJz1Xa8ndgUhJCFy6nnOJIxkR
	QGmAMtP71sPmsMxWOLlpXNndIC9uQFWoiUvzcD7vgJ4QEzGJF6qcnMVmCDNmvujAo8k+J1AeZ5h
	FNRlMNPgBsQlEK4TPQucCzcY4ClygkokouHpJzNym/XmfO4kYILDK1eLjMxai5t+0ucYutY4uwz
	6c5Q+9ZxOPbz88SjalsNDT7qpZOawDeOTTr7hMGUxfoc9OKpUSrFXaYgk9451aVgwVfmNdpsgZy
	U4dy63NlsnY3QvGi3IW93hZTTw1ndry2nzMZcXF//ikYQRScTqcmumTh7DCLbzzE7kw6NWz6kdi
	KLhtjrFcoojEGY4mlxnQXwn6qHMsf/jmmQz1JtFlrUMzcQbYTS8Cdf9Y2fp1/rNoRGg5if4FYU2
	ZI7ckBkkZjzMMU70TZWaxiBFB3NWd/Zsn9+Gk8F0RbLCL/qpmWS4RZTVpHxZa6kxv/ZIz/q3kgC
	ZcGqb817itf25duwhPgp/Ne8POZBxCVstdXWxq1OXBKb6kZO+ZxlueeEl7FajORIBELbzZkaBHb
	WcjGKqzJNZ1V0zOClth9NdQozKMI2fGLs97wQ0bfV1jQ3tH2vRE3W7xWT4/LxfC81FQS7NGiHy1
	36zibkON001RAxvaTche/gY27DnVB1QQZOhALo2gBQgBg3qM=
X-Received: by 2002:a17:90b:54c5:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3ae58195369mr3420391a91.66.1793252687719;
        Wed, 28 Oct 2026 22:44:47 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:47 -0700 (PDT)
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
Subject: [PATCH v8 12/14] ALSA: pcm: add an optional reset operation under the stream lock
Date: Thu, 29 Oct 2026 14:43:52 +0900
Message-ID: <20261029054354.2931-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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

A driver which keeps private capture counters needs to reset those
counters together with the PCM application's position. The ioctl RESET
path releases the stream lock before core completes the position rebase,
and appl_ptr is updated in a separate post_action. Period processing can
observe the intermediate state.

Add an optional reset operation whose stream lock remains held through
the core position and appl_ptr updates. Export the common pointer reset
as snd_pcm_lib_reset(), so drivers can reuse pointer validation, time
accounting and XRUN handling without reacquiring the stream lock.
Drivers without the new operation keep their existing ioctl path.

A successful callback member completes its reset immediately. If a later
linked member fails, the first error is returned and completed members
are not rolled back. Legacy members retain the existing post_action
behavior, including in mixed groups. An error can leave partial changes
in the failing member as well. Callers must recover the group before
relying on its capture positions again.

The operation also runs after a successful driver prepare. A later
prepare failure can leave an earlier member reset without the group's
post_prepare state transition. Document this together with the atomic
and nonatomic locking requirements.

Linked synthetic capture tests cover both locking modes, four callback
combinations, later-member errors and recovery. The lock-window concern
was found by inspection; the existing delayed v7 test did not reproduce
a user-visible failure. The new-candidate tests validate the
synchronization contract and recovery paths.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -77,6 +77,20 @@
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
+	 * Return zero on success or a negative error. Linked RESET/prepare
+	 * stops at the first error without rollback. Earlier callback members
+	 * retain their completed reset; legacy members retain the existing
+	 * post_action policy. An error does not guarantee unchanged state.
+	 */
+	int (*reset)(struct snd_pcm_substream *substream);
 };
 
 /*
@@ -1179,6 +1193,7 @@
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
@@ -1989,7 +1989,31 @@
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
@@ -2005,6 +2029,9 @@
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->ops->reset)
+		return;
 	guard(pcm_stream_lock_irq)(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
