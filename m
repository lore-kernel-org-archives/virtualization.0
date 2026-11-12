Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464700;
	b=Zi9LPegru1P5PoYzTdwhgmkKGGsrFKEUyBFBhI+lN1lbDpgh3cfJKQwNzImeyCXOGVE3
	 1rINhDYC/gmbe94GchrE9uExZXP2+R54OKuhqaR554ksH7MxtbN3tT5/3EX7croukBIAr
	 74qkfTpovWIM0zgps7kFwBD8i3GGR4pYN78SeP0lRAcGBZmr7Msde3YJG9sEpiPBz3ksT
	 JBwm+BZC5swhJF8dtYOFa8ezWFi4p8cTVQMwEYflJdlOPdEr7SwWTSnrsOCpfi6630rgy
	 LOVsOFjEMR4Yx4Gc/oF9Ym8Zd1EmWTQCa1DAuQ8RhxAxM523c6sFsgf/J70CfpJI8lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=uDRYNhY2TqrESMSU7Bbqt5QfoE8bIHx7bLfUaiX1j6hYdVD9QLCFk9BrQvSihLztyCha
	 g/OZiTPH50KvbHucLiyPwdaB5ebG8s8I5injq5s53zf38mvstMjGWyFnBN1RRy25SqUJF
	 AkNDbAHT3DygbEG6p2Lu944OI1eoS9Dk1S7cq+BjvFw2kqvp7WhaLjPftyKUQqlZzm1er
	 /eda853AvENnsVmbSU/mFTrryEb1cECkjsQUtvrbadlGhBdn7XQSvzM3rxMMoiXUnVZsK
	 foJx+iJ6Z8RXTV8BYngz8VU3TDwlz1NZc0Btu69XQfYfIQ3CBKLd/0xFBrUKn5Or4LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk86Ekll;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059B606A88A
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7059B606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk86Ekll
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e946155442so31899905ad.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464700; x=1795069500; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=dk86Ekll7fuUizZ+LDjboHntYI0axPxORG0r9tbO3CsoCQLFAOSEACmtQaKwu//FkB
         +cxawXqdmBI1DEVI+Dn34GgHJVYDt1GpZpGbwXlau6ObIwlYQEsV9eDmtTyriIOE6/Ga
         baIk80h8VIja6tVCVdh29gpbQwO0o8eMEto33vurWUWavSqbd5tPVCSBHZD16+IML91c
         dlqnjaiK9uJg+w7hP05vMlhDdaoJtOzZL/Wt3tZ38b+28zaJqPTfViXYwJbArNfQ5ThI
         AG8s5GWxNd/leUWRePFgAZ8L2VXWdfvY+w87CpZp2c70mGzObIXZeTjD1kA2ZnlBRLu4
         dIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464700; x=1795069500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=PtHgTQD4ULTsYf9qrLu/z2cZtoKh8GiF81AiMVqdJEyf+s2y8V/C6HjN/9yPtM5dP9
         AXEMiAjEEA42YTVSy1X8/XoO0RcMJe03ZUZatvQRnsdEf/oKu+Dn2JrpnA+afk/LNtq4
         DkJQfDZ64rLmYVdBRnkpSuT2rhSLW6V642HLAN5xG4H0XUnQ9B8Dn+HSWNRyk6t7LO1V
         h6Zi4NeaVBMYaOoyd2eLAL4DV+60GCHcv4NjiFxekatEIfcPIfwY1fH1s0tNcLPux52t
         zg3dHFEdIL/4oN+ktH/hpdlt5Z83/DNvSy+qjY4pXRUHKkqSiWyH4SHrN+eafP/J8b+4
         80CQ==
X-Forwarded-Encrypted: i=1; AL+hErFlngOn+VYebcKdHHMz9oi2nu1rBH2HgxRGwDjoWz6KmINy3dSL1OlhfEhEFKY5Wnt8IQH8nR/x26ba5HtsXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Pw59ml5EXGAR/BsZ4PSzVpQwCeUUv3hWXVs8FcnvknRop6KDZ
	tNDrccQtGl55IL92lNQerjvw4gUfU9KqBI7QP7bdgDSn9PAJkp+D3nVu
X-Gm-Gg: AYBFou2cDAokOB4plhwaHRs19jHYB6Y20vl/nzX1q0oaJPLXRW2xd0jGMuaG1oUkFp9
	3GopXBf0O/NGeSzxmT/tbx/5akiXKnVvEpAJVVjUHMhhQ5Mp1K3tgKdyUXOebPqGGIrjHAeQA6V
	F7wyLsqki3q77rVds/cxE3XSgMxRnfgh2FBUk6fCLibbebs+AV+4CaVT6/hWutZjVhcMo/edmv/
	eJ+1kudmtExAB/8HAtNWikuOUtDr1uH5noYq/ZG5+wmGynWi+0FUOc1cWUo2L3X+a6Vz8ysB8mF
	qPFV3OzxiUK0NpvUyob2uiQ8Ih2hntDrjG5/t0gIBq/AYVrGUrK5j68EHVwOTPkeo89ddXda0Cz
	Vcgvs8yPPGmmPENNZIqU1hFNCoTK1h7jDv9c28oFi3zMMwrpTORITj5qWqZ6EJTX1tSvIBm5/7Y
	0WDb2pQHU1meSvNz2OnX5cVEUdkieFYmOdLcElPj6lC5tIE3GPUCkSQG050lOjyRB4HA6a7bQ7o
	a9Az6SdVNfKPKZGttc7+P5P1g879a3n5eEiNYCQS1nU6p+M+v/1E7i3IWbDD6G+/OyQKTHK+hfw
	JphcNMsfyfgmxcKOFa7Iw+OhNXOlSV/GAZ5Xt5yokKO7lLTmhx4tGW8lwEv936myCh6nSQ69vcn
	8RLDle4Ih7u9Y4/gQGrXfriPDiMgItOHucQRYaapMvUpeBjg4
X-Received: by 2002:a17:902:f54e:b0:2ea:1b9b:b946 with SMTP id d9443c01a7336-2edd76d66f3mr54934855ad.14.1794464699653;
        Wed, 11 Nov 2026 22:24:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.24.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:24:59 -0800 (PST)
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
Subject: [PATCH v30 02/17] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 12 Nov 2026 15:24:31 +0900
Message-ID: <20261112062446.159-3-mynameisjune111@gmail.com>
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
