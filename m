Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247F1AED4C
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103609; cv=none; b=tJ0Kp5Q3EAPMIKA0BTLNy72bYaSZL/VKBbthmsgNupqlBKTMOG0nkpmQYB4l8czp3ALkSEOTylVan9yJmkByF5EO2u1XuaID5FvLh2NZrbxzuH/cI22yvj7qLckJPtS3mbtxjuqwEoUjnLKCW9ZqEu2mRam+M1a/njZJ5gHxIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103609; c=relaxed/simple;
	bh=F1IcreTe4McxAC8/b/Zfr2kSHzGbyrXxRXQZT1N+gnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWsGXoIRddl2F42hMeAWDOdEXCrUoyAnkl6abB5czUgCKJae+t4YTMTl621G/4HnXwH+JyZ3fF/HQ6FJ+Z9WhhZk7CwBDWtSSmO8FBM5/Ft8Wte6YA8NHswzWrTS3qCRRtYMRvCghHeXIUsUFNbfp+S5p/N7/9gOfzYFRuEP3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FwYTYJKU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FwYTYJKU"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso8212591fa.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103605; x=1720708405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=FwYTYJKUuSGszvKOWg7kuK0dFNZ8BizHokyF2C+TrvIztTaiPhmH9TL+EaWDg0DT/y
         ZJwNFT4P1WNVky4j+WLRLihO398G8ek3nstGPOZwWm08KukNa0RZGCuKakMQX8QJpo96
         CZ7HYTSzGVAxC5R/zgesqmyQ7VnhUDOjEKLba6NZMFbpzEWKAdPFjsytGkU/r4+mjaKf
         jY2Rqoe1iZ4tu9VfSJ3UZR7EnfkhKuXenwILQ6FIqVxNl3U9dDwZplnwkM6Fu3I/C3+6
         s3azEpQEU9C+8sMiA+fZZ1BajuK0jiunKFbWcGHpQuB5/Q+75V9PWoECQtqbQ19zkujO
         Ppfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103605; x=1720708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=XjgoNqi5q6FlMjTud/jVpZUlqezEAtkBODt1vJorRKnBRxvLTmXaRwCZPVoXm9+l81
         +/Lvchd38UYavBujGiURouvf6RIZkgRbjte97p0kTeQykreXfq4b2/o9wwHFvuQo/ARh
         Rc93pwgUa/oS8exhxToUCZzmwkywPG6KMIhorQesn8KkWZUaRitHirbh9EhS5aLClsuu
         c8fhFKIAxyKIM7cb8sYVp4OaU2CY1agglrNUpmWIbNppme2+cRnh0JNSAOj0WnMoXF46
         GGCEcXEH5cGm1qyhOT3zbm8Nu2jD9V+G8mQQkEcGC5+eRR35YkSOt7HKAWwFS8WOPu3L
         LXiA==
X-Gm-Message-State: AOJu0Yw/hDA7k44kY/9Iixh5CBxm99sGLUU1+GO5LyCAXVpSi9nP/u7Y
	0wmm6Wah7ZYVYqH5KoY0eHGlTj112Rk1q4gGU7+IKNscM6DWYsVmev+SkkZ9X6cHuPViIuSw6lC
	hU9w=
X-Google-Smtp-Source: AGHT+IHckUxMMUzpEk51UIHJKJnvPhioBardvZXxQJAMzVGTX11NHge0CNQBXxYFt2ipSD58LAbmIA==
X-Received: by 2002:a2e:900f:0:b0:2ee:87ef:825a with SMTP id 38308e7fff4ca-2ee8ee216b0mr13216901fa.53.1720103604804;
        Thu, 04 Jul 2024 07:33:24 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367961a507csm3858358f8f.77.2024.07.04.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 02/19] virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
Date: Thu,  4 Jul 2024 16:32:50 +0200
Message-ID: <20240704143307.1212454-3-jiri@resnulli.us>
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
virtio_find_vqs() to call virtio_find_vqs_ctx() instead of op directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..d19eaf6bafbf 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -225,22 +225,23 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 }
 
 static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
+			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
+				      desc);
 }
 
 static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
+			const char * const names[],
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
-				      desc);
+	return virtio_find_vqs_ctx(vdev, nvqs, vqs, callbacks,
+				   names, NULL, desc);
 }
 
 /**
-- 
2.45.2

