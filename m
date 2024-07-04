Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC71A08BF
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075451; cv=none; b=MmF1hpzXzxiMPDcC5r79bsBLd5NYY/ThSj6Kz5l36snCnyK0+D7ZNQSvfakgaNaN4iDauYMVR9Wf+az6nehAOlsloJNj4llgFVSY56rDId/g6TrSQ4XatwOmj08n85Sdlvg4gRF7flhatIiZGQkFOy3I+hN6wiUFNi1iYrlEOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075451; c=relaxed/simple;
	bh=8jiRFwPoEZ2vOQtE1J8Wg1j60BIA2GoNZbVzpcXhE7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGg+H3n6vK7wHbiA9ZtoSCGTyZAM9oFCpJVDG94E7ALsx/HzWW7NaMR6LZXOCr2phASmkuP40KjtZQJRb+JUulEou2D8AcYgDtQ+wbUtsAZPj6rpigrOqzwk77NqexMXpRjd4ODlUAdzUfJLROTQkq82nvmnJ95e0UdrWMfJLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0UZWN7tS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0UZWN7tS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-362bc731810so227266f8f.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075448; x=1720680248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhpolTUCsUWJAhNRww/l1e1EkOmycqVodC5huLla9G0=;
        b=0UZWN7tSKDGNPuGzel4ZzJK/xOlHqSNk6Y4WlpNQCYGsq3tf8dExypveKK6eZehdQm
         BdlQsN/EEqbbXb+4ymzPXoOxElpvXD/eIG9QBAnMTyesKLAzYWAvLlNw4wfNecdkkw5K
         C0VhSnO+hxD7+BZcWoF0zaxTfMXXk0GxSr0fYdcKhubZEKx1JbHBzMB92o54Es4Ks1x1
         0FtvMY/yDGlovuIscftlOqIEJNmpCTN+VC88oMnLA1663u+C0K4EtPuDM4NFPzbEriuF
         QlZJxaDY4MkSMw5D/BM5jSwF3YgVSM5w+Nquhc2p79c+wOCM3O8c/TzhraE3PUl1G4be
         ld5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075448; x=1720680248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhpolTUCsUWJAhNRww/l1e1EkOmycqVodC5huLla9G0=;
        b=SySjaqgZODWFNppBRqPzL0dV59D+SxBjxhSKff/HH74TQLNXTJ7H0Fltrrv2Up4XnR
         /YSDPRZAdFvtMTcimVHI5IyATuzxbSyXTzekSbcCdGaEhM5jm2crsAZ+6DfxGXSjFmRA
         Ml1KJlx3XitJkA3tQnaUj2y51DhxpOjzrP5fqub+vs3kfi2dg577rpOGq6x+JhZn/mRm
         /AY0ROR3u8KY37AwZn1Dn7HJO4JW7Eo+VM2KmuDuj5ncVd0xNx5tpNKLjkX6gZQfBndk
         RfSurkKmXP72RZSulBWXSq4qEWhoDMobRQEAxF7CPkqLq5XwKn5+po4p4tW9HakSj3NN
         RrDA==
X-Gm-Message-State: AOJu0YxqQT7yNHraCQ4VA6Pjq41/1/gFnJL4jJjAZy8p0ImuD59u1NFJ
	qP+PaGxBAXs8S+6oS5bpGGJDNfYxmI0NfjUIiMuXxE0vkpGNx0tO6hzWGsZ/HEjhga3G5wyq93H
	m
X-Google-Smtp-Source: AGHT+IEyqGHKKEfJrV2KgIMuAU14u7RRpWfF7n8ja2pFAL6yHt2jXlzHvisVeiGgPURuXRwvpDoFLA==
X-Received: by 2002:a05:6000:1245:b0:367:9903:a91 with SMTP id ffacd0b85a97d-3679dd102b2mr601941f8f.11.1720075448371;
        Wed, 03 Jul 2024 23:44:08 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm17804868f8f.0.2024.07.03.23.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:07 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 07/19] virtio: call virtio_find_vqs_info() from virtio_find_single_vq() directly
Date: Thu,  4 Jul 2024 08:43:38 +0200
Message-ID: <20240704064350.1097716-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since there are no more implementations of find_vqs() op, call
virtio_find_vqs_info() from virtio_find_single_vq() directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 include/linux/virtio_config.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 9b975c2830f6..eabbc28cdd0f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -279,10 +279,11 @@ static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
 {
-	vq_callback_t *callbacks[] = { c };
-	const char *names[] = { n };
+	struct virtqueue_info vqs_info[] = {
+		{ n, c },
+	};
 	struct virtqueue *vq;
-	int err = virtio_find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+	int err = virtio_find_vqs_info(vdev, 1, &vq, vqs_info, NULL);
 
 	if (err < 0)
 		return ERR_PTR(err);
-- 
2.45.2

