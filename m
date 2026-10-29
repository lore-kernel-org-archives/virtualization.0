Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263877;
	b=xGo4xhd+00v83HMK2qda6y2TlIq0JjLYpqNalLfQCD4QXF8xXQFy/vU5w5PYummv+jO4
	 jk66tvzS9VDMmWTF3fV1J/Ea6ohn2cjWSVEoNPobe18I5onNxLByTWLGzNHZB80n70JZr
	 01BlJaFduVSQQL8DaMiTbi9LHNpSeRAXE+4qqlgOvjJP0TSSpt4t6oy1cq+86GjFKU7lc
	 WKeNDtnScjZh9ae7wal+dssONsyo/jqqz/m3bX9fXOnX9qWna15ISqirvBQB9AEwckd62
	 8IHZv8FTUYgMmAsWRnkZLv0r2gn2fSlC2A4TqR08EuLSbAe/pKDAJ97VUuOPfDoC3Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
	b=yj9iDmN0BdHci2nr2yWgjI9lfyBmyGtxVqUoVIhzP+kuZDFsQl5fvjVwpJbHM1nOz+xJ
	 hIQWatQgn2naOiqGHji/RdmSP1lpTdGuTtagADhlvSUq1jRoCZazMlYr/0Aplsvgw//2j
	 vI/0Ux7oj0iDVP8ZjFEtDymz549RbsV+4k7R9V/i9lh9qc2SL4LBGFQUjtgvRUnGDUiGo
	 IjyE7Z7IYmpawZBUNu1y2UIyEpFImXHGQtMQp/iI/Fi1dbGuDsEp8n0r0nQAeuO8yNIbb
	 QoHoz/vKAsyfmkPDdWRet9GI8GhthgV77xgiMgCrA7O55qBKrt5dbFMMxotGD9FnHYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O20BdEvd;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA56606A321
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA56606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O20BdEvd
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea0efd636dso15343065ad.0
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263876; x=1793868676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=O20BdEvdRo/oi61kUTACob+4jn1ixWWhxbjgnoNIFmlYHJTpCHyLMeCBMFhBA/iG4g
         CmeXrGIZHd10UkBDHA4mzWQI6S+CKeQd7WIJDIUrfKI/Ju4+ZUvd/V6b2ljp3qCjOxmz
         eLTR1J5UNOjzDSeobf2lJ+u5paj6AUwyMjgJ0ZZLLRWJhcZtUXaPoQw4V0PFF8uo0T96
         h+PJ/lSj7exrqJbeCRnyOgt6WxpRTt06xlpE3doeODKKm7kD3hfZdHSSt91EhpW5HfhR
         0pwLk0MoH0eSSo8AfUi//iyFIab8xqm1aCzg2QOMWeSQU88KwYFQT/T94G+s9hHPZ3hW
         Loqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263876; x=1793868676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=L88XKEPvRLtmyABiTbBzjvo47D7AQaJbjbl5sR9ljrqiM/OytcRMzBWF3KAJWIsfTa
         2UF6BkK5qZrcIG/0XxhLhbxe/Podg2sdcIsYyh6IwQc4RjyaHFss5awB99tPerZVYYX6
         4M5xCldij9/mWxyY2is/WxblASsh3LAGw4thAIlVduRSrxVrv6NqQKW9Bz59EccApWsS
         q/Bz78QR+hVvw9ZdO08RNqH3l6JTL3Tf6rg5Iy+z0PI/eRIu8pHlVdi9cmxiEivA91nU
         gAJz8UX6EpHuH5/J43A2Loawk7wU6g1o3BMTYlwy/gf6o5D9HO0MZgl5JHPQGZkF27Kv
         SiHw==
X-Forwarded-Encrypted: i=1; AKwUvBwpIlAETuP0msrY+yruftyXRLjEiVC2RhP3Zs1ObL55MaZX9Gzv5pva9tAfF0hzMCbeVCSPyc2ZR0AMl2LqRg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJI6CXVTSplpI1d5gBX9PzRfM+4Zf+pLzd3/RZ5BXSO3e6qt787
	U5BlW+yWjn/ywQ5m3O4HcIbKnuVIBOpF7Z/DvXyIH8Ww77MBxXgZD9gp
X-Gm-Gg: AYBFou2XsgWqUYZgjtWE5Z9UeNvMD9Jh2v8Ejs9O9soVUfdtFySsy6d8Yef/iBntS3Y
	3YDD8TbjdkHiThZTnBKKdWIN7rMEmUGSNfSSe1vzBv6KShSYVXOzPngzhwHlQXckXQr5c2jbb8T
	AQrYgE+Z1Cc8yEOH1gCLqPa2s+sbbxfgQNl8hRb501GeA8TyBeBF5983QLGvQ39iRA8wBAiM21U
	cyuy9W1lwoEFzfxMQ1S7gtSfpSnSag0Fym3eNWg9j/A7IeYEi8LT9PAH4bMawIhm7AxXQN4vvwC
	Z1oSQppyFUfMKd2S6etvGY0e0nNioAoC8b0r4PyiD+HihGibq28yGXDlQ8IcNV5Qy3iu2l0BNBs
	TbLQJgZTZmC+nid9ocwjm+hAZsFzpGUe4iMhYyeVRslqs5sCu8hyq/8V6kQOtByfRkO7MvVisHB
	/5z8YGESD4gCvzc7or/aj9Ye7aucqFRTz0MbSf4sAh9T9syGE0TShcqmQqXR2ya/6jEOgL1j3C1
	lBbTdMxmfvDGnLRCaLPecaJa0tk5oxd5gvU/MI/LHFu/nM3gURUfqxMBT+4nClITPvFt7YtYzce
	FOT2l6bDa560gN458Ob6bzDX/6eZ+4U98P7ER6gMFjfOzR7TniZFDswJRcZI7/Wo8JW4ie/pmOA
	5agKm3CRtptq9Dqu9EUC2pqQMeLKd0ElIx/i6wK87fw==
X-Received: by 2002:a17:903:240d:b0:2e9:3d65:22f1 with SMTP id d9443c01a7336-2eb00519403mr41782825ad.20.1793263876019;
        Thu, 29 Oct 2026 01:51:16 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:15 -0700 (PDT)
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
Subject: [PATCH v9 08/14] ALSA: pcm: report partial progress under the stream lock
Date: Thu, 29 Oct 2026 17:50:26 +0900
Message-ID: <20261029085032.70689-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085032.70689-1-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
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
