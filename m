Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837403;
	b=s+VcSNFtPZBZ4LivIxZKIHtolEFk0sxeHPgaQt7ABQprwJTLN+YxIn8uO2zeVxuKPPPS
	 /jlA3Y86JMkt3d/74DLRb7NgbAfPclDSgDgJJdd4fzU+LxkF2X6m75wTsvPel+aDmkRXR
	 tDjqHjynmB8u3qrL42LHYYnLH9vAjgt78galFiVFbDn+adpK4vR6tgvT0W7pc8OizTqql
	 9b8oPbDpe0qpLcnOEnvFTgNvRT+Th/1K+C+dEmMJxPtIA5z7C78DB+X8Xqv7Ff+AVYe4F
	 tSFakWGz0PNe7FUGpc0oDfRTBNsuwt2vl5Ysji1V+5zR1avabERGzrPVB+m+LOBvTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
	b=IwZ0qAee6/2afC3rnzHRf8Lnwgk0ZSzIzuC50oCoEafKXClJR5h7NwMMI3uNO6Ar1ldZ
	 UJpMZMv+lFExeLumwfrv14B0s1B0ho6YVqEzXtKLI3zLws9Z38RVFfskZtzNN8UOGNHgX
	 MotzVPTO2Sxn+4DWV0MaYixj3Hv4qBKNhFkOiAuwmPvl68fJY+bOtMqGLTLDLHSnly91y
	 oBp3VJEkOcql1sj32WmF4alfR5DzZ6jfFg2wpnMEWEhz3IXAjsDtiSQA8DI5rs9vb3/Cl
	 4gVgbDoMIinyqCWgb5XbvWFjrCodqZnp1tNkpuFcASnJXgiZLopLX2dau6O8qWKAghg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hggi/GYM";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C96083613
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53C96083613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hggi/GYM
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso600722a12.3
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837401; x=1794442201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=hggi/GYMSGIyGBuQ1iipXRqbPZ/kq4rXfRTO/8LEuUDkR0AxWxj6hEYYeE6zp0d7Nr
         pXH9EfSVKNKC864h3SkYVRtKojBriuz0BqQPeK3AfBIAfDFjSDiCh0sMdqvW+IeYLHhb
         7IZiDKBmqIFBKl9skc6kU0iYgVaRedpL1zLNzjBdMWYcefpzBrEZUXFY8rHGlOkDc7n6
         b8zz9ed4za71Z8q+uktitAd292GGRe9fkV0meqWNrV/ggwpMRSdVVTIFPqoZrj0O0UJb
         GznOgkwL6ZQg1hl6axozQItpUSjfmS6kqF78AeFOsHQQmCNULQFIhB8OUtQ9ZJL2K6Gv
         CBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837401; x=1794442201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=eG1wx/ou00gkiUDOvYWOJvgSBtEMQZTuZm7cv89dekoHvpbMK0Muo0jHx3UGQEVPcA
         KdAbzPccPbK3a7LftMYx7UUOiaIeoZfZNboS6PxnKJ67c2cKy0frt+ob4sfdMRtvB7Ev
         REZYLg6gVmJSpZuud5TsuC53DPp6txOistMA8A7YPLuw3Pp1DwThPHn0DZiKvbzZvKTa
         4+nOipfZZieY0GjbYF9Yq+fI9KVacvLZ48LNgD3ahmCyeCJVn7HQ5gLt2dZaADOFwr7F
         ReSnMQC0cq7zzgVvtW72Ftve0QNf1427Irln/b6BpvSaj8Y/x4XIkuhLjMismqDpzoR6
         uQpw==
X-Forwarded-Encrypted: i=1; AKwUvBzF+1miScJ82mnpptEz6IZoSfAedbdXopnD8QVkjRPT05jo/rWR5xbr9+sTR5oYAFbQQXDsDwVMZp7SXks0RA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3GiC1fnAefkABiMLkQeUcGywBk9HPVkoB5Jq+bZx532HUUoKs
	8PbUK6jERmHBUM4Z4dnNnRoLkFRT7ytUjpUK1NNlznf7Eg2KDFu0WNZp
X-Gm-Gg: AYBFou1Uf+t0Gc7rNyFRGvhK49+vq4UUz5l71MZ+V+Zp9pzccGkG0C+zvOzlmmQU/it
	HVvmewcDBFPqFooC8FBotcY6/lzLRl8RPny9DdjRIvVPZaCDCA990WFcgMqAS/3KPMRNs4iIOPb
	W/c/+pl2d93dXKWXmEftAMIFFyWkNwtzunrQ25/7lPIKZV6o6VIxoiiaJI49GdBci/Y5OHQc4rq
	SoONOeZikI8mKV9JgVbT/aNVcksYtvCzVuPID4UTYJvptLDiBlWXG8fEt8wsQlTaIKgrHCrwCKF
	OlM1Vp5xJhzh9q78IgdKe+tltK1Zj3GRXKBY2TVyMWbnXdWHuXLbolT2zRwwR4fP3r0LrbLKnrp
	rkkfzvqNiq1BYDKhC6l4g+yk57JBXUWEHFRiPV0O7gEB5U2AYgE6eGY9goeO+QgIrT50TWlyoye
	u3UH67c2fG0GDYDtWXWhsapWGd+NtnZ5QahwJy6TuvPlFEQyYilTp+YdChXzN6iUzeyt0WeGVax
	Gs3vsl1YTjLFv/K6jTeKtPKc1oubuuSjUPMWOhqm/nW68R6vugVeZCN4Bg8kd6k21GBkKJgLlaB
	OHWV6lNTINrcPB4PhhhMjV7uF2hmlEyzLQlhShMWcVAopollPbn6jTISHFdyEgTKGdjd3mxrLB6
	S3rhMmagiMnG/y6UuBnP/iS6t0KvErj6yewkfkpAZmbngfIQ=
X-Received: by 2002:a17:90a:d887:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3ae897c94e8mr15687754a91.10.1793837401292;
        Wed, 04 Nov 2026 16:10:01 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:10:00 -0800 (PST)
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
Subject: [PATCH v15 11/12] ALSA: virtio: prioritize staged capture period work
Date: Thu,  5 Nov 2026 09:09:14 +0900
Message-ID: <20261105000915.15177-12-mynameisjune111@gmail.com>
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
 
