Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758680;
	b=bjYkGTKFpBKZxUoFUw83xj5HPcwiI4Txqqx/w5ngCAqtSDZYgO2NvyQTT4ZbVXUEYO5p
	 zQb8JNq7uYGAcZf5fCDRNE6sKfb73OFs6YyWrc6GOBL87cVcLyMTIGW4aKCjj5aejl5nc
	 /eRh1eB05dHBmj6B2NqHQyefXaW10C46ZHig8FS39K5oOi49XxZw0xuiyD+zC/o9QjI5O
	 wk6/Pt0qd6326CT6riX6Vq07lAFU13hMbKppFxk9AygJFOxZEPbDAnPES5FVINkIGVjHI
	 m7d2F0jDoPX1ZdWZoZuFP+eQ6GxFRyfPYUm8Y482tC6RB1DYxOHw2fJ5v2Ont3VT9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
	b=WFW7rxoa6N1Rc04Ko/WrxIacD1AaHySR2gzFDE6/l9eFc4V6UgRjl5bYa64aRNEiwrbf
	 Q11ohTK3nwuO58eyQr9Hru7yLb6h96br9eRxi5sm/EeJ7NnV2sPneKuqUqQo2yJ4PCOuz
	 pTv6/bimYO0ncI+ndIYDKJpNNYcyGLefXr8CHXELDSW5ooAlvKdNVr6QaqwvW/gV2pPBh
	 8hWSn/hJnJPS/W+FwLwMbAuGdWFFfsYU6QX99ibkumLxr4sRqS16bUPiyTDHhwFPR/giJ
	 PKURN/+4A3koshM5IbOVjDqK6K0HZBc7zv1f8Qoz0iNTZjn4VgzPPIVVMGxV/6FzSJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jsct6Ugm;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1F606A331
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB1F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jsct6Ugm
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06b436dffso89367b3a.3
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758680; x=1794363480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
        b=Jsct6UgmfGCp//rtBRiKEQd46zVcs+fK554HQ/CGmaky42XAjh36lq3gAlutR+QHYT
         xlHwx10PG5coc0C+H3uRXSPgTh9j3vZxA3a2Rcen3j3yzjsYrVP5VA6piQIEgz1iOLH0
         rxrpxyf7XIZJudYF6IW8GxIV2ixde7Q7zekAeo0VbxmZd0NnAs9JvFAeCnmUTDHZPXw5
         pZKwQq8pKvFuC6OebCTxcxPlij9gJ5b7B5kpAQ1K6+MSwkf39MFNWdq7RNAmWt99bf5G
         rn+jaYUHNWILKtFyN6dp9kkGSoK0moWBjr+1Qtd5I5EiQXdNJrnFlKYG186r3XlmvtbT
         6D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758680; x=1794363480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
        b=QkIXpWG38kJ391qa55OPkTrY5p06v+Lyt0hmoe8FnsBKCdeSBncU1eHBUm1pzm/Nj8
         BhqEszAlsQFyuG5PlZ5RoiWkonK/mdUf9OYkA9KQYyapyzQ5U2KJXaMbfhVn3GRJtZRD
         OC5QUJ0rAMA5E2V81F6C5RTkg9JJ3Bfsvec33vAhQU7mURAo8X7Rve5lrqD7oYlK/mez
         ukLOHOuIy5PtuxOd3OfXYP438YIRDVXCickfv+6uHca4VeF3d48mfS07jDIntFZLHLf+
         0/VOvn6GXTCbZc3dGDDCsNnpCNHdzw+sn5cEThK4B23WjUL1bBeIme0m7iEjaEZUjhQj
         jtIw==
X-Forwarded-Encrypted: i=1; AKwUvByGPo6tAelZKRmr2U8GsFraOdZ47l5jaTuLw8i0b1shIQgqQQFGKRcuy6t0+v7cDtg3WyQ79gB2JT/HD0ZYTQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/RopfmM2zySA/m48hlT8wQR9g8K9tXzFp5UpT8ykCWSJpyNrT5
	OcIr4GxuYIX7060WaY8jQZiMlldme6cNMsNj+lO6dzWIJAQPINiklyxz
X-Gm-Gg: AYBFou323I/AnovERIBYLFedfeEqnHv0DhF+WMAkzt893LN9AK7nTdIrZQzN4Gb69cj
	9Rs99d7zVOWk0K563nbV4bMNjn2JSlhHSvCJmVuS8enYVBx9fSdhF0LJtQ/y0ULH9Ayo8BB8RGF
	mTB32v4cdagwuxcyOkEi9OyBHlMZctVbSOX8Qse8ploUuhfnWduAiybBnlPplsfNE4hWaPd1yEy
	8IFLHkwRYtM5UPVoSE2azXiFS1Uir80biwGZPHsg7IsmDCAuw+DTbOA7RJU57ETlmOnnMScm1Ud
	UkyRtu3zNeq2M/sldwhSm0tvm/NvwuvGxcUltr4exSoFZWcd/ahSn6lh58cUNgNuDCemCK3e5FY
	vh6HtX5REeosOl5NBtzjIaMJK1MNdUsll3aqQrYMUY5x4WC9tBI5XzIHRUoSUOgIQnbcrP9Jfdi
	A9UCrtDODjnju7y2WGd2ba1Wdi7QMMalhXK+no2LHW9YmQCuRuE4rOZY/2DVQ8uxJYyepufr+8M
	AG0Z197uQO6uHQ52DZIZQH4XSkZi6dE2WUEUAwF2hxYrjKlHmZ54uAhwPmWsk1WZt/phcUPh5yC
	fZizfvIZHENDBMgGx9ryJl8PVgcTLgf7xm5l7iHF/TLG2UhfhSwJe/PhBcl0PJc1/rUROLStRvz
	oIX7JPz5OT5PSFD+TJi+uKO6Oi0awmOPuco0O7QdLFS7k8Mc=
X-Received: by 2002:a05:6a21:a103:b0:3de:4fcd:f9a5 with SMTP id adf61e73a8af0-3e928d553c6mr9724186637.41.1793758679552;
        Tue, 03 Nov 2026 18:17:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.17.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:17:59 -0800 (PST)
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
Subject: [PATCH v14 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Wed,  4 Nov 2026 11:17:35 +0900
Message-ID: <20261104021745.57733-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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
