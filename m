Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297717625D
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010376; cv=none; b=bZMXAnYWz60DgZpPGSt4d2rVzHMZS5bRnnyQnTcE0rJf7moqN0Z560Ezd36fGc1MHr4gsWriztS/weKxryIB1g0vBtjZy7p12iKsNmlo1hu+9Q2kP84+lnOLA9zeTrzU9ho8U3Ly3tO1VNL23nJHTMM5KcmJ2L4I4UEcHIMiutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010376; c=relaxed/simple;
	bh=Ejlf1kqfgu4Sjr9vD62wFu8Yxljiio3MmUzYjCugIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbnYqLNHMqZe1QbazZs95MGQjd6aPWBo7/KDzrf7dZbb0DYnEELIOJE93FrKsYA747x+Ccs6fVNxMwa/jTGlqTD+YzU6/4Io1VPAJ4AJI8+QDutd0VB0hbq1bbgBPZEc5sYUrHn2j7UHIYVLQpj7YT+4ZXcQOAeRAZj5uTPuwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iVVXrKMa; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iVVXrKMa"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so54956661fa.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010373; x=1720615173; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=iVVXrKMaUSW8ZSkIRMclbzniA1J9Q3Ht3FtrpyVtQnaFXxhbE6YAXcq/mC1AnwLnEA
         Fx6wVmeY6R/FgQb4MgufozTDATYpR7IHGYeprx9eQX312OpCVkplJJoeWhiOkUS4rDiu
         5CjHAb72ucur0ub+U15Ohx0DmU27F9vvy/W0g0/f5b4QmD/og7nVdOkVU5XNP798Cetj
         rCVPHpVuo3wIZJn2BydC0g0ToKCaOfWmdvKBxDoGhxLiXvOUJTkxbPZR2AcEcsvW/63E
         JJPje9QIeZT1GxsrIViwvbyANz69nknO7NMRQeYTETNPF1yjtkJtLURBhZYECKSZ8oPO
         7MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010373; x=1720615173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=b9hdu0BnT/P2Talvhb6/6o6ZNWwRodA8dmz0//twYlsgKqkQVQN59unrOqF65QRH+S
         bjJLFGhEYC1swcGOysC+A+pD6T+HsmY7RCk8uC0uFzhe8nrVRY/+lH9vOsbxVqxWLoaq
         NlfL/lIKDqRJ+GyDABYV3BRSnbxTpyb1qj678ypOkVbRsEDOjN8JGUGkB4rZXlBprBS9
         C+Mhre7kXIfmvrm+6cfyvFB79WKBqR7aH4KwLgV8tCk5KNKxtuW8scxBnlDUqPpVA6i0
         +QvRHKYfexXjFWEe9asV3MEL4if8g6G3g5Q29/RcbtnluZuhTis5hxTyJaj7uG9v6xwB
         wCVg==
X-Gm-Message-State: AOJu0YwF5ZUZp80fXZDi7VPrCaGrAa/BvtA7+8MK7Z8/hI4DtbD4RlPg
	UQ8Dpppr5wSyKKp3n4O16X7mQS2cMki8wdaB20JofUlzfDWsfepTck7En9kcWoyDR1DkNBG85dg
	l
X-Google-Smtp-Source: AGHT+IEad2UhjQshggDJVDFGFOGjme3UxlBS62ckEB8qXnMoyvmDWzV1LBpxlz1lEYOaIcIArGbnmA==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78275171fa.47.1720010362847;
        Wed, 03 Jul 2024 05:39:22 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a648dd3sm3830419f8f.89.2024.07.03.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 03/19] virtio: make virtio_find_single_vq() call virtio_find_vqs()
Date: Wed,  3 Jul 2024 14:38:57 +0200
Message-ID: <20240703123913.969202-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
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

