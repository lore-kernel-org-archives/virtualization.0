Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201391;
	b=bw1Q8vOYFnJdEdHhhWGojVWAdssXo+eKQ0OpbXhS+ofVVTzpba//3vrk8Uk0p72xeMKm
	 25JLz2RCs0zvzpEf5twQObbx/9eSrQ/e7qSWRbC5IZwXylI0q3WoFxOf15pMwj78RQM52
	 D8uFnyob/bOAdZPaVfhswdxRMVEz+AfhRSy/A2STYq4X+WMqZhH1pCnUDqTWQylidERSM
	 Dop1DWidHVmg7RqNN4JzkjQpcH/g90VduRyAtJUdFhdRxxppApxKWduMaRg/k0AwKQHT0
	 I5r9uaTII0JRRFzkufkTs7UNULtppKEXzOK0dfHUXlLT+Iwb37dRnxgUfe3KmRI3O3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
	b=R/P4hK8YVZ80KNkOEyxIPIAzmQlswdo+xCDCdx44T0XRQH0zAFGRk/0gF7vBaHoNlPQ3
	 NvvocsVzE/xmZ9g8CVhkKK7rwyAJzm+6nsh/Myfwc6W4B4At5hCsz1p8CTB7cPiRd80ur
	 bKgnXQKoU3+pomFcXsAMY5MghCn78hxUK1BmFGP7pri/yMINLXnWSppY8z6TVHFR21DWf
	 axyB/Y57K+kE9uLqYJEgsHpdiI/yB6Qa+aJIuQEy5TSIHd1Nrzri4+s/+TvpEnhblR173
	 nFlyNAvX3N+zXcP+I8fteT2RMZPTAP0zVQd8w/EtWvKBTfrxZpg3HCQ3ijEQkqH61qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErA1QPDO;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A83606A330
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A83606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErA1QPDO
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-170135e43c7so665003c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201390; x=1794806190; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
        b=ErA1QPDORTRMo123SLzVYKE887LJTLhxsOvHUrF6WPXK6pofCsUuzupqlT3Pi6IcOU
         jEMydV2zhJveScWAc1Oz4TWZSqkdfn1S+6MnvL1lQy+u8t2+IG5lqEs78Su40RbdrNum
         fRAj5kULqjAmwhZoI8RyGudFHOKzm85ayvjU6GXxUKajEZCg0DMQ48aSOLjx+WPsa7+q
         gY5Tb4zMxlUMzug8zdDR7DS8JuSZam/6vqmOzdQ+mnnYcz0ejjpt6hbONdSpXTSCEqsv
         4Rj0m6frxkuBZ3h1WRz+kjqmEPUXCQlbq+SMbOLSEyC2DvuJhstpOAFZo9cFt6DVxKpZ
         Q80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201390; x=1794806190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
        b=uQqA5Pfj6CVv7GdbtMn9IPIIJn+LKnd3TT34qCz7jbLFcg5YVOuHdjI1nsXFwr9JXE
         5n6NYS3eHnzJRLbxfCA+k7ZupWoPgujl9PtFMssMopv1QCULnhf2Gjr6PJn0jZOgolDp
         I1ay0QjCVrzb5I1D28xmiHfdjfaZrfcziz92W8yFELBKCOaqVxCeq1RUUNss3VxroUKM
         C/bYjEenluOCNkPjaagMR8fbspzgkLK7bKsWO1IPeiMxTTyaWn4C3dTJYBLEXzIfW61M
         5sv/TwNgorcE38ZSz3UO1OQxOj3otuFqiKSLitFIrljiDTQ3CGyz1e1K47j/kFe9yyNL
         RISA==
X-Forwarded-Encrypted: i=1; AL+hErHWMwDw/5es/MdPpWiqL/2j0bz9jLgH3duTgsKk7EJW6ruHLbLnlb/HWzSqn/HTvAzapRGwcXnNMPYlmkwrrw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/wHsIXYMq48z454uqPChg037c6zSQODgHjMMP7pNBcYFpo8bTY
	DY1R6b7ZNRrbPsqI4eqIK+rygOrnW8lLg71QlE/VwgjbdAs0Fiaz18/+
X-Gm-Gg: AYBFou0avDEfCqjMms9sSA6JZBtqOdGoJIrHaEYwZFWo8qf5PVCAvUTtjqze9KODpOt
	yrbojD169+3rWd3k+7wjvRZICyj66vG4lo9aEA3tFAgTGrjHmtcx0Y7aNahTrKnFUFX5F60sOYu
	gwrrjubir5tWOKVJdbl+w19KujbOVQQUP3V9pXpRJEV3fmaevw7b1OxJmJv0EOWrC0Nft2HfL04
	BC4ADHeqDfEAWa4qiK3/oN+URp863lMWwi4EkiQV3e0zwV6+bnxzkK96mDwAj8utZHaCIZU69lM
	vPfqZwSrb5yep5/LgwBTALUZSRSQZVOZX7r600Ana6EIENsi3UN3ODdOAk4VT6J7jlyp8Vo2ZyR
	qCz/2TsGCy3/0mc6fgvSJBWnFSUxg7ukhlqmv5t5iTn30DCkcCvGIGdv17H6IGePEdOsn101R6K
	ahm243lTiVcqzzkEar279QaM7ctLUc6RNNErmyZ6A4t064Rek1c/rymk80ViRgYDiUcqJc0rCLn
	xDOgq3K6Nu4mNbAR2xOn1F8olNfv1A+ItcabFtlKHj9pyH377HWOv+dzhlw4FSU0DLx8ln8Vr/V
	ZwkGYQ/F900e4SzEbVkvaxiHHY9fKvXwTUbnrOe+L3cKAJikZpu6zAqSn112Wu9Dnm5VL96hPb9
	l5cxZ2IIou1wo5Qh6VJo2JT56gztWzwT/uRYNmYOHRcpapls=
X-Received: by 2002:a05:701b:2902:b0:1b2:539b:496c with SMTP id a92af1059eb24-1b39ff1388fmr4548819c88.35.1794201390152;
        Sun, 08 Nov 2026 21:16:30 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:29 -0800 (PST)
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
Subject: [PATCH v22 02/13] ALSA: pcm: report partial progress under the stream lock
Date: Mon,  9 Nov 2026 14:16:07 +0900
Message-ID: <20261109051618.22506-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
using the period-interrupt path for this event can infer a false ring
wrap when the notification is delayed.

Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
through the non-interrupt path and notify readers and fasync listeners.
It runs under the caller's PCM stream lock and does not tick the PCM
timer. The driver must release its pointer and trigger locks before
calling it. Existing period notification callers keep their current
behavior.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
