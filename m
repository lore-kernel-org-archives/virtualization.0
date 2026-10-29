Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263872;
	b=NSNj0HVtErQZbt6XBRxz1LEiR/fB0lNuU1dq/1nmlftlbOCkAQw0LpsB6tmSpkJ5fFB4
	 ZRij0Qs0zID5tdWTV2WsU7doN3NsG6YZBfOE82XxCeXUXD9J6x5RD6ZbFzSi4Dgo2L5pO
	 dFyL6YlZCeRp5SAFFc9olduRyPyb+7S45wi2DyZv4KC995MrbPeLN8Q+83TWz+HRgtfEE
	 UeZMutGx22BGcI0+s/z+++zRyyT2/0MviaigHgeTF+WCZ9acTA5iPTVL8tir2NUhFJunz
	 rkOwSNul5RhKZBLvnWIzguGJh5bA+iezPP4NE1sayOxvhQ7AmMQDDGwSBNAoRK65H/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
	b=WJ+4v8ScwORTiaeENw3c+jP4OASBRcQMC/5P06943lj3t0yCw+pLGo89FWOYiA6MO5FN
	 +G3gvyAgSXX7prlASSqEXFqZ59puqGjgeTlfqPp7WbwDzkAMQK2M51R6mfWMyJXq6iPzk
	 WehJE3FxyB1RBF2IYjwbzU+4yF4LM8xWrv6Mz/uOw1u7BlhXud4LCCA9GRwT4vbdXUUMw
	 HtulDS+YCr53dAHRhVgieMxtYbinHx6Zb2DnDZP8PlzlU8yq7S7OvKXdLKnNd67UtU//D
	 CcZ7E/t7klObFj419oB1U7C6HmBALkm/cgM0WhjtUXQCyZwmtucTbYQVLVtqg4i9YAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoYF4w3b;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D5606A32A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 021D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoYF4w3b
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9ae391a05so3608775ad.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263871; x=1793868671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=VoYF4w3bEC5Crj5MJLeWhuxwDfRICpxCu2TEP65zbTC9XCxpZKUxT044fTeNSA3sMn
         TRKCRwcVVbREiD673vjTgTcRUJ1KRDr4MC3ABvfm/AZyKOlyqUqZKub8Vyph3LJ0q9C0
         iB2iZz5byglZs5bFYxms7lvohLrNBqFr5DxoSPBvNlmdgquuLsIvQW0o1NwJbRccef1G
         zKkxRs5H8fU3QAxZdgcq0fFT33cQrVCRD9njVCUpnNWZhCYipNT+BCs1AByJ93pWfsvy
         d46Fesduy+mtmjxzjK/QCSS2CKc11xyrTeOSShVsnhKr2W0WhA7pmnu3Hbqm3L93ywtl
         0qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263871; x=1793868671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=F1hWeJi+Y9uIGBgysksEUQ39BwVWbGWRD24IkW9LusrP+tl50DjrOmQ3og8o4OdacY
         XUqHGHUJqk8FXsJK412G7A6hrOekHGzDRHT0L1WaNupmuoLpRXlG0A/FfXnEF3LoBZqw
         6nhTQ9x3SAod7YJ9+T2Vl7q/fAN4rwtezH8dLgeBKqonCPmik4rK7Z9wwNVAl4wxyw3I
         63QuXDgC7BFJeIcJiZOj34o46Y6zi2TgF220cRhHpdu8fx68jeiTgTezqd6QH8KwOH8L
         RRxMIv28M8cd3CZX+1QeIChwKGNZeSjI93xbT3sSRsl1+HwUV4R8GOQjymOqTwsjz1R/
         iuWw==
X-Forwarded-Encrypted: i=1; AKwUvBxClhxdN5tgOgGjicyvxgxhM2hq0TBHuFTJgMokNujUZYKSuRaySeg+JgPxbyAZQZSdcWYq78VzZ+peYHC/ow==@lists.linux.dev
X-Gm-Message-State: AFq9FYLW6OeNg0Eu3mOR/Z+BDk5oH7GcsIX38Cz+ALJtNZZ1Uzv6pY7s
	Q5N3HTYzgJ0FVd3SJKpxk9IbTEkQN7wCIA87jPgSemi3QGQHxCEL0V7t
X-Gm-Gg: AYBFou0LsKMKC5eMhIrTy4kI4Q3je6PCOK6yxKSEHiTFvhVS9LI7+CoOW6UZXhNWo5r
	8+IICmDDcs2eoofnK/2vNjYS7hdl/roqiNSubKubgrky0b/ZIJT9TPYuKDoksjHfw9Xx4Hn5Dlm
	K/uPxQuoL0vMp1z8TJwkU91QgUpYcc8FDDA9W9w4kWEVXcbpH8wmx9cmRrKqDTZrou1T4au4H5l
	Mgauz9gvSwMUY4iN4X3RFaAIq3EMNxmst4PMlssbAJwKhsgeZyB465YHmaSlhjGW57lo4RZHPfG
	cg+GhpwqjNOUOiTVwvIz/UeC0Qg3oe/pFd8RzZ4jmfeLR1e4gUJEyh572+DHiW6JV3Y5QaOqtUe
	/BKYBIEDu0+5kMRv0+5Ib3hFFEJ6qA90RMWm6LM5Ytli+GUJcIGNLBhGfI1iM8shOkgOEHma2k5
	FNbnrNLAG9XI4rnIBpJYqs5tzHhdhMTZH9PZgQ1jFT4nw3TOrebK6yhdUupnl4suTXg5r3zOdTM
	I+aPOwgZuZSdoDfD68qrtLJv6/GZNWP5DRRS0qZl94HNMkiKUZRjnNRcACi/0VlVhfz+Q9ctV5s
	xtiBSJ+LIeJyfY+K5X1rgSdZ9cXz87h+MBZtLceyT7vYn76CpQPSKSFdPG1rhsudNahQMTSv9hi
	8omvUT65/9y2rgqtalZYCq17VrC7g9Imi7vDPfD002g==
X-Received: by 2002:a17:903:19e7:b0:2e9:64b9:a338 with SMTP id d9443c01a7336-2eb1aab220cmr12773445ad.7.1793263871292;
        Thu, 29 Oct 2026 01:51:11 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:10 -0700 (PDT)
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
Subject: [PATCH v9 07/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 29 Oct 2026 17:50:25 +0900
Message-ID: <20261029085032.70689-8-mynameisjune111@gmail.com>
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
