Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845949;
	b=kqoIc2tKDNuEvwysiJaWDIX9XxD4pVOGYk/eyGPxcbw41AdrEkhvFJ1a0GrR7fCptmtw
	 0JqJMpVxHbY9leRPubEE12ZSrt3rdVD5LcujuTIoG6wpb/WHanBBeIDND8ftNB+rG8ZiZ
	 HnI4vKnlw8gJ1aODffCLf4ObFS3EnY5fGR5Dl/Rf9ECQJbPar49UWxPcDAPAmYgWUFBiY
	 43DVJ0rPV3s+Hw8x1VM4v+EjWtsSIaQD4DbD4WWemhGG4B7Tgc5lF5QdJEr5ucQixNpNz
	 HRGT07MmDpvuG3D26qmJbmIdfpX3c8PhpctyEhBLVCWlSq8LC8MwaKTfxbcjGca/eIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
	b=G+RGpTbpApUutlARcCuW4HR4iHMdyPwbWUfG+xRKeZK0y4im+TLzPBBW0F7w3vO82gfY
	 ve4iFhPLIItFjggAbBAN2CqBXcxCiysuTQ7W4FcYAjDXpXwv+a/I6e7GrIEfnaf/9XGfu
	 Gd9x0AHM55hDdjso7UEvIYdQLzqPbtD5Pl7sdAGRgl3jU3bLhs6mBx7rP0UerlqPhLmA+
	 jq9tBgVetd9de5KhZZiA8ceQ5bHpnUPGO7uHUBEE298oAeGyLL/LZqmFX7SGA276B/Qfr
	 RdvzdIBGFUmZEhudbkk00/QRxRTPlmg2rwWcQJXrKoWIyngD7ndllLsXj8t8DVkum4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vhJM/k+b";
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF1606D81C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BF1606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vhJM/k+b
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso727759a12.2
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845948; x=1794450748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=vhJM/k+bZooNkwJLvH8SVJkyDSdnyD5RVNOEtjT1M+PZw1QM/16H0sUidpy5bKGaUz
         Zo2ofX462l0lDYNKEl4TcYSLNAOcOrsa4iHQYITu/o7f2bVo4zgZWte3FNbjoN7yHHXO
         8Yg2h4wW88Ib/PvvKrImtNxQVghzrYfV2X+j77KgWPSTK1cbhfDwRDei3C/+IEOybmfy
         ZmWbImRYuD9A6DLV2bvcMPnHUnBIbU/iVlE0vjysgy+YEH3Xo/QXxVe/4QnvNxDSFkWe
         ftp+TNNxNzuHQ+g3ae16BObqRtCdqCHI+z1dhCwlBAxFpCY97zl49o4oDNJkD3JOuWD2
         pyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845948; x=1794450748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=obgABy8sZEDbwFhSCLYiqvfddFF4nTqGtFDfCDt/jRkR2Iu01yBhlzjFJWoI2u7w+r
         FX7YY8gp5j8Ncmt7uUmBhWXKJ/YxwLFLVdokWVizftbBZCkBgg6QeRygnMTd9GPZtuHW
         VxXse/PYn9YsvM38+Hw5BXFOEBt2Hqy8x9fzmV1BEWg9y7mOu+T9KSNW3+Zl/eUJndz8
         w3YdijW9mmcDkj6VKU98Ew/QL1g8neoQcW36T9edIBxxUDv0cn9fsG1DFQdUnvyTxYTX
         y4VuH6VI8i8eNsRQQ+GEjSC/85Y8iTSqG3zK9UcGoW08pUFt8E7RzqINcBhYMFcoIzJq
         2tEw==
X-Forwarded-Encrypted: i=1; AKwUvBx8NiPrzhlCFkk7GjQczGNEehnubaeP5aJapfT5isRWRGStGeO3DplNwjpMCQTpHmx/9WPdhP5Di3sVTxzB6g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/T2G9raRjZCXSVRwPxxwYTYeejP+yLOKhnpwmwaZO2KbSPTx7/
	7doG08Aud6jZOdueF31Qv180sy9ShHZBFRn6TLb4LGnPQe+xOy9w9x7G0nU9PQ==
X-Gm-Gg: AYBFou3YSJ1P2lQnNxuo0KnmYvjF85alr9XnSO66Lwtdt127JPiw2Lf28sO22DbLeEL
	2HsZFiSUstpgI+BcqPRMly6d2CS8WSW119/Yy9d/2DySW04K9s2lkrE9/wVd+Vcr2Hn04mInces
	VRMEmsGUSKJ2ADNmzc9YMo6cvwfibJZIrnrPWRvt4TYPWvtGsMbY38ZRKQqkjFUrd3fBtAnXI7V
	DXt1gzAnBdMk2OZfpjzcDfHSYjt0kWpTlszzvEcisxvktL9BzEstwaMWxQvdVtF313LREKn1+rX
	cw/waoAaVC/azchz++EHDJzsF1vzxEJvr+GydUzlBV8dlVgcUF/PfT8Rh1SxkuotLN0F2a6B4TK
	aIL0qyJjTBBVPj7itODQ5QODeuioV+A49jt+TfxMLMq7kK3bmFDxNcs+sJiYUHhF3daYeWQIOta
	bNjNgqcTqu3FENl2w1CR/hissRLd9EqvIrqSEa0AtP0nwkZ/anGSwocCwHExMApv77lUbYM09Qu
	ekr6tBa6FLzKyShcktKsBUeJpqg4pRqNds03wLbDqEh+8UOulDn6LcIwXK/aqvEZ4xrIVp+NAyx
	/IRaqFcNqfKQ2UKQ3oWjSe+BZ+f7N0Vcur+UVw7bgDTgr44RP7JG5WulhVjptrjsmd9bpAKARvY
	QkzHi6wXiCnsfLnniSq8JlchNJS+soGapO4giYpPVONKtJeI=
X-Received: by 2002:a17:90b:3148:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ae897364c0mr14242904a91.22.1793845948373;
        Wed, 04 Nov 2026 18:32:28 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.32.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:32:27 -0800 (PST)
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
Subject: [PATCH v16 11/12] ALSA: virtio: prioritize staged capture period work
Date: Thu,  5 Nov 2026 11:31:39 +0900
Message-ID: <20261105023140.18373-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105023140.18373-1-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
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
 
