Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458178;
	b=MUCWcAiB0NqIOW4d11XizZPh8girKr8plxvf/5xDm7B5Lbh6YefKCRtWh7QWdTSodvR/
	 jvejUnApBES1hmWcG54NjLSBGk4T73aplQ5NJsnWeKLiPm8Dxrx4mrwA3zvrGf6WXMcRo
	 vf4HtbEgGuSXN0nOkEgiQh9CAWRx6ztni4U8OgZKpjyf5RKn0fIPhD44tp8Wp+fGc4f1B
	 ByEyosP9kLOYDD2mF4HKF6+1R5gKsT1cB2NcgQUgcMR/0w+pbMp2tu+uf0M3bxeQTz1ys
	 +VJQUlnjDqr/MiEXJ4HHdTxErCVs5eZaW6LUFNausESEyPQ3xHfNE48AjKUJ3LKEH4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
	b=xdZ1WbAT+2sR3xXhi/VlA1uYYnyNwR5PDvxrITnDvN5mxbUY3RQjukTUiXCS60HPJ7P3
	 DzMvt9o8ItEPP5ysxj6ZQ/+Q5A/6d1/4eorCtw0JF34BpXaPUyfKHcDub3Hb6RB6GNZQ2
	 1LSct4HG+EggDcJi7TnpEMGId+XqAD3g9Jq0EAkYyrgXBAXNnQru20T2/AG6oKDNtcb7w
	 K1F+maJhWJUVhiOWYQNRmgudE+EgXnyp4qTr+kU+Uaw4NwX9DV5MzQ2se1p+Jv6oBpnXw
	 /M4pDlWxa/4ROa3eTMNbS3e0ZUk2ECuHTP42dR2I+veatru0Zf5eOzKm80yLj5AJqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucVr7ULf;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6C60A6F6C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE6C60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucVr7ULf
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1949810a91.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458178; x=1795062978; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=ucVr7ULfhIvjZgKog37Z0eBy6UJbWxDsrOnI31qDj6Pmbu1xlN4l36HmhEsOyT5N+T
         EYIp3606ZWUQTyHSZNsZuUjyXic56XyYmOP7Jw3pesbuI3TuDtANz6FD2bF+vur0BIgb
         D+ycVoSSgFlW/J9ZwzuL/Ik04dmKRgPmYYAXpu/ruQhkcZZmOX056eQXx4kDWWakWMq9
         B1pC7onaOW0+hJY8gUMQUrS03j4qV2+vltD8VSJGgAjDbHPp6jVnym1ES2PDNzSmG3fZ
         Bfap7juAm5kRB+zT6NE9yWja7zCJCqrOSa0SAJZN38VZIsWH/vehkesReX8Z0TMvaitj
         5zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458178; x=1795062978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=h2HbnPYP+8Hm18ewdKh3sbNkP6zVJO3DjaKPiyGMsKjMceSYM65GJbPhGkeHLZeA1b
         xJwAshepmoXyYTwKgFnkKhgBMtPo3Dud7tcm5hrVQGeKe+q2Hwpuq7n7iKbmM9aBvoVj
         77TtSrboG9yO6Grt/11Ys611VegkkY02UZyHx8rL2kLVB0zNQUvphi8JcucpUJWPWesg
         gBKZ1dOUFEKR5zmODLG+9Vpuopmb6mvPNyx58sLcyOXzyNp579UwtLIGtqnI8wMHbNhJ
         NEyATmRLOffQIriUMFcpQKXIikk6IJKYw7aF8r92F3QqCbkiUb1JhHFLvBMGxjwGzDn6
         1YjQ==
X-Forwarded-Encrypted: i=1; AL+hErHWj9EQrt1+/CRQWJvQhLzsXD7k3EUFbdMxUjSIFbMcVFzgdcttDvLiHgfAN0wIRJd3LetsIz2XSckRPNAPfg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/GsJdWuiNVN/Zy9CI91pzd5kokCRaGlVAyxX9HObVhiwZUjaVk
	mlqy1N/pe6pV79mIDDdZVCM+JXf+GROY3Z0R+LTqb3h7d1pwgb3Cxjkl
