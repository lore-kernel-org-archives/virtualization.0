Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664279;
	b=sBwFbOCj17AKPQQ+Jg8IDhZPcuCl2ehlf+fKZ4Jdb6cRAaPsX5Zd3GNjiEnKE/Ju56Hu
	 VQIC7mCCpMKGPHoqFlxW/ATjserrNEI8uBs9e06mSDe79PgYtXJtoG8I/HYzix0y/ddBX
	 vDoU4MVGukxszZHDBhKVTLnjlCb4+s9OtxZI6bED1Zu/6YfQ/6YKADBdQ5wAL6M7XufgU
	 TtykdZZaXHIY+CC2uq+3mQ+7cYi+STiddjLoxm3iI+RhqW9QhNPQOhjJrShhjLtZiSAmx
	 KN3NRVAWsZx26RXLUTqaxF/HoUX7SkaxTXdmS2cKo1BemDSGQkFQW8Iv3OoIwDC1tHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
	b=D0KTbwzYIB85+qrk/QyQIp+/goDa4Zn3lHXvHPI11fOzwgXdlvEu0ffJyntaQGkaNlD6
	 oJQUsn3HwaJ41Zvir9+9LSPdyqxFbzy13JxQiCGLdXXD9N04wS812lSK70mmtKqEifRea
	 xRgFQeEaQ+cdN3cR4UYbBmO+5gXjFRBuodxSMPmBlwF7YQ8CGs3vhULAqXRcVSJJ82PO3
	 0nZTMv0zVg9wO0S/X8WtQOQRR7KqwY6uWGZyAxG9hoN+My+21AMr4nQIFCHWb4gUEvTxt
	 UxUkuu0u1QmOgRhpc+2ptwCi3k0OSTuUZxCf82DWT7bL0X/nHxyGQ9a2/D6ynOoLm7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fTHGFSv;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337B606A33D
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4337B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fTHGFSv
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3959252a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664273; x=1794269073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=0fTHGFSv6wFDaptZGd/ExVocmsKo9A3dgF8j5L2WCJgx6vovz19nKOkxvpf2t2TfYl
         Qo2H4R3rv0j4HEV3vjVmNXaN7gEG1iLNzzHn3AAOKGb2KgrC7bmHIoq5kD/qfAM/J/qD
         1qpOGWMWPDjheo3F5rdfYz/c4SQspIpsgrxTG4bkSVTiSU5zvBy9rTDutzM2QrnbseFp
         WggbT6hBsOu9uysAqiKwF9EHU78tj2AjZ6nvWwyleBBVmA/IGK4Mjl6ENMESxY4uGiv/
         DBERB4CAjOdnxXHgjhuB2VsiQ7d0Q/iCjXJ2iDafRPf/Fd683hPGpIoPT3/RFmnSptol
         +yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664273; x=1794269073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=0ml+ZZUh3DLsvWDoNctk+e+lMtGukpGoW+PUHI2fRMutOsY/Unu4ykF78cQ6JGhGBo
         5B6uyOJcdUQIITP+EcG3DLjpaXkk6LGaHfpAggHQQZHfoztMPCvLy21/flcwTYlz9nDj
         Mpus+q6TzUdj5B83gB6NJn3atrXCm7NcGn4OkHJlk7p2gr2RBzUxsx+ZIsZMAj266b1G
         DKAPrX83wHarRFLJtGypSDvttmikT4YNEK9xZjDYi7+2tZCIAccTnsDgbpbtOnVPd+CN
         Mi/vYy8aw7BPhcrUWc2BN4gHOJhqKqmSt+JvJL1ufPjOyaYHN4OAKiTP41tN8WQckRe8
         Pi6w==
X-Forwarded-Encrypted: i=1; AKwUvBz4J0mbIBUFdbSnPyOHc8yiSQk9r8r1/3SgQYw1uH925SyGEghvsw4nrcJ4Q1F7VuCLpJB1VojazRLiG84ajw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8EGeV+LfoyljnuIIhb7htagbiWAQV4KNoTkAV4Zw4+9M9hEkJn
	PeQoRNFQGOoorfOtL6vXrRKx0isw8BtlTYU50AIAtw1Xn0k0ZwfhGuta
X-Gm-Gg: AYBFou10W+zenosl8W2mqq9jdmn1rz+7uTtYL1RGn7iJ/FkXpW9n5IT/J0k2n9HmcT3
	YS2ZJ5J6rixyxCmXvu2tQE+ElZHU5iAB0tc7Rm1oiQkqagqs5uKY32dXEZkYbVXok2AlDld9YQq
	sKaNHT0gJ9GxRx8wDWRaKIFXi93D3zdQnVY2SfiGtRV5Xfx3ID/PQMs/1gHoV1G4O3rJxjrdZju
	DvzrQAtmmbIc4k4Wdv5CskDFixZonD+FX0t5V/QGD1xDkqc0OYxEnWzM7paibTppqDo5IC4NEvx
	3jidFhD80jw1N3BXYhU/dYNHXnnPE1Aiz1jzXsrMA1u0/Ju6ntU2CX6jTWtJeznYTXu1m+cKU/R
	IGabwJrZBIcNsQpptSmoKCOqS5uyTNLM8kuCnF1Byp8aD8Y6u1YwjgKh2LrlJBZb4AtLYYLi0Wi
	1fJkt/1KmBi8fIcJs6KLl//N1Mjlu8mCPCrkjZiIpLLPYKAAJ+qFkjbH9f1B9wiry8ry1V+OlUS
	gPPBq91bVul5WlBzPiS3HceMc6gzHkqHV9noTtHE/toqRL18PlIuox6hyeZMhnfixvaHqN8xcOO
	c7mYdgf7o7RyzJo33ezwqU06U+BoEdFQ0FPUh33OqxkjzsSdbIdGQF7/l+ESak61HMMe+pjMKD4
	ZdT3psV7QyfPXhivxzn+Ss/fm6nWY8hVAQMSYc5NTMH45vtsr5LIfoe3vVs6YZmGVpKsd
X-Received: by 2002:a17:90b:1f92:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae897c8014mr9974284a91.16.1793664272643;
        Mon, 02 Nov 2026 16:04:32 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:32 -0800 (PST)
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
Subject: [PATCH v12 07/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Tue,  3 Nov 2026 09:03:58 +0900
Message-ID: <20261103000403.67106-8-mynameisjune111@gmail.com>
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

The staged virtio-snd capture path needs to sample stop_threshold from
completion context to distinguish free-running capture from bounded
capture. Software parameters can update this field while capture runs.

Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
status read with READ_ONCE. This pairs the assignments with the driver's
READ_ONCE policy sampling in patch 9.

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
