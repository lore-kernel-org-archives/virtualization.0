Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466225;
	b=dI3giUB9Fjge6cr39MruDX36WFfMleja5lF7svGRiSFQrcLIBvJtxt1XU2wsQrSLnd42
	 lTZE+S8e566bc4fYup3tZqrGVaAbWCvK9taujCLXjoUa2zMMU+lbsFdb7amJfbcjHkrdf
	 ophL4x0pW1ygfO3jhvFaJOxwW7WRF9oVXyaY2VG1Uwru2jeG9D6og06MUeqg20D6At4Da
	 n8gixzqaIQiCuFMFGjP2lQlvx1Pwmj6IT8L2kjGUWoP4Vq0Uzam4Py+nRLi1g2bpt6tef
	 b+HZGXgyY6h3PR/acvuVSjjMOG5Bn7oq4nF4oupzUxRNhwwo65JwRWscpHfQAiRTWRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=IXjWpC6n3KGITRSI5GpwFd9ZHzXps0LYSa7a8MXI8Vbs+9km4okT09w6NtKd5OriNsuZ
	 WAPaHVtlt3G5X+YSRMpyJahJqzPLjz2IarFbOdyqLau6NdRxkiEUAT+fOA8lLQv9+y8FH
	 UYziWV4dYHSc6i2x9ZQ1WVqUQWgcfaLHb8J1yTeRCLs57dW/tJQjYNDoynMEJBuzeXxao
	 KBiBce2wSHIcbVjrFnyfx4e4fdV2XeHFHnxDezLX4Hqwzi92uvnn7wmuMiopIjVlp2ZYk
	 D1Tj4VgfJmIlgDrCDVF3q0RdEtkaFt4BlGl+0TeUXMQ2PrYS+m6ZSsvot2PrXH9fUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCLoJGGX;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62760A2606
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB62760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCLoJGGX
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1968616b3a.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466224; x=1795071024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=mCLoJGGXvvnvwAEP0BPhYdI4YFVPP8IGpz94vE8JJ3uEG0G8UMmHexwZAG+FtVbAL6
         KFVBhNg896ay6R4aLgX173Ez/y/xSY9ctvj18vErsH2OiAxj491FwRhTV8GOz+8C3iuo
         yIJEkOEh8uUGH7x5mESp9kqeV06pBFLDbgObz266Y1+8910zp4RKqF2rXRmO9EdNV8dx
         5IFfXIStf3eiy/yWQmX2m40ZTKbvXsild5q1QY/IqE4NBsQl0SiwLm97APELIvA1lSq+
         WzEjKv78ORDkfsXPTck6vwhtxZMWPgga17O7Xqt1VYkvQFutOMLDKw190t35tOr350RA
         JvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466224; x=1795071024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=YNazx96OL0gd+yWwFgGlVnsF3IlLxj0O9iBm5ZMN0LaycXsu1t12xp+502D2LetO3U
         nIarhrI23Spv1G17o7Sk+1N0qUo7Z1r0wortkmTXPGY37y9IDXxAWVCKm0HzwnPRFAtS
         PcIgIWKyicPDsgeM8YDh207yIfd4brlmq+0MhARX8hGCrm+XwP2bGSlc8fLhhOo5ZmgA
         Ofl748JJJ6AfIvpPUkWj8l6Cbe8lhwppXBzW8wR6K/aY4pZJlQKG5zYrfx+D3Ewh3lMc
         2rf2W+fhMZt6qDhQPaBqV8GlyH27sfL7wQKl5GxtnFumH8ymqeLEaLdw2blzQr9scXEe
         9quQ==
X-Forwarded-Encrypted: i=1; AL+hErEmfTKL7X7gRgtOX9ztzvExWw8JiyA/CMhbYsySalqlZvSDgvI7RWMgLFT36PsDOIrnTckxSrWqJVexcJVIYw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Y9mdPW+yovKPdvX6pP52IOzp1mtPbVb2YI239WaW9ahNa6jCF
	jj7GPaMWDPrt0E/8D7foPQwWYprWqY+lRBAimHKGwgPMmzt2fSt4Ucm4
X-Gm-Gg: AYBFou2FFhTDm5ZNR2u9oBaqFlQC79P4X59xyaM0wZZlWiS1Nuw7r0VSPzANfXx0xuJ
	zHtZnpmcXBTexnPLEEZP7PxzOVIy9UTM8hwr8THqrqomDorxIjWBVAsg4tRApEzUSXlwzZVPAuN
	eykgH1SIICSpfhoknVx7Y0iBzr2dyXVp4N8i7/K9XoZE+6i3u34Zh/X4ezy+tgFM26Kq7NMZZN6
	EvKg1LClIzQJ2ZybOADtP1NXiH5bXen1jgke6iu+MLMzJwDVKeZ6dNj6WovzI9ypwpBQx3EgXTN
	Kkbxtu6z1d9ThB9fidLHhR5JDNQQJUqrjw9+6YcbzNB4fDcgHn3shlegU8Y/LFGuJbR3ZMpQpjF
	OJFQHj9HxWWeU76ITSwKM4COoFroFbiht6OiYA8uo9gtxyPi3u/hEgANtSPtEG3ux/MzYqpBHhJ
	sC1WiLPICzE+TgMWrRyq87Fmr+kx5Ya6Kt2dqcVY1Q68jLpeNVTWA13TWQGTrKCoRoXNylSGAnk
	E/ePgCOXGdg3WYYbMYBUyvVoFkb06d4V+7xcrSEl6lGhaReed2AcXRzwWZmOQfv5sAUpNOH6/1x
	114dORzmAXBTxzKlxg4Cddt4gvRYrBOZBjuNKtx3j5JRJxpOVM8/RDBN10IKOttIrj53irva8+f
	p+HsZhQDuzO1RimLT7m1/Po7k0PkhDL1JH1AxftwVGzgzSA8=
X-Received: by 2002:a05:6a00:148f:b0:8b5:94e0:91a2 with SMTP id d2e1a72fcca58-8bc1b6ff204mr5007644b3a.10.1794466224163;
        Wed, 11 Nov 2026 22:50:24 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.50.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:50:23 -0800 (PST)
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
Subject: [PATCH v31 13/17] ALSA: virtio: prioritize capture period work
Date: Thu, 12 Nov 2026 15:49:25 +0900
Message-ID: <20261112064929.11211-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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

Use system_highpri_wq for capture progress notifications. Capture now
always uses request-owned storage. Playback keeps the ordinary
workqueue. This preserves the priority proposal separately from recovery
and accounting. It provides no hard real-time guarantee and cannot
prevent reader overruns.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -173,6 +173,9 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
