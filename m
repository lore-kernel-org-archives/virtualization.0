Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B7178CE8
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010390; cv=none; b=YOYUIuvcmIdk/HoHw+f+RkNCtP3cIPTlc2bcr713pW8dmfDvxZepLQOd+Qm6ywC9RoGfxyTPZw6EOpBNauxwZhR9mlEEOYkpLSRubURDVPCa8zkmZSp4Nq42ww2wH/ecj6CcTrXhkBGqX6KYLVnJxUTsD7ZMQtuNXLvhXyHhRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010390; c=relaxed/simple;
	bh=2DENUfQJfY66i5F5JVC+R8bImucoD4aouJvaVY5N53Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jar/lZdXNHAF4gWucWpwH6u7kviIrRzqMIDX/BsvLgcmjZ0hPErmdiGxXLDROKTOeL7qOf8KS+LjBDZqcU7l2nTu7f86Sh+UJOpi21hcy9UBoU9aACzmVbcjDTWw6DKmG1BxHgrKi1Cu2U/ydMCvQ2roOi4wMmheEnZsRYED6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MRVWjAaR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MRVWjAaR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so37350715e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010387; x=1720615187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcOPJRQu7kUXDnrFgVqwafEkeMWZopxun4M2LgfNDlo=;
        b=MRVWjAaRjAqXaA2/BKwl/9b8/JVhwVOml8zPeq4eMLzhDzUkghlx0c4CflmiePIMlz
         yMisjOEwExxbupGUp814R9qBQo+ZB/mkvqZaoPZqC5NnWeYWVgNErwLCtpqC70DHQ8qN
         c6ESV3NllKU51/TdRs55AYfGk9MrHibTa7nGFJuruAPTdAQ3DWLPf4u41ZOze4RT3Rs0
         +Qp4Dk6U8ryxFV/OF2+faTPt+ePtCCPT7xov3qT59DU4AVXrr/cXgRWJZ2ft1OFIW5vZ
         ylpQ9RhgTHrfvz7cF0s0Svqt+dkl7YHpE6wgpLUeaf3utlrC+R73cDFzVDJTzn5wXdkt
         KwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010387; x=1720615187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcOPJRQu7kUXDnrFgVqwafEkeMWZopxun4M2LgfNDlo=;
        b=P/Hau8J57Fl7Nx/9enLqXT+RJA8au5OfAwNrFMJkGLnoIhKAuIuxyI8yxSKZS2xpwe
         mQnBW+zrd2l1DLEUaqDDTxuimJUwjrUmPKk1NOvvlvmBQHCAFg04kwoGYUZjVIzetbK7
         UpMZqHi1LrP7DrWzC4qLfivhYifZW4LPCodw91Rgto4fELQhm03IJJdX5f5F3nbxNWJV
         R35ycp6NuUejrKTgBaNtBbVOoYc5G/GUwvnFcO7BecBIZxkA0hllAiM9qwQ/0Ek3APra
         ZCnWXbxL+nceAkDc6cOE93t/G0p/uYjdY7mR4rRRVHsf9z/zAmz2mC5JJfvouX4c+Zv6
         0rBg==
X-Gm-Message-State: AOJu0Yym6ax6Ynt13NnziVyJEDHzU3F6f28ehVUTW5Z7X6LZq7cahcz8
	6i6BPnJNlDGH7qG0sQwB8Z6QpkEe84B96yK3rrksHHx4qj502i8XpSMGE6ZRBHuHt6VEI/fHZCA
	8
X-Google-Smtp-Source: AGHT+IF+8jlPoKz67KNi0FiUZLqeeGGf8aXzpOd05Iz6eb7FvOcK2KEu5HQBubz9GfKqg9zJBsO6+w==
X-Received: by 2002:a05:600c:4a16:b0:424:a779:b5c1 with SMTP id 5b1f17b1804b1-4257a0114a9mr77966995e9.20.1720010386860;
        Wed, 03 Jul 2024 05:39:46 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b099c72sm236961785e9.37.2024.07.03.05.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:46 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 10/19] virtio_blk: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:04 +0200
Message-ID: <20240703123913.969202-11-jiri@resnulli.us>
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
 drivers/block/virtio_blk.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 46bdbad1ab48..574498280dee 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -964,8 +964,7 @@ static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
 	unsigned short i;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtio_queue_info *vqs_info;
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

