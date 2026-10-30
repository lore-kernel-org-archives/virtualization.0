Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338023;
	b=0v4AjUWO8maRfmFV3Q1DQW4y1oagcl9U0BPsUTsUfSFaA8CFjZPxr4JvtqLq58NG7pPe
	 ck9JUftdwDv3qT6BVshPK+nMswyN3VlZuNqcTT1H9bnIsq2w6cjH1SP1nsBFViO2sjt3T
	 2x/CMrjcQbLYeEff2U1JcsTTu7nN+AOuXyeR0qHqYX72IurpdcxuskHjYICPRttqcCAvr
	 FCZDh63OeAt80mJSaOT/AUL87AJDpmzt7vwBR47D5D/OzzQIw5SreHzGptKNiX81k12QW
	 9C3ey8dw62xEzXQwfCCAzQg7E+cN8B3i817Jb10VVDOQT8R2CmLVrlSPb3jjiua0YSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
	b=LozovbQThriOFYqUjL/EheSXzSRcGEZCgliYpo7DfWF6visDfwhGA26MFJTdXUyZ2WcP
	 akoVGO0rYZWB0WTxdSH4zMxiBH8b6t6nKinM1lPyPdhkWqK9AOZmnz178Q0/XAkc6jZm6
	 KQrRo3jP27EeCCnTr6OD0+Kw+xnQYM85mK8v59Vtd6wKy0bNwlm7DBEiZ4G/yKmCDSv0n
	 hahiyn+QNV8cGRobGowfJBwBhA/KSQFBXvDEfVKNXKu1fRph8Rp3ZqVAxCCQef0KGk8V4
	 seM31EtYBqxTfz2hYRXxJ6zzNM/M4eQ0ji0QELUklED0qyT+fN8vpINqU9w+VSbPUyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDHlqWF1;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CD606A332
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36CD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDHlqWF1
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ccca948203aso87869a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338022; x=1793942822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=pDHlqWF1Iz2T0vGornP8jRjM+eugWQfTmuZ8wRtFn462mUX7njASBFsyP32zWDvI9V
         OIdqepX8FhOAnJiAF3utmhXDmPthFcmZsvbqyG7B8iPdRlYcmxenLv23lx1fDYy9rlll
         ot1e83g6qw1abZRc1obfCmakZw0uhiws4X8n85qkay5QFNTl0gVZsivhw7Y27LqzWP0G
         eKxOQ00C4hzE0bQRBRgZPfqJEhz7M0EIImMYM8MkStTqTqeD9ywiUSnA5wDxlDm9FCvL
         7ouf6C3HZcCOHLPxH8d+gN/1wHLJOFaoTegC9Zta62mGaL5j5ZZi4tJqXbAApPTy7h7M
         /M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338022; x=1793942822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=AupdKs7uBdPK/By4Bqg0I3fDdoxwy90wCIJbvyDWvuyAYuwZuyfl4tAUxELwbxJbEL
         kYRiPqQbBwHjX/a/yg7ns+66hmXGr9b/EALi1gss/yDpgwtkz36v+lZ+5ynUICKaDzzT
         8FicgOpE5/IwAYMqzxK4I5eKxUUIpso/LXOSLHK4GM6iu7qe9UfuK7mHAEtH3B+MfdrB
         W1Aw4rJrIMZXsCmD2BX7v0uHG4clgTi/uzyF4veGdjL/A38inie/ICSU7ksC2xVUuRgo
         aszdtgzvEifp+zYX428eO67/YP7MirrQlZPW3fKmY5Q8A6oODJ1Z8CWYw05aUCKqqbq6
         Vqnw==
X-Forwarded-Encrypted: i=1; AKwUvBwP73dKv3L0Q7Ikw7EnB+0iJoM/YLXtw6H8qsDcQDxGjmJeJMMOF5HQx5CAsLPjYvQNsO/9HxJtcMNiSgiISA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJEw34cK1Jm5efywTpS4t8zTHLyG4wqRfLPo/TWM6c0YNtr26o+
	BN2Rd3y+zDqLYUPJ21WYKUSLuFbdynxhI1hRb/EbG5eU+HdvxzljN+Hf
X-Gm-Gg: AYBFou10LILrdOnyotet1hs4/nR7OGYHQBYSpq8cxVHcrpKgAZj8SsrpvNnHUSn/CDv
	+0+ha2auzLm+/BVjroPY/T0znDuRkv21/ggN7k3EYZaF5meavV2X8T0q7+sibjeS4wQi1oSu5rZ
	TajAG77pAGEuVhQOpLUvnePRQtL4arTNmE+d+Y9tu7W/Yzll5QIhkKtz7QfP0mVKYlfwzQJVaja
	Jz4wRfN516sEkK6CuT0mxnfa+PXEPnTGMQsqDif7kxiEytM6fqk0QsT3uw4B1eQ7er8IUbf64uU
	hhabQywLZDlZHHxoAjP6sM7+U2GMqtnzap/JuPs1JN1y4aREKvfclW3tHSaPnrcyNLnt8tKWbOH
	vQXUDVYpIE0E22mEYi+CNZjbujuP1QcvrvM+fbvDW5swD7GBnl7LXzAdOhnV7pMbmeCOU52RdJ7
	Vk7ekj8tCXBJULtOsn6qRcIiIQ0nQ4zsOKR+txKJ/wuwp6s1WFlcMTjSP8ZkD1zHse6mZqEkAzK
	N4tyLC4/gyHQS8oTLE6VsA4S6quPLT+WVV2w48olXYJ5XMJYZb/klRfxxm3ZDI4Epu1/N4cJk6w
	4mDGa3tMEjSxfRAUPMzb/ZjXwBViN/yC8BxFsTZ9knJiR7oVvdOsf/JNzXdvuorpfZWOzcS/UKR
	RHDqxl7F3SepBmtS+/UDKbB29DCsCjT02EDVHVM6rjYhSNtL3
X-Received: by 2002:a17:90b:3b51:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3ae897dc967mr988753a91.53.1793338022165;
        Thu, 29 Oct 2026 22:27:02 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:01 -0700 (PDT)
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
Subject: [PATCH v10 08/14] ALSA: pcm: report partial progress under the stream lock
Date: Fri, 30 Oct 2026 14:26:23 +0900
Message-ID: <20261030052629.27742-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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
