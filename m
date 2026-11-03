Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693346;
	b=WyZbUbk9/hqug7T3anLQAXGm4U5kUjcKwmIY0uJ/KBrrwHNFfQkiCZB8Ow5ClGLeueLQ
	 SA3gz6qtmJr3VZgISo1y108aK6mKAKYdcnOQbQnMNPTe1vHQqZHMuofGBQSyGaVBYpDMv
	 Z+zixEksDcXvVazHt9ZHHGLjVHKg0GJWWd5yqfSknm5/zEOtLZEH4iw2dt5cZJ+kKms1a
	 TUz2dDUr1SDrr1cLC7htMv4wqdkb05RULEOuoUiNrpE/NSYLVF6+4/9WiwZdS0gPpU0Tl
	 LJqoytZO05I0eyoXHkEXppcpK5VgU95qssZeGuY6n/eDkl+GLipXTIxKXR/+nJW0MTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NvWnjCDmeIY5HYOU7QecIwh3VjwG9tp0eowU5uql+p4=;
	b=AM1t69tRoymZx/IaOFntKHfMLDff22wdrBmgLiJv8/GHi4VbvGrHgjozDH8mzk4qT1SH
	 HJ/YAp/r4N2ASp4fsuwCRKHIQxnrL/VMV6RB5MP/RkmMfgdrClCUnIGY6tiKjaAGWAz/e
	 nQFgWYrOzSJ0pD2rpsTFXK8EP6GnsimSj9z/zw/8nqTFhjbAGFc5TMmAFdYGDJBI+lWs6
	 iV+cJuxLMUlnjtVtgUlbAmgGCY5057sKLACLBBIiyK8wOL6a5hC5E1DiX2wykrfmu8PWo
	 w9rCOT+1fQzMgGRh9ZwW36NwU0i5nSmHGF3K4jaP0DQ1OIsIJ3wOcgeLwNkVzSm4wHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyGyIneh;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE255606EE80
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE255606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyGyIneh
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so5792453eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693345; x=1794298145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvWnjCDmeIY5HYOU7QecIwh3VjwG9tp0eowU5uql+p4=;
        b=EyGyInehu+xEbd6JhGJubDgKcVcpcHdY+l+pP+C2LFrErjstdnDfzZ7q00MFcyH+L/
         STIjvnMqI9XOI+j98ZOHzHTaQW8J0xBR06tEd7QFIaB2podxbvQ42IkJ6NyV5P4axmCq
         kOLr9bk+85MLHM615kp4FJ/6zFQikyaQiARA0Txo/2bo/bBbzYQywCtIs0KjFM/2NMO2
         1wZCgYu4jsDcArGGUjSNrVIySSdvQtArdYis5YJZlBB/NyJea2LHUJUnXhFkVko/ANzv
         SrjiSDQBbIosM/iv36YeM0ulEywC0s22W+8CC/je0FpYnvaisRvOmp5bp5zMfr+iM/7Q
         uk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693345; x=1794298145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvWnjCDmeIY5HYOU7QecIwh3VjwG9tp0eowU5uql+p4=;
        b=a8dhWGsE08WsCI468fYLTgA4xQVafyEMd0OjRsMOWc9rvCEAFaEB5XrT9XScfNWGqu
         8fCdLeu000gSO9nKRqhAuKqDPolw+LhlfSQ/1hGuP0lub/0hJ0S5ruAg/8gK/7wsWTN0
         kVKcGJ+zgFXRd5dlWw/lKH7pHQzUMEQVhuJJGXmL239casNjbbvSt9183RPpMTNVP6bC
         cE/rIA5eLuhYLbwB4MTIT0JWHXx6vKvaKzt+Caa25DS+WcQeWr6pkznOGCj84dc2AZma
         XToGLbHMSS2OlolgXofLmrMVbivM0ep0pMbR8JB46QIcERoFm30we7ou34FZAUah0XSa
         BA3A==
X-Forwarded-Encrypted: i=1; AKwUvBxUMiM/v7fXUU1TOgXEKK1hg0mVeXBlBP6fuYGqe6N0lV+TSL2YrcGp8LlEO9nbZyP7KIm1xzjuF55GBBTRkA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JrDpRP1jeXAiQ+0e9Os6HQ/h69C0VSPQJkcmKVpC3dBTS+Cot
	TB0fp+yMuJOgJP610XSZWKu0C+tdeY6ecBrT2Gaek8kOFD0zqR5jIEDv
X-Gm-Gg: AYBFou0RYfEIt0isZ0uzNXgqelN6HuPPvvV2XDUTLgaI+Wg7cGB1yLbqcCmrFquEFmx
	bUTAJc1PL1gxEcSirxpkXBN81zkCEiLADN8nruZkl9a9DtOTNFA8UF0lW8NDJCn87c9sJud3Ltb
	1mjpieKV3lYB8N9h3DhNVPW6DoYQ7AcFQkXo58v04P5xq8jloxz0LSVGIDszRz7YQKgtSCqcLoK
	hqfUv+cXqxiT91SZLIkM8BlBjI3kQrmpZIqx1/mva22C6+7yyZbjbsMZE76T586pNMW6Yvlw7A9
	JKqhMnM6pXrKrLL569c8hMujvq5kM5wRYMXFZsYQD/+V7ASdb0biohZ7jwXPL/o72A6E9ngcvez
	33BLygruXiW1fHQQyMM4wC/Wg+JVaS9RIo09EXuSxz/SaJqeBdz9hWWPTotPY5McgRfDibbGRWe
	FEteTpPIxzYp2dOp5J/yVctcpFJqGZYQGK2eWjvJ5/Hq6vjzdgUQ6ArS9eFzPwzSxcxXMfW+zDk
	2PF5plKotAmdk6HJIlnUHy02f5UvKgB1lHZKgcu2SDcqs6OefOJ122QjrC2B6S+Io2AgQl13CdQ
	08dyoQGFmdsAbq1dSevZMLIGxUCVryYg0MTyrY2b8AC9RE4SnE5urIOsd44gVsgkl9H0CktP9lN
	tQM9hgQpZAHd9wWqQV4+gFAyzFye0e50z0bysVl10PZr9hes=
X-Received: by 2002:a05:693c:20c2:10b0:369:f9b6:f486 with SMTP id 5a478bee46e88-36a4260db8cmr20091240eec.41.1793693344807;
        Tue, 03 Nov 2026 00:09:04 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.09.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:09:04 -0800 (PST)
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
Subject: [PATCH v13 11/12] ALSA: virtio: prioritize staged capture period work
Date: Tue,  3 Nov 2026 17:08:20 +0900
Message-ID: <20261103080821.16983-12-mynameisjune111@gmail.com>
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

Queue staged capture period notifications on system_highpri_wq through
the common scheduling helper. This allows capture notifications to make
progress when ordinary workqueue workers are delayed by CPU contention.
Playback and ordinary capture keep schedule_work().

This preserves the existing priority proposal without mixing RESET or
lifecycle changes into it. It provides no hard real-time deadline and
cannot prevent a userspace reader from overrunning its buffer.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
 sound/virtio/virtio_pcm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -169,6 +169,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
