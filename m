Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263890;
	b=gzRZ+d8FEyLREPi9usvPijpSa6WzxuRw3tiQMBGP7h6bazhpZTcTb8tsTueM41MqykZ6
	 YI63IHHb60Zetq8wgT0xZZt8ZZWU+mb05u8IHimjr0Y1dEi/j5Du9dQ9LBywtxRuiOAc4
	 ENTfodhZj2nSeKE4lwLhQS2yl6LjRxDb3Oku8hwavCkeVth+jxxDtRtl47RahpG/Fd9A2
	 fY2RhxNDSbPnBuVxmSxVhTg1raL6wqoLmO5/G/gHz1nJ36GMSGKv0XGjgENKt9Yvz0D80
	 C6XkW09YUaNa+kn7W0GZkKVnVzUxzJsCvj/Ytpw1a1YAlIo02tyYiCUTmGoE0oXm1rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
	b=hJlq7UnGN/m6vuqAq8d5qBfkAupy+5i2aDZME9bI8Mx6T6M6Va4iW4QNv4b0Xih7Fi4X
	 PSQQ6PJqxAmSMlcGPGXa0YSRydHZ6HO+/hA5HaRISbmsFhLSj5qWfpxyKx8B3YONLTg5B
	 bBUMVNg2NyBOMvW+8uBZq6/07R4tphaTp3uZMlKoVZN4Zdi/hGXiyLK5zqRsKkzpd2URb
	 ca+iDkC42dy8C0f36Ru5entFZEKQCtDOZyWwIQ0sI9+4QyP/SfJi+qleH3+fJKDDDsDKK
	 dvTQmUzUGkT8D0kuluve/RvhHEWm0B5RInAYejF5j28CfJFzAO5GzpdI7WBWjcxQUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9TG9NWp;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14684606A334
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14684606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9TG9NWp
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea138a3497so10906775ad.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263889; x=1793868689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=u9TG9NWpncJ1DYHeAj55umU+D6rrfVbS+y4acGTHjJyuD4H4ReE6aNBEXb1xhLNQuv
         BC1kNjTooMferrTy0v7iQ1lAeBgEwp501Y/ePL+r2eitJywMeXZXPuu/dcUPgiLwaJL2
         5BfN6F2u/LoFVNT/qjPeo1z28eE9k2+0Psh2sGunFNelEQkJutJLjwL+eD94/RRVQMFu
         B+uy3jLOQIK22woOMmkruPOJAqiQm5ZxfkNatDlJXS3gJSHxkjemxzzv4s/hGFP9hv6W
         oH4aoXIUUuRYQeNdAOgTXIMM0XQGmS7X5Tu/WfDh/qV0GJMJUmQ58LFIjOrmAeiYaTYH
         MEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263889; x=1793868689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=UciClEzmz5qMxkWZEZ+gQxSA4x4z1Ez16KmrdZ1mF4A0nptBgi1f8wbWGI25dUQad0
         C6KYkn63jPHDDj1KEWy9A6pHHI4FHI3lN20ThmARYH32A1ehdhAK7ND21SKwhQr8uPzC
         8glMKXplrVNwuIuTn3CXcNGRf4DHmB8a9IQTHsGAGF/RZrBQOK//JlGdK1icLna5DNeH
         cH/jKfJTbQU7cTYaLD0pg/Uk9rB29QFEaneohJIlEyMP0p+XjRvu008WIP8UN9+l5Aj1
         /563XE9Xqfz0rBNBYzpH1ulRyE9uXYzYezh8sMGpcu20ose7/uIWdcxyIldY0GUtrUTF
         QybA==
X-Forwarded-Encrypted: i=1; AKwUvBwD8gw2kc4y+bqhV0zagTOWj7b+en66warWcRato63wPa/zpK1PDwk3oNK4H8Nq7On9FgpTyV/KnU9NzcZUlA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJk8bbsHXak7AzPWtJJ701+TOC8ePIDodKG/LRaJgYkZNlxuJcr
	PzW42dTfVbjh54FjaGwvWZ+ZuH4udVqXU4UqVMnraWSaVuYNn9Q6eh79
X-Gm-Gg: AYBFou3ZARKo7N3p0nIgSPO00MDtJ3TtFpNvOlAR8XOD3c7C5o+ax5rLfiNXtmWAOmg
	Y7pgUu9qXRgNvvfWftsrCQWHcaxWYZnrAWElZRsjJqq7/5fJitcmDhVoS8jLDpIX81/MIaHwBYT
	6F5IE6CYBso+MhWi+h0738U2E2A/Qdh8ofCKDzsi2zzcXtUtOQ9LyXdhI0Ou1vS8akXivO3zgvI
	DBKEJjsHWcbpQiPK0eaUpRlIXiPLCWv0uoif/P1haZCi02GJaAJCqTH9ODhwjNOXCgXgjLCLz06
	fgCGDxVlJ5L10DmPxMQVvigSut64nJYcgscrBOR4pNMHZUfDe57XUND4fnupgyqLVc2ybfArs2z
	hG/wCnOaLczuJsuICiKnA5OkJ+lm93mMQ77vgZo7zmCrYOMJO5IoroWLUdNe5K0W89kQNHDxzsa
	BwEuACOfT0qCK3BCRUK7b2RummYfSy3fwclRuz2qrxBUArZdYid2Kf7mbE9+Lre0gECogQhgEJt
	nTON4QZxHLgkC2Febb+2pQJ1DpKG3lCsw5CXhlC79VY43boKMlcEgcjMOpo0+/6rCHiSXKw4a/H
	7xKbMYzOS+ZUh9MsSRMqkHxYBd0TdU2Xs8BnM6yEut9mF7RbaRNCbXC/fTQ58bkh/BKsDIo+H6C
	Tk7FWyOKD+ws3+F0nJWgYgOmbi/kTv7fEyNH7g53NVQ==
X-Received: by 2002:a17:902:f68c:b0:2e5:cf96:9340 with SMTP id d9443c01a7336-2eb00338bb4mr39809965ad.18.1793263889488;
        Thu, 29 Oct 2026 01:51:29 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:28 -0700 (PDT)
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
Subject: [PATCH v9 11/14] docs: describe virtio-sound capture options
Date: Thu, 29 Oct 2026 17:50:29 +0900
Message-ID: <20261029085032.70689-12-mynameisjune111@gmail.com>
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
 
