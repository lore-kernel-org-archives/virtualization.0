Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664291;
	b=QaPYK2Rv4wPojvX5foKl+dIyTASRONO2ZCZfO8T958aH9IB+11Z1VQv8e0HrcY0b+s5N
	 5eGXJumHduP3R8pIrT4zSeMOTkBEhFI2faXKMEfWY7XLqk8x1L8a7/DiOILjHAS6J/i8u
	 5B+R+v+V/7N+4O/0iKGCk+u5i6MatKaLnTpfJRg8DDFM55MYMSYbZ4zsJETYYeOMkm52T
	 qlUn4W0tQLpZODqKI2psphLGjHrz0qgX/tixH49OXdImhR4FUjHI4TC3y4KoMC5T2LM5b
	 OJ2iMIAbIpG1T9+qvbgKl3uAtmLjrwnfMxfjm7JStoZmbH4Bceutx0enCoC/vK2U7yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
	b=D/DPL7X6xH56l09siaNwuYn6L+ycRydlbqKCwFJiQ6IW2/JsJVEeySCgaC9ah3BJ3Z3S
	 nBaIYrlXZPdRs58TwJTVhBjpoayJbrxkgW4vb84B6wMuOPsmUDjbVRze7hIAaPpr8Xzh7
	 PBxnRfRGdtKI/enpMcI5iwNP0OvNzMupuU9Nb0yBIH6crnBGSAslFn/EknCYd/dlMdYPH
	 qI0b2vi6MvHNaDm85GEWY//yul3d1UgtkOq11p5y5nSaZIykPJcWC7U5FKjxrCvCw7KTe
	 zPWByDMxgXAql43UMHJqJI9NXxv+vY73u5npCS51rwLEeTzi1VOzWSiiP4DWZfYXuJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMlJKyPk;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E032606D81D
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E032606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMlJKyPk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1504308a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664290; x=1794269090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=KMlJKyPkFjDhm+QsNrXVrBKIZc5E3/H0NVQByf+dXcRMZQ9BS37IJY/ry+UlJy5eHr
         zW3BFUkatotEo+j9MR86B6GDVKeQV6YPdBe0rK28ztIb5jXtELgOqyKSojzxY5cMjp59
         zoD3kyrv9qomZ1pyzBGwkIoqaczO6MlmLC/MX37fzzehmiLTsWIqa6C70PwzU5YoMWbP
         CcORY8k6h0fGi8AJvuEiwNyzX48JG2n+x8oUxddEa1G/nRPSjdfZ/MijBSVskSYuat1x
         M5/H7RV8Na4Yqmd1bvfStro/tfmcyzjUuNw9dPfA13RGqx05glQX11iAu3yFAwCbcfj1
         PhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664290; x=1794269090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=1wGzIwexPCUaIdnl5W1U9Tr47u8dnsgnezG9eVmhVPpwderkP1ncdJD7lqhN119oLN
         2qX4Wji/qmVlVLuw9ssim0jxAfbL528yXZnLNZieg7xhnGUISZNJ52UpCINgUnjalbXT
         8QzNfMdW+n2Z/BUlpCJBQWwBZg7LPJb0BYECGSLIoEw0aX3UA1ZwrXpmvMR0YvU7u5f5
         5aPhfkUfO4DIUIr/tu6GtODrWk3/cj1Q98OwJ/pFb8yI6FhJZbii4ksVppE/5q0TbE7p
         PF+Q5GFxGYy4hQ+eCBiqt4+7xrSbWbJ+lC0b4A8eJWx+Ev5a1+zJcOmd9Ld4sgXMriKp
         2i+A==
X-Forwarded-Encrypted: i=1; AKwUvBwGqpZKlfDA/6kCYz3o8vnCFwuwy1S2mU5KWmTHB2MvAs24AZdUTfJjqUMx6ia9fldjRkZSHWxKKoYH7VwhZw==@lists.linux.dev
X-Gm-Message-State: APuU4Z88sdTQLgKwtyVDvSsHLBv/yBrr2RYW/NUujt5F0+haoesblh6d
	xc8elJCzRiO4wGbpkr+7OqFps5V7pAiWONntLlnpdpOIusnU6v8iGHUN
X-Gm-Gg: AYBFou1nBr8zxkK1PZM9PsTeVBhNVTTF6kDOTZrkbiXOD2qtPOT/TtVWn8UFmMcvFOo
	L4xKM0UjoaluKkf8zAuLDxt0oVR5S3J5U3UJYsd6SPp+s0hyUGRsbvRW8MmEWVsuEg3q3kRvqUm
	FP5j5ytx5CpVwKNbTvD6ATfHOhesM1gzurw4QyAWPMoylpwueXiJyNuipn6hdz8MOYBAwLF+SEa
	hW0Wn/H0i5Yf/PxUz8e46gBIPQohnGt6KIBEw48OXwjaoNotMbqh5bWrlgNtdBxZJfZ5HVAD2M4
	T7KCMcsP3j4TBOL9zkn2WJfGWa5ICZlt4+rNDQ4z9r10hAxprAXDdPj4WTUq0/haxJdnSdHbUWU
	WRFbjivTdE98nJWwF4TOwj/YaqTwbcR1LtG+tUA2sQR+ZbICWfOIw+kXj9OkstG9C3smgMK7dKM
	qB4LLhAHXP/X7pjw9GinTMTnvyP6G9mAlchGGZ+O54/UEX0dMOCr5IQ4mR6ChT3Tytcw4cn/jZT
	NclOmcX73LaCqsnPKKO4lBkcrT9I2HAxVffaES3tMSILrwh+Hq1o7GhKt0WvzdvAKmrESsFM0Z9
	VsVeBxpXX6+RUxSj/4QX9l3lfeDihas2RuVjb7nfrLKr5mBT2xj5jmDNBdc8+28RI0QIvLvmUhm
	E2Y0S24y0j5Z+jNCjWibkuIRaq5lIoi0WJ8EYR9P3fReFD78=
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ae896f8315mr9974105a91.11.1793664289956;
        Mon, 02 Nov 2026 16:04:49 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:49 -0800 (PST)
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
Subject: [PATCH v12 12/12] docs: describe virtio-sound capture options
Date: Tue,  3 Nov 2026 09:04:03 +0900
Message-ID: <20261103000403.67106-13-mynameisjune111@gmail.com>
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

Document the five opt-in capture module parameters introduced by this
series. All default to false. Describe the startup-empty, short-payload,
packed-status and pause-restart compatibility behavior alongside staging,
and require validation with the target device.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8328,6 +8328,36 @@
 			brightness level.
 			default: 1
 
+	virtio_snd.capture_allow_empty= [HW,SOUND]
+			Retry a bounded number of empty startup capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,SOUND]
+			Accept non-empty, frame-aligned short capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,SOUND]
+			Read status immediately after the returned capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,SOUND]
+			Release and reprepare capture streams across pause.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_staging= [HW,SOUND]
+			Use request-owned buffers for capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.
 
