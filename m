Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156036;
	b=y8HRzUq9n4Eqw5vUsbKYxlZ1fWLmP/YyD2DpgmHgFVzxedWFoMjOJ7BL9aaEEe1TsNLL
	 8lbDn8MWzlxLBF3rGTx4qswQKKsz6OElH9rlKDag/8oM8OrZNFNvpfNihqY0ibBkjWQsj
	 mQY0Fg8N+6MCL3UZeqpcUSNghrU0eoc9hpIxhiUbjqB2YVS8oXk0NAO7q46c+fAQbH0hF
	 i4sPbGiXIIo/9DwH+jeDyGwq8NThiLyB/uLz40mYqAPrD/Wc2p83ms/SFir4MlJLU2IOX
	 DL2zfsndOXMKQloyur/AVZvrco0XrVLdvSoTbNTCS0XhBK+ZFzd0ooYAZl/1VePxxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=2geeSnJ9oYXEhSiO0fYvxJgMMZKX0lnWHdN9dJTlBuBf8VLGIv7xUMwmRnOI/EpeTmmS
	 YE0S98xkUpLdUrjQBMdxJWUFfCf9mstCFCdiitvXVeALdeO3XDYV9tphj5r9xzdCMGC5X
	 VEwZowww6X5AsdjJV1Cfn2nlpe7AUUKODPXa53KSHWDsZyiwm5nQ/qAEthv8gxij8hyTs
	 /yOBKQXjuqn0zi/c3v89a3CTL6YajQf94U9l1SGKGrTQbOPz+4cqxaz1oULNoPvghOhh4
	 yjfwrUtn574dPGawLUY3f7GNpNi70UIzKPLEQzEYreqXsx6DhdvzhAaLWHN27q/BM3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Se7yTztj;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A060A3809
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086A060A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Se7yTztj
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35c76e9614aso781176eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156035; x=1793760835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=Se7yTztjgPXJ3ILHDO1gQMG7bLuzcuh0Jys/hZtS+URbLSmTl4ZonnuflmXl2hjbfq
         TnUz12QJta2+nwCuxIxrluzPpkn66IqPBHcyZaByLFOFjfduh7GuHbQyBl9CpBFx88xH
         dtZIGfAYlSLHOmmYBREKyTSH5NKhUz/PGCBu9rHQ/Mk/1lbroh2MRdi7+orIELQdtrQi
         bFzlscsgCxJawdpDHQiM8bm9qwT0GuoFgT37UW9gky/Y7u0V5g/mxAYFqJKmo7FXV8Fx
         oJjKOaIKI9dZrZAIRImuhUK9S/5pz8rbRuv5YrCQwTVB+pdXjg1P9qymTK8juGCV9kBY
         ubag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156035; x=1793760835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=phPPffIiiMih5WCWxowbYmX45eueRPB3Bg5EeOR80xwDoaeZ//wQYcROH2bLf0Be8R
         DUzXKwAY94VdeWUqtNT0fsoGJOf8+hNiwhXPUiS5LESzVd9pPGHAYAjkpUNXs+fSh1Yj
         qYAV2mXYCCtJ6KY/EIPhpYCccLPkK0veds1qlid1q9VcuvJ5QbdQIkwvXGh3BS+J7AVx
         1ONn2nWs1ur3OMNp8zEntxnbCxvuoMEdTvWYolf0VKrS/MLIE6xvubifgwsJnkQlO7CD
         J7cpauaJd9jVRbC58fC5KCPC4muTR4BmEmlA/0kF9eEd/QK/sAcsKrZncSh8lx983h2/
         VKRg==
X-Forwarded-Encrypted: i=1; AKwUvBxJcclD+yCyD2d0Ug/lwc2V1QdDTYH4lzujK+eBPyLFqIUuQIE2qwTTNtSfwYHFtrkJaPb0jLEFh3Eck1534w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtbxz6uk5It3VAsXS3tD7Iz9nWnwlB7TeHusfwubFwaYgpvfUQ
	J8hHlttGySMrOKmrw4f4KkUh/jiz/QNUYSVx8DdJ+fE/IrjU8RGNvGlX
