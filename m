Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365830;
	b=4z9LttuplLbPnCXd7y7xl6ny7IeLbjMoREG4DAiq6CoiroJMLaSyRaLw2+IoCNo9xKtk
	 YdpDiItuceJc1EnkcZgfN2o5GrnsNczW7Kxq9WTSNxpXUfPSqxqtYbGhvrd3572FpxGnf
	 6v/OwlIguCICL1CE2lGNmDsrekjdkBdfeIq0DpDWTejoydw7lHE1u1b1YAsheuVfuOcSP
	 xYKYAXUgcbhCReGyQYXal+Lnh4LSN2jsz9yZ9dtUZUZyQxXOyhn6/vs14JICUXTgOgAOl
	 s5YkAqOBxoEwm5mrhOq+sLy9/OYE2aby5ZOYPP9nUv5uvozDQeg/5BLBJAyJ7fcOjrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
	b=Fz0U9eylo1f6x5gvHU873Wc1pOobmAqHPRkxrwpBaWBqdY0bT/ustsvBS3ls+mMgGKHj
	 2WtC8itU+yWIr29HTO8BTwpbut+7wI/Q5LF4ewTOfqTuKVT9t+7qESFKB2556Oua3TYt+
	 nvxJof1lId+ziqahP5dQqpCuZ9VPv+HqHHoQFA50rcnpFrYkWCYzjvNH+E9bAzICPMpaN
	 jrxJbxeYJY88JKLziTabftEARCaNHd5X1WaJtNbIp9CoZdg+bPb7yzL2V/QfR/X+vMJi9
	 2nNEaO0yPe74jcsovjvySwOoZjLWxXaRpZ/u3iXbqtpRTJ6fqvqi9+0Tz0MTSlttiTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sLPPyCe;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798E606A32E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4798E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sLPPyCe
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3712b6d9843so2588057eec.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365829; x=1794970629; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=0sLPPyCeI6SQw1WPShKp5khdP5MTAV4G1UwYR73ZSkvxt26kjinhJ/Ncph069+A1+O
         2W7kSkmihMl2vyMEqElV9WFwSxVuB0Ry0qWmay7GHVSQyDyUxGt+L20BL6CreqoY6HYR
         U9Rp6XAM/DGYpXf6a18ZL79KjVppbMa6SPNZpmxVEzoRyfvvx7xjeIJOcgKPQiiyKlpw
         q/5SHLsTqzBMfEEFUmSFPecaNTjtJGD6RxXtVPPafh/wUr5kt66mG04Uw7vZLEol/0Mp
         kll7sIwjP25rUzsQhlltttA9OZMjKIBnYnJfOfE1Era1KqBP9k250r2jeFtdPtWA/dgF
         VM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365829; x=1794970629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSQ6q1+hzrUJLXDFxgCVobdqtJne/nbtoWxCk+WJcL0=;
        b=uSI4nLKd4LleCdVDyu36ct6XHzysDbgLB6C3MDSFztNSDsM61P5CDPntvMRwJrIq5l
         QofZ21fTspwtEx/uGc4vxUbQl7wxQONxV4mheiwFhKW85Our1TEARhl2Gvouasef7HXR
         qpRF7M8Q2NAaPMRp8x8nuKVP4oSSaYbKb/VJjLEE5SwFp9OuCWn9WnAqI7+uM4fpfpOt
         yBjWpmBT6LzJZXRmuHXxkOiJEQDINzBDdASyC5GV+mn4+EgrqhuK/MS4Qy1G7iZ8FBgz
         Xd1nDnQ2QNlzVzfGKdrw3BydBOEfhPIyxSzrfIxWN4fL8FE0hDCThlppaCOLE3fPocPX
         ssYw==
X-Forwarded-Encrypted: i=1; AL+hErHyA8XVrktssyhEizqNvhIXb2k9sFLjveNiGeJGApnHhAUAd+ZAhoTdvFT3r9D6K5oaLWr9G6g3r8szLkasrQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8FpX5yRm1hzheLgJC7Ixn+Pw6BZHlUgY5SYU9CgCIOUlIigL4s
	UrckGFsxpie8BzyJ5VN5Vf2y2d6g9T1zV63ZwYpnjGQV5lI/aF4V+7QL
X-Gm-Gg: AYBFou2P/sDSXpJo+TvXGaHWVtZEk9V0jI0GylgpjztWAPrTzlKT2E3jQoMwsoyo0mu
	JzjVcAyCxjy37fzpXHqb9cg+5CqapDUCl0EilAvsZxJCDpOGNJ809RiPZEZUF8StM7goqdH79R9
	he+HKiP9cDxwZZHHdIyhX5C9AHlMKdg5tmzmqeD/93V5J6ISFP68nYdz5q801IHIw9gUn5DfV+9
	Xv5vN6PuiguKxRnfhp02NtZkDXToZqNHxBzNhFGyas+su13tNIzUXHDcJFSThnWDv+pqlo1IYuI
	tZbGG5g65i83+I9HWMSlkneX6F443yPAhXbUIbEVMb7DF1bjLHfxHeNg2DwkvCrw3qkWzIdslBB
	QuURpYAOYuGNXbJ+djsPZA08BJmGG+Wmn//wEmGK9KTusJ/k5pqckbHIEhgx7fDeysUH+jw5RmK
	3WJwHEnzosIgqD2pA9gzQagujHGn7sDw00mDA1dNH2c04aOVh1lzW5GksaZ+pk1CrRzOmc6RVm3
	rtnUKCGCf9EppW3sd3azu7M+cfGb4s3oqn7SdSRpf+EDxhM3lV1cl2gAx/stFKqloMZrXtLpBya
	VIzQikIEG5PLG66i4q7J+gR+KcQr52Pnv6wfT5J0x3RM2GXdeQ7e17fJl/6VV/KXtnvDTPKD7yU
	z44leYc3cC16gkxN/b9GpzfEjrQCO9QaGWgzcZyJVALISuHU=
X-Received: by 2002:a05:7301:df4c:b0:36a:270:ce76 with SMTP id 5a478bee46e88-37686c3b606mr1546950eec.33.1794365828493;
        Tue, 10 Nov 2026 18:57:08 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:08 -0800 (PST)
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
Subject: [PATCH v25 02/16] ALSA: pcm: report partial progress under the stream lock
Date: Wed, 11 Nov 2026 11:56:41 +0900
Message-ID: <20261111025655.63951-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