X-Gm-Gg: AYBFou23mwtdM2H0GJ91F8CsVpUEfSGNpCfkwsHDjp0ssimrsdGdAxwK8eTKBB0Vp2B
	8YhZobj+HIvF0xNMXWoCwy4FOT/gwjYY4zjeBYe510S2DXJNvOGciSIr0fnyyWhIgql2tO9z71S
	t1pBCc/N78aSgr5FcEsJY9P7yPbVvrJN6MmtRmAQwMIVqPXSTdK0+DdtfWvm24Eg8TegHaIti7y
	reBmQY3SwZHmfzmf1Y9nMuTY/l/4eQ8+fTz6bD3FrrbRmixTfqUnOK4+zbBlCcfoxHrfIyA5+jX
	3XqDAJIMEia/Fk1RmYVTWpmnx/zHNBhJXfNFt8fdXiM9jLK4DtOlaDO6ba0bIC4I7gt+KNAVN49
	VNjrlpJbQkOC4ifeUfnim054gGRKKXD7Hhrwso4P7/4kRCR5/gyXMVA2+EW/dyMLpetSb9ZBOQX
	3ktPjeclqQPU7sbE1UWEUAf4cFkTEKj1NopVXGhED3omH0awaFt08aNeQsLVxju05AVTck9WZfb
	nToUYIWFe/sSY6Gm/KJ1DSJstFj+pdAvdRrmSIVTQRkn1M42aLsjEwi7FSa5/RIBd1IAEhxf8v0
	yVXiwtgYReZbW7mJbcD+teg6yn2MGUOgcCLmjsz7nfswge7akyU0RCTQTG6wQiIDlpFxBDFIgvt
	GXjUAWajMsvbhLHIJX6uI56n5ZZ7h4uQFpUgFEqZKOdAPPUE=
X-Received: by 2002:a17:90b:4f81:b0:3b0:9e2c:9b5f with SMTP id 98e67ed59e1d1-3b182df3369mr4529123a91.2.1794458177488;
        Wed, 11 Nov 2026 20:36:17 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:36:17 -0800 (PST)
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
Subject: [PATCH v28 16/17] ALSA: pcm: add an explicit application pointer to indirect playback transfer
Date: Thu, 12 Nov 2026 13:35:15 +0900
Message-ID: <20261112043516.37010-17-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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

The indirect playback transfer helper samples runtime->control->appl_ptr
internally. A driver that needs to refill already committed data from a
pointer callback cannot pass the application-pointer snapshot used for
ACK validation.

Add snd_pcm_indirect_playback_transfer_appl_ptr() so callers can supply
that snapshot. Keep snd_pcm_indirect_playback_transfer() as a wrapper
that samples the runtime pointer as before, preserving existing callers.

The explicit-pointer form lets virtio refill accepted data without
accepting new application progress while the ALSA buffer-access gate is
closed.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm-indirect.h |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/sound/pcm-indirect.h b/include/sound/pcm-indirect.h
--- a/include/sound/pcm-indirect.h
+++ b/include/sound/pcm-indirect.h
@@ -28,15 +28,17 @@
 					struct snd_pcm_indirect *rec, size_t bytes);
 
 /*
- * helper function for playback ack callback
+ * Playback transfer using a caller-supplied application pointer snapshot.
+ * Passing rec->appl_ptr refills previously accepted data without accepting
+ * additional application progress.
  */
 static inline int
-snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
-				   struct snd_pcm_indirect *rec,
-				   snd_pcm_indirect_copy_t copy)
+snd_pcm_indirect_playback_transfer_appl_ptr(struct snd_pcm_substream *substream,
+					    struct snd_pcm_indirect *rec,
+					    snd_pcm_indirect_copy_t copy,
+					    snd_pcm_uframes_t appl_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
 	snd_pcm_sframes_t diff = appl_ptr - rec->appl_ptr;
 	int qsize;
 
@@ -72,6 +74,18 @@
 		rec->sw_ready -= bytes;
 	}
 	return 0;
+}
+
+/* Preserve the application pointer sampling of the ordinary ACK helper. */
+static inline int
+snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect *rec,
+				   snd_pcm_indirect_copy_t copy)
+{
+	snd_pcm_uframes_t appl_ptr = substream->runtime->control->appl_ptr;
+
+	return snd_pcm_indirect_playback_transfer_appl_ptr(substream, rec, copy,
+							  appl_ptr);
 }
 
 /*
