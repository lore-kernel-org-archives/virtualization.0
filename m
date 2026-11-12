Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461700;
	b=BB2dTrQ4OHXexPDX3EvcE9VFh6GI6eU0fsNnUrnerqPemzvpKEzsuonWE0tvCAIHIhnd
	 rDjTostOZb8y24hljazGloQB0BTdacE3SqjdMgwloVCGk4qBJyQILQ6IelJIeo0EHhW3X
	 /CXB7qlxgZBfzySNGWoabRBsMDx1646glC6MEJFX19HPFmkUq1Md3zgM6YD7vrE2F1swT
	 UVXl+wvg6KgpoZe7CPlHaNfoXq5QBS0bVcDtHn2nlWwEwDuFI5Pf64QVjED1gLpVS0N1r
	 CtAFoaY8gqUICwf4cgKDnan8+INaxiD9X1jJwxmk4teyz1ewC+g8UzQTpwOBGKZBPmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=i5OrM+p02lnQ0W698vgIvMXoA97BICOcDNUraH0BKngxxJciQXbBvxqM9Ncdx5YOO4Vd
	 bsudH2iMlFMhrSAnqFOfD+tbl4wjbIHrjgD+v0Xl8/t9f+kih5rHzxw/EA8rXpZ/yLQuQ
	 jdRxfZot8zYWiU5o+pIzfMXVa8h1rIaou+Z0YP18fw7cMcdYmtdrTyCeLIMBjW21L5y5o
	 74eLD/epYTT8nAwfAQmHiEBG/xSK/nRO8mwYRhTuSNWA/Uouvldn2Vs9HnUozkUxj0l44
	 /LBaYKFaTw7J3z43hHkBA1T3MVNN6vYGadSefxb2MjfSY11OCQcgB6ivtF9c6OO7BAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Le7dlfEV;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB32606A894
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB32606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Le7dlfEV
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1914973c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461699; x=1795066499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=Le7dlfEVgUPdgnv7gBY2ibCrsL5P3i9P14z1hfs1KAGkNdN9NVBVtEuVlh0yBV9Z06
         OBZFRp4U/NU/Dvyru/CDFDyUg0l3mpaL8+wFWTRN9lPuUGaJuixHhfDRFh9KLtc+gaZu
         s5CW3dX0ow6hwdfbyrKsxABiVMmpjxwLfCoxgMjFRJ0cOhQO0eVYuiBb0MmwnE/Eshx9
         iZmZj8k+WtjE231Z21aW4pipbOIyQ9SdMaUumf5GrynDIOC57eB6flqggO7cgtxm/Jbn
         QSp8dtB7RSTQk/1QMxB3lT6MiYyVdGdD6gURkLYdLD7jHZMWp/VPxT57nUVOQaZvlthg
         lPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461699; x=1795066499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=USj9uT1pSrNwWvk+pmVZFEw/a5aBrKnUb/eoiTl7tVN5j88FOl61jAFvENraWTva3e
         ZjsZoKrqMOFFURB5FVknqEyWdApPPqRnT8eJ71ukbVfmYKARmAubIfK/9RWjhTKnemeD
         bxF+AEur9Q0Tkzf5w/DR9FMWiiB+4Cry6uWVRIk+walb08jPnUPdAc6Bu8skGq4LGPHR
         GrrVIkzFyJKZnbtd6suv16koTe3LQaiRWbijQ2NVm+AgnPWrDi7P2yGDwd5twaH63quj
         RT9GHRcraoBEPD+YpXHJnjiL+CtBx9gcikQ0R1sVdKnuG6QyyCMls6pZkdLa4leazKAc
         5Zrw==
X-Forwarded-Encrypted: i=1; AL+hErGTPXiBbDFXBNwvLiDDllHXMedBrfdu7/dAC0WEcibtDuFZ1qfa/Xdx6OoKjA8+zIFuQx0v8sE4V77oY9+Njw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9TQ13hcZHgMef4EFKwaz36MD6fHQerE0m6nlf89cDrXOA3A8GQ
	kVlmONiUnIX2V8T2yeCokhTcfdRvceudKP8N+57Qi2n/z+9bNyu0JN6c
X-Gm-Gg: AYBFou1mPsvKLZSDMS/FU+KIDDIB5xaqNGEZtykalC8sWYeHkEA1BnC9T61bB86vCKC
	MDQFzq/fc3RHF6PJ+AxWCx5a+RTPguzPgZm2b122RMpAAJMfm+CYRGuqK9KhthYjXqAzir8w1x8
	WQH6AacXT+KZ4gqsSo5NCl/t7RPUAICIPrkRRWr12F7746KW9zpt/8WR40qaX2hWumpssf8pZz7
	1usgB6KjgfShdf14hpqHpdJnfKpFtNdGOlzTCqmToDK1+f3usJhvDrbeNvDJZm1oMj2Gz8bij7o
	aQksET61cDXGcZWubF3HZ7pIBGyPLXRIP7Zvze2UeYTCCVWyD110XDpFD5695qMTZfIQBHIPyxZ
	BeZAADFM51vQGYAwrB/u3+R3UYF7ijpbIM7un9pA7i/nd07kSZYTcpd46YhtXZhPBCdiIRziEZb
	jfzPX1GSYOEzYW2Mpft/xvnK0XCycQ/O/te+DaWbqKXv3AGrONOgd5WL2jcAhcwCdaxaVdWLi6T
	QnDbNtIEzjHwcVgdLphACHfgSgcpj5NTaKLRJKIgt9PAii1C18/M4fhwcCWDMsZODaRqVxIYmt8
	bDLVyMFPIqDBgQBfOmOgk0awfVI9pPII5xsyOKdk2jLUBoQhMuB56kwhEfkpBy3KWdRH65HafGE
	aPMw1c6Lc+Is9dyLjatTLoJZ4JvYcNjtW+Dl1qy3U8hEpIFSA
X-Received: by 2002:a05:7022:e804:b0:1b3:755a:ec49 with SMTP id a92af1059eb24-1b3c03527f7mr4578437c88.40.1794461699106;
        Wed, 11 Nov 2026 21:34:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:34:58 -0800 (PST)
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
Subject: [PATCH v29 02/17] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 12 Nov 2026 14:34:31 +0900
Message-ID: <20261112053446.73504-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
