Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923622;
	b=nvfkzTFiJDeDx0/CzHgEn6R5n0PbxpeBa8Pwz8OhoEHd4+6yVrdFnizRcRk7dWSQpyRA
	 m5s5nBynvuLH7qjU3LjHEIFUm6JmR/sccX/JTrO1bC3eOlh/eEb/EeX9k6aKI0ivmOSdo
	 Y8+shBxmIZP0EqNa8DX13gZqcOgSSH3IqUU515ZhQA7h5ctIfzOFTH6Vl8PY7kgRW6H6N
	 PUDUuMfuw5Ylgm1C92L8t/Qx2/jYrM4YloM8JHh0/D2Lq5Fpxp3OOM12wOFj+xXod3Lrk
	 aw5NOYnOfsPV//Nnd+8S0UZrfQWDpzBnFr8qKYp2PDY99JNCPmP6uAwPP6o1O3uK3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
	b=HCanalZgwWgFc+xymKFppwu00rZBRszVpnMQ8wrlgRFMsZANB+XzKpfygrPEzhRgplGl
	 WqJ7ugykgJCNd4uTlbIs5g6ZvcvgWiTZUF6PZmHnHcd7M02aG3UXRKxu1PDPSxQuv52yh
	 mu/ci74ZIYJAKhYKnlUkpvdzz0wJTuJwIVz6Bgvf4HqVzScWwZa/KbQKK06uw2hmgC27C
	 FsWZLfwxQYjwMjYrO3o4PMDLtIT5Qg/sT1oUCT+cCKbo8dPlbNoOrnFV9TSUw+582BoyJ
	 0GKuAgWfq/PeUUOvP6b9046ZzL3ie1Yb44jjjnZ2TTmxe16KGNRd0bgI14yGPgLkD/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yf9L7JTS;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BA606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 005BA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yf9L7JTS
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso303661c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923616; x=1794528416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=yf9L7JTSNQw+MCKOiYehdh47CBlPm2rBZecBN0iOlwZfxHH8XCoxWb2OecqfFIDXF3
         JKroa1KE3UYPIg+caNu+TBUJpqsy+vxort9KXSfaOznokx1pg6CUckESmywSAs0+UnPS
         iezbn+MBRhyNpCjSyi43ADg8GKbRWxT4X3ckQPoQXSbcGfy8PIZcqplH5G5CD/AII84R
         ITSr58qqPKB5KTQsbcF9x3jzNacc5AfmkKD2rhGIiBgrP3xV/CE0prXsl7mY2U7XU3IX
         5DmwIcYv0A0C/gZcPCEyLyUWjF8VLhPgR/mKa+QeO6azJh6LTet7QFwLV+UlmiABiNJh
         SWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923616; x=1794528416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=wiG5U3Wpv/I62XJrU2+XvVogCjhO/mEtPOs7JAPDlkL04PHfQ40+Yyo4eDQ2n0wfQh
         afVsMuWUBuhZqbCDCSF24p1ycyEUa0Wb8bJL2zKHESjVqYbqYbqA0p2uGIGFQUBs6KlB
         ex/YbcukB0fq8sBFsgY+8heI40Il3j5sViHXB4EhgVGGzNfbYHxUw2xF5qjImDNo6reY
         ZGYJw+U/mhAlMZbzhsnAePQHPlqDQfqxKd1StW1/7+BRJX8TJKm566+XFJhrybq52DuS
         r+i2qAzrYDbv5tFMCnwir9QcrfBKawVXZHBzBzb11tWbIjPpCLcMoVzb1SgI7BgoSXRi
         FhTA==
X-Forwarded-Encrypted: i=1; AKwUvByXKRzYytuSp0sZh0zoqRg2VdIghWcIevSxlADAZl/d0t6S1iaLF/RoOJwqbJFd2SH7bM3qU8zJmwJk7Dg54A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Quk41VlXU8K+UtLhtmXu9dlqQh9RwV2Hylm7XB81pk6p1VthC
	YhEW/+QrCwck5RA24e0xrmC689xBhs0h/PGVHjX7I3MZQJ5rQ64O06Tl
X-Gm-Gg: AYBFou0OA2SixvQt1ZDGlXRpwB0xNIuQJI0Rd3RnOcAS/vyXzbydV18UaEPf40us90A
	8TSFt02E1jAJZyNCY86RwBJhgUpjIObqLnPti+SbsLK0KCgQ3/GD6H5kIbpr6VsuSNosAx1SmvN
	PtBFgV3SDqZacCEVy+G6b01RH5/X8Qb7gHXe07x0QSVPh8WCj2jvYWpC9DNYpEbA9JWGYKp5zYg
	/Cf4H3PLZnBM/04FczJmMDOP4ONTL5S/lVkkCMHisl88TBOn4sk+ZfK4m1o+RCclYW5JbNAl32z
	sxghpe9Wk4vdHF8+tC5IHEn5IKhDsqJ7GdApTiwaX6CyLt84IhohlQQyG4VM36DjADTx4/X0lhd
	YSw1BUEiaV+7Cf/SDDweMIE8Os1wvfjyZT7g1xUMRSZ3ahg9biP2cqXkP3XPPmMnyr3uCDzBsp/
	XZp4GTz/pgYozHUl/FCfg5vU5FqMFLb4zWUS9Ud0/uWq56TpXAjNUFgl2+G30h5PDvbfLTXMOuW
	HDGgYa89EpFQchuyteBd2REA5VWqSKc4+UY1LOjWWLuHMID5G5Q6fOS6xuU1n9fs/dY92F+6mJV
	+FEe4QnNx9Y6Q1JcGV1jlXdUO60/EF65dRBv+jDuBaVGV+760k2rZw2Z1iNCIbh1dLAno+b+u1X
	DIlpyYCBt80ZoVqojTj2obLTK1cOEmgAylgcy5Q7HNGh/bAE=
X-Received: by 2002:a05:7023:a8a:b0:144:de98:eec1 with SMTP id a92af1059eb24-1b25d30dee3mr1114593c88.11.1793923616042;
        Thu, 05 Nov 2026 16:06:56 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.06.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:06:55 -0800 (PST)
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
Subject: [PATCH v18 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Fri,  6 Nov 2026 09:06:34 +0900
Message-ID: <20261106000644.20460-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
