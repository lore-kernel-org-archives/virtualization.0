Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252681;
	b=ji57+ZRXnSrDyznDbluKasr9Z3V6p2U2OJIKU++3KIi6A6rU7ioyFzF5yuvy7yEtXskT
	 jQIj/nI8802BLZV781tmiG4HUf4f0XEVgqnYKtBBxpIqXjV9hu4CtqpXDsu3Ym/qPaCJt
	 TjaqXRQnuW6Lhb0tvmVJEMc2BN0OTmgfqNkT41OnkXUCRybMKyXZ6Mp6Nuk1FQyT+4MG5
	 u4+vTWUR0n/jTUj19TAZFuueHtb5IkTpIw8EwpIHckZb6Tml76E2lBm9K8ZfJSN07VGKg
	 PjumZebZhgrYunhzCum+pExvwJ+m0rt3gdqfuqvVXMYJYCJJ0rln4xp+dxE6jrCLCLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z/l4dD/5O5m6RU90kbEhUZI1etATEz4+8y2FIjERE5k=;
	b=xkmc79lxkmfXHm8gsNER+OTy2apN8COUMu2eG24lkImV/WddsKc9Qhp6koECPSPiJiLc
	 OmYCk3iMTlu80MTe35SoFa7WQftxhKzLbQhjJbryarJR7fig1amb/TvVnywR5EEf6OI+z
	 KqA8ixjRTVGp8fs+LgpnFgklUleH0cwxA7rAo2+HbW9tXCD/R7y0URxY2VvkPT6O/z6B2
	 +t9S1lm3ZJqZChRo0iNXnKD6IRDEDbR0h1jd5imvPrvDZBBBaiMZqiR9zWdvBoSbJ7pA4
	 Y35HXKXdk/d8O9AUGOpnBpI8ZM6z6r3ffZ8VTuKcuVSWxrvkB4uD0L8Xdz6TdAv0t6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sG5QMdVE;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67872606A323
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67872606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sG5QMdVE
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so162424a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252680; x=1793857480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/l4dD/5O5m6RU90kbEhUZI1etATEz4+8y2FIjERE5k=;
        b=sG5QMdVE/MZ6grlFr9kA3Z25y2DxNr6ZNDn2u62ritH9Q2/6URQASwOQW/EdF4jnRQ
         5MSzds7Ba6QBxlgSg0HJ+O+J9dW8Tw6Lpx4jNhkIEHakvXNch8rLCHNOa958+DMEPf1U
         k0zBJuuCQaHOanGwV9NLKBhoOQ2apvJxNMgOwUyuT7ue/burNwzguXJ+aLCwG7Ox9k9U
         zTBtw2yEKMlTW9wmSrqZGZWpNQn9ndvhv1aLLOIEvUn7/MExaA7pESNAOFJN1/zfkZm2
         0RqKmdGUIsWAhYlfXGLyED598H/EpoU+mfuXa1MY6KdRaMDKcUZEVfJ+/e8tPbM6fFjt
         0QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252680; x=1793857480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/l4dD/5O5m6RU90kbEhUZI1etATEz4+8y2FIjERE5k=;
        b=WHzuwYx+G+u9S61II6Ko76+27FRD7QfEPIEUnIN2aFSyYIOnrZQOPo/zKwpg7Lx3Sl
         NleQKFkPNiHQPUz9cduTSs/p7969cD7w9wGlsvQzWczPwoUNPVS/FA14d0tR3mMh54BS
         ksbJPs+Euc9KLUWpBEyHCxWE7xRtCBMKkfDQIYxxdobfEj0Xam1Cr21OoNOBUwq/kMzi
         7LhGPXf9GdPzWkfADMr+a0HxdoDGCr76+N6BLwiPU5pMqj3YjzwYq5mtvOxE2zJysmbz
         CwgydwNsvf5eB8N7sA7dF2FZz3b3jS5Xs9Mv1qZpTCeglL7oCz1q4QlwSzQjZBYVRBDZ
         U9iQ==
X-Forwarded-Encrypted: i=1; AKwUvBy74bi518s9yl7RwrkHs731aMeUu4BGf0QxpqHOpR6uBV8b+8ArYCONICXb2KXXhFaNJHdZacuMulDR1nsEDg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpueibRPW8W44a6+kUkeh7yF6J1+SGE3Hz9144KOdp1V9MvnqQ
	zq9p6VixPNbrMvTHljJnaEiwKx+kaymvCJmUcoFqnnd/TI9s2VGmph0m
X-Gm-Gg: AYBFou2occpqe+Rk7MIIknSHdAoVmePMoyrYCXWwggtDPcQCHyu9B8BwhXYMnS1Xlov
	DGCEDjf13fIhj2a/tDuGYnZ51gyYc07m3I0YxlfoaVLKRR20RGUsAtuojpgZPheAReUj1jZcotc
	dFSHex556Kv0SXtGSrrPzg8VRp2XLgdTvikmj5Hcy3QeleTkAGN1lyKShyZhcG9xFvjnZppxpth
	dDy5WhOKGPQwqyOefwfsQPsC0Bxe7QoexPONnU7e6ELQEBBECKOOXOyInJd8jEKXW/qB+l0AuG6
	6hYjDjSpUACm6GLROso1zriXxkOF1gjoAUk33IAyHGrN0CFRlsy7wqu9sdMPttEeG9FBmXplZt4
	GfQ51v7TJOVhF6EVT/AYIJ1g8RByj5l2XGWtgRiHQ9GOMOC/SJUQUhGQWv99uc7/Jexuh5Ua23C
	nqO10PdQzamH9zT0QOOTJzl5ai7rJbJ6btfRkSF75YYljvMx7bk/GPwZM/NDU2mWWdyNJ3MaUIV
	podq6LBZL4bU/PJCocEZDt1lFizvcM9qjyiAiVLCtjJehfUiOVIEtQlrbeZbnmSnr7D+mYYS6kN
	1f2YV4P5NwUYSsx2nFPOIK+pIivy3A3zzrtyZf6CJCLx4oMiNN0N/ac3T2NY8teKjIav1q71Ktq
	eaaiqhcUhF48FLuJmU4fKyxj9gVKQJcMWathVblIIif1kTT8=
X-Received: by 2002:a17:90b:3d83:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3ae6ed4d633mr905165a91.26.1793252679788;
        Wed, 28 Oct 2026 22:44:39 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:39 -0700 (PDT)
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
Subject: [PATCH v8 10/14] ALSA: virtio: prioritize staged capture period work
Date: Thu, 29 Oct 2026 14:43:50 +0900
Message-ID: <20261029054354.2931-11-mynameisjune111@gmail.com>
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
@@ -146,10 +146,14 @@
 	runtime->stop_operating = true;
 }
 
-/* Use one notification helper for all producers. */
+/* Keep non-staged PCM notifications on schedule_work()'s normal queue. */
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
