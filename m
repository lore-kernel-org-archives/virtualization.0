Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F234AAE9
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125434; cv=none; b=kfIFz1ZwQx7YDpiAJKBHALRZg7VU8MB4505nlar5GVOMonEA3QWRrnA8TSwYG8iK8+NxHJVv8bYC71dwytKmJKSfrPgVUlmOb5VmfdnnBg56z/lKaUU1TwJWdPkDrbsVwLrh6CwpGIJ8ubpIiZ0ygcOL550uU3uIr3K31kxYEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125434; c=relaxed/simple;
	bh=p/A+hyd8Czmzv+d6bee7JEW5kyJdrX0FwFb3c+j1AQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqMFOFvLe1DAhNp9qnA11OwhNVVaZPVnw/fMSB+EQJKtJwXcsLIhy/xeSwJ8ieA4Ze6Ax+1xhtj2oLunbfoJ8hV9skicgYUyia97k7Ty+VOJMDFt+rHHeZeYimXmsPAI09HHbsDhFwNSH7z2rBN6ZCfSwLmCYKAp0Q3fnf7Ul7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYr3sTAQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYr3sTAQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c12614b81c9so1022576866b.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125430; x=1784730230; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3M40eRQW8Z0pMjSw8FZJIlwcW2HMM9RvErrQLP04DY=;
        b=qYr3sTAQa+lHajUv5IGGnXonxQikbxQLrTdqrF2yMkBcz8Ux1hxmGNKXmX0bCpJTYG
         /eOxx/3FqPFpFOe3h6Z03V22izbqSVDlVSLIZiarBEaGw0yJ9/HlUE5e2r5/ufBiKuOI
         LrQUXl3k4AvPM8+BfXpCylrWoXuk/TL9bTjPvqn9ewa43II4GWhBD4kRfTkym1A+TvOM
         8+HzDsXBXUa1ZMlB5C/zX0WHMEhn8ant/iH124aNFIblN+hN5pLlBQU0JW6GYZCHjAan
         yrz6+Yjo4awHrVwd96s52f3iiDfCatKPXsFHV1Uq5CIkMXcCrARgD3FBFhMc5H8Qqh4S
         BHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125430; x=1784730230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3M40eRQW8Z0pMjSw8FZJIlwcW2HMM9RvErrQLP04DY=;
        b=gmZMsKzymRkmBBS6vXT5TJoYJEGkiHchkt+X53t7PkOrrFXTCMoACqD2TO3x8cZKPT
         V+LRE5EHH5crY7XQP7+sgaJLsBFp2nx/N5BwBVdLIvuUlOuVcicj7lyOmNMN/4zWlp3a
         yRy5pavOSuBQFURpDoJfWtweWN6GQQg5QMzOeWdrjl7Ao3Ha6yplY2MLDebT3O+aBEcV
         UYAPbyb8+QvNpDEflsDcYnDNFY6wuEmGWEVgz1m9Y2LFLxlFjiEqqfoneqGTLJY+lf5V
         wOoUIvlWgQ5gDBd9G5gElJMvvdTG12cucwTVoTugUaA1CeeaR/agi61Kf5BESagIDUYL
         ndwg==
X-Forwarded-Encrypted: i=1; AHgh+RpUVDVK64p74dhjsNgMyWEdc+Iyn2g+p1aqxNe9Ej3aUHjWbbti8Ybyn+bWTakRG9DwXL+RdatvWddDG1zWvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOfUDwhZTUtCi7hgOBmi/WM0aeO6gxRxgwHIkwEShPgoWTi4YE
	Ho1mABW7AUXRgQFSAfVsVpXt/jp6Bz24ZsPGvLExWwptGNr0ac4x4O2F
X-Gm-Gg: AfdE7cm4t7LXgFBgYUXEpwyhgpsYv4AvAxd0/+uuVs8XNbfBU6b1g+TUhI+JD3aag4i
	LO2ESp8wTdTDGOQo6JKYnGNtuE8pPXaSlPzwVM0/vcfqFrMe7ARg6F5lxh4jhUDb8jpdUcwlG1G
	4T1/I37m6rVMhAqigTrqUMUiRBPOBvGswW5yP293o5J4Wq8pRWsdfiXfYAwi1sdACgDcYLEC/7h
	mit1lBUBNJlELYHJ5khVqyAskn7p6fwiRb1AvfqPPE/O3TH7m5IcRwB7bUifbN2fNm5vTXkdk4Z
	hz4rvdPQcmEyGFmEQhxUiTy82Be9qwBK74t+WlEq8QfJa9/ZgRA8m4TLGMPFfKwOjIoUDXboxJ8
	IYmOqMnhGgn+8jPFkCFuumJ93D2DgGnpPNW0/9esddaDAvFffk+o+vWZbPdWqteYujcbAISwM34
	hvzxh38g0vNRajqMV8u4Mk2pHrC9bgM53E+Rl7bj/79m5Lo44vuSJh7bUpchP09ZXlVO6bk8oUZ
	bTe
X-Received: by 2002:a17:907:d16:b0:c15:bc2d:e938 with SMTP id a640c23a62f3a-c16792a5887mr227159666b.32.1784125429946;
        Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 2/4] virtio_input: validate device-reported multitouch slot count
Date: Wed, 15 Jul 2026 16:22:41 +0200
Message-ID: <20260715142337.22811-3-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nslots is derived from the ABS_MT_SLOT maximum reported by the
virtio device. A device could report a bogus maximum (e.g. -1)
making nslots = 0, which input_mt_init_slots() does not reject;
it returns success without allocating any slot storage, silently
leaving the device registered as multitouch capable with no
backing state. Reject non-positive slot counts before calling
input_mt_init_slots().

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..2cc19782cdd3 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -312,6 +312,10 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
 			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
+			if (nslots <= 0) {
+				err = -EINVAL;
+				goto err_mt_init_slots;
+			}
 			err = input_mt_init_slots(vi->idev, nslots, 0);
 			if (err)
 				goto err_mt_init_slots;
-- 
2.43.0

