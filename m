Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267663;
	b=NswcqqnUo69MqTc5XTD7S6pgIThwWQwSc79n+MagHooQou4MThL15pOiqajc+SOYD571
	 gJJ8IJeYi6qZNBaEr8LKQZNW95n+lt0wNPEF2moORR9wnjxUasqedr8HhEDnUb7Wh0daJ
	 lmowuH6BHCUiwn0EayaKN5wTZgwkB/zOhnl3+XSs2VPnWEXsyi3noRCsXTY55h+YJm++W
	 1xjbs+iMwFlv7gzgDICVQ5TSQIhyWxFjIX6p/isZGJ1YUEdubX6a0e0BP8rPaPItgmHBU
	 5CStsHIYaL/ZgWLfvVroWzcedYf+XekJGwP0GT6Ks/tzAxzN443/+hw4mgGvJfVkiig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
	b=fP6O0+hYwLIiS5cXQP6QkMlJmwoClliLcBEY29O2214p/pshOxA3gh+mjaJdlaWztGD0
	 Rc3BiVTg8sGcymDl9Uy4qhhzdXOJUVMBtm4+L6VqdgffenqM2oZe/SmdYcY9jLwK0kk+W
	 W3zytkQW2L3TKcm5IhPIPNCp09tnzh4C1kTQpmd4804bJeSivqOcIehpu1D1lL/hP/8jC
	 pueyrpH1KRZ9cyLUk31tAGccCduWGLq9hpNTjv7lomiio0b4l7mV2CWa1JtNkJxxYo6Pz
	 L3p8+CCTTNPhnNj7z9ZT1REq2FsUab02TtAb2dA/PR3Ri1Pl+DDXhkCb4RSsXVML1TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HVG+Cms;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D578606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D578606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HVG+Cms
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36dbde64409so2746501eec.0
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267662; x=1794872462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
        b=0HVG+Cmsld/JWO3HvV4N8FNE6kwxnEjDCF5G5TDVZM+k2pvgKjsCpfnDCFgj90RW48
         ZR9SrIcPbmtIsLNUTEs+iYNwnzfUnCTspsxtmcl5OODsrHTAJwg0nNzSfrR2aBuPX1fX
         4IkZe2i6/sq1cUGTsx1ETF7xpNKDghcrOAdG2Tgr8Jh/lIkjyo4PXNx6ANJmhqx+otDY
         kGIcz4SN6LMnni4fS43Y5uJzxCvNsonCnUZc8PP81l77g80n43STHrJutu22fWA8KFcg
         d+pAKTuhevK1G4CfFmmwSyjJL9lWo4WXLaM47xwCFBbWYiB7M/Vn0Sf9RxTJhg2C/LvD
         QLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267662; x=1794872462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIRJFzJUwhXXYeLruwX5KfbkGWQEo4baZ96Hekp+nk0=;
        b=mFQ8GJimJ0JAGKToKwLZOkAQTxand13uuW9MJpVXLvRodPp1vhl9DohgpWl8qnGypF
         dsOb03LXILdLG8wp7ZHHSyW1HGPzAsV1rM8mDp5K8u16xOtdzAtYnFM3T4V2/gLcv95v
         wAVtQtgj6mDFPuK+NQclrXIEN7zkL2WaWHq4obuy6N/co2dpnN8NKgCkt9zpD8+YlMx7
         jKbd3pYq9fz7iW1/hh7/61gpv0Acnc0KeBIMewvpVdoySpX4/2s20yMSqZ6hLJzApmAW
         ULH8esXLZWGdT5kijsHVp18jRaACq2SSvZOo+3DfW2jliEQ/YQxfUbly6azxO44mjTmw
         e97g==
X-Forwarded-Encrypted: i=1; AL+hErG+X+54IMU2dMUyCgjn3XViubBkQoJjjq5fHaXAUwEDNVG9U0jD6qTJgiEDWQ4V7kssLPUD2YqRZu+LFs8tPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ZoOsdJ7/bm9oXlupK81jdUHih4EA39a5wLizBi3OQ/DdDuhRF
	li3BXFoPfFgjHStYosd+DGaMqJcR+P7UK43M9ODtGeuW6emcdFDrJVX7
X-Gm-Gg: AYBFou1jBMdQW1VPAVeaVAIACwx68KiVn512v6/z05AID5di478E3IhWDc1QseZ+JBr
	17zsMhz/waoUSE29EVZs2pYj2sBskUJ1igoNHvbF8WEUmv0LwzOXQyPlJZkaI7I7SD6w252UAvu
	Z9R2PBFQntjoMzHN9kluf8eRJHUGJSlj5eToOWJCRonv8ppP49bOT0ZYsmrAI8PpXx9Ymcll7Us
	911IhvQPB6D4SBUhSj5p6l4yKen8iKpJhiSKJH5PwOoSmdQZPMwgnMmABf25/LBA5B3xUV1+9JE
	3IL3n1H2VEWVLj3xUaWng0OhBeG4kZ6BwHH7u6qMRLi+kzotCg/YutoRDyGjYzH+pcA8/Qc2rez
	XJbxeZo73lWFjUXxbCiRS+hu18U+PxeJ58prp+sK80ydFTflMVNxx8FYRNoInI0itWkt1WFHgor
	oCOcUzHlJj9hnuNu7ypzy9ofQECf4t5ZBsG9Qc8xXRTy3q/+yzO8B+SP8PpVtlqHUixycwuJZHc
	m19ARyp04FcQuyRF1qj7p6rUa3vrrzq5wvi5H0TpyuZ//uKAGIgLhoUM5Fpyk757ThGcewveos8
	yLx+npgT+hegRx5SLqQPaUOlDdJMZrKfZAylvUiWjbVn3yGydCh/RiaoOVgf4yIstv39hlLYeaF
	HUtGko0cWFZHe1X2yz1/Z5N7Zbgd2kb0TMLsLmJtFOTzrQjs=
X-Received: by 2002:a05:693c:2a12:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-3751fb32251mr859755eec.9.1794267661936;
        Mon, 09 Nov 2026 15:41:01 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.40.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:01 -0800 (PST)
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
Subject: [PATCH v23 02/14] ALSA: pcm: report partial progress under the stream lock
Date: Tue, 10 Nov 2026 08:40:37 +0900
Message-ID: <20261109234049.79534-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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
