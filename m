Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338030;
	b=b0mnTbJjPYvuGoU35XU0rLKZa6K9qWZnkhMlYW4olEcIH9QzmuPNtxgdKS0gPnrnPMjy
	 k47EgIatOUmbbE0VC+ufpq7+nY0bRz1wmutt7DfT1q1vsSiS7ZsT77Lru93VgvT8X3NX7
	 1fdypiDVYDAQTwfFeGa0R8zBJx4GjnkjGi8FWjLj3RzYGP72p1JCwZoRG/HaX5KJad7MP
	 WvcIJV7J1gmfhIlTyuZL4Xbc7j6OJnNJhqoD62iQYujRP7t46cRoZVta7ujf3q/Zd5aw2
	 35m6pzmAS7dODjhgM0JEX5dSj/wPMnbDO2hml/qXNxebwZjdTVz/dnGGqcUkzcTJ/kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
	b=qkt8NUAHmJ6frzERW6UzTODZpIr0slcpnLn2cxXqZQ0O3qg3epgmGncERg7ECMa5SFsg
	 K+/8eMtWfT+NT2WUtlUbXD9gw+TKDKbOx9rStNcGphRESTJQE468eL7NPB2/vdMURMOqU
	 nUZqezubGbPImL3t5E4UsUxysxnJ0YqeD3sug7dxMb2uNWShU4rDpAhcLcljktW20RCRm
	 K6zf11/1QBz6BCwkYJRjbGPlDYY+TgxNbYGqEZSaRt4bqE+NUHiMTHAj556CNTFy4lJUC
	 UvO4/tYzj/q0xhNCZnTGMBRfFKK4y2uxhi2AsAkjGqzr7vXCeUbKiWyXIIdSBqIXoXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYC5UTTd;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275B606A33B
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E275B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYC5UTTd
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso173852a91.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338029; x=1793942829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
        b=DYC5UTTdo41z/Bey9ILlcCCGYmJpzb+HhAcBHOG1FAF5AOF9opXegr3S6yrBCNpBBz
         I2KDo6OO5tsh/KW4xrmZ18uI2rLgk7gliemnqi6jTcuknbCTH6hVC5ZO6nej2YWj4jYm
         YeNvP68uU4oK1+rmdFPXim1qaNrxfmRjp5PbCp4PsOAPTFfsTQ7dxqKYiBFs1PhMt7bh
         nNmf2OOuaw3UOw5IfwdH8X7ZIM5UxwnJrMeJ7TbQGjY0ustLrk6k+2jdyms3pHtFyrg2
         WMcCFgyfAx1sHpg2WxZqlpxYNtY+15LnjzyHIXYsmJ2hkphwdVSfS+G2pcJjOjbemNm+
         9Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338029; x=1793942829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqhUqx0lysr6sCpQ4kFLl5TD33Z5oOALBO9Bt5uIT2U=;
        b=ADgDwzKbXI39bpF4p6o/w9VN4ASYyncpYVHsX13zjkiOfcLA28zvThmIRNpfZVETKN
         FZSB8VtCmmASfZWOYy9hHIsFaL/M4pbYNO/3lrXNLkdu72/CJucIJn95umztQNEi+jAc
         dojb76OTOEDJT1/R/wDTCrZTyaIZRTnWinvjFgzr3NVDB3KMu4j5N9DE1zQCP0LYcUFi
         lVNDzFpfg1TW0p4XRzzU2O8/3Xf1K8PKpZv6xqPOEgHC9Rou/lPYU/rms3CYKHq7BQtk
         lnvFzAXNE9YOYpzLUdZn2FXczdFGU0shvu34PYuxD6eSe5fsdSrChEfR3RBN3jRlMO/W
         l7DA==
X-Forwarded-Encrypted: i=1; AKwUvBxdF8zG0e/ESPYh3E4FnDzUkIHLQAsz0Ue4OdlCPv2pRRF0tfLNm9vVAZFqmI/8GeeUKQOi8tmkg9fDYsyCAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJIYssYPU729zyfyQaGWiPhmsu2OCAM4YFELvC04JbiwdnFfut6
	t6GG43oCEfX5GqORo5reNkn+YFVQNTTcxdW9xuhHgVFsup1KzT3GjD5m
X-Gm-Gg: AYBFou3/12t+EYbW1SvFfHbBXDmRmxvN0PBtr2+cVsKm4t3iO1qOA+PXb5bQusjexyx
	I8+sJ29HqcHLkpGQl66mRBqcWTUuc2oG7f/ZI5TF/s34dauo6FGNsjOcW4V7YOUsMecJDyrW8ZS
	OKw2EJ5LGxcmRubLrdMNew8ZidOn9muRXbHO2Fxx8NAf2UmMBxX7J9IhHYfiJTG3jYujhmMe08o
	1o4CKTrboapBxp8SZx5HbacjostsQpUHvoHiLy9nX41rmtN23/ikhTew7efS4Wx3A2Addy/JKfn
	gKY0xO7iLI1EfKeDfYZVy1sHSre67WmKMDqpdvfypZeXZH3DeBiAGic2xmlAnAGLphyIzswoMnH
	ZkBH7imBKk5LTanvsZz3qiSG2vxEqgf3L8Mq8ORy+TRKhyH1xRDhg8u/pQBJBh39BNw2RfjpiFp
	i14Cna1WQIbjFz0Dzvhj1biOXEkZPSTEEM/OoY/5wXts17hxkeXGlFI1M6IggnBHD/ajVbmNurM
	tnS8RJF+DQnVSxoYuMzqpcYv0ejfuL7Se0aC5LZkZ5amPDHSxSf3Gk2N9XemdFV3TyTp1p297w5
	3XWFj7zmFX62nj9olUQE2Yz592RSpIoOMCMepiuWKy8Z8qbL4BuImlLPEl9xLlHc2obUp2vbDDi
	JNPUxjFNQEdsgvsVU1xeOPITHanGbLd79hQCOHnkV3bPL1ww=
X-Received: by 2002:a17:90b:5827:b0:3ac:17c:6e74 with SMTP id 98e67ed59e1d1-3ae897c212emr943776a91.53.1793338029049;
        Thu, 29 Oct 2026 22:27:09 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.27.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:08 -0700 (PDT)
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
Subject: [PATCH v10 10/14] ALSA: virtio: prioritize staged capture period work
Date: Fri, 30 Oct 2026 14:26:25 +0900
Message-ID: <20261030052629.27742-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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
 
