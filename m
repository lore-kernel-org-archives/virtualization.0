Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C641A08C5
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075469; cv=none; b=VwJ/Q1SuD53V3BHpoJ1m9pX09a1VwXIV+wrXRk8BpIJ5WPMKC77WBOFXaTFOWBxQ5GQmWCN1vMqdBB4Sgs4p5WW/quTT9qSEe1RLRrKMZTfYEXexvB0zrZ9uYc0+v7+1rdFvGEy634gFeNzNSDvaMOFHiWEAIgeVufXUGu6nZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075469; c=relaxed/simple;
	bh=YvG8cvCq1Z8V6IqSjasubgqIFjoptBHMqcmbljj0cY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElBLSaSPT9l/k3Vrs/xduBD8nwc0CWNMxun1UtOTajq+TmRaTSHwLWs9mujjYLu50D94n2aPFfaMgyveakLfeM4bhKyX0NGD5R0wBi1OaWYAyOw+dwDf1oyz/GBadmQKS55Wh5Ic47ER8ejm2a92xk1m7TaRgZIGKUAqoRJSDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pwCE1263; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pwCE1263"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424acfff613so2272655e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075466; x=1720680266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMUqItVhAwoeZ7JnxygEiXHiN5g+NWR5ItCHYDCKn9Y=;
        b=pwCE1263vgZby6B1UD9WVThbuV/xsJSVCveok0FN1EE8Pt9xBO6jwBxI69ROIOn9t4
         8k25jQlb+FA9Ft/qIsIWR/XTQ4vvHKEy1Gs+vlin0kzFy8aIphrHk9oBufTAIfycNYvs
         BP4gnTrmdrJg57Ruz+UnsTQ8p08wZf7UEcet/Ynh4T5JqvKOWXHWBDS6DhxW3pMGgiXS
         WZWOcVwjhoBydv5TCDhMlIHQ98wkCc/mgkVyB7IZEJHFskcVOc1dbces9zND5A1SoafP
         wAsMp370wVH+jFPnMg2Ch6W5FhUwOB8a+/ozhrJ4tIF3WyZfOOyhEDREKLLV/tB1bxwk
         asmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075466; x=1720680266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMUqItVhAwoeZ7JnxygEiXHiN5g+NWR5ItCHYDCKn9Y=;
        b=NIC3VZWmzfqo2oUBPo43g3zLQ5SamwKtN2pv0MrDDRrFMrIxHBG4O4+N0Gb7+dA9af
         QBdl/jG30mT6C9Uprgim5mcGlKJ5CgvZlQ9hGKab2BPPxgTVxzVbhs/od9Vy6oa3bwQb
         a/2o/o1hJt1eLcJRhWQ3szH9xRwhWqkeTaqDSEKdBjzTnaytHf+ythHxcTUQ3eS6i0Xx
         PFWm3XvnhyF4rzrfC9h8HR+74B6NRR/OCoqIK/yM6BGo/9VGfIW0jmUhqkLZEdeQd2xH
         cNBseZRU/YuIwyNwhwCDz8nnOd50uEeYaiq2ujqf7o8Xsx7Leo2DWT3I/s0GPcZwBcpc
         oxCA==
X-Gm-Message-State: AOJu0Yzc5z3rgB3Zyu/8R72Sn1STxdMzCcmWnpCG3DJ8yko3S+dkHbeP
	qgOlnCMzQhphW6mrgpwVd+K/TBtc13Bj4uRobNQceAUN/dyXwolPBM2y9kYDGuvVCb6QTgepTEq
	6
X-Google-Smtp-Source: AGHT+IF6FQxHbKOd1WxgaInuA8BkBUeB7mHY5x+WhbkzgWLaQjVhvDMx8vB7CRM/Qm8+XBys5Wuelw==
X-Received: by 2002:a05:600c:41d6:b0:424:c837:f54b with SMTP id 5b1f17b1804b1-4264a41eecfmr7954395e9.38.1720075466013;
        Wed, 03 Jul 2024 23:44:26 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1692sm11241935e9.9.2024.07.03.23.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 15/19] virtiofs: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:46 +0200
Message-ID: <20240704064350.1097716-16-jiri@resnulli.us>
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

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
- rebased on top of recent code changes
---
 fs/fuse/virtio_fs.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 728f14e077bd..a335b421f196 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -789,14 +789,13 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
 static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 			       struct virtio_fs *fs)
 {
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
-	vq_callback_t **callbacks;
 	/* Specify pre_vectors to ensure that the queues before the
 	 * request queues (e.g. hiprio) don't claim any of the CPUs in
 	 * the multi-queue mapping and interrupt affinities
 	 */
 	struct irq_affinity desc = { .pre_vectors = VQ_REQUEST };
-	const char **names;
 	unsigned int i;
 	int ret = 0;
 
@@ -814,20 +813,18 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		return -ENOMEM;
 
 	vqs = kmalloc_array(fs->nvqs, sizeof(vqs[VQ_HIPRIO]), GFP_KERNEL);
-	callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
-					GFP_KERNEL);
-	names = kmalloc_array(fs->nvqs, sizeof(names[VQ_HIPRIO]), GFP_KERNEL);
 	fs->mq_map = kcalloc_node(nr_cpu_ids, sizeof(*fs->mq_map), GFP_KERNEL,
 					dev_to_node(&vdev->dev));
-	if (!vqs || !callbacks || !names || !fs->mq_map) {
+	vqs_info = kcalloc(fs->nvqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs || !vqs_info || !fs->mq_map) {
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
@@ -835,11 +832,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 		snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
 		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
-		callbacks[i] = virtio_fs_vq_done;
-		names[i] = fs->vqs[i].name;
+		vqs_info[i].callback = virtio_fs_vq_done;
+		vqs_info[i].name = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
+	ret = virtio_find_vqs_info(vdev, fs->nvqs, vqs, vqs_info, &desc);
 	if (ret < 0)
 		goto out;
 
@@ -848,8 +845,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 	virtio_fs_start_all_queues(fs);
 out:
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 	if (ret) {
 		kfree(fs->vqs);
-- 
2.45.2

