Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F2176AC4
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010364; cv=none; b=qUrjK7LHhSURFaUu3ny9nmbSu4F+r+bKcMpuh6JrUHfW5ui/VHsA7V/MqDtUTPqiFlPKWwJXy8HeCBOD/kEwY8LknQYGrxrHgfZvvUGrS/SiSIruj99+GUc+zO7+UFWnsTAklOotbyu1eUqTUP4zOR6fv2xnB0KDitorjK10lPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010364; c=relaxed/simple;
	bh=F1IcreTe4McxAC8/b/Zfr2kSHzGbyrXxRXQZT1N+gnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oawKevQL4s4qBhl5it9g+bxjuPTPAh2Burg/hgGPtkkfR2+ogi5wZFKvRXBDG0P/4Fm3MXvm1MPfTCChpVkBZegVVuq2Mz+sJc+sHvuovb2IbiEg4kq6fXOE0dymjnQHqYkQGKZEyQtsp81oRJY7huf/ui7zLg0Hv00KpUFRLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eTLR5cfd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eTLR5cfd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4256f102e89so36260705e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010360; x=1720615160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=eTLR5cfdlSNgoEfi5q40RocwgmCrF1DL1Jo5Qp4Flvts8iY8za0FTHJaNytKSgitIz
         1iLm9V8SkFo0kuwyk8xI10wD9dPLd6EfHLpUA/pmN8mWj0Czk3JVJ5iUL0r7byQXpz7B
         cmhLaMFZp8d4U+ERgazwFlpLV0hnXbQfFMj6vDLzXfHXCyjAKqzrX9gO76J01D6Ql6U5
         PshOV+9PWTrrgpYIF6EUfPCuCjwpe2L0oBpAMRoNT4Ns3hpRNOD21KL4efr0aOH4cTF5
         x8w1cIfJxR3b/Syo1l3ODEsBtlE9acIeTRpl+OWXaaafsvmK/OKVgWBu7aFu/c7jOuMy
         36qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010360; x=1720615160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=S5mI5w/X9OP0kdvNmwgQ3BwttB4TAhWQPFEdcHSDsFR3clVcp53QnLnkE/iC+fi2fC
         2FWk3ApjlwF4jiex1NSlqveQyayHYG1J6tbG6V1tI83FjPhKUiE47Izv2K/LxKft1ktM
         lsz7W2F2KCJtrUcOuTtVlPYPebBhuA1ECxIycE/dzg3iKWKCjor9u6Ckg/xt6w1ntAN9
         onsDIPQnwhjBQW+mJIfOrwvX7RB7xB7m9ekenoRBfqevUY9vtAlGdIZnxsiPtrVQjTpK
         APJtUHR3hCFwbePoeuc9gJb1CaoOrJa5piHhgfB1uZAEP+2y6FB8DlU9DvxdDFNP61Xc
         uQhA==
X-Gm-Message-State: AOJu0YzLsnei6q+Q6f3ZYiJ1wynP5JZVdhpA8JKJoIqN0gaYRqAgCeGk
	EycMZxxMwm0VIq1wdRB3Xiac/6nvd8MLCMs4lzwzv72KU9jgiRQJ/fy8rXMqFEwttxE0bffVm+x
	D
X-Google-Smtp-Source: AGHT+IGJfJvZgmVT4x7jhK6a4FhF0OMtCGKct71IbYGuVNXZWpaPYzpWorA6NyJZHiDXBynFlt//Xg==
X-Received: by 2002:a05:600c:6a8d:b0:425:6f85:600c with SMTP id 5b1f17b1804b1-4257a00d0e5mr77462845e9.11.1720010360585;
        Wed, 03 Jul 2024 05:39:20 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3912asm245077335e9.10.2024.07.03.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 02/19] virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
Date: Wed,  3 Jul 2024 14:38:56 +0200
Message-ID: <20240703123913.969202-3-jiri@resnulli.us>
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

