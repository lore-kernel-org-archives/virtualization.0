Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355557;
	b=2SjXiSpQtBE1v+b4Oz+3Ii612nQK41nO1deGPTo5wNa579kmvn34rGvmMgRbl3/K2BYe
	 jkmfqjpJZ+NS50ao5Mew6Xgn+cP5uhKBpGY2IBKBzgtJw6UbORkss/ni0dpP+ml8zsQYd
	 FNV+6q7eFE4X2FjoeF/8FaIeZzGd0zyrmgVvUg2BcNAsBloebb7lDPEZ3a+2rWE8m7KqR
	 VpfO8bnStHXFKsVHsgNoROTINWUZ4QR7MSUWlzqyTFJbGzQ0TarwdhzvsX+qbTkUDJ/Nf
	 EimB1wJIuGez0z7XcjwyJoxxyAB++Wlkt/qacb6CX6Q6WR+Bgqw7MH5j93ZNDEtCAQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QL7qMQJCM15dowTzRdUWpkJm+YzN+M4BPLeeodrjsps=;
	b=zGF0894avfAiNeGK2mVkp9Zlip/aIDQ2YXLq5COxH/LO1L+SSAU1yUbmVocSpPlRV9x/
	 gL6f/4K3SGlerBQcHf0svNgGcQUi0zEvkD8zD4UJ2yEQ+6mEesKlTTu2ei6BaB2MALJeq
	 Xn2NitIGxabTq3md8ycO1t5nclK8M2FXS3W3ycwsW4vEgzbzP7h1PaZJPCEqXUVNOBmwC
	 IIIO8m2hnjQIM+uygbZilkcAZbY3y+FEQwgCTFji2RhACgB+/hDwuouO4sOEexFhyeoUJ
	 2iJoSRL77ahJDrwDTJuVXbf43RMl51ounXwLmk1P09Xfj8pS3Lz1gI5HrfNTzGrXS9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qqe+BSIr;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23460A2610
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF23460A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qqe+BSIr
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so1820132a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355556; x=1794960356; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QL7qMQJCM15dowTzRdUWpkJm+YzN+M4BPLeeodrjsps=;
        b=Qqe+BSIr1Gtf7sl9Zpu+hGxpozz3KP/VSBaSg2de+8kxdS5Wly5a2kG1GyL3JqsZLq
         BFYCxSrvIRFstAnTxZnNVbL5OXILrBb6AACM1Z4OEPp+84nlm1w1rYsYp19zB3FnWq7n
         v5mIdXHEhIL9ZAhQRhfE0qPtkJcJFcZMhCv+XqdxGYcTPMQapkJtVX2eBhKWk3cbFkmj
         mXlacTrn+g3AEo6OWlTXbtQ0YajGo+JB5o3SOu0ru1ipKoOAN9ySYqej0zBnaeRuGpes
         N275lVunBVLrG8gQgWoinRuWsLcRDvP6A+iKbklPmbd/d7eliUW2dDxBeJI9/yEoC5aw
         bG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355556; x=1794960356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QL7qMQJCM15dowTzRdUWpkJm+YzN+M4BPLeeodrjsps=;
        b=DUMWSk4qWLRyGYfrAE3HQQIQQMqOad56DvfneKbFgZz9Fi+cUdk8e5+bn2bsd/nbJz
         n7EwLcqKlAY3XfWCNvnTRafAcHgV7RMZIyXghrimVy4iIC/gtZ+ZkKlDYEaDF96gu0lN
         KPUUhZE2l05LS+2QEOzqtzv95WNLdxDl3ZnpVaI9pQRDK/s9i18cac7yodXy9I4Niype
         KX/pVkHq5ZTK/VyQKGYur4pWVUMY9JcIxZPWSz3EX1azE3s0Tshoh0ermnj2Egkfjg0m
         2x3PGgca4/w7INeKgXAd/BRQWYx9hcw9063u0XgMSfjIV0OiN44sEPz5rODtUQqLnbiu
         pfoA==
X-Forwarded-Encrypted: i=1; AL+hErGYUE9nFzk8Bzbbs3P+RVjb7KhUrTWbGZNX0dJ6fAviY0zkPNJjmzCUzDTCbcWo4lnLv4q44cWD7s7Ty1sUYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7vpjoMUbzWiR9RUezBu8wxHrDRothwh+WpypgkAKIgIFVWgP5
	0ApjA6VWrOH8YismNaxF2019txDEP0la/gHgrcIkYwqM+BwyJe8/gADv
X-Gm-Gg: AYBFou3iGk7RMIj6oKMAD/qP2kbeFoSooyFPwESoqLj3H1EV631y6X6wOagZuzD0yKj
	S/n9nLlhcj6oWU2yU81kcErjtNtZxJdLNaWBOaQyRYOokPdBllkMDFXx2r7Q9GF6N49xELG78yL
	1SKDoVqwi/WlFSdfjyRlWWh8iFN6yDxxCYN+awyAlpfcmWhuWvEehX3tRYFxKiG32Q1oQE0VpkI
	NTdEsPIPbPsHIlQqjgaGxUngVuFl8ClbD6gbLfmEnC7HY4sGyY0ybzZh0j+y4dORVuw+yXOaHYC
	+mkIlDpGGhAp+kCDz04rTgfVa65cy1Mp7JxS8biAuqGWA8uGgWyz9Td9eEVzHGRaHAzp5scMtFW
	teQVuuwvESKUmwudNr5OCla19V6clya4+PRvxoyxEIWgB/Drt6J9lORo+EvqPZUmdwjteOTkpDs
	dy6xpuW5HwJbZ9RM0j0/HeWh2ETAJtjSR8+te+t/WHuFjDKgYPrNLszknzNfvKLIw/UppC9YGmm
	+WtDFtbWM+aFAtcT8lriZPBIB/GcIOyA5fILc1+W6WxOFe/apgA0Lpks39qwQd/hWz0lx01+Isf
	1MTnd9ac6ZYffDGKkAmXSmGhIiZfyhmYs8yc0wI98YpQBLIsTARGcnFu1NHXR3cCnJINAl2gpMp
	lS5IpgMlLc+bWya1VUQgfL9yPFSef3tJSatojVZ6YCemRXiM=
X-Received: by 2002:a17:90b:4c:b0:3ac:c024:b275 with SMTP id 98e67ed59e1d1-3b182df3c21mr660693a91.9.1794355556265;
        Tue, 10 Nov 2026 16:05:56 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.05.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:05:55 -0800 (PST)
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
Subject: [PATCH v24 02/16] ALSA: pcm: report partial progress under the stream lock
Date: Wed, 11 Nov 2026 09:05:29 +0900
Message-ID: <20261111000543.28550-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
@@ -1919,6 +1919,30 @@
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
