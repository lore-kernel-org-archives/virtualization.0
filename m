Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458129;
	b=FFCU/E/deNQ/1VsAzAgIpR2dkUjq4weUAeiixYunhNfy0je9Wlm1ify27EYAfMaP8ajo
	 ysXYeABPZIhqy0uBGjQopA1MVRYpfHTdWrOffNAMmZ+lRbMes0EB3bChyNthVJY90qPuF
	 cHNWLBeOBggKVukB4gAAnS0++XQik1W8eHkBYqEFrp5rnjLhdxvqElWxN23Dhf2Z55VWA
	 WLoIkw9Y/DYfsdGoEqGzhXuj1QeL2FxPQbyFpGpI9atFygjGzq0xCSPiI3LLhwyp0R6gh
	 C2mrRgpUokehgNbOmZw5ZTjOr2EY48F77e9MhUmAKmvQpIg2NNBvia88AYqNlU9snHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=NlStIJQBqGpoevP1qMWXO1jzEIU6zVH4hxtcPY0TiXec2szM+tEi7YyJsNSsJDs9skoL
	 diLzMxYj4eTzohoY9EUzdA2BRM5nAXFcoVGZOOY1zkZF+oTQ1SfJljIHXmuheVFQ3UlA6
	 9NElaQaMIYV0TAtHm1oTPmhqbr9MP4s+WZEe+zvtoiunVYlkL3T/ep2XIKyWCRW0cScna
	 lxp6rGZoUxHRdVGlXgx8/RWm/WozG/x8zgN9yG+7zTN5IBnKPTPCGxh+ACtuDHnR4mcHb
	 Ijhpg72mv5guJVJ2hF7RxIxWX+DZCHnAJ4fAujK3HHF1gAX/XT5GUYW0nTmDQ6D5pug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XBwRlqJ/";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0B606A896
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE0B606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBwRlqJ/
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1773074a12.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458129; x=1795062929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=XBwRlqJ/EGZt1f4uCFygpBLYIuZQXTn2gWnFPaNkNs+dbOmgfWlzU6bl7IGhz5yWqu
         2inMaHfZyuG2iSJaXEFyhCQI8+616YLN+6eTeQq4O2auOwdvabNT+g6/J79Mc63ag06u
         Xm83q6Tm7q/58D0NXKOufkPowOCLCX9YBTtQLh2nRpd/fCIwE5W0hNA+ILwiOGfYui0/
         iHYmhwcAzIYhZHvcogUusrxzpq2D1fuHPTupSGfVrLj5tKba2Hb9rxJqSud/xMKZskbM
         vUi8iy1K55id58z+eSQcpZyyYmIIVWxtMqfjiAAavF/etR+sJ1PYaWuSaKHdtcJ8EJQG
         tJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458129; x=1795062929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=l7PbC5DDwFekNJUZ4nuzM9B3ATHbu+zLOEPbUryAyltiNS1FUFUMc7oAtk8I5AmozS
         XNzzuOKDTrHoIJSKGyjdGLWdBHwuRPuNHQki9s+STwLvBw9Av1/BbXN/D3t/dIRKPu+R
         mw9iDGCPTR+GdsjZzxTlM60UMSlV9me9vLN+73vIWBXT8h54eeLQ195n/bsf5S8Dpkn2
         YMRHJy2IAj3bLQtpuB3ILXPEwWlKbqN7ueLPFOMO7vOjYjbSvt+khAK9/tuB9/vGK7kH
         dmmkqwX0XjFKDXtgQps28PSf0+FgOlp2cgUqyluRt931YCLxQ2f45nBSh+jbj3oz04Pz
         xUtA==
X-Forwarded-Encrypted: i=1; AL+hErFvq1cJIEzj0FPUJZz8Q0gTU6k11sj2OERfWTYppUU8H5Af8XGWp0ue6PXyPBREadlUrRu5TYr1FzLblOb2iA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9oXsuP3LEokGrE+NOP6V9sNnujGUSN/wuaxFBj6VLLR8l6WqHX
	8SDkb04bGzjQeIXQSryNaL2CnF7wd49F1D+hRMxxhAdu+3AgUg++9zPr
