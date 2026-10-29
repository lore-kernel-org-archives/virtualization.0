Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263886;
	b=3zXoBs948yuntJ+CDwXir6GsLbFBlmvT98VbdyeOTYwpcVZ0+8qsVfmH3jeG1KyNo64D
	 AJ8CHoJBY5teawXh+Zaavbo/YK8+4tfQDEPdwQCOWlbXPEw7q8VXcu90iVlL73aRqRWnh
	 4CfRzjsqB7gkn/buHbpf7HtAalhnzgWJHD/pRaBeUgzTCm9w7Dc4hJKcoNLiQWDgcwVOC
	 RMlqZHwGnufSk6tb+Ww0jSpz4md9tvOouEw55jsBCSy9WHKVHQoBEF80cNySPPmsAFzvQ
	 n4Y6QpHB0ffkNMmdYt6o5Mb6LrgyKgyUpvsj6uU3a1jMs8wM0Z+ZPT0e8nY45WJAaFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
	b=0C+MuRx9ZF0MyesocJ3VGtEfdw+GG6F2LFS9MBgn8SpbSOyX9/I7YSZmsNWU8HpekGvO
	 YFvo6w3ljskhApBmx+0Te/zOoK/bICzgH1g+sxiz0d/avrVIGvACee3oSGgTCprN/54QX
	 3ols5n+1hnnf0keH80jW/GcB8YgyNHUfFJb42AZAdQRVwc6blklf2QrvEBwVZRahRwtME
	 18QRYejHBNW/xnGhCMpsd67r5heC9fSVeTK050FCmxtAwxS7MaxBFFnsHVQ5gIEMfGAVt
	 LQTcmAG1/NU3vwXCCwqO7yjgIYqsTyPZFlwrXHbmwXmvgMYHAvyd7Q4wLzz9ab6tUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdE88Wj9;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ACA60A2605
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35ACA60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdE88Wj9
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so12095415ad.0
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263885; x=1793868685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
        b=AdE88Wj96Au5TmxWGgHUNtVs9jMeVLp/5WfQaf9mF97f26jBSxcMI+aUZSR/ICJBTC
         yba1jEu0R5LxfDJeu6SCRbyNmjW3M9iEjH0KQOv6gHLyCoLBJamLEVLZEzcZir7QlpqV
         lnkTC0ewdI54h3w6SCKIGq+HIMeD30mknD3dG+CZsGVmWVGUz2yc3REh+Ck0CPKx7h6n
         DwLbji7IyqjcczM4BE2SDAn4WfQzSqg7t6c1fBK6FTwq5cy8zOMSoLF8SC5yvLw9gN6w
         vP0qDoso+jf1Co49qFjhtuEIMT3ECEmHOn13Xnu1oOPXqRKMvnkRP98IbrA8FsURjhz/
         6R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263885; x=1793868685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
        b=RppMc4O9sfQXvZ352WWm7Wc7iIdaoO82PmyqtymyfA93FIqxgpZMp6e8pXTgFybe1x
         QZjwNXvp7KHdWJQ67tRr7tju2Cyqo8BFL+cxCqHVFRUkzE6M5/leeDJR5zw/o0SAiMw2
         mF74LnpmZGXBykqhfv5vbvhYxB06IteMUYMQU7RVrQcvgVCJVtwD1d13o8DkT9sjHUtT
         nyfNjm2YGK9HbojLADT3jllvMCRAZPHHbfGHmNl0UTdFmvgPTxezT896/3WSkwn3IoZw
         kVBzte4evzMjs2Y8DblUVSzV9x4z5PjTMZ8VOeZjFJ+VDyiX2OpclfGmgEjMG+ANloJW
         4Xpw==
X-Forwarded-Encrypted: i=1; AKwUvBw0x/V7Xhy/fmghHR3EDlNjlnQLyek8ZtilvprQMre+GAUulY4y4MVbQbuGJybYsu6QiAJXvC069Frq8D6AHw==@lists.linux.dev
X-Gm-Message-State: AFq9FYICC68zYvFxH7el4wx2wwY+vaU5EFs/WvxisOGNbBwTecnlJ9qR
	cdzIrKAzYC8/FdvkoimxepqXRYhIoyM9wuFVUT+yl02rql/wOG1Fwz3P
X-Gm-Gg: AYBFou0+gOv6ZzFn4rhPvhIJFNZbX2gu1Ay/uPAfOZ/5Onrwb5c73zYP9Vs1mTW2W8r
	Vk+fQ/lOpZjyS3WYrCJ5E7OLOn0ljs2KH7zKS0+IwESiiYUQoc4e6YQrJ1KZavJdQ7qdvkasJ9t
	HbfQL4ZYcO0N6mosyxnq7UOJglQhVARLuLmid0n0XOoEGHpkuJejGoMCW6jE8rkSQtkGIBlaWog
	rLRXBw5nYGUCKjgK6Rtkiz4UJd8mzIopHGyk1Uu/nAFFRAUIzdSf2iSyS4/Pq2MK3BNllVtsHjh
	ppD+3omlR9aqZ0UVrz/CRZtX3U0YwmX1OFaga8A+MGfeGV8pWEDkr7RCx+AUi9fFF8TlPe1bE6E
	X01ngv4TQLuYoxc68H+g6sRayOAfOQGJvkJ+mWChBbbXS4S3Bp6m7u5ZtWZwv5itegwMFHs4Bn2
	gdwORNNc2a4MFeqUM90zTmgO6dk9aw80WSODsgOQzkeTp5SPonDch3iRRbo4nkryzE9ncq6hatM
	a2DgbTyH8HDw3dNV2VCVLTxEND5FpJZwL9Tdrg3QhUTNj9p7omhM4Bwf8sYBHTetTXc+0VXgaCG
	Of7VFDANhLGqqCUvdiCieqNKas4R6DNdyNGx4oQpphppemDnDvqwAYDzgS/VuKK69CcGjKQgDfy
	/A+kRjR+XQ+PPjclaCNGIGReCbI3uzHODmyP30A4EPA==
X-Received: by 2002:a17:903:1a0b:b0:2ea:fb8b:258d with SMTP id d9443c01a7336-2eb0012b52bmr46327015ad.6.1793263885507;
        Thu, 29 Oct 2026 01:51:25 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:25 -0700 (PDT)
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
Subject: [PATCH v9 10/14] ALSA: virtio: prioritize staged capture period work
Date: Thu, 29 Oct 2026 17:50:28 +0900
Message-ID: <20261029085032.70689-11-mynameisjune111@gmail.com>
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
@@ -159,6 +159,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
