Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC931AC247
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103617; cv=none; b=ZO9obFv6lRGVG23H66cIZS1VFooR2rZAqEDKRsH1Xjw1YH9KXtV1ftmsupDKku9Iok8tlgvE5rdPvz7FDjfyDh6RdQ5Ycp/atJiNaFc6P6RksHJSzymUOHMhXyy44zVuz23W2eBFm1NZUyvC5uaTSdBUlOHXUp1tbM0/SrHg97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103617; c=relaxed/simple;
	bh=Ejlf1kqfgu4Sjr9vD62wFu8Yxljiio3MmUzYjCugIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USUDWTItuAKPBAAmiEZsrDXwOvkLXhkkIp8GJoPTK+9vut2ubT1bRRY4BGM5dkDLoynQreLridEe8Rd2KuKDhruSDwuYG3nq6MY0cgTr+GDwBintDpfFgdY00WExSldUz6/y2mKKyQUtPqTuYCVItt5ZyenvGEn9HJkzFEncupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N65X8W95; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N65X8W95"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f06861ae6so427106f8f.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103613; x=1720708413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=N65X8W95krZkvEziuR3TdOJF3EPqR2Bf4HEC7BR/IXdiMEtq+COyzctnOX/w9/0Jlc
         OilDeCsFEqrCKpbWfEouRorL6g9SF6hzntiUGQTDboHv1chtzpu9mnWTQXCz9SBVJrRR
         Pw8ZftsFjYM/7Ee95OSQkC20yQ+PNn5vqtUFlqFL4LF1BGfDeQkIh2bQwcwuoiEUefq3
         nn/ImXpCdzTX3k/B0q/QRcsCs28oo2Yi4GFBpNOIUWntB03R5Y3i4TTbbE/hJRu60b+S
         6ySfPZY3udDN5M5v2Ys/FDYjWI7GGW/C+qCOg/wAx7KO+0EFpPdmxUXaCrrZwqgnMOw+
         NekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103613; x=1720708413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=HpPtu0P3oOedw3uZnt8/+T3fKPc0hCHWUSxO6kgqfK5tbqoXnEIY+/JEEGu6bfCfyO
         AYeTLxHZs+Q9BVOjjvGscKTiLmk2CJmJdP7yvXGeEev1ZNYtSpVvBf8X5y1d7hGhiQfZ
         RWhXAuOB0gAIk2+tEp1PJRkrHOKJ41OGZ3wpWd/OD6F163nKPnurfUQIsOsfrIvsOAs5
         lw5FvQkg9vCxqdXxJYSTNGhRKLfVqWgnaNQX+o1zmth69ukH9GBeHzQF8gi+hU1LXOWE
         ArBHjIgL6YvTN7aCj6MbsKoqQ8aQ5Pyec9wMCPuk7dbI7Utv2PscI3PpqOYkXzAujeYD
         e7Tw==
X-Gm-Message-State: AOJu0Ywq5jYzAj3W/orrfsvJT53fPtyz3HlwnXtZQziBlVpY3a7mKpvS
	Q2OuhWcz7evHQXYmsOk88v7ahGIdf+onqhLSlQdQ7UoTXdBP2+Y+vIDOFNsabwCmT9YPxE/GeB5
	rmt0=
X-Google-Smtp-Source: AGHT+IEKBm8dWeaO5CFumdv+jCXF4auRGHs4SNzyAdgWLb7fU/xzfYR3ZGuySy2bZHG0iGg2oc3Mlg==
X-Received: by 2002:adf:ef49:0:b0:367:97e2:c5b9 with SMTP id ffacd0b85a97d-3679dd739d4mr1350703f8f.63.1720103613057;
        Thu, 04 Jul 2024 07:33:33 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a112b3f0sm1225841f8f.19.2024.07.04.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:32 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 03/19] virtio: make virtio_find_single_vq() call virtio_find_vqs()
Date: Thu,  4 Jul 2024 16:32:51 +0200
Message-ID: <20240704143307.1212454-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to prepare for conversion of virtio_find_vqs*() arguments, make
virtio_find_single_vq() to call virtio_find_vqs() instead of
op directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d19eaf6bafbf..82a1d798b2f1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -210,20 +210,6 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
-static inline
-struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
-					vq_callback_t *c, const char *n)
-{
-	vq_callback_t *callbacks[] = { c };
-	const char *names[] = { n };
-	struct virtqueue *vq;
-	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL,
-					 NULL);
-	if (err < 0)
-		return ERR_PTR(err);
-	return vq;
-}
-
 static inline
 int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
@@ -244,6 +230,20 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 				   names, NULL, desc);
 }
 
+static inline
+struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
+					vq_callback_t *c, const char *n)
+{
+	vq_callback_t *callbacks[] = { c };
+	const char *names[] = { n };
+	struct virtqueue *vq;
+	int err = virtio_find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+
+	if (err < 0)
+		return ERR_PTR(err);
+	return vq;
+}
+
 /**
  * virtio_synchronize_cbs - synchronize with virtqueue callbacks
  * @dev: the virtio device
-- 
2.45.2