X-Gm-Gg: AYBFou0XvLlOjEH5wHtjxhuHZ4QkotedE40Y5qvaJYzgLWeEZ4swohtyWz9fbDRrJYk
	z4/GqrCUwnIbjM3FBmCltO2drGvGMhy/buieCH7Vc2RWZOm2kV6aVjg2hmhAfMhPd3yB7QJZ1hT
	ICPGhF7/tjeYEIh2U4OHga06agwrXKGg0nkLumQ6lBe8MX3P5Vn93pPahki+0H+8HVS9YQS00Cp
	fXOiBIPBpL1m2p+qvgIAp5HIcIwgqveO7w7KVRiAeMpt32D/teOuyBHsa3Mm8B4HcIPZgGhwHjq
	uBu73/6quO9KLmpspi2DDIRle0WFgtdjhutkGwH6XEM3T0IWxlwrDTtkAlgTtf+KUENTJ00nD0a
	VDnef1x1Sr8iRJlbb932eL2UaQQsa0vesktqkYKeqdFbYE/69JVc41Bg1nRzTnuilSI7hf0D9pU
	JSHj93QmH0xrZthbfXNTRtRyg4MkREbJ8MxtLLBwab9+fkCLj++VhtjbYWW5On6kWM9qrtctaYA
	lCRO7ZFXSumoXSrgkuzrmonUFTYW+SRit2sWSbTzWPSiTk2go4SG79/AjWYcgZ4spxIbn62WTjT
	PXjdLLcVjqZIsIL5oOmkX8eqeFx5iNURIS/L9o/z6WvHbfLFsWULVdBFyyJQ76lffNpz1uPAVoD
	dsuQu6g8my1so2xmUh5n2hdP7jJJXrpdxdGnXAjrkKct6ScQE/RUPhKl2NXZLEdKHT7zE
X-Received: by 2002:a05:7300:a8f:b0:368:c6b9:d3bb with SMTP id 5a478bee46e88-36a203f18f1mr1809613eec.14.1793156034971;
        Tue, 27 Oct 2026 19:53:54 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:54 -0700 (PDT)
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
Subject: [PATCH v6 10/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed, 28 Oct 2026 11:53:13 +0900
Message-ID: <20261028025317.92450-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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

The staged virtio-snd capture path needs to sample stop_threshold from
completion context to distinguish free-running capture from bounded
capture. Software parameters can update this field while capture runs.

Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
status read with READ_ONCE. This pairs the assignments with the driver's
READ_ONCE policy sampling in the following patch.

These annotations do not provide a transaction for the entire sw_params
update. The driver serializes its cached policy and accounting with its
own substream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2958,7 +2958,7 @@
 	       runtime->oss.mmap_bytes);
 #endif
 	/* In mmap mode we never stop */
-	runtime->stop_threshold = runtime->boundary;
+	WRITE_ONCE(runtime->stop_threshold, runtime->boundary);
 
 	return 0;
 }
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -422,7 +422,8 @@
 	snd_iprintf(buffer, "period_step: %u\n", runtime->period_step);
 	snd_iprintf(buffer, "avail_min: %lu\n", runtime->control->avail_min);
 	snd_iprintf(buffer, "start_threshold: %lu\n", runtime->start_threshold);
-	snd_iprintf(buffer, "stop_threshold: %lu\n", runtime->stop_threshold);
+	snd_iprintf(buffer, "stop_threshold: %lu\n",
+		    READ_ONCE(runtime->stop_threshold));
 	snd_iprintf(buffer, "silence_threshold: %lu\n", runtime->silence_threshold);
 	snd_iprintf(buffer, "silence_size: %lu\n", runtime->silence_size);
 	snd_iprintf(buffer, "boundary: %lu\n", runtime->boundary);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -871,7 +871,7 @@
 	runtime->period_step = 1;
 	runtime->control->avail_min = runtime->period_size;
 	runtime->start_threshold = 1;
-	runtime->stop_threshold = runtime->buffer_size;
+	WRITE_ONCE(runtime->stop_threshold, runtime->buffer_size);
 	runtime->silence_threshold = 0;
 	runtime->silence_size = 0;
 	runtime->boundary = runtime->buffer_size;
@@ -1062,7 +1062,8 @@
 		runtime->period_step = params->period_step;
 		runtime->control->avail_min = params->avail_min;
 		runtime->start_threshold = params->start_threshold;
-		runtime->stop_threshold = params->stop_threshold;
+		/* Drivers may sample the stop policy from completion context. */
+		WRITE_ONCE(runtime->stop_threshold, params->stop_threshold);
 		runtime->silence_threshold = params->silence_threshold;
 		runtime->silence_size = params->silence_size;
 		params->boundary = runtime->boundary;
