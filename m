Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837371;
	b=4/DnD9odc1dC4BkqIO3MXgwFaGp4tcbw+UzQv4DXP5NIlj4zFvkkJkw842SWFk0ghSBK
	 SnFnvoZ/CmUar1QR5eMTK4u1Am8N2VCwe2ZG/+xDLKkZ4zspBFpTKzOhe9mvJ7cKh2sTD
	 +5NZA6yjWJRwtefEWbsjy3GNFE7mt51l6HJrx/7mFThAccqsg/Ql8SKHHkIW69FeRxvM2
	 h8DxwvNUpynbaKSHRMEkO3c6Qe99U7eLIMW4ScAP3AFwItiwP3bPyIUHcAs0E0PaJbGYD
	 UxsDjK7vBt36sAgzVltwQihh1G9VVK3VU8xJlP3dGAngArzosfWmd+4HjpsTGbGaWUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
	b=AvfRBvLktf4AlAOUvTc3uHW/GFhZDFNpooefq1/P97Fr3KGCbOs2ESBSj+Cr9lL49prq
	 f+NZ7hYPqS+QSuzAOZGQ+KDPrMO9+N2b/OP9q/qgW4lkJKeyzlGq5GkYU8xMb8uOIHO4W
	 n64VmbSIeTlQs/I5JTcSfpou1yNlnDTeA/LJMB9KubBsRP46ENv3c8HklpID8zyXA/9rN
	 S4YK8wzKge69qDt7edAI1ydjM7b5Ji4vZ50DFSCDKN2LFwaBNw5c3E64ZeoisCcQ6CnLa
	 NvZ6ccLiqQYffS0e3sdEFfXZbY5btIHqqEszfkByox4tuK0F9BeB89X3kLbyzogOzhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uryrXbq3;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B45606D833
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B45606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uryrXbq3
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso536888a12.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837370; x=1794442170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
        b=uryrXbq3KSYKMc6/WQDNXzx/Egf/GoQ/1E2e6KH5vvr37lEI2GheSi4uQOHtF9A3XE
         3FKj9kbsQEdeKQ4/hwPDmg7XO4NA/hKNfF1Y5nNdld28LlXslSvrPG9zbLb2DQQp8kLK
         99EuAY+6HIzql9EIFL0z8I7Tt4DqnrDCGjZfC+nLRaOfxKY7UK1AtIIObzrNbTCFvx6I
         2e7dRKXRSPpTQxCtICf4YFMhaqFb0z6+zeHqXMCedzBL68yK1jkdE87nAJ/eAtQRQP98
         YxM9UxrmPmzoHFgddJV/802xoktoe52cmxMYRCAw36iqKLjrof63Cs/Ti23uAfbl+Ogz
         pjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837370; x=1794442170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vq33bnlu/OQ1LhE9PZ9KLC/HSs9IVBdbU21ySq3r478=;
        b=Q+SQbSgCsqwTaHLXmVnlW+xpX+UjdU7rVfs6BiICHcZUhj9acfgKm0MZa7GgjHVl+V
         Qv2enEzkcwk+lvp7P1hxFIliILv5Alqfyqg3OCDP6BHGVqeTuv5m0FmdkzCpKY+psm3/
         IiHpV9JZes+/u4iWdFNt/1ku+8y6WhiqEEibtnLTQMO3ShoeZElsc1AMLH6eotD3n2kX
         KkpIVP22Qd410/3dUW862fuSqHUkEI8sxtqg9JuMIRmHTx9sNURu4uuHh1Q+DZshPTv+
         16FUnCgktuDrqHgrBbUpsmjrxs+nJgsyhSp3iK0MPbWzuM/dDLLy07H/vzliV3sD4nP2
         A8bA==
X-Forwarded-Encrypted: i=1; AKwUvBwkXeUkg/U3eFrJ1NVHy+J/0gYFLxRK6KDqrqxZO63/yycjS/wkf+yulHfkDTgH4Pdw2ShHBD/ReffxTTc5QA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8kuRyjIXWTH5a8Fv46MiR4+He/zwpgRK7kCygSuMJ7+lVZmeYF
	KdoWt3P2xsToiXFwo0eNKtUJK12DhJsif+OS/xG5gHOFLcsHsqJKRnWy
X-Gm-Gg: AYBFou0wxzLRlOkU6+I9uFDB+hadksrm4MG6y6KKG2vvUu7G5PXz/e+eDrZmzJIiHVn
	KGAosEh3Regi3KXfP3YpHW1xYTKfVY15Qt16XmqdLz7JL+yD2FS9YOZKhF/5r3q43dwyhx0s6JU
	LrsNEZRxMHyR9V0GUnrHANx+5UBpM7NzyvcwS/7OURlDiZenOSHXwhBx6HMTA2mDLyh8uH4B6NE
	SoK7MNa86byY/gSVY0cZMXmfQVFk5IJzQaklyF9MZDoz1HH3jVeZYMvFKjN1AIc3jOQVehdkINs
	y5iK/v+w/OCXCKAeApAJnb/PGtXMs5HgClsqxbYHzgZFmXQe7M7OFWzh+pyMBjqZadcZQrwZbiU
	r+O4ugnb0WzUV66fw7B3HEhp0iUqGaPobG8owmSwIOTg3iFTi7jtizp/6DpGOMVs+xMTzENQIya
	20OsTYQ/Li9TkKWPx/sgOZXItt2zEaVzsKwUS3o3VjpX0ttFk47bIu8/+m+ieuIPoWlH72bFR7S
	vGdp+p1mFwJXoWon+6h8fEMYaPIKEZw1yXwb0nf0ZjeBnHaCJ4al9NGH+uUY/upiMXG/34O/ayr
	8UnMt1+vZQwVzrIe8NC1TDD8GxSYxAMZo9MuvvWZlGYD796rQCGx+34ZS6qKRSSDDeIyRY4gMHx
	R7hm0BcqbJyCrPwbIX74kbu69I/6Bt9ckwgqI/wC90BThRtw=
X-Received: by 2002:a17:90a:e187:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3ae896f862emr13929601a91.15.1793837369930;
        Wed, 04 Nov 2026 16:09:29 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:28 -0800 (PST)
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
Subject: [PATCH v15 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Thu,  5 Nov 2026 09:09:05 +0900
Message-ID: <20261105000915.15177-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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
