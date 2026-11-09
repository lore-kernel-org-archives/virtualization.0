Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201424;
	b=cBd7rHYEdFUmJ4Th2qVHFzv07EXr0RgVDtG0PUjAGGkjbL7ZBbNvXotGI9SAtxcbbn2V
	 02XX268K99Z+l4WGDAo3gx2eG0wB34Oy+/1HuLpJr4DqB72HFRQrg4m0Az8moAMX8k7ba
	 NhYafjQuem7iTirxYDxUssQ4rnkSGAOs2jT7RxgLmHcejVoCS5GxWnD/qB+9fE5EMmihe
	 RJDprdmWzy9tQn6P35DhmzJ5a3YSUGSpqjjwD8PLw8ghq5s/1liYLg4Yt9K5PPGx4GZP+
	 J6m0kvFNpV4z91VxdTId5G0m3bqBXtdTA/MjMGmChyX6pU1ZGU8oyf99CenzCf+pZ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
	b=K6TdaIyhAwtYPbAH8HRav5MB/5NGTmIC5GhmCwG6b8GraiebzQnKqeOUo4exZ1OUU0Sb
	 bPrK5zvNTb+Dk9nF7Bmqgxk0mM69weabtQmAfsea2qksNuuKHI6BoJuSjMvuDReLcIYdV
	 XLp5t6o67Jlugspw7vuUK7Kcgt/Tq8jl4iO1p9brQpf1JGY3TAJKIqGH8TJrlx7eWyxev
	 FsZHPQ4cFz8eyL7Bj0zbIbR6AsqFPtDwlBOhZFjntVHM/bUW5nDr6OUlpUUSv8ajETePk
	 aT4BD5rpRpWQmX0dyf4OotGDgCw9ThxhVDRClG850Bz42QyJyNu1vLJALSuXajXpjyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O/1/OjaT";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E94606A33A
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E94606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/1/OjaT
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fb88ea38cso671517eec.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201423; x=1794806223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
        b=O/1/OjaT1SjlIV2jpL8TTn8DwlGqAICzmPUU0gYs3NUsM6V4IQFvw8d7JwX3B/bf8V
         Y4mNs6pp+ORwhAB5V6nX8XydmbZTmUY5YL0e4p8X9VW5WeH/zXthT3HBHybnD1EizaWW
         /VcL+tOXp2Ds5vnysoHzfNGm2xwVA251a+IRILhheOfSFDTv41HN4sr3GF/YCLLNc/1D
         9uKYP5wOHBHdIMUTEVp91jpSSOwEwREAg9HGSX1S+Dxavp3QWhXuIhXO1S6dMLhkMut8
         n5C+xYuPsrTAmpIIUzwUfviVgeX/2BH05pEuypn37IuQPERP1IlZG4wxeSvP3kUMnbtF
         4VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201423; x=1794806223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
        b=ixW09fuEQeNb5ybzRuzhVkSN18/gT+1nVvx2vTlNlxTaL+pNFT+kbB5PHcuiqL2BZU
         /EdWMdP1EB3sBFdbTgTTfmjSkemJ9Zz9UaKktI3Nt2BPQXJgdwul9g2plr3A3DCi3tOZ
         6C28e3AdJgqUs5kdxXZhwS3HuFo7uWehpWjl7t6A5o9E2SiL1xigTS1md01jdI2Sg5AL
         g3/wQeeazFx98vOiXC98ObJzadZA/yXadsvUzh66IfgtQkdnrtEDj6qRgwJepBFUwv1K
         zQFXgoLbpyNr1dXdqLL76e9rE1GVCl200gonfCMPvEBLriOet65g34HqkooAnj52tFEV
         8UZA==
X-Forwarded-Encrypted: i=1; AL+hErEMyuExQvTdQv0gamXDoLX0JqBtm+y+sXDfmlpHH4qt4iUwaMNlGC+ar5W9ZdYn3zWXzKSzvhg47qZQSFBLsQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9j9q3Rp9Y4UMb9OEs+96wk7OstkUDXkrZ39a/VSa0SGEDL+woH
	l02mOfRSthsJOTuSaT5iejaFnBvGdvZXpBiW0qCjuNXP64Krwz5lHah/
X-Gm-Gg: AYBFou1GKNRxrJeCTq4S1D0fS3McnsCmvXBh5FQccKFjz3zOA2lC3P8ImXaKiFz6wpT
	Zl+ngRAFchXxmfdf4LjfcS0L5SdAtdSNp/qjbUKzBHxea7h0htiVCRL5l8S4wijjsQV1bgIjMd1
	iTerVF8B8tf5wXUYb/V513hScyzewj9gT3MT8yUmeLb3zuEte6ctnKCG3f4Rh7WNy2eJUU1c05D
	CTfSAA3lHSj1FsTKZsmap/9I85H6E5/fET9pMe7VZ0uQ/v4Sdp29vnEn7D698I6ue1KHSPFnjlR
	HLtb2ahpCZRYu/t/Y3SzwdEKIo/UFePyWyVn6yM52kyoO84DSICVOxAIrW/XA2RzLluUe3/hNlU
	/v4kXiZuqG1X016ece4Qz+E69kFogPx/aS0WcVgEB3fBwJ0Me8JhD0KoqS0qRSqBgMbUsH57rJR
	i/OXteQKItQgYMFF4hWWASksOLjx4/ZNxaxjxy/64CHziqNJu+YCG+e86V8/6xhtnQEB0tAZSV0
	/p/uj/eAXdVVlbRblwWErzvDSpuFwtJWCILIQCULxsXRLgePPIBDahZlT06lhta0poV0dPxbciT
	8eZ+I3Q9HQIyLWyovshjJfySySZf+DZF4HPh+gdsl89cKIlbOYbzGKWdqsSRXNI82BRhLl5a1i0
	cnyqju4WZaUtYhHnRno7sIz9wCc1qAY4KfJXeUtDQMsWwraA=
X-Received: by 2002:a05:701b:4244:20b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-1b39fece05cmr4832119c88.19.1794201422928;
        Sun, 08 Nov 2026 21:17:02 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:17:02 -0800 (PST)
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
Subject: [PATCH v22 12/13] ALSA: virtio: prioritize staged capture period work
Date: Mon,  9 Nov 2026 14:16:17 +0900
Message-ID: <20261109051618.22506-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
 
