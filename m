Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AA17625D
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010400; cv=none; b=SFIV3R5t9KYEO6JuEurbNsQVdP69DEpsoE59r9uidG+wmOasfTT+PlSsnG2UvSxZG4C+cuQWPi3rXC/OLB6wYb21Yc2/NI6DsPOrHF8gdkqDEQbT4o3J8I1gpBbnHdb4MH/mpN1vYyvWV2rrmHXmhocomy9ZROqlaFlBPF69QmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010400; c=relaxed/simple;
	bh=UunuH/VJccmHa90s0btxrNYGhAq73Va8gBHNjHRJem0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMYfc1Z1WF08k7mUv6aagq9+WvROmbSV8xhrwb0tpPyzQso9drXw0TH3WOp1fEPxkE1Z6/6WZVsL7stX+EitCBs2JqAxy5oTQewyqeXK0IdEcvA3YGfXr/FkKnlL+uNPbXs8MRUDVnZwnFvDOMUmsd8gUMhMFt3J5uRGo5N5j20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OLL9pc2o; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OLL9pc2o"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3636c572257so3823058f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010397; x=1720615197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eOdI3FpzFCez01lo9LaoWc9JuPythni1VQDb5E38wE=;
        b=OLL9pc2oAJXmHlWIsQaqR9i9BVLEOab3K97GBCwiWjLgk8Mnjtu9Zh7GIcQxYH0rmC
         ahmW+rUa89SC/dw5LVR+cs/V+EtvJv5cwTPrrOpvpT6oezhdDzCdskdYY/Ltr6/Cjb0z
         /RKf8r5JdpY7hdHTQqYPVlcusKI7hCMhBOXXMP8RAj1Q5hmIMnVpQO5RuqhluamfGu6S
         H/6AJNatvsbht3zI/GhsMzBx817AOZCElo00bzRUHHD32Xq+SuznEWzQGRgxFt9LspRX
         /zqZHWVhb/0gd7nKRUOK6QOCF4C2LQUhvJOGieGx9sGxGqLx5cj16fe6dy0L6Q+vDjeA
         udEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010397; x=1720615197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eOdI3FpzFCez01lo9LaoWc9JuPythni1VQDb5E38wE=;
        b=R07vyiFipenB9nIqyxzIOm6gTC9fw81GlL6DLXhvF6EdIpXZ7vxM2jf0xinnSBgZqh
         d9MkgffxuqhA282ntOjVaSZ5mfSqPHBR/cCWfc9TBWdJKPrFhBnh2LKO4TJpUdkO5+LA
         gD0FDtAPHJZWz7D9UuvGinfH5EIEb7P2CLnsXDYeOPHhbwgLxbrezyUTLEVJF/FVo0Bj
         v9RN++RnBBbJtIcSnWBT3+LEJc+E8y4Gl+YA8KiL7wAVq2zQctzBhDg6US4h30E00bhH
         GpGOH45cq9iOf4RZGkPdbk6GXXC0aFD5Z4VpxjTGbzjKvQtswtno8gd0uH6VGdnG0ZbN
         G2+g==
X-Gm-Message-State: AOJu0Yxz63UaaSya7bEl4kf7wkDi7dLpCy+SE+hygL/4zi2qYmosBoSh
	J+XHaI0wxM4rzN6n8XWVItBqnbqIlJAURMp3uWai3ltzHPoWb4f+rXonXOYJgnRHZQclLm4bvu6
	P
X-Google-Smtp-Source: AGHT+IEkUu3wZkDhQ+t2wuhJlaVrwLZZJCA/lh2hrPUlosZnEI+cQ7n3Y0xNuc+doPVM5Vj9KDoXqQ==
X-Received: by 2002:a5d:4044:0:b0:367:94b8:1dfd with SMTP id ffacd0b85a97d-36794b8209fmr1251670f8f.46.1720010397289;
        Wed, 03 Jul 2024 05:39:57 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm2609817f8f.61.2024.07.03.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 15/19] virtiofs: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:09 +0200
Message-ID: <20240703123913.969202-16-jiri@resnulli.us>
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
 fs/fuse/virtio_fs.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ca7b64f9c3c7..466d4888d664 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -740,9 +740,8 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
 static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 			       struct virtio_fs *fs)
 {
+	struct virtio_queue_info *vqs_info;
 	struct virtqueue **vqs;
-	vq_callback_t **callbacks;
-	const char **names;
 	unsigned int i;
 	int ret = 0;
 
@@ -757,18 +756,16 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		return -ENOMEM;
 
 	vqs = kmalloc_array(fs->nvqs, sizeof(vqs[VQ_HIPRIO]), GFP_KERNEL);
-	callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
-					GFP_KERNEL);
-	names = kmalloc_array(fs->nvqs, sizeof(names[VQ_HIPRIO]), GFP_KERNEL);
-	if (!vqs || !callbacks || !names) {
+	vqs_info = kcalloc(fs->nvqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs || !vqs_info) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	/* Initialize the hiprio/forget request virtqueue */
-	callbacks[VQ_HIPRIO] = virtio_fs_vq_done;
+	vqs_info[VQ_HIPRIO].callback = virtio_fs_vq_done;
 	virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
-	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
+	vqs_info[VQ_HIPRIO].name = fs->vqs[VQ_HIPRIO].name;
 
 	/* Initialize the requests virtqueues */
 	for (i = VQ_REQUEST; i < fs->nvqs; i++) {
@@ -776,11 +773,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 		snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
 		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
-		callbacks[i] = virtio_fs_vq_done;
-		names[i] = fs->vqs[i].name;
+		vqs_info[i].callback = virtio_fs_vq_done;
+		vqs_info[i].name = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs_info(vdev, fs->nvqs, vqs, vqs_info, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -789,8 +786,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 	virtio_fs_start_all_queues(fs);
 out:
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 	if (ret)
 		kfree(fs->vqs);
-- 
2.45.2

