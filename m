Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466183;
	b=tVZOVDQgRmwjOSdTZLfWAWAsXN6SopSkeBNO0AxExutIOx2irTQ9R0F1EY60zZx71vSG
	 sad7N9Al9niP/HLVmfeRMZugoH9AO3k5USib/nIf93gZEgUeIyVgdIZTvlgGP8pPQpbcY
	 j8Idqu06c7ipIy85uszQzUCH0OzYgdV6LqF514uJFTD/mmabJ1iFiPPC2gc3I9tC8fXts
	 Ykuvo5Fv4u1WTR6EWUKBUrxEuf7sEArUk0MRgwhTmMcZYShNkcbOIabXyt37rcTn7diWd
	 0iKUKUR+C6qkJzMAmCYZrOSI6hRzoUBsDrG3wvCkEAhwWLxUtXfw5wVQolZBYVKa54A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=vPZ5tbHymQ6RrxhKtzTo2QO+VBdosYifvzfmPpHZFJ4nqI4V3dP1w0QGzgFnl5E34F5E
	 WG2TU9EA0R8+KHo0E8KdeowTA0TOmztElLedyDKZnIVYkFGCuQJb1GGDah9cLG0hZ13Xc
	 n/K99sWYFGQCxNbCjEhOS1p7OlOIgGU5EfzbvYxXmUnvKnUA2BcdlqZbkK3ZigFs6nF34
	 r2nFcN3tpbCEG0nchzSUvntNJnv+TZiMgZKzKKc6309o1LWSlMalZsz4ts749q2seLchV
	 Cs1/3IWkMU1DWG1Q7RElebCxaFI2skrBPknj4zJY6WBUJfBkjO8gBj/C5f0ar27PAgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTfpq088;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F6606A881
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1F6606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTfpq088
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a058315c79so2056850b3a.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466183; x=1795070983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=aTfpq088BnfCMoxqzmXq00se9ZVCLZGSxOi2WZw9kB8cEmTmpU8+hEjhCYYKzcN4Io
         n8HKcXcnj4zCStYOesORw2afR43r50QgyefR8xMIJswKjiUESwWLzVTn5NSAABDF8CkJ
         /LRbwjK33V1e+hzPQlwpee0LoTCP0QaNG6pJFdTGwGDKOclMlzZW89mWY41ZbRR3fNMN
         IzNlwPzofsNbl/fxhBMpIu14WKSBVkP+sDPpw9ysZf++/dfJZymLYSg9/wPs63bwIG1m
         dHmIXrJ76VuZmYMCNoO6FvBgYPatX5WoDEs7mUjyBGP5jSkb6HfvqpRXdHBrHiWOQj+L
         sOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466183; x=1795070983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=a6RHjfQe7BTlnmtlBK8Qba+edQ8U70AMkrgRO172+rCkpYPOgnXDzdM2RomTv2XLPx
         HT7TEjVhAzlP9qWBY+e33R6INvZEyPK4DGt8uga5PX2OmOGMfs70BQcFVQjbACRdL6fu
         Pth8P+geytnCLx9xsxLJSsBzVKp09sUZXHESXDfCkqqqbbJaNyr/zB6JX3H/e1OibjgH
         gXrUzK3rOpjlDnobxgR8+Xsed0cS5/eYsu4ES2OkB9VpK4UAlHWAG4QTd2WwC6E00aUB
         vTz/YLBfTgss+ZVQwN5dO1CPbejAHaCv/ciBosVZIcL+52R7oVCMnce4G/rEfRbwqovQ
         CEXw==
X-Forwarded-Encrypted: i=1; AL+hErEnnK3cA633ToRBLpbRJ8SSB6TmhZvc5OFwlRH6KKdXj0daG1DVhQO/Xda38rJY8VTb59uOAAR4cz0RrqwyyQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9iUhenVnHVWHmj9yI4JT8JOmst3fMtijh63MitFPa4W/1TLId9
	jYLMuFTlA1iYI7VRoDYVL4cNlvps0DqPuleHUHy9bk/rdLwgG5rPVRGm
X-Gm-Gg: AYBFou3Z2ppALrdrvVa9OEkBpn/+63xvy+/NB0wDfUAgUWgWP80yDDhSH6LWj19zPEA
	ad5bAKqoOh4LuK0ttKDxcfCPjIb64m2d2xIHWra0Xy/iuFTzQFXcjOqD1r8SMpEqbqbHIKlfUG3
	C5MVESSSwJYBW9xSTVPclDFOnFYszVpQMKLmwdNTT5pvSWmDRuFjqCePXt3+r/9uohghI7W+JV6
	511ai3Ag506uVONnJUAgu5yp4MbldUmHp0EN6ZkRgVoLXn1QfArV/YZPtYhzxYkLfp5Ya3/b/Tz
	aH1kRUCKvPkRD7J91AQPDLnnZwdc+r3IwxsmlB0TWfkElEMZGFhX/l7XOxt9bAjE8tHzayvXf1r
	LpBkmLExAB5lT8HmySU3dofIUKWd/1++kQasTiYouOm328LKAg6p7x4CNAsj6wXliqASNSJ7tGz
	euxsPcmkcyB6YKOH1OS547gnoQFGasTZimy9XEqFNfpFumS0VArZ8EIZs7mW8mPDqdg8khqpPPq
	xHR4uavm84tEFy+EltAOQKMcgd/6N//2fP7LbaU9Zf7ACfE6xK+2LQ90uMvcPwv6hfhfIFD17rT
	6dbazKP/ya1hBOjyYiTyBWsLCj7Z/SW1iQavHSqw4YLCNSNqYAHhVnYjnO/w23vB9qsGOSbSQgt
	18hb4jqfKBs5kw+kM61riQnCQglPKGWJ7M22/Mb7UI0EGa2Y=
X-Received: by 2002:a05:6a00:170b:b0:8b6:59a:2ae with SMTP id d2e1a72fcca58-8bc1d819c34mr4549542b3a.52.1794466182900;
        Wed, 11 Nov 2026 22:49:42 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:42 -0800 (PST)
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
Subject: [PATCH v31 02/17] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 12 Nov 2026 15:49:14 +0900
Message-ID: <20261112064929.11211-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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
