Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277E30F52B
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773457592; cv=none; b=k9wdy2zEgxb6m5Vmz8xMB5Q3dUXWxugVqpbQScJBcm/rr+4KWjEZed/9FdFH6P4Yxjk7TF3eDL9UoHbINyn1Kj5UGRO9An5BUeDe19rjgL2L4A3a2iu2yZGsvwSFA++74tcBDKYIyUa8SImvvySEE++LKIp12nd2XrW14XsgWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773457592; c=relaxed/simple;
	bh=JsCdI1j27/Q008Y0RmTqKbhlwiwYDL29o+1VwGYzKdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7+EOUKwOj7Ri7ve0D2Qbfy6AnAGDs9PcmYRwxzeHogDgo0OsbviN33P/sy/7rD5WsBt8tOiLeFLIjqaPV8KJRyQSHVh/J2uHlU7xXeCCU65al8C6+Ba6cCWa7hiBxi7KUjlXtaEXVfYqnGrrOTh8+bYObSmQ8XX0z5utYlYeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=H/Y8p9Pi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="H/Y8p9Pi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829865a8471so2671486b3a.3
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1773457589; x=1774062389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ldpGN4CH7HTJ/1fz9XHIFnVyO2fAyaEcw1ZFiYgdj0=;
        b=H/Y8p9PieEVzUoJySmUa7MT7SMzb12x39451pM+EX3eaIkq795hzI0gBYxnWV4pmDY
         LJrY7gBwj+haGy2YFNKEz364qv56BtpDzd4auD+0v/f0ez2I8UcjBTMTptpLm5Ie6oW1
         jW+1UVHHBiZ1zcQ/LtBjYHVh7DhdxV4DevAzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773457589; x=1774062389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ldpGN4CH7HTJ/1fz9XHIFnVyO2fAyaEcw1ZFiYgdj0=;
        b=TaUS4wwdHcW7R2uo5ksH1nqpJT1IqNJwUzWFEYKRLnltyew0gnZjs5xH/hGm7+KOC4
         Hy9VHEy1IR5lYvJVKWdTw7Fj6rWT3lWn0mlTuB8iaOR7Sm7S//RGT1y0spjGBMw7kBHQ
         xIYCoXVzIdKf8UMV+P+Ajua9cwksuMQtVPOSkpwEyZboX21Eljse5BAxtNjJ6JyGVGrd
         R3qhAAMjrV6Psd8l4taS6Z5K+gVdkYxL94oH/Bh3sDgp1gNUPvEjYIP+KsYbz9L3GsK+
         eyT1WU8+1ANtnBuupnr13aZuokCgviUuLsnExKzHtZhw2SjpiwzK87gboSuEpC8q1KRE
         uLrw==
X-Gm-Message-State: AOJu0YxNlv319P2HU+f1t36ChT1LgSy8S/rUKfrCJhYULwCvypwmKLsr
	CYTTZeZ7GCDUa+UPcb8JVq5J6MAM+ru3y7/vc9DJfykg+X/9/obMTz8Zso4BsN10nH4=
X-Gm-Gg: ATEYQzyRrt3ySvCU1XW6XSI1MuBqxMmdrWVcTf6YOr6ykgu22H3QdtFp3d6AMdP134+
	R8ErvHlNijm2Kd1ahh60PzHhrAZksw94a4ksi7Y2TDLI7JEE6fLmvnnkIicKz6ZAHkqUHVfVFdR
	6mFbIW6sEZ37sdIHlLoywmhCMWZiyKtSQc1TLYPvvDLClhz1SirZWuRRPdb69grlpezc6tM+K9x
	7HCyz2QpaAeMkvHd25bxPoV/Lbq63o8DsU2IQCk72BmlKWVnXKjeSmU4zRE1XbMBaEv516JMfHH
	gCga/N56XcTjmk7an/gXMp25kmEgRt9qAcg4HRuWVGMM92tuLvJmvrZC5ykpVyscc7mvdQLEH6T
	c5UwD9E3qfF8TCAQ2hBBvIYawNne+vg6ZCuuIA31f9qd3/7ik0JQLhQ3xfAGYdi56hXfruAu301
	H44fFye1cmHypOfT3CF+UqS1KViGuqX2nViSodQt0YnrZv4cCB5DkTfreY/WXmVZPZSY66l9qci
	j2Xkp6U75E7xMA9
X-Received: by 2002:a05:6a00:1586:b0:81a:857b:f944 with SMTP id d2e1a72fcca58-82a19866231mr4000648b3a.26.1773457588857;
        Fri, 13 Mar 2026 20:06:28 -0700 (PDT)
Received: from kinako.work.home.arpa (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a13a2f2d6sm8630734b3a.9.2026.03.13.20.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:06:27 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	arnd@kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH 0/2] Allow virtio-mmio to work on m68k nommu 68000
Date: Sat, 14 Mar 2026 12:06:09 +0900
Message-ID: <20260314030612.1949420-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- First patch just cleans up sizeof usage so that checkpatch complains
  less about the second patch.

- Second patch replaces uses of readl()/writel() with raw io access +
  explict endian conversion to avoid getting the wrong values where
  readl()/writel() are abnormal like m68k nommu for non-coldfire.

Tested on QEMU + patches to make a 68000 virt machine possible.

Daniel Palmer (2):
  virtio-mmio: Replace sizeof x with sizeof(x)
  virtio-mmio: Use raw io accessors to avoid arch issues

 drivers/virtio/virtio_mmio.c | 140 ++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 66 deletions(-)

-- 
2.51.0

