Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CD17625D
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010394; cv=none; b=Nzu4aX5UFv5KUQtgQZArsdduqgpUjRVG4ezr6T3PMw2JNnSLLu8DoP8GKz7Y8FBA9Qm7/q7WDoXHOoxRdQWCGNqWN+4oJOWQ8x/1BtWUYxIoywaNCCywEBaOfEfWJ1/8IWfhJxj8ItdYVK/4fatGxcHyOhufHGtIf+HAyUCi1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010394; c=relaxed/simple;
	bh=vIk+4i3ncgamYeLSUVoQB96BoiQejXKSaXEEbypuAVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rErK6Dxz42cKg+EYeo6qss1urwefgUfRMQFDsO1NcKHzJBlyXXqIqNgVSr8lF3SurkPH4Hdcfc0jHzNsqkUpUQqAKPK4Wxsp9stFUG/uA1A+ZQ2cnjEm2QOqzcV6H/fwpTp66T7wvCKY9aC8dEvfBOBROz2fnQIK5U4+N23KW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=owxSqgTR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="owxSqgTR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso41402335e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010391; x=1720615191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwBH8AOPDq68l9erqe4YumRZVVLVK18ysMfv47uVpds=;
        b=owxSqgTRsPazpOhTaSe2FBTZLeE4iLrgtiH/S69BqUfT4+i4GVRaKYgl7c9vB/zPcf
         whYVJdxixFbkOji3NuhixKvDVsaAM9vEza9e9snIdGdNv1ek1jPwo+P7E8KkFnqVLIuT
         jKy25yEPNVfVGXV49T3vObzG6tUSnUgnbNEKfIHyKINuPlvlJcPFvLOEcpJtRSmNzItl
         ZzW+TJ+Pmcj94HZwoe0faOyNo/exg6f7QeUgP0DZUTRvNYlcHCc7QBpRM9zaTJmt5VRP
         kgCVDTJZsxl+3d517Ig9BzGj9uwS7/Wno15VEncseGsRwlidTB6ilXCZ2jEY31knedhh
         74ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010391; x=1720615191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwBH8AOPDq68l9erqe4YumRZVVLVK18ysMfv47uVpds=;
        b=s6fUUlz6I43Y4/puyQeQYmouqxZ4/ZSSBwG8UVy0g2S2gPj5CxCwLABHqFL/Dxizz4
         1So+ioY+UgqRQN0QiVz4bq1XRFNmACZIrstPDTU+B27rVlqdXtvCgeYvOC5T0fUZ3cwK
         z3/y6O+lRh+MPiWyRxwxcHbdxp+aqzjUyt2lZBUpnwIqZg+VGZPDi8CXh26GlAhwetih
         aaDwmFV5zuqcAvuAfakeT5ITeRRnmDSohY9I1AEM/FQE9OZpBKED49cTH+zO8UChv+08
         bwq9tIs3nOCMhJRqp4YzJEW/AmzqDXp2pud96xzU++SO1B4JKMS7lsqrNskXfB7LwT+A
         EWvA==
X-Gm-Message-State: AOJu0YzikOQfnrGae23SMNGkWkWHWzA5eeJZJHW2GFJlQHKOpWtrvH5V
	DoBBHwnBKk6D+nGKreSslqGjbN+ARKdU9TxLmz0B8Qkd8ReteZwyWLvWTHwp7Bnegtmstbievwu
	F
X-Google-Smtp-Source: AGHT+IF18GQY+QYgS7iNQDydm+Ftt6HpumS5Gg1TIe2rOWeB+91GFGrSh2ZIWuCyvdYGA1TFfqF/eA==
X-Received: by 2002:a05:600c:4213:b0:424:8fe1:41f9 with SMTP id 5b1f17b1804b1-4257a02b772mr79639475e9.11.1720010390920;
        Wed, 03 Jul 2024 05:39:50 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm235070515e9.39.2024.07.03.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:50 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 12/19] virtio_crypto: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:06 +0200
Message-ID: <20240703123913.969202-13-jiri@resnulli.us>
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

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 31 +++++++++-------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 30cd040aa03b..800d5c2a688c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -96,11 +96,10 @@ static void virtcrypto_dataq_callback(struct virtqueue *vq)
 
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 {
-	vq_callback_t **callbacks;
+	struct virtio_queue_info *vqs_info;
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

