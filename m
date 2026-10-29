Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252684;
	b=239R0n52Y53b4U0odcMDixtmCnTUSeIPV5OrV3Ub1DWdmJXk2LqOBjPfAX22gvQFRvuH
	 cGLX3nx3BYky3uCgdvovQhlwekgOGlvy8elRZ1/aWSsbIoL/tQ/i4MCy7wmmpQ5dHLGZX
	 NYoJf94PsMLyNWIbqhfv5ZuhixX2103CPYarqf2OnHj/SUdueEMuvPwXTzyDacku1VMiM
	 S9Ot86+4bL67Ed69z8V3DSZh6zLlzqWilB26zJe5WYdDojhKE2APP0ZmUMG0E+Rtl0bvZ
	 7ln0YmdpTk+hcCKbQV/Mkc9r8iWJPOaevnBwhGzoBqzLzDw9tbQlVGugqJVERtHUsZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ec4/N7zw6HP65LFOCU/La2k3iDwpzO2wT9iw6qkE45M=;
	b=A9M8hAutf/8QFpmOUYupluCxgI7t+KQac42RqeQ3MGGhUeb20IDizOSr34nGmylFrJ1W
	 l2ML0HIN7wkxZVOlMnKmuNS0OaaXvXta91MW5dpYwAC60dzFnVHs+CRcbLJUboxmNAVJB
	 Pt4ihhSQFZkq/VebpfTKYQ7ywmcvTWMXwTcdZxUi8sk92BSogKbJH/xqnQKvzQUf//PpH
	 JknYmvpYtqbIOSMfssKjpBovaQNT+xcfH6xzAYYlaDYgFTO/qH0N6723kOytd89zWNQOD
	 GX4iHicK2nQ+XumC8yvjXIPteSX9frvZsmgCLd5JzU8S8p2nJG0riNlSiyugB0guMqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W+/cGuWg";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63573606A32C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63573606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+/cGuWg
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1249742a91.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252684; x=1793857484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ec4/N7zw6HP65LFOCU/La2k3iDwpzO2wT9iw6qkE45M=;
        b=W+/cGuWgAc4VyYWSw4gmbHG33LTKtkLVqqGqvhZrfBmU2CPiiDPpfZm8rKr4j8N31i
         5pdwqHXqTXeZkkpSKFZpN6eRudOFpbAietbBNhgO+/Yg3Y2vJo4d+L0DOf0WWjrWZUFd
         fwmp85/2Ypol99j8c8eOFkRfxhnx7P6vqe1mRBBfsrcMIQjZitcI567tdkrVXKB63dpi
         TFe8UCrQcfLU5u/0msbY9cQGt9kZ0TX9wQB3Mp7ALsoADNGoNyF+xzcbdv+SlkpTHYMj
         Xp/bT8wiAXnb7fdysvFln9s1LN5+gHdAbncnGuIwiG53CfVYBEDOlrqTJ5tym1rCkicA
         px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252684; x=1793857484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ec4/N7zw6HP65LFOCU/La2k3iDwpzO2wT9iw6qkE45M=;
        b=CAy1/FTRh5SnrzjT2c8mM6xIXdyWj97GE/iBGS3rNjDsXyz6+bDiWtPHhfjfwyj9rH
         36m8c28bGDeSx1tCV3LgVpHVTnB6boV84+WWqp3g5f3s2sOUBcZNT0j8bznVqsDH71l1
         JeLdBG5P3PxOJAIzGs0cvkk+iV1kjBzeBZyMGBYQKjvIacqsQXZmik8G8Y6O4p1zeE7P
         3ZpHfkKDD1MMDAr3mmJ8cf7Kd0A14DKzb/Bz9k4dB7Q7y4oFELv0Q4yWZkDEiwlhmBGE
         /imiHbHnwavYEfr3NiEXIsFOwQ21SGkfY74g/VxwpNLM00kFgjr5iOjKBEX2K2gX4tBk
         c4Pg==
X-Forwarded-Encrypted: i=1; AKwUvBzrNzSN9h3/y+RrmoXJJ2vypadvQFUib721Zj+msQY3y4chrfZ/G4+9Y1zgrEMOaqGflYEQAKz35cG4w2oNsw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5bwbdftQCUpAJibwRPx08XPSwPOSva4ih5GX5xYlq8rM6q3XD
	CXCWp+jFmVs4AdGj+pFjHhtyyiPdSRDDJ4VDPka5ANppnVOdku+UckYr
X-Gm-Gg: AYBFou1Mt8fhvcnWB3H0FHFyP5Sk8m015WRKqCww8+Wz3B99KnZLGsrBpZjxpUKw0px
	BljH3p2uWBOR07hK3FGDt9Lm1pkl/0Aniv5JVYW6hn3xIpJMh1S9R3FW7tvg5PPfHUEnH2kiqi5
	BjJ8cLiKOLTPBdGmCESgAySeUCvSfvzYnbvVyijiL1ftWcYNQDYNd6EBflkSe5HQFwW8Ez4Zz7B
	366W6Pt5b+mjJiKk0BYtV28cLIpcd67qlGChsxSu/x73dqK9X8DdAGNmio80cN+yXugk6PptMCE
	gOfw8294PoCWlHhSYnJIGVqWhUSek4wCCJuvrJ/ez6z1AAp4UTcDq0ZhM6AtYf90tFj67XVSTzS
	EEcXyrc1afLnx8uSxYhcON6Al1DC9DGFTcaFLTPyDeEbdYSM+Hf9pZNmmYgzk3yo54Y0t6x+eA4
	eHiEfM5aLdQL7iHzWz/HUXwEjzLWKiJWt6gfEprbTl5W6zUt3g2wACYNO2/vy9IpaBz78oeuaXi
	SaczjyNIV9kT4nxEIwGLDWxG3kVFwi3Dkg1ES3tSTT0j1Q9Zqx/EMaxUErTWEKtUaM98WrLLDjF
	mHl0pyHpMXkfbQecmyhrhalurDzjNx95eMz+wqAIN694djrScETk2fL3u4FDHUCLsoITEaDybax
	c0qOK59dcngadyjv75uBYsAdI7gXJGNnqf63rodCZybK0fq50HJ9i47IthS7RM00bnKqp
X-Received: by 2002:a17:90a:d603:b0:3ad:818f:3da2 with SMTP id 98e67ed59e1d1-3ae5823f4eemr2777102a91.63.1793252683601;
        Wed, 28 Oct 2026 22:44:43 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:43 -0700 (PDT)
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
Subject: [PATCH v8 11/14] docs: describe virtio-sound capture options
Date: Thu, 29 Oct 2026 14:43:51 +0900
Message-ID: <20261029054354.2931-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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
 

