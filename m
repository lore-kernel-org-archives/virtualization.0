Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693335;
	b=y2mD5qFsURe1dAESa7yTHjsfcxORSlLFwGt/6A/v2NbO1bM1jMldUZvOeUjskEJ3bUEM
	 5qFjVyU1qRcDDnT+z7EYBdelE171Af76wAI7XzI6w4gm117q2Y2M8nWughjD/Ow21dniJ
	 3hijaEFK2CMSM1U6TzhDykm3rfoTi4/Zw1T09Az3AdqbMFxhjRH1Bxvp1AY/LNsMPtdU9
	 Y3y0HTxqu1+sLkB2sFD7clgkHtAtzDWOvKDLOhCNL8hCY6nKwpLtCRcP8mLlz8GZEUC/L
	 CnfkJsNaRK6byr4gcS8n+jZjE+LtiXNcZLMeXs85ig2SmxiQLAlsUkyDjAGFgshhmig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s/Zxo1I+8S4n5i1RRZUqfT8IwOehGqzQiN0Xdf27+bI=;
	b=noKBOGN58g9AHi55Ep9juN3khFX+hS7x9SpByaU33ai3WNkXH5GZuderHPB+c5FSgL/s
	 4t7Mei+LWscKbaO4YYgZJtnonZ6gYmke7nSRAEiXPsmTBMz43znUQY0Zo8l/oTt086Djr
	 /0NI5fEeFgVyeVXdadkLx2psrpqX0qMyW34FC282VqE7YNCxoH2B2hgQ0j4jBS9aX9p9b
	 ulrKksz8afcn87NtLHZ4c4wLDiPvXbAkba8KBr9T5S65X0O8dgrTnBuEepClV7rfopgF7
	 OFjeHhPCy6TtlJvW2cnPwSaBuZVtVAuLcaev/AEH1de6nd+sIlBhIciyU1bsX+xLWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLpBpU5g;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23C606D827
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A23C606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLpBpU5g
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36c9a93a1abso114652eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693334; x=1794298134; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/Zxo1I+8S4n5i1RRZUqfT8IwOehGqzQiN0Xdf27+bI=;
        b=WLpBpU5gHVjEbYgT1tWts4JUhOH8pbshomNuKMMgQLKCJq1LPMIUn95fxrvKTynGI0
         v+5GmPA8mlgbfpw44bNyMgzVHfcKXRjm0qnCEWGLHCvfTNF5lJd6TTZET4VHtyq8vKZp
         8TwWz7ROSTvr5G9fkn5iGvZsqhJdKvHkz4ySiCX0xI/E0s/+bx428VTUTDJtM5wJfqla
         akLqAbKdonh/nBJVxIx8AgZoESnkRZ0I39WCDSq0/52QYWy41EomRM2la+QL7YBOeLvf
         RzL0tfP+a7GHjC71a7rYLKzJUO/fOW2PqO6CcBsQXoODS0AS4TrE9UIwLcx1i+ced8FG
         aoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693334; x=1794298134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/Zxo1I+8S4n5i1RRZUqfT8IwOehGqzQiN0Xdf27+bI=;
        b=SD+FJrJvKkdnJMLVz1aM7MAEj73VWfRJtGbPpvzowZq5Dy6tWkGfo/7M4xmAecKBQu
         Jwllt1aqxgI3kiQWL6FzzOSyQkTdM3+SIcw0giZXcauxDV2tUbAos/EAA7WGM4XaCzJN
         tJSKq0UBz+GwBhr6kabDdfWI6cK2Qt8AQJIajXNl/3uKJQuGz5qlnqM6Da4LkHeC+rsG
         Sfw4uKB8hkUKSap8miG6KULddudXVLP4R3JRGQZRAifUt6eY/6UUf5CzxqUet8oxC7V7
         U9Li8j27UjU0LpiuJxVOOJmcPTYEAS3xUpForYZ+Ohm1P5/f6fE4OscnXXdujGfvWrxh
         YAgQ==
X-Forwarded-Encrypted: i=1; AKwUvByKRvAOHLUTyIntK9QGytTxgXvmVs8z+nnphf9bmvs7sMZXt6sQUakdnVAOItGEWdFplBHzCxdusiDpjGFtkQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Htoqak1GC377VUKnG2X1ubyYTBpedWwRkBOhvNhRBThP4YDQI
	301CuBseXsRkpLx/ItaepbFaTkzFvpUTYByNU6hmNwdlAy5j5cuxvla3
X-Gm-Gg: AYBFou2DiobhUcUiHtyOQGEKPbN+vrbqM7JGT+c78TTwTfTJlgC2kED927NsPFnnEtf
	/s5k3eUEBwDXKIBR/lyQZnygD9iAPhfCTeuvOGemzyBd9IcMIIuW6F88UrfEMWHAbJ1JIB7kwr+
	YvcLTSvUF/zSb4X02SHZwmp3xkB9jCEbkKEnlWrD6DqWZJDyX211KObtKSPWgTF8NEXsTCPpSJX
	XNw4G0pVSkhtvaJSdHl9xJuzPoQktPjBUdXPAKYFjJ49ZQu4ycwxLtzViSfbQi+qpeRa1CukVg6
	WdN1ONzsKx3p1FJyjin4AewkcsoECCDSZHbwVeIhGAYHlQdD2ycFk67osoIlaRzhQpsUotksH+t
	/BcMpWlw8CXp/Vn7CnDtfouFOTeG822hTP0TZ//6Fh5Ma2phuf5lzb+vK1aUcDKL846br2vBkQI
	okMbPYzVJYmhrHjJ9osgnZMqWktimWk2w43k3tTcxsYWyqfLW0hpa1Aibfa6RVUcBLFi3A4EQLD
	fRc9zbJDVrnxX0AJv9r4Bagd98cYvL+9XnGrRTWFdrEZxor8Sj4nC1xIPrXbQVqzY/zit6ftOGK
	9+3NbUTP+d/zKyUXuHER7cT9I/fyC3f+2r2W0mTBOYl2BWWd9t9zqzTBovmOhY7JZ2QZw4Jxfp8
	r7S2YK3qYBXRjO2c5t0np/C74j+PZDUR3JxqRLslEyFt0NK8=
X-Received: by 2002:a05:7300:fe87:b0:36b:c4a0:47b8 with SMTP id 5a478bee46e88-36bc4a04a45mr1387296eec.11.1793693334448;
        Tue, 03 Nov 2026 00:08:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:53 -0800 (PST)
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
Subject: [PATCH v13 08/12] ALSA: pcm: report partial progress under the stream lock
Date: Tue,  3 Nov 2026 17:08:17 +0900
Message-ID: <20261103080821.16983-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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
