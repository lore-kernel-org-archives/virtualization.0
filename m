Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156049;
	b=WUFXiZDMkVu/7zoO/0TezPVlgTxIl/DpPIpcxCHji909jv1acsMSCvaS/cboLBpZcYUs
	 xTK0soCFVfDhEGEIpAEAlBGzAtXZglbcQL+A/MzLkZQXVSm1KKtf5JW2E+FTTqZIxPrVZ
	 MGCshSWR9q0RDDB4Iuem7V0Tq6DvOkc2SSNFeQxUleRJgNvX3v4HR5G9qPZ/Sk6HZJQKa
	 pQwBFN/kBYgJ7Ga1hnIxaXOioGjypdDZfr5gwglahSGOXZZcHIKFX9UR8vLASX0OvD1m6
	 G3e9pLRt+pKBtMDB9pf5pqaY1N5qiln3d0fJFkO0ooOYwCc5+AH30jI2YjzOuCi00Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
	b=yOkOm/SmvedbtM5QhAoHuIMvBYlUVQjvrfU7koeg9PhBhLbZ47zY82zDhGACpVLs5Kqs
	 P6Bst/io0+A5ayaw/mg4ip2UXFfSP7RZjOTPaMW3lEW7HddLLBICSKpyIkgJvp2UN4L0k
	 ZoA/pYl8HcZUVNws8+4TuPp3wKqVRbEz3RI0VBTn5cAS2x8I0PWaPMDhK8t1C171YtgNz
	 Zc9GvMiRoD2e2xS+9agVjkdKavBkDXQ6r8+XaSk7f3W0zT57GvL/Z0HGK0OD+p8vwb5mN
	 uBOCqHo9I7GfitJlVTscR1wCnf6iqMeH4aLogSJAGrvNxZ4cE7qk07XkcWZXRCVHCvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjMg6zt9;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4260A261B
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC4260A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjMg6zt9
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a121bb8c2so647332eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156048; x=1793760848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
        b=xjMg6zt9MDm+xa0zW/CJngXmSQlXgvpYA5E+E6YrhzH8Y7gF+06WYhISPVMJeCDmcx
         SzuLz6OgtpEWadOfroO1e7zMQNL8H9UL1jSVBiAuO8BdHgjyT4vZcdkrCOZHfeW9mdXF
         FtvbRWzU6Uy8ef2w0BslW2n1M8EWWzW0tLgA7SoYZQzA+dT1186uwmz3CxeX6sCy/mJy
         +RJrIHMjYd703DOYhKyPPrb5/tCP+m+uBkGZvgiVA8hhf89xqRJaVgxBbJDKKK8u0riT
         lAoBvDkX54kGslV1BU/o9JUOPlH7rPLIer1FXnCTD0ll7Uz8DPj6vIniKDEApjKOJAI1
         bs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156048; x=1793760848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
        b=jgWYsEKWn2WNuscDaDTYDDosoXLqYIMUheT7g23ZUEqlS0hmRfBr2qfFZFlUWNNqXk
         QGR9qpmNDSkWNxuL+zUYV42q4S4sMPvDXQEgGtxX5REL3fR5YPygpNZQDqL1k5TS5t5J
         Z0/2p5SdHus5ZYAcIrFA0ZrH+MB+dAVG+OBxyYMsZMo1DobkjGHzDkPC7nDV6Dw3wM/O
         F+YQQ+bsZH4mmFcwmowR5+iXoLOx3EidVzFJS1IAalvCcZ+wln4na7CeqrhjU9SIYOOh
         JRbOf3hnRmE3SMkDo8pD6o3sxXLJlfyyfz9v1spjpoDWd8SgcljhQ85zq0dMV78ktB0j
         YJDg==
X-Forwarded-Encrypted: i=1; AKwUvBxwxu/9jTd0RDTzZS5qAFCGcWobQQlj5Ko60Bt/dc1GOnpl6khGpBg4b02Tsig7BPmapIc/O/gtD2uOZ9yCVg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIeid6OpW6pW8Etx/sEQNaAyBAjC+PYvW5Nl3OOr6GZBq3165KO
	Fg7UcWLCXfzwz2StnkDeOvc0cLuQ5gAw/IYXHpT8OD8N708pcMKRD30n
X-Gm-Gg: AYBFou2LPC/hKGP2hH0q7B+irFQ6vKYi8UeAQsgCtGpcfDND/3bx53K4bpVmal+lH7P
	mTlrNRYZRR4RHIOpWhDEi/Die4KImtHOUjGizGT9d095bvzzAxyZaPzCf/yzByuqh1jwtqpLJ6g
	OQAFqtk+h/1/w+LXqgyEN+KHAsQzbQwIhMBlZN2wCGrlwXcR8+mkMx6ywwzCO++0et8K7QFOGHv
	sTerHObOYQ7v297rdF0Y5TEJXXcqZS6nBXdRcbqLNdw6I9VnqVnRpODIn3p/CQlO0chExwH8Jv6
	F0WiHdC/lrJxj7ljrFPpmGeATTUUbey1C2mHJecb0j5n4ZQuCXltzXVYaQHVZKYuAdclQgegDTa
	xIKwCmuAAqVMC1mI+d8f5XHaOZgpNaGF9N2Y27T10r2Yit6LAoa3z3Lt2jq3TJDUBeBV7bsKNHy
	WYY0uBy2lr0b9UeHG2Cv3cAkZEPTPwELIsdeSrBAePDSh/wcGoSZzoY7zyLcNAjCnhSaKfp/C1B
	70puujuI9piQuXiNb+HFH88OcypbgNNWuVz1D3tSaYUqH83LMTVgP+KynMDD9F981a5CTZTyKMh
	hn3p+jBwyuAWXxgC+DQV9EGT3VFWPw6l4+o3Up6bVYL7lRl3pzny0v7tLxTNVfaAqnBVhYOF9Rt
	kHmpuNx8pkStFhPUsiB1Rt1mLudZZjpIPxj+zJgUxspjwR98=
X-Received: by 2002:a05:7300:681b:b0:36a:2473:9b2f with SMTP id 5a478bee46e88-36a24739b3dmr365410eec.23.1793156048042;
        Tue, 27 Oct 2026 19:54:08 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.54.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:54:07 -0700 (PDT)
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
Subject: [PATCH v6 14/14] docs: describe virtio-sound capture options
Date: Wed, 28 Oct 2026 11:53:17 +0900
Message-ID: <20261028025317.92450-15-mynameisjune111@gmail.com>
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

Document the five opt-in capture module parameters introduced by this
series. All default to false. Describe the startup-empty, short-payload,
packed-status and pause-restart compatibility behavior alongside staging,
and require validation with the target device.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f..6c7b1b3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8328,6 +8328,36 @@ Kernel parameters
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
 
