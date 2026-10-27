Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144674;
	b=iMAkNTnH/jyLOxY9uPIikvS27hbMYPYSbbcWek+TKgX/PTfZxl6BRisrXl4eDHLyaFTw
	 74aY7LGCYhqDtl5hrJUZ3MF/fn8hfTKQn8oH4j1E16ef2w9NAOmgAnpRCNFuD7aMNKr6G
	 +UP8ZALv1cQvEQY0Rlm9nwojl5+nfQDsrRNUGQLLY245AxkbjGgsdG63a+pdjL3IwA6C1
	 5z5EnJ0Ehjyq+9hsbCk8j+iDo1QmvXxOugA54FGi+MurV0jOfTySkrJQE8wWhEO9E5dw2
	 eZlUDkBeg1Ha7mnzw8vSzgG8fTwrjZIF36SnisebP9tjAj1KsY98u8GzTzxxzJ+l1jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=DW9iUp9A1PZVwNOIjhacK20I7hbXNK32hr791Md7PdFAjg/158AtBfouHQ0ZZn8WWC+O
	 3M0jro7Iu8K7K/3ltPbVMA3KpYFPKDZP5Oo5owY55lbHZeetHJPBSywAhOE85ZBK+f+hH
	 rI1rzNqKq3n2YMhQlBTn/JLES8r3kM8U0DeMw4ArUuRYkLJy4aJDn2kKCrH+QMz68v9UT
	 E/SMgqhOoZsfXX+cCa+9lWqfid3d/TcaZyFSVXDuxOfBfKYUGyqamvoG/Ju3f7+5uWtNV
	 0XiLwARCwssWHPe0S/bU9cqV8JHR7e9NrHDHIqGW2tpmVLhoWf1arPxhfECSsHDbsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb5AoqYu;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE4606A31F
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CBE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb5AoqYu
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so295261a12.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144673; x=1793749473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=Wb5AoqYu4vlgYcDkTYDqO8pSPtgrVpkaL1VOSfwZ4hlKVlSSkinDKF+wUu+Ja92oAH
         5Mim1noklK7g8fWEIMr599ne9awHI9Parm1HgBkBssMeLLD4akJToUDMLFXGEuS+c1eT
         XvhMkFqrdR3FuAHv0M1oh97P66INZ+j1SzEJSRF9WmnPWq8Si2J8IF1sapy59w0dyH/J
         OvjK2XItCy3+1+n1gS7rissDO2enh07aQerEGIy1yo5gCB6kzZ099n2sRrOMuvz3XcmH
         b02z01MNpCK59f7NQGujtOWspACpUyuhl+h09t2MkpI5T/5aLgLGaZUqZqoxBTwrtPcg
         ecKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144673; x=1793749473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=hAssLi99PnNr6NlH7VGUrJ8k/gapTn7mUspIQEphPnqyqMqX/Qlm01aq2MaB1d7kaQ
         mQhiJrm2zQ5eEYf05N4J3gjxwbpqLX2U/FHeHxh5unsg9nO3uKxRrzlAiQgZOAAku39o
         sYcUkanbi38kdAUC5zNy+Zzn2QRRxZ4tiTF50E0VLjeMPScvIaRAt2y9u4uNB77eXy83
         e5NTmGun/ep8kPNM/jPui8HoqRTgtMLLkjV5pqufg8BY0kXLy2LQbkiH4/3DJzs3zIo/
         PyHVXiL3unkVwt/pivIi5Etym4U8hmQbbl8DgMBvTp2iLAdirdbtKOFEUhxzttQvkOqP
         bI8Q==
X-Forwarded-Encrypted: i=1; AKwUvByHZNYAmTs6jpkkNViGj1baIDvmvow5yshPSb+lV61I3TIcII5XFdWXdK3B6V3aWbou2esF8iDK+LpY9fQZMA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKljvxZcsl+Di5+zQLYj0feaxsfA+5eorv3KinBrAoUPSMxfE4e
	/Wl+ghMtOgd5GVAQcRpGyIRC1Bz3h7DahKx7z9sszRy6zpj/24bwl7aO
X-Gm-Gg: AYBFou3py6lCPUhgOTUKQ22FK4o5H0jTZS22qp2My21iVkRlFUINvRRQCp+fGgohUom
	pTOsQ/p5FlkSf5+0X8VpUGSYeIMi07f4aMieha1EyA3NUp4Gdf6lSE1LtOKlB4tVQjxvqPq3Kfo
	RRIxE9igxp7q/B8NuVxX9VFtQixKbzTuzrSQRIKLFpfGBxG186oyZYGxZ/GPIZG64MZTcyIOUWN
	gtOOM/j8I/Iz/ftyFRhunNfvaJEhbAanI64HMyq8md5Kbw0bd0ZRIrmrbdkX9YwYv3Jeub6NGf2
	Vdn0/illBaIOVIzp1QwIlemuxmVhdYx8G0KUBEuOUGPagUheDtDBidMCrRh8YBVqnl5S3zotW4t
	IIvZYYJaq6dFIwFGTkp55uMGkLgZvJPxPqRPrKQjGTGIO/Ghq3oLqMCxmiYewTIoPowXUOuQ0sI
	ub0trolY8nfEchrZyAdkCgmURetLow+qDEartfH7bCs8zS7H61fX3Gd1lDFK95W99y2nNG9rYTR
	Siwvcz+pXRN1z4ywzMAwQsylZ0iQvg/p/IzVvMscUdcPr9OLXcA2/7JMSGGU4ZkYgj23JATntQh
	/icYEgQcDL31VjRy0xRYEMtvRBsoM78UAN/tbpaYXcRcwxFAIv015wB1c1VzRZKHbnlGBTz7XQ=
	=
X-Received: by 2002:a05:6a21:8217:b0:3e2:1656:b7c9 with SMTP id adf61e73a8af0-3e9023f48c4mr784167637.66.1793144672902;
        Tue, 27 Oct 2026 16:44:32 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.44.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:44:31 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 10/11] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed, 28 Oct 2026 08:43:33 +0900
Message-ID: <20261027234334.32551-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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
