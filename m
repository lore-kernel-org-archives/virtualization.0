Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981932;
	b=NScwWHhiy9f9C/aWvXi34jQsPIMWqnNYKA7lpyxBeut1QgrNj53v4nqYOGUMx5kPIaJY
	 uqy57tkr+4poVHG526jkZ2wP670TwfJl908mQsyUxgvOWL09R5WXmsw7FYkGxxJnvp++z
	 JLMSrpxQPMPlOZ5L1L9bmmAE1A3ZIR9UPhOVEnVz4JydD/VF1zCgcZ4nTg2g2WjqFnubk
	 haLdpblGaszL+Z8JmeXSL3u5t8C7SLLWIft7+HcwSbSl1XStDtW4wykBGVSaF2zzqlH1y
	 PCx+h8CM+u2FSFZx1rqynU6VoQBIxucgquHOmSOYA9da2xI9wU+SrNTVQl1gPHTujyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
	b=IHXVa4AI5jKT1sXlMMDDp/paWCnb532DfL1BGikeg28KLpvsDYw5icFb8iFu0LtoKpz9
	 SgwdTnLO3QxxRGh0M5M6hxbI+4QcQbgCuc5Qzl5xW+smA8o4RWFfpXpJUdCGmLQDxsFew
	 Basx33E8NvTmR0n0qdMTbfne/IqFyE9PhvTfMYWD3BYhm1MqwClJpkEeYVUKc1E4auhjB
	 os3wNEbVl7ZclrIqn0Hr4gAaenXlPdemIhWkU4oa/gyEr5HisBPim8Vnvatqvtfj6SASW
	 jTUjVjc/PHqRHQe4ddYRWpRwPyqqfRXUtTcrf3ILlXLB3PWsP+znyud9PJYTGLAR1OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IC9ZRyJE;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA3606D837
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AA3606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IC9ZRyJE
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b244fb7fffso1382802c88.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981931; x=1794586731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=IC9ZRyJEvH3RCaTjGWQ7XnPLVZqVbC6zgxdjNdJVDX1dDasxRDcuLJD7CW9qXRLblq
         OOMve5+bJb3TkV/LxIDDL5bFGEJRUOqiSJFahhgdZhH9f79xx2vt2pfIqsLo6WaWN7Eb
         4/TVWput/YBTx0bBuMIFa2HMwB3dnycG672sFepGp5hSB14y312XAw/dWq1vqS0poUpv
         8URV89tr5R7pit1EuJLv08l4xqw8Zy0EWYltS7KTkQfLzO/EBPsS3feD3FQiQae1YD8S
         9Sv7cjzJhsbSkEpWbd3+gtaDKlqhQ/9Zpu4pLKOfy5oSuKNQeMNiSx+amFJcwK+1/+Vm
         r5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981931; x=1794586731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=0NWCU+9bqvnc/B/enLKalgVjuTR5b4D+BKsHwMAFS0LZjy+rKec0zWPLd4yM69I9hz
         WiFgBznv03JfzDS7hfRmNNbeUgvF5MshM1K2bBG7AwO/JCeZr7bM1TQIo3TmeYYVEhGV
         92SFsZQ/HpQO5EQ3XySIG/L3RYDxkskPtkDceeVQK+1fsv9OHn3XoRqjLnw1CKflxBUZ
         2BHiY6qjzqVb8rPF9jv8ZVia7r8xN0L34S2/DT/CmNNzmUyE2N7yQYBu7ZXD5xe8etxC
         9wh1S/iKI22XnhM41s2TWTOOq+6w3lZXRZ1kEjR8p5KiEIVQioweGEGXwIjvMVNXqPHO
         P2aw==
X-Forwarded-Encrypted: i=1; AKwUvBzeQjRfT6nkPG5SNCJddiSEdecev/IqlVRoEoXCO7d+He7WlAJngxbCvBfWHSJjzFFyg1Q9wP4yaglicIFQ5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/r5nQ6vChhnR0gDj8n1bBIq2P6oVciM+oJfoSlQjrwBj65MDt6
	dulHPyxFXj/ykGqNRT1AfeBhy2CqPGh+CZJHvBMlxUfhPcIjzsnYH4Hs
X-Gm-Gg: AYBFou2yzzhYm6dDuozMu63dIxSftotHQh/XbkEfn607cfjlKY6LdJeu33KbMox7LaL
	lZhGOes5xxvnCkiB83ELWgIJ41rsGZtnbgYIHkcmhoIxki9oSgpfFo5QbdWkPemWklWoGUgP/Xx
	T3+ZRBoeddpLKw4qYuVbu6JEYcsl+SwxZqWi6U8Jlab2Y2ecf5xjbppgAkqiW/JlIBT/LnftUu4
	1Q602fvKxgVmcxueO5xMN/4WuQhxWc1iJN3yTuZCPqM2EA3GKZ2MFpqowjZ+EmJgqkz05MlupMQ
	gAX2vpp5Wa2uZ4QTa4VcOZB8ecYtfIT0qeNORsUya0Y/gah/Dsl+1cCZRlE451EFXJ/u8R1Qzlj
	VZTYgWIlHEu2EdQHcDTdZmHSH4nF4jemX4+p0o9KBQ3bmxQEMOPp/Tig7aHc50GBzV6vjpzLgEK
	b5WcNrnpIyyoNLJYoluGS5/zSXyUjUlusl8E8r0du1UeyIDGYRApL2syHsmHyrZGGljS+s1Rm0A
	4yDkWK1Hjg512u6QNoRrC3c3MziG+FfxCt9lDMUg3RMCA9QpDmQ/ZyQiAQHdN5EWvFrHanJl0Bq
	YduebMF7TfRPeH1IHQA2iZd6uTk6vmQFrZZEveoZnCbL6FY2ux4nyZoERSoIlpSHMZnW9TnbyTh
	IpuQiljyEAXhGfWNsZwxTBCMyFFJcGSJl/bwtNPCymEDlZaQ=
X-Received: by 2002:a05:701b:2505:b0:176:a225:e364 with SMTP id a92af1059eb24-1b25d38aaafmr3408405c88.35.1793981930826;
        Fri, 06 Nov 2026 08:18:50 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.18.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:18:49 -0800 (PST)
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
Subject: [PATCH v19 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Sat,  7 Nov 2026 01:18:28 +0900
Message-ID: <20261106161838.94308-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
