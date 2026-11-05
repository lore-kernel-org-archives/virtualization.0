Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862543;
	b=UqCuKNFk0lXcP8QxAOj+2E1detYUbykpaFEwC5DOrf72FUHAtpxtItWm/2Y/z7BAo9Mj
	 Cea6M2xx8W9NTkLYmmkxioj9tv06kkAqidGVaTpUK7QzvTcJVujjxPK6tBOltFxBMbQIa
	 WnBAbFv/stToAAe+ba6zk4IXeh+2WpB8p3j3yRO5hhe1igiawRuseP5oQzBClXQalZ1ql
	 x8/tBrctInjFvh7sFlEnFwGEgrapWIBJyBSgzRbYxaQlqA/WEXPs0ZRjKv9wkkQGXGncD
	 aF6yYIQCGtcCXM6EZsJuCSzUz8HyXcvXu74G/wQhgqEtPBZGaCaf6MpLBRRHT5SCang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
	b=PQFjYpiX0g95ukIBQfzDTpcwjXnusPa7ye9gFnV1qV8RQUg1X+g7uhp+nRQMV43GfeYJ
	 1AbqpQY0XYRxZ3MIfm7AtLn5AEcMVKpUb/b0xZzpHfAzYSgt+KIfpLFHXwrUGjVHMJFth
	 kUHBOweqtX9f/U3HaBsESbXrXMlgsIYtcqcBGwhgqdXschm8sGxdfMHTcJciM0kIqNQ52
	 xT0uZbWNhtpI0b3bo52NOzRwTLyc+L/DWYeZIqxrA5/6GrY88h/Cbe9JKs2uOVymuHkq1
	 FrZoo6H9WGHcD1ExSQecQ686NtzL5lHHnqdWS0gcU8Cjyk1hbAuVJhnsHUJndKkFErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfm24c8U;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B323606A333
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B323606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfm24c8U
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so2049575eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862542; x=1794467342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=jfm24c8U3boIoQJ9kQC0hknYZu0zD9YFk4SU0WC6Xs/uAYIAHiuXmuuczrYTGDmWI3
         3KYe49DlFTMY9JFncGmDKpTRQyKM2zQCpve6pWEigBL90FJQtLVSlwm8Dqe2m3qdUiQx
         deEv0MClRiWWz/04oqgwh6/oYsvN1/DIDVwDBNOLWEa1+oA4hFIpSi7+j2Y5gWyEhn9h
         SNv+EzckYC9fJA+Xev6bSz2Ts0Ri5Lta+va52qml88c/JNtyxir6MoacYqDfItJNC0b5
         xWL1wR5T3A6Hq1zdp1p1UUzZjsjfLCxWKE87R/PNz27SdsXQhhj85N3M0PDqQHHOOU04
         jSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862542; x=1794467342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=enmjwD45ZujvpnoeUlRlv0nqKkENZxynPMxPl4TJ104HgcQYDoersV86kXZzJ9unVL
         48AhHFmJCtV/90U/2hUBeQ6YZZE/dew5am9j/OsihaSg4NfaodJd4bxjGLh+d785znE2
         QpI+cgl/dD6FByUM2kzCM7yI5xPB1cDasSTs6j+IIsUMPvJSGo4kKp+EhMBVrUOJVDkq
         ln/8KSRQ591/LUdXJ+Ejo8cptivCIfalczvrH4Lq429ADjCvkO0TzkYPQT3QKjOX99J5
         IbEjO9k7pFRhGHMIGO0aNhEwV1wumwC/HBELYTw9mmaM7FsLxO+5OaiNNUd9FJ/u5bDF
         PNIg==
X-Forwarded-Encrypted: i=1; AKwUvByIhQMOvOMk+MCELAfTxT3WlBw4eUUm1xVydtl/WRJNfBmFRsXfLU4Yfd9V8rLB+7TBhlqqC0jn8MNeJ72dcQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+NGCi4zm20SgbbWT6CT7zz13+tngf+nT1zMhAG2OJBeisjBmjT
	YdcSHXfs7M/PP0pMAO30PgLc4NCRJ/cG1wGzHvpAk/VYWiIUCICgV77x
X-Gm-Gg: AYBFou2du9xm3WkJlNc+3dFS3NyEQekmWF4e5CoIZartPlZ8f7yrmDArZyZ7YYNXgj4
	37Y7MyfdqCIJUnIOdcmj4XmBFZ9Ksy0zpVHedDMNj4pFOSYnwxfHojX0QrgCr0rjOflVsfXATBu
	z64EBgJrqKvpFY18yYCmXP6N+Fei1D1zZXVEFeRMKfvjLa0tLCp5hi04IA0c6PeIj2r4sCV9XQ4
	nmSEQGK+3nltZeQ9EiuGVGh/DujyDTTgVYL3AznrBR8mKgFfFYas3Lt8KcBItmfe3ThSogtZE7J
	B2LvRnEAN5EfukpZV+UOEfuMcOhRPcXhxUZRpAXNwa6kLB7UL4ZfUFTEvd/RgHcX+nPNaI27XDw
	tb3Pu6DKW6fy7xwzSkuHfam9owsqj1rhOFezkwZd/tuiBRuGdF6XctpyUQhGAR5+/Oley4sA47A
	uT6DG07Xxy/Cx8w421Gxi0AHARaIMd+EcepXROIEJWdOIdqW5M9BvPJuEK8F+1yskl0PdoJIsJF
	QnnAegbA8w/LCH5Wmc9wd3g90EwFNyaBvX6pf05qd41gID1dqfIJkxuUHmdQdizpLDvzZix9PNs
	7cCTAvJSpRQZP1jFSqFH9ayxjaaW07YdtxMzmVU5ERhB6JWZvEB7VWy2ritgYyh0iSdJbI2LFbW
	vpei2/+7Nj+nVy3SgXoo5CLBB6Df80csl/dz1ZuJXXCH0OViilqlM7ta3OFyy20s8LeJh
X-Received: by 2002:a05:693c:42d4:b0:361:1dd6:531b with SMTP id 5a478bee46e88-36a42484fa3mr25645993eec.26.1793862541804;
        Wed, 04 Nov 2026 23:09:01 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.08.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:01 -0800 (PST)
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
Subject: [PATCH v17 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Thu,  5 Nov 2026 16:08:35 +0900
Message-ID: <20261105070845.6449-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
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
