Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664277;
	b=0G/Ph6xa4JjNsy3NcXca9tfWiKdMiWvcfEsO6lhJ0e91oJaK1JbecvU871Vyw305Bs6v
	 A3XHzOH951z4Jc9w3UofCRwVgddyeeGEOqlXjmt+DlU1pO7J/gbVeR6Ii/scCy+7BpmHn
	 l4Lt03hoBrx/JHNwS2WRUBCatHUojRMY0HHTceKVdh1QMumH9oEzqavzmrs1+a1rjjS/t
	 G6IXYYDXma5Uy1doNPvVUQtgbiivpStKeOfwN6cS1+R6N7wDbX8BFjOXo5ZrhyS+gTvSP
	 m1fU8E6XI45MsTWMk4GTLJNHcpyH8tKwysQ1ldUsyrvYsNMhHQABfccTJ9xQa6Tkejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
	b=tSyWX5CX72YLp0iNVisyq1t9xwDR5xH3dmN2Ufso75FYCObOOyTNG+BdIBKITViqvabS
	 aGebATHGJDU/4Rpie5YzT2ou4fQhjOJaPJFD+7CHn7fZkbJFLdZXThxWUBMD5cnwxUm5X
	 ZRT6YiH6uWUKnRYdWxFJ15Jl6ZrDL3JX3zwo/TShBgZgewWAK1X26Ka1mhhSNEj5SnX2c
	 XP8thDYYX6kiJkmseZh05zkCFu4yNzHgUYTmdHyLHXRGe1Rv7gjxK/XgWT0PQiV+Vt0qA
	 lxfftcv53v8JWOJA/ayhp0mpozrr4/zrgfezLMmc18Qc6VmBkt+jlytCr4FTcw3MVMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZI/tm0wf";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3C606EE81
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA3C606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZI/tm0wf
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1731913a12.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664276; x=1794269076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=ZI/tm0wfyEnfxSMRv+gm7gftsCn1Qc4oP0Ww5CvjddO72yyvJ8A+W68YfHu5X+p+gq
         ayiLVLVvDqBzJdtixadpWNs33zg44qthuY2itWdCeMda0Abti5AOFwEfSmWD58gnDAut
         IPnPLa7lu8cpxSe3ysgrndpLUNElNi1OG8x65cCajtCfHByDOHSR9+wjCGUBnh0CP3x2
         bjyU5d/szi+oYXWH2tb/S4yzN3Af8hqqwBIHuIOeL7hFT786oKDXhdhxEehvUYyoz+AR
         07q4DvWqPaBc/4/uTljEe8522oBSmOlQKF3d0tgulrP3viCYQwyZYmN7NBNowwsBgUGk
         lrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664276; x=1794269076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=tIbjDJHP7RWl3bznl6P+1GuGGyEy4yqJ7DJRRB+iCzytrv7dLZ0SHLDYS1RxRMSF1B
         3KCDn7jQwt3WBtkygX2itTNn1BmbC15FKB31aA1KEHl/H8sNvGLZgI2xtqLCIm58S3Me
         YkvegI7iHuEQKAhlxRKX91DS+En56+bxARhv3Kg5s+v2zJB4g6NPqpZaAs6wed8x/A0u
         /6xRuAmEU/WCzLOdDqmdRUvCAfrQmFA1HX6F7uYIvbp+dKp+2cDTC3JY1K4N/THsnhwq
         4OmmWmBKuIguHyBWHBFucQ8KOm/YBS8+3dlONm6J+pakIzN7Z6EAvdYKVI+1q3fJ+c0d
         Wo9w==
X-Forwarded-Encrypted: i=1; AKwUvBxr+cpiKiJbfeEyk1OtSdoKHvIn7G+ko+/OyGxRVpkkcnxxrJSaF3ZJbCGjlRzPHqvIgEUb6dQ+OI11fmM/4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+X2nBQ5BF1Odm4Fh1vQv+9Vs+LHe0+6d0O462VqcHMSLzfWUgI
	IkDPi6smJuNm/69QuEPU3eme39jJHKr7zWBSFtsGLRVb0JxDCT/szXJm
X-Gm-Gg: AYBFou2JULrLL4yWhGRJWEmb1vr3de8FIlmV/poa91mZCbC+44avKbbHjYkg73oVDhz
	SmQZrIeU6vJCeF2O4iy+aQUJ7cMg77hQb+zCCTfBh62xZIog46nycPwA5bVkXFumPml+TGSJrqO
	rO4gdFscQv27n6zeuPoACJLx25peA+5kzrp15jpOmqTquZzzpw6Hy9k63yStust4ZE3ZbYfrNEy
	VqYpP/fMh4HtuyTS9Kp47yW8PFsOG2bMRxtDBeAnmYPwUhq+XDb2fguHhfxBwkQ6LoRzB+fVLRZ
	E4EviXfm9JS8TKNH6WOMaHAoZyt9mJKu/u7UpetOdMfmpzfTZ/ZUYNAJD4xMj/lWXPS2epauR8x
	E8Zhl7eak86GXxe9rUboJ1/NXWIR59phE/pBJ7nXkhkvhbhnmG3ZYY3oDG0/pPwoK+vAtlNW9NY
	Xz73KCA3xsplgJycqtVHj0e9vDJWX3oe4Hv2FegF8+NzhjGQLXdIVgdY1i8hGAJBowh3NDVgRol
	gp7gi4241Vss/YLQCczLeq/oLChcpRarlzzgGyEKuC4vfZzTNDnI1PfJoKfFYrQrZjwfb9UKyAS
	XtqqK9A9urKsUv3XSarf7HHSFMVjVs/KmHKztJ+cbYzA8a5xBJh+r90ABjNxX5J7SJyDZjwlJZ3
	DmaBk60AREkmajdA0BQUoAs9dmWSclRDh/fFnUeZBNEh9QT8=
X-Received: by 2002:a17:90a:ec8e:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3ae897d5fc0mr8022586a91.34.1793664275838;
        Mon, 02 Nov 2026 16:04:35 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:35 -0800 (PST)
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
Subject: [PATCH v12 08/12] ALSA: pcm: report partial progress under the stream lock
Date: Tue,  3 Nov 2026 09:03:59 +0900
Message-ID: <20261103000403.67106-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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

Staged capture can make readable data available before a complete period
has elapsed. Skipping notification leaves a blocked reader asleep, while
using the period-interrupt path for this event can infer a false ring wrap
when the notification is delayed.

Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
through the non-interrupt path and notify readers and fasync listeners.
It runs under the caller's PCM stream lock and does not tick the PCM timer.
The driver must release its pointer and trigger locks before calling it.
Existing period notification callers keep their current behavior.

Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
and false-wrap alternatives. The new helper delivered 64 final frames and
reported four available frames after delayed partial progress without XRUN.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
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
@@ -1919,6 +1919,25 @@
 EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
 
 /**
+ * snd_pcm_progress_under_stream_lock - Report progress without a period IRQ
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held, with no driver pointer or trigger locks held.
+ * Updates the pointer and wakes readers for partial-period transfers. Unlike
+ * a period notification, this does not imply an elapsed period or tick the PCM
+ * timer. The same pointer, trigger and timestamp callbacks may be invoked.
+ */
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (PCM_RUNTIME_CHECK(substream) || !snd_pcm_running(substream))
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
