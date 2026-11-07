Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062107;
	b=gU8wX17c5m5tc4uvyWrkJ1RSfoyZ+t7OzoV8CKEupx0qUIGp+iU3/p9SxFEztcQohAmI
	 yAkiTsfYHZIuDyIobe/7IcKBKKXppW5e1PY1wc4O10B2q0aEffknlDABwmqH2AamGNz9P
	 SHFKVuWNE16g753E6+fdOEJBfqDiysqnKsY9GUFJ+FaejfzjM8IB1RYQpTyQCawUgygMO
	 6U26XF4DJHb5DxyBEQPN8oms7DDyKU15bCp8vAyhnGOH4/3anrA6f8IEegR25jUhWTQ7J
	 4xMt2Zd6PqDebbqBAPXYm82IOsZo8SZpq2OfHGkVkQdsYPBfzq1MM9/IqMeJlyuEasA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
	b=wbZZGG1W2rpC2BuSBLWvheUG/6BFwfHRdYNaKJBa+rDmp73Ue1c1fshf6iYLIfQ+ozwk
	 pV7esgrrrpXpOOvxZZO9/fvNe0ZJMTHQ8Zb/bSMkazO0AYPjQLiL/d8tqLw7KBMuxv/7m
	 NlukNY/r2jtlRTB7zgkrka3o33fDKFH8qAHmkD1pYEwD41a+sahC0mwodhK6Hw6V9HHcY
	 TyZcDoGsw4lMAKvIjBhPIN8xpNj76V2BBBoZPLTNIhLoAVa13i3jCuw5Vxw+xMjrmk+Sv
	 vARzUTuFFrRmfkCd+bba86pZaWiNVTODPYqHpDkHJaUWA5fED0mlG8h4FA94BbE702Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlFWD70R;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D2606EE89
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031D2606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlFWD70R
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2584044eec.0
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062106; x=1794666906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=ZlFWD70Re5guab75CodaY40ykCiz2Tid5PwAqhTQy3XFdQFGu4HdTJQBBGFk09UPvw
         0z8xUN4sOzPbkaSL+OQs9MAJgFn+m41Ue4dzCltng2wK26+dYDfmZWIt+kcmrr/f5Jgn
         He8k1CGmAQNNB0Nv2FY2JdghLJWGverlIXoWq/9y1yNx9dTfq8SpxG4XiHx4PVIZwAfA
         jhuwtGtvg8fB0avBPv860ca2zFk9xUwhKwnseGmmoMEULJKCRvh8oeKBo2sI+MkqjZKk
         rdmMUm/NP2u5lww1XmWQn3DIvWk7J5vnpFGfU7we1Pq9aA4RmHRUFI8leZGe+Kxx/oDw
         FImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062106; x=1794666906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=hLF82GatGD46Kvsorzo1Q+jaUVJVlSVa4PRwYy+EuwqWDliQhJRrHV2uFyqNP6gkAn
         90FnDig0M2Af6s/oDcXEXJjF0F2r3HhESB0rBAmrUL/lstI5HalMJtBfOMdQbHGUas0q
         xcM4thQYrLwSGp/QVpauDg3SNDOPcgO+WEsPI0EExUM/Cne1AvjviQ0h08IE6QFWLm3l
         rMsyS2zCkcD9LK60aiVWnklXNjQ6ib0VTyFQiZPpcwEb7v4cjkuLwzFMEukBSv3riAYF
         HAGnWy1DZpHJfxpOVSEOe5AhApCsnJ+8Iy/r7ID1/rhthFLaX6TDF+lVLTaH+lY/Ztz5
         QQxQ==
X-Forwarded-Encrypted: i=1; AL+hErET3464pe5AZm9j7KQRdoxEhhtjAqtE6QkfiAD4xZhCVOJ73Q7YUE9bKHVmeygUoyf3X2UluWpVJZM28u44Qg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eJioEvhsMooVHkOMvDEeuLXlFEAWu2wrKqgMBY1mSljJbQZHq
	LUwEIkE/hDX3ygF5A1Zz/dPb6pn8pfsdnBNYktQGeuLt88T8TMvtHCc2DrzwMJ6i
X-Gm-Gg: AYBFou14oeG5FzNKEOJgTQWoL5s+4z54TCrejuvBAZG+psnVc89k8tZe7REHsnXBPiN
	ScAthy7UNjZpvceMT6fOtHuXjIFf3Wvh0q1pgHHOx9AU74hNzo+2E1496PM+ZhlRSY2PQkbMBHI
	y79Ki2/UrrTMgxiimyYCSmQOEX3u2ySA29lJvsosUMTM1Flht/5aHFFtnXTUm0QAjPfCPYwyCfc
	Ukrv0A+vYBm28RcyZmiD/UkII+uf5x9YBLL4PgNfPevFljqEnNurFQr/QQXLl55PEBwk5Y7O7J/
	nFC5bsKP+ungTbSKOevJ/bGn7csX+tglrFnc4G9Azvs35dr6395BjAL6dUWN1hLgfPhBBZ7Dz51
	LplTsBHdQb7JBvXHVTBM22ngVnwKJYlkNH5OlBovjd9Qxko3+qMEDBtbBDK8GdIyzIirC3gbQnH
	ei7HVyIXai1o7YxszRx2dDAtBZXYn9ndDlByHIFvDQ0d9O9i7ibxAAXegC97OegIlNdO1g4toyO
	uN9UYx81rZg/AufZbws3n9IPZD2iPK8Z93v9/Z5Md/jM19Nj2CCJbBzfo+FBSPKoeY+lUZTGwj8
	OoNQcpQh+2weKiW+yPGxuOsxaM+eyIeeQnTpsjyMG0QwPkph2ER9IEPL22gCwaVGa85C3P0bKAO
	8CBt4fb/VDfb+FLi1hj+rHJEI39bwdMl5q5RdHUwGkEc37A==
X-Received: by 2002:a05:7301:d805:b0:36b:f09f:924a with SMTP id 5a478bee46e88-36f7592e4d4mr7639013eec.14.1794062106044;
        Sat, 07 Nov 2026 06:35:06 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.35.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:35:05 -0800 (PST)
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
Subject: [PATCH v20 11/12] ALSA: virtio: prioritize staged capture period work
Date: Sat,  7 Nov 2026 23:34:21 +0900
Message-ID: <20261107143422.29319-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -168,6 +168,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