X-Gm-Gg: AYBFou1g58MRRRnobg2yM9EwKnD5LhwpnZWKnO5xeJWf3hv2rMe9uulrS3hUMbzcGQg
	Evcrp/Zj/RfsLZsX76sVvE7Ep2LIup2yYfuexNgQ5eLofPtxLDD9ZFl8ccBmXBv7bJ2WPrLmHQe
	scIX9tl+eOO+/I8WI5OoyZRN+iISJmd2yj/U5JBCQ92NEhK0bhWPaaBDKjLCfZybiz6WA3TyS+F
	atoZ4XIZSHgJQU91K8BVjgbYuxb/8pVVIH1wA2alIqT+mDT8q3E3JEOZ545SyvNXY8NJq6QF5BO
	YqTBBCtvaAfKQ3GkruRHYEJfvwtkO5X0Hko2PmaVFHGjf45vgDE/Ex+9zaCK9OTcX2JEG/ujFKK
	cA8TMLbSWhYixh/atIswBmd75MWkXHunOKTEV+OUe5e+DF8fRVAe7ekIaLHQJFOVRxOB69vEhrJ
	uiT6Y4gcJ+jXozsapwQTMGnf3nn/8yDJTzYediMlmTozo4Lqy5bMeGSyPvnnRgb2/yOtAx2apLB
	50/QiCyPNrnfkJ5nxTB7GfZCgWU6rmLUwJkfYZyvt75ZN1Dp1sF5/fgTYpclNfcCllAybFs4CTC
	5O4KDH6E4Y9hSjYuL1OUr1D5NZpEcNnEYtUg0tNSkzxxQxaT8mRnWanntJbrdF2Dwetwmn3QCh8
	lgnHeM0ByMIv/Ci25QXdIS0hSUtmHIF5jBs/ootJWSCRMldkP
X-Received: by 2002:a17:90b:3901:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3b182f6384bmr3693962a91.46.1794458128581;
        Wed, 11 Nov 2026 20:35:28 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:28 -0800 (PST)
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
Subject: [PATCH v28 02/17] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 12 Nov 2026 13:35:01 +0900
Message-ID: <20261112043516.37010-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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

Allow a driver to publish subperiod progress under the PCM stream lock
without generating a period timer notification. Use the ordinary pointer
update, XRUN and wakeup path. Capture DRAINING can publish its final
tail while playback and other inactive states retain their existing
behavior.

Handle capture DRAINING separately in the state update: a full buffer is
still readable capture data, while progress beyond the buffer capacity
is an overrun. Playback continues to finish draining when its buffer is
empty.

Refresh capture availability after the unlocked copy and application
pointer commit while DRAINING. A final tail can arrive during the copy;
subtracting only the copied frames from the earlier snapshot can
otherwise finish draining with unread samples left in the ring.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1182,6 +1182,7 @@
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream);
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *buf, bool interleaved,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -215,8 +215,14 @@
 	if (avail > runtime->avail_max)
 		runtime->avail_max = avail;
 	if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
-		if (avail >= runtime->buffer_size) {
-			snd_pcm_drain_done(substream);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			if (avail >= runtime->buffer_size) {
+				snd_pcm_drain_done(substream);
+				return -EPIPE;
+			}
+		} else if (avail > runtime->buffer_size) {
+			/* A full capture buffer remains readable while draining. */
+			__snd_pcm_xrun(substream);
 			return -EPIPE;
 		}
 	} else {
@@ -1919,6 +1925,30 @@
 EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
 
 /**
+ * snd_pcm_progress_under_stream_lock - Report progress without a period IRQ
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held, with no driver pointer or trigger locks held.
+ * Updates the pointer and wakes readers for partial-period transfers. Capture
+ * streams may report their final tail while DRAINING. Unlike a period
+ * notification, this does not imply an elapsed period or tick the PCM timer.
+ * The same pointer, trigger and timestamp callbacks may be invoked.
+ */
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (PCM_RUNTIME_CHECK(substream))
+		return;
+	if (!snd_pcm_running(substream) &&
+	    !(substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	      substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
+		return;
+	snd_pcm_update_hw_ptr(substream);
+	snd_kill_fasync(substream->runtime->fasync, SIGIO, POLL_IN);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_progress_under_stream_lock);
+
+
+/**
  * snd_pcm_period_elapsed() - update the status of runtime for the next period by acquiring lock of
  *			      PCM substream.
  * @substream: the instance of PCM substream.
@@ -2405,7 +2435,11 @@
 		offset += frames;
 		size -= frames;
 		xfer += frames;
-		avail -= frames;
+		if (!is_playback &&
+		    runtime->state == SNDRV_PCM_STATE_DRAINING)
+			avail = snd_pcm_avail(substream);
+		else
+			avail -= frames;
 		if (is_playback &&
 		    runtime->state == SNDRV_PCM_STATE_PREPARED &&
 		    snd_pcm_playback_hw_avail(runtime) >= (snd_pcm_sframes_t)runtime->start_threshold) {
