Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B81B010A
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103670; cv=none; b=lhW0WQBPuFU27b70ChDgFI6b7Gv9S265xiu1vbWf5GDZn48tUVqM98flLkmDJic5GYsKIjRlfu9UsRGoU7+VltBuz5gniSiTlA/M++gsmrmiljxpZzyOP0ikpUdDZr70I15U0iFQ/xhF18T/UvjYjZpSViWFOtGf43SdzbQRME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103670; c=relaxed/simple;
	bh=L/3en0bkvOysInXLFUAmmljOLApUNUuJ0gjHrjskSC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE/k1cCjaurRf1jNOhfT30R7g4eswczHmjgRhGnFyueauwvQMgwMBkoouOOkcqwUroF1jaIyszHZT1g+94zuOyPCdZBLL9l3tAixTZw4EXnXelgKH9QyJKr2e+Oob+s5yfwNbY5T84qijrw7mfQKyfWDdfu4rYPK2C7ynQHvzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BU0Xh7Yl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BU0Xh7Yl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367818349a0so411203f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103667; x=1720708467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqVaCC9DZgHd9nT60tI2Q6fo236s+2BQRfq0WTkR1tQ=;
        b=BU0Xh7Yl8hrmOV/WsafYSMbRjkq1wl+EEZ5ehmh5UsjEhmpYsk75BbPuswE3hXyJh2
         B44O09v11XCnf7kBqwG5TIffTYcDMDPgU0W3ynmbtmx5eWe8+0Rg2RVTJZLl5HDW4wjI
         /DJ1y1qlpDZRqH0rROdVuUD1K6U7vh8SczqwJE0AWUy1uHF0iDw1l81XghSnPZnjXagN
         VH4zIijKx2kQD//mojsEelG3pBi9D23Sx0gnhP5lRJG+Ol64sh09Q5kZN9R1gTxkPK4N
         mYUM8l6RhWDXUkehplIO0XqxR9VSLasnbZ7vYgPmaW3oI+paFKXtPFn4uwSq59ut6NeS
         kqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103667; x=1720708467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqVaCC9DZgHd9nT60tI2Q6fo236s+2BQRfq0WTkR1tQ=;
        b=F81HDfb5+HFJZ50/tLfHHkiklqftBXO3FjkI9vBdCVB0ssMHxxFpD+tznWfglys00H
         nLYxSM3yHYdp+f0f0VArkmI4vk8WAOODey0InrNVyXkxQGAHX8zWV7ill70KZfSD3pYD
         JOROLUiDMM2pOQOGPbU5eBfq99j3HWnPBXD49zhZLiKifPpEIuvnrY+nbt2AoURqiuPi
         iH5x84XaP/fdtkU2pY7eB8H417LsT3keQDMWH7QqFMNw3eQLYDMNbuzClcDrohN9yKeB
         l5vLKbFN9Wl1ZHR97QC9UTovhj2OyqiaRMHFYbJOTmmWi/DCzY+DeQv70XkmbBTil+zx
         2MMQ==
X-Gm-Message-State: AOJu0YwWh+TqY+0RXqsqY8C5/x+8MGOCnj6hk1GKWCTpKQxZj/ysZ9pd
	xJbwuYZr9YOg6Uz5MkltJm6S0E/UR9VaqGT3UF8D75i2gPzWTztm1DMnfuFOehkRkQJWtoQ/pWL
	2p3k=
X-Google-Smtp-Source: AGHT+IHJdBRjA0iO46byuVcOB1yfiDYpsv455A7sjjb21hiF3uipYXto/6lTTuLawQZ2aPGFCQXguQ==
X-Received: by 2002:a5d:4147:0:b0:355:143:b5f5 with SMTP id ffacd0b85a97d-3679dd73996mr1246077f8f.64.1720103667201;
        Thu, 04 Jul 2024 07:34:27 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a54f237bsm61234f8f.16.2024.07.04.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 12/19] virtio_crypto: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:00 +0200
Message-ID: <20240704143307.1212454-13-jiri@resnulli.us>
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

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/crypto/virtio/virtio_crypto_core.c | 31 +++++++++-------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 30cd040aa03b..b8119d1f9931 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -96,11 +96,10 @@ static void virtcrypto_dataq_callback(struct virtqueue *vq)
 
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 {
-	vq_callback_t **callbacks;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	int ret = -ENOMEM;
 	int i, total_vqs;
-	const char **names;
 	struct device *dev = &vi->vdev->dev;
 
 	/*
@@ -114,26 +113,23 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs)
 		goto err_vq;
-	callbacks = kcalloc(total_vqs, sizeof(*callbacks), GFP_KERNEL);
-	if (!callbacks)
-		goto err_callback;
-	names = kcalloc(total_vqs, sizeof(*names), GFP_KERNEL);
-	if (!names)
-		goto err_names;
+	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs_info)
+		goto err_vqs_info;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
-	names[total_vqs - 1] = "controlq";
+	vqs_info[total_vqs - 1].callback = virtcrypto_ctrlq_callback;
+	vqs_info[total_vqs - 1].name = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
 	for (i = 0; i < vi->max_data_queues; i++) {
-		callbacks[i] = virtcrypto_dataq_callback;
+		vqs_info[i].callback = virtcrypto_dataq_callback;
 		snprintf(vi->data_vq[i].name, sizeof(vi->data_vq[i].name),
 				"dataq.%d", i);
-		names[i] = vi->data_vq[i].name;
+		vqs_info[i].name = vi->data_vq[i].name;
 	}
 
-	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
@@ -153,18 +149,15 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 				(unsigned long)&vi->data_vq[i]);
 	}
 
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return 0;
 
 err_engine:
 err_find:
-	kfree(names);
-err_names:
-	kfree(callbacks);
-err_callback:
+	kfree(vqs_info);
+err_vqs_info:
 	kfree(vqs);
 err_vq:
 	return ret;
-- 
2.45.2

