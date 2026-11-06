Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923650;
	b=HhuOUNxp5JhlLCckK9tgOGXa21sBJYhdyTkz5nKwGow6Y9TtPSLMftizTMzJZ3dDQWrS
	 doboeB6+5g749FDqEYdWv8vNmmafmEdwNCjqAJx8wQuYwZpyNTT/AN4cljIjzAmkjB89w
	 Pm2xe72Li0TT6pLPsxKlJdFGOLQ57Fyj/sTRejXtDORy3bid/oaYs3YhKQK7d4aT6ijIZ
	 SUtX0mRBPebE6ArMh0S4SeTW3dMva7aKb9SOPgo0++aTVfQhh6YbF94GRpZqP/K/UczcK
	 ON7HCNKInbi3scfQxmLuIAff4MgnimUVpa4F7/kmg27Alc1oa5EdWTp3hvH+gc72Lfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
	b=v3OUWxKb8q0E8yKJchryGmhDxirxm2Fb6D6Cx40V6og1mlf5a2wDpVKeQfI/py1eF6tg
	 EpNPRpp2vIidu7M6FJmAoVn8bF4iLosGdkae01VGLNS0hB7s6HKmRhFxSN3mCDqQmV3ib
	 Iu28+8ajxjFXKVhtc04jnRoxU2SfeQLD+gq34PN6z0PPuSjVMj7vSBjcAbL3EpgVyZSdA
	 aPPfuDQ3v7tKahVaD7uSBSXLJZ4ETZvCAd2X1R6U9eFNroKQT69qWhYKK6xaxVncHk4gb
	 A3C0UYC1oVAMGNIsQ4oy/b6NBiUlzC1LpiazLEqw3i/Xp5rQ1oE+XYt3xfWcDnxpotQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5LwmfMK;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED0606D818
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DED0606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5LwmfMK
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so136283c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923649; x=1794528449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=U5LwmfMKPB4X4SgJk5dXIrNYtbkUT5UxTHPt61vcJwJGSeypozNAGqaoYaJb7RYVIM
         U4jcPbc9L6UuE8HhJ20zzB7c7pfKNFOkSt6lR8AOEwLQvDtCmXSLZhZwpM7MPCh4RG92
         q/Lwc9I1cPkaPwH8hZIbweOdQYiQCCN7DtVxYYZ4hmhe2ChXFSEytKV4/jmRPivoNi/u
         O1QDHqfoqTkKSjwIHNhQ5fBU91e+lG/sCRPlBKhv+rL7sCyQ+jc9k0jNobkImWYvY3M+
         ci9phiXrJduMfRhRgXAmFqUP2mNuaANOSUL6J31DJxE8ojcXz7YNbhBBRVrIPMcwnIwn
         GvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923649; x=1794528449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=ahZlpODJTvGZT3endxg9XjtNgKsXUVQW+4EFzFeT+NqCIPHEi8VUl7eIDQ/NLADKg9
         sVMBXtyVfoqR/3V97hM7fKC959AfYzt0sZNM8vmnBALAb2mT9vLbJ4CntPsW0NMERdx7
         dnvj16erysVRZt7preZxTjERUib3/ZVAPdulTNzRiRk9H1eET1QY/Cdj3pmt2vyvkWoA
         awD2S2qr+nedQF5/i778LCeMZubPvFRocHqMs9iUr8z1cmLR0oEPPY7lCjZfNng5NMaI
         d/joCO09hHZvQreAEeqjKt2RU1lu/qgCGd9bx9BOPCJK4zftS9MuPU2X+mv0ru8GfaP6
         nQqA==
X-Forwarded-Encrypted: i=1; AKwUvBwlAQ/9bjVAmxKPfSnHvGT44jLeqK4PxER/XN4x9Dh+UrlWfQxOdIUEFlRhQpmsP/zzP0umM81ULIOy5nzwIA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+x3qiaNKYz/flYW9qvTMZfa1UIzSeIN9T9H9uvyr6epmCvo5Eg
	mo3RXJRnQ8e7FF5znPePxBSI4XK8t6bKDj1vcgU437kZOVvJ4UVN+lUD46dgRg==
X-Gm-Gg: AYBFou0WQ9QDWzvcD43rWFsUlWtGjdeou2HoQyzBK/pR79XVjmm0uUNtZOERQDB1R2R
	RBbL/Y7DGjja7K6PuWhYqlS2HYGB2YA9SRHSU+9unWrc/5PCk3yC0XH32DzHT3LQCyG/dK7mMjo
	6Uxmc+Gnvx1hJQ+bOCBHFocU6GmjH8qNt4nFC5eRFrCn1UFGMcCWsztYBL0HdoSuv+ZA54G3+EZ
	esNAzpTTe3jwXBrpdWub7/jpY/+YJL/XB/NaG+3t33+MH2CQ8KIiGxnEJ7L5PNqsHu61CB1HFxk
	gtvuVn3R6iSr2f0hU2ln3a1Dil9w9Gax57Pv3fuHUoLQkEJ0v/+sOLW9ynuXtFW/h2Ie3NsMkyh
	7gKILMoakyJGFJdowOsj6xANR4p6HWFSBJ6hTYTmvRwrCZEJLi6r6rnJIfLTjRBWv3p00s1F6uY
	CJhQI/sfRbj7fpo5iYHMulmaRNsSsBfI0ZEK3YAwwOcRklv+u26QabBGMv3B8yAL5lWgYHLaYde
	ljBYsXQiLT8Gx+lHIWDCNfJqcJc+MdnHr6Rqfp12LsMpihoSTk6NecvMapoXhGaDkIoupSTpVFy
	meIWXiueBwWM8jkvXPbN+aG3Dq40ITvS+MjTbO8NNt1s8Tw4r5bUrQGz20iRAcXSD1Jl1LR/r55
	KP/Bcd2lETIVsCjBmhT4xL+U/eWJqIa3EpI+yPMUTmqPq9Xs=
X-Received: by 2002:a05:7022:1306:b0:1b2:44b3:8ed2 with SMTP id a92af1059eb24-1b25d373302mr766303c88.42.1793923649075;
        Thu, 05 Nov 2026 16:07:29 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:07:28 -0800 (PST)
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
Subject: [PATCH v18 12/12] docs: describe virtio-sound capture options
Date: Fri,  6 Nov 2026 09:06:44 +0900
Message-ID: <20261106000644.20460-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State
that capture_allow_empty, capture_allow_short, capture_packed_status and
capture_pause_restart require capture_staging, and use the ALSA kernel
parameter restriction tag for each entry.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,35 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,ALSA]
+			Retry a bounded number of empty startup capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,ALSA]
+			Accept non-empty, frame-aligned short capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read status immediately after the returned capture data
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Release and reprepare capture streams across pause when
+			virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_staging= [HW,ALSA]
+			Enable staged capture using request-owned buffers.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
