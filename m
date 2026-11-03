Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664287;
	b=qXRVt5w1ukHz9rk54W71j9Y2tm8m0CefoFRVO8jyC8A5lpooFB0gxhv9OEZ+rCXn+p+a
	 p7Ob93EZPWF8wCEZjRkTBzpcTbzPZSe52mfvARcwNisIOKWeMnb/H9PfOAlNyMY77/TAT
	 MqAVola+cVcqHUGJOCNE5PN0P5UvB/pi7n4wK/z/rSnGi3rg2eDWSNgxwoxUpqSg6LmzR
	 QxHmWYqo0lZ2w8shrV0mkoplDqWdclqqnBINmmgXR5A/BGOo5CmCG+p8kMCP5f4z0UPR+
	 Wc/obPK/+2mJDAcCXD7IvdfekEzcyCaLFtFoUIxuF3/e3XH38s+OE7MPW6Y+riTyxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YeGo5xYJrpnxNAew8vJ5guu9FtuzQOdSkjYnhG+rvTc=;
	b=iBXuWxJXE1sZucdnE0xwLUtTYjj7MdFpIIvBDi1MX8zO1rChLwHjxqzzLiM0w8leK3f7
	 d7jYP2jvn7PRmFejXJtz6Ol1rPen0ZWs9RsymMi2XWyfI6um5LV0e9CUXxaoq6cn2A0lf
	 c9KzufTi6/bvcGNa4fbHX77eI0RTLJnNfQC5Q/bCC6GFfm2Y8HIthrV1BOBNhzgyPbAa+
	 beTNfbqICF2Kb3hEVbMrtpwBPh8hgL3Bs68WA8h2RVRdReC01KmGF45pOt4MdMXMbpTcz
	 LKCl9OV68sBMWi0g894XJ+7VRwp7iijvXVxtTV+b02kXVj7cgH+GV3nzArxSluhlDyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5Mw76Ux;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1C606EE85
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B1C606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5Mw76Ux
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc147d86bebso110956a12.0
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664287; x=1794269087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YeGo5xYJrpnxNAew8vJ5guu9FtuzQOdSkjYnhG+rvTc=;
        b=f5Mw76UxXSWFiddLuSfqmCYJRyGgrbBj63T0LCWyKMSX4Jce9DwSVZYnVzla1m3CTr
         cdEK0Ol+jYmvmQ3kdtpjiT0fEQKcgWzq/Kq1VIne95LqCXtHhDpavhum7Ilypn2qJsaG
         jIXw543/bzm1XC0NF2rdH40ZU2wrUp6HwmQRGERR+xdq8BlZ1BodceUvEEHYyrqMatgX
         jN9dnsorP//nz7y+p6tnm3b9bO7xK16/kTcMGFRh5unl0XBXKKMkcvBrNX4uJXZfsSYy
         d/UoTv075dSeiop7ySQwGttORBdfWtRrQviHN23gb9eoRloUiW5wxmaKqXvAzqdcq592
         17og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664287; x=1794269087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YeGo5xYJrpnxNAew8vJ5guu9FtuzQOdSkjYnhG+rvTc=;
        b=jCTKmNThJ4AHP6IjYXKALph/ewkIOxPt9yBHz//etPmDociKXJiIdXglmkGP+5eSzR
         d3N8mAB8gRBWnkETX3R2rzWTFco98/1AJcbfJarubpMA2OXSJ/l+8G8On7K7zoHvGtBl
         5d/lKVBOp76d5X5qfpIVnANLciPf14wCMQtSbFjMqAcTLqTKLVcJQLOZPTFOABJwfMow
         lHk3vpKurhP9h+hRd41+KtOnb5yp7vyLYViA1KEpKZPAYoowRl0n82rZGyE/H/pvIuUB
         pzxCGS3R18bHTE3qG7c9QQq8NbSWkEXz2jUZz1NKgHREWe43FRM0d1aJpPYSxRJiprew
         +7bw==
X-Forwarded-Encrypted: i=1; AKwUvBzNM7/p7JDZwgOxujFBpkzfljyXmEk6McqkIfIXIeKtqcRIdSIZy3ANxFFq2kkFdOxIvAjM0Le/cIqJ2WD6Ww==@lists.linux.dev
X-Gm-Message-State: APuU4Z9CKqEcSHF/owxAAan3NmI4eFOL9iSa254ZcYDVspC6W9Epq8S/
	0mpFtk3kZxvX9RP/ScEvKWB6pJEK2vfhqZ2XRrA9dUxGuWyXAcn9DVx4
X-Gm-Gg: AYBFou1dxnTWsnel6cgMyMS6ZD+XAF1xLgyuM+Q9fGeoxV2SMKWinDkzWVNwA892z28
	IIc0ii0vwR6tcV70Bipx830fsYzoJ8HIfqNgNEalQP6pawkJ2AqiqzDe9dO3kfFMRI8SaHk3NGn
	YX/U/XAtjUNSBMhqSdqI+dFldCB07thcxn7JdkGlkw1wzzxnC7FqQadm9FYp9GjhJUjy7pBHV9A
	4cIQAnqkP9B4zcuII+0AMfo9EMI5EAhnqc/ZXwiQdrWOgcmgsI9GqNvS4moZk/FoUMfIGEYM2h5
	cBpkGpNUVlYxzIRtevJ+thLiSvvxVfClJB4r+yC2zp3R1UhEK9i1IcOIyUFjCAALFH5Q0yZXWRs
	iSFBiDRWFxOIyBinrNynsrAraKxcZxNtAvTH0ED8q6eHdWUwP/cgdR5AP4uvtyHFGWP9i+yCIF/
	kec/pANxaDC1j7Ox+SyKEMoTpupbBMJs4P6DuvYmIMXOmvUUi06m9dvdIjIMjBg9ihFjgY/cAPt
	xOjAyNwOD2fhsb6s6bTHflEy/D/0HGet+hBFil228ZsiNIFM7KKm3SdmEoZwdlhbwgCCBiQJ+Ej
	BpcWjewzBie+X8W3WO2x6hlBSJiVH2NhfniF6T1kZqRBy6h+Zi7z23YqM59HKE70rddA3o0htrS
	Oy7o0SWcA2+83jvv0ZOOx3t8QKqKJIQMyKK6pozhNIX7bF5SyA+1RHsczpTtGFN8lgdbg
X-Received: by 2002:a17:90b:4a4d:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3ae89542f3dmr6388084a91.3.1793664286684;
        Mon, 02 Nov 2026 16:04:46 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:46 -0800 (PST)
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
Subject: [PATCH v12 11/12] ALSA: virtio: prioritize staged capture period work
Date: Tue,  3 Nov 2026 09:04:02 +0900
Message-ID: <20261103000403.67106-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -167,6 +167,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
