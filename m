Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5361B0121
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103659; cv=none; b=scNMj7H0Jl0BlRoFFvLuz+WD9ftgq767VcDrlH8PWxUtNq5ZQEXkeWomyMvYrnjg/a++fm2EzNiCact+uh+58pPtZM4CrGRvBTh4Dsp2OkoyRSu46driLge59fxQD3b0ORQ4Io3Hhha9vpJkxqPjvxxkEC559nulBL2cd2c6JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103659; c=relaxed/simple;
	bh=LoTagj27334PEVm2uZnnPAKRI46dp8/+UIOr8P9j1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eetGRqnhLkxDqHjnzXws+v5422UDtxEyjKHqQwZHZJXhiB1Po0EbQywcMbT1JA6NvOk0gnJIaFDpPa9VZD8JKtyig/lkXOJ1kEr/uRxOYVf45lJ3Xkk2iOpAefQD9ZLWSQmO6V58MdTxtsJ+nQJySM3B1baKAeKuj+dHPta8mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IZOg0Sy5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IZOg0Sy5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a23462e6so274348f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103656; x=1720708456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGLbDU2Wxnhi5/g0YKI0ZvQpGjuefDEKag9AESbm88A=;
        b=IZOg0Sy5B/bRejsX+zoNARzWZVD/+cYRS/tQhcWP0VFPFLpLGPahSo1seAjOSDyTG0
         uc6esUr71bdtOyNLGiromGeU7PxOnkxQcjDydr5U9qSgQtNLtMttpnZmY48mbyqbm22e
         0Tr24e8an/Pv9mJTlQEYPONNpBqFfSVN9N42GKcDjMm7UdSHH3Ap9LjGCwm8bKmFEEkZ
         A0O18M3R9pzbEgO7IqjPWoeIEEjZKaOW2LwHSJiuCSnpO6rgJhv7qicrki0qYEbmH3ZJ
         kR9ksxbDGkv0mG3fNCAE+kiNhSKuwMZOwgzzDUQ9CVC3vnrjpcxl9NW6rkrf6PJTO7JI
         MftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103656; x=1720708456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGLbDU2Wxnhi5/g0YKI0ZvQpGjuefDEKag9AESbm88A=;
        b=s7O6GYKBxMGO59zCwfFn5HESf3EmtrztpIW/HE/eSN7KZTihhNdjcF7uyY1HxtSLui
         vs5lIEzYgdNQrdvv768NL+XpaqH87F5Dtj5OOcqiVIITaT+JlY01VAfT498xlBQTzwDG
         HbE9VByvfestTQNumagN2XMtBJ7Hfrf+lmbfbWojdcdlW4ubi4RAiJUyh+dUkqU9mFuz
         1kBtAaSSfdUGPNfzOo/8xh7lWql5XCBGZRJ1yG/zMSBoZ2q9uFx6vPJu7f7T7DTPepWd
         IkNmabG8iNVfFHxecZwCaeWnAvpE6lgTmVmvj3LOrYNHp+onTZAEa1lBXjhFQ9yOi0Sw
         EILA==
X-Gm-Message-State: AOJu0YyDW7QiQ9BqUk8xanNuBzMO86f8ucepxNzEGfYWYkv0fDfsksgB
	ffbEYM3+c8Zs2Kju+AzWG7+KrVDfQDmjabB8DSCCcfwEqKsoclGeRnhibEvqlRx3yVldH/LD2rK
	46jI=
X-Google-Smtp-Source: AGHT+IFVQ79PEooYCzWpzZBnL2GnDrS4MzCyQ41H8bMi//ddBjrjkqCNmvuE6CIC+Q0KVD9aqnAFBQ==
X-Received: by 2002:a5d:69ce:0:b0:366:ef03:a8a2 with SMTP id ffacd0b85a97d-3679dd66e0dmr1338492f8f.54.1720103655747;
        Thu, 04 Jul 2024 07:34:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679508ff26sm4130034f8f.111.2024.07.04.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 10/19] virtio_blk: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:32:58 +0200
Message-ID: <20240704143307.1212454-11-jiri@resnulli.us>
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
 drivers/block/virtio_blk.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..ca3446503e82 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -964,8 +964,7 @@ static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
 	unsigned short i;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
@@ -1002,28 +1001,26 @@ static int init_vq(struct virtio_blk *vblk)
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
-	callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
+	vqs_info = kcalloc(num_vqs, sizeof(*vqs_info), GFP_KERNEL);
 	vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
-	if (!names || !callbacks || !vqs) {
+	if (!vqs_info || !vqs) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
-		callbacks[i] = virtblk_done;
+		vqs_info[i].callback = virtblk_done;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
-		callbacks[i] = NULL;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -1035,8 +1032,7 @@ static int init_vq(struct virtio_blk *vblk)
 
 out:
 	kfree(vqs);
-	kfree(callbacks);
-	kfree(names);
+	kfree(vqs_info);
 	if (err)
 		kfree(vblk->vqs);
 	return err;
-- 
2.45.2

