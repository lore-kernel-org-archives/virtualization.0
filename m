Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444439;
	b=Cj2/IoOehHGcwA28mtC3d/qTIvyv+t8uxYqD9zPZ2h1cKDWsPQz0l5VU1QLp75tn/TZN
	 /JBjXL97x0Ab5tzEr+bHlduiV+CTzN4DBrPa6A660P3APuG3Ji4EYVgN1LdZHnrBANncZ
	 JOXD7953+JvBKYsiPP5vfL30ICK6EKo3vgx+muCFTAhACBtB6v+4/8Aqp5OgrfrHp/6Mb
	 Qk+hHaCQXy24TSWUPqqniOMp8yX4SP31Tack/xJz82EuTqMNqjOQWcAvT03j0OTweWDe2
	 YLOiZBRsRxzk9r+am/64upSm/+PTFk2a/ZzEtyUYxFMD7t6J8/WEJ0/nN/hjKoaZipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=pdsYZm5wkoD0niC2L94AElENqHo9X/B5VmNpImtgtLx84DmXLZ9SZDbuQvpuQ/90Q2T/
	 By2Oih6HjCuB0ERAwSq/u+DCx5poBc7vM8Xc3OwOSa2NGTElW+vm7cX3+Nk7vuGyHAzkh
	 yuv/Bq0bTbbQFCSWK87QDYNM8ho1lwvx0tRtJqCw/Nj8M6LuEUrttGO9gvYZs0JDOOrNT
	 zUMzAKzjyO2nIaI8hSbmTyL/LdOzZmF2HMFR6plEvLwUdqRawlyAoDUEgLpfIdiFtJNua
	 G/TSL5slWvVMIyKSmbLXFLBOFX7LaI/hU2dYTARHmGHT6rq29EzXmveHYd99dg1Jlhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afqNTaRf;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2460A2623
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D2460A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afqNTaRf
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1438d9363fbso236660c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444438; x=1795049238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=afqNTaRfBYBOn7WGAYY0tY7pnBfcci4Y58i/vFQLLd3CLVshyYZcaT5/QQYQvfhuZj
         GCzakicWPMpSr3dSJEw1hfOd4b9Rn2EzT80Uh48cTlE59Y9OukvDrw5W5wfq9nfWS1GF
         K5Dm98Tk3f/Eg4V5LMnHiLaNaQvR5FxoFmkt4/D/9p/OvstpYfY3zv0VWTBT12QPUXzq
         UHL8xsDdjEntdlChz4MgCelGCFqhh18FHSuATCtiI2gtA8ajZLL0JgFrvMYWbVNE7dNS
         Ugis8sHsRjLfW/Sd2ESf6pApo0/Nvgahcu21xnBCl/gqZqOvHcSS8dy6/kIvieYCEei7
         gBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444438; x=1795049238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=Q3/rwLhglglpTxs1zaIySlN00rGVY8yTERsIcDtBme9W/El5X1w2Cqt+5RocLitff6
         6vStDksFRpi2j24+ko411VB8Ph174MG40JgBCIYzMf8uIIntnn+EccL81ObAUesI5cH2
         oCWzDervDepElj2UaKDJEWAsQ0788JkC/m1Xdg9yZ027qkYX5I4SG6v5oSLekthbdTjO
         CWm+2LXvrAQJZT8I1FiTqZqKum4xyLRc8z1LiB6VxuJSp0CHHB0U7GC1pJ4H780g3AjP
         vq9AB00tftVTTGXu6uEjiWSXv02YR4sl5Y72iPJQLQOu3KguGha2bU7e3jWa75OVdQJ1
         h+ng==
X-Forwarded-Encrypted: i=1; AL+hErH6ASAnqIOEmZ0ICgpx3LSx4nVnZE0YK+cL4ulwhZBevy9vNfi/ap2PiDu3KSP1pIPYf0wS/9khUGrRJnG6Aw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+IbxZBx2AvXZNFQ8WE49+9QqYeLM09b10AMxupfhHqMWkL4lmB
	3pouzse0mU0FwLHZbZcuP2lVNco8741pyLZE1W+s18LXNFPdrXYgsg8b
X-Gm-Gg: AYBFou1eQpw8v3i9MGeXYhDsSrDIWiUYDALoFVZE3CTpgfrLOsIqgB2ubKGV/mY6G5/
	deOvoTEREMgJ0l+STCjcFRJ/gx9ELnLbIDkH8eY0lslqaDPw/kT5aYnDFZ+Uesh+2D/aMbmMXGz
	MbSN1gCY/iqvu+ys+7sSOy2kdkGe9GoZ34XSW2JD4yxuxJNYBxibm2+i5xBAobAePN25+Lxku1Q
	sg715e1sti1+HSGw9bKBuxjWEjA6KoOKy6yENA7Y4H0pu9vTZ5oA2RUj8ojImjRo0GtNYUUMd4j
	OBZT0UIJtusoM+EZ1J/i4ob2fWgoN9jFa/vs1XFr8YVDqxPMSpG39/aQ88eg8WP0qLCjqSY8Nwy
	PsmT5TFE5N+YU82a0Hqw7Yb53hGGRhsoXSD08LqD2/z6dw4aqG03kQ6hQCyvJIKGkW4ANH2VzbD
	tf15vkxdSDgTVH1FrPVIpp0Nb30vZe0ZDjeDaBWre/qOY4BD1YXVSQSIq2vfBGHgLwGkBKLRppo
	uHzLnLCtgSPiK2WTn53Owc3m48fFHWNiqh1JS4gYHGHioYLM8BgFJtE3g6hy8g0EVKNYcitTxdz
	miDxPugLkxtGVQebh69ouX0Qbi4r54HYsKEVJOsODKpI+aFeTM1ZzYT0rXR7bgPgXxlQ68eDrE8
	o5gUke3EBJXbDDnRxbH5TUM4iOSzdMMBnqJcxoD7TzZbpn/xW9Gd1qxDPpdaCXzwyzQx7
X-Received: by 2002:a05:701b:42c5:10b0:14e:61bb:ec3d with SMTP id a92af1059eb24-1b4f5eb2338mr989131c88.16.1794444437591;
        Wed, 11 Nov 2026 16:47:17 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:17 -0800 (PST)
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
Subject: [PATCH v27 02/17] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 12 Nov 2026 09:46:49 +0900
Message-ID: <20261112004704.49758-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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
