Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AE1AEFE7
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103686; cv=none; b=AlVI74aWddjkreVkmq0T/iYrFWGZ/MeqTOMjPER8pzFep/X1z5zCREzp/UcBDkv0zMMFb6ScLL6+qAEOGAOP2E+W8xdltxtIOX0rtkfr33FZpRpt5l7HTXOfpA0sfVVr3Sayb1ze7d06G8lVbh6eX2685pmkGqUqgAgGz/c97UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103686; c=relaxed/simple;
	bh=pDqigonvOjcrChGdKjWXDhZw37X7BnFYz7MjB8yOYJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubJp5wy+YvkmaG9fIC5DWSrtN0zqD1T+BSWQ6nR9m5p+0NVNsNkBv6Foa1OQsBtq4E3C1eUzmCPaDIdmCQZA2UvCD0PW5DfkptJdTQD/CWYi4xLgLY3tdVifPrWJ8VahL51wDaSEHz8f2idubK5AuPoScE+PyLTlD3bLJnd+IDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NucWSzBr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NucWSzBr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-425680b1d3aso4685705e9.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103683; x=1720708483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC0flQJ/nnjYGCQouxTxSf0adCylJd/RjHqeDKE0PUs=;
        b=NucWSzBrzbOt6kYrVlErmQzdT57yzcDNY93qJnqVPVfnttuaVa7BTYl5a0129U40C0
         qTIrauVcUhemjXC8mHBrkANRxCyQ+manbHXHS73GdvrN7S0uAM7R0wt7ihggq4B6aHi4
         lDXsyNxjSQ/FU27nRp7qV/4owUf8GBOHEBTmdQ9Xan0WfDmCgSjW0+RHePyilBGFXhH6
         gSDU9rMyevMkXlvXbuT2DvmR7oIalPfqu7HwW7KavdM1BzsjzjQL6xB/KIbpH4evvnNS
         0AV15jeHDkbmkBvAwqAM7SJ0kbJLGrJV1cDnCQpwuD8FeXLNxuxq64LKGS5VssrKrpEZ
         pIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103683; x=1720708483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC0flQJ/nnjYGCQouxTxSf0adCylJd/RjHqeDKE0PUs=;
        b=Emkqu0PFWp5wTFdWW+gmi8SE6835wMzohnpyGXRekloiGW9Iamt1PK23hWI15HnSX1
         0qA9xeWyEphIBzowwOP3uUuEPL9bzyOQFiQsAnJRbscF8HSrKqVvHbWsdmr+gryMIhN7
         ZaNYoFfUZTQcgIfyxt0uroAquqVqDE4XCTw8zjUWFwxBLltqQHRjgwuapJPtLG+SjWuQ
         1qILQ/4KMPDM51RiFriJPiqdviQtZgTEJU9G2VK3euDI6bHHZ/SFwVF5G2fuSWUb4eIb
         J6sKW61R8dtyM2N47FIOhpBxRZnWliFBxJNI76eV/VhMCLo3kI+RiaEl5uuMqvkJhOJ+
         zlYg==
X-Gm-Message-State: AOJu0YyKXlljoO5MkrHegImPlTMU4abMc2BcEbOPaP0S+V3j8qAPVfha
	sAix8CE35Hm2JIa086DFVRtMUr3LUE70GhXNywLpRJc3oev1ANzFmv0quFFqN54o/0kZ0n+D2rx
	SUaY=
X-Google-Smtp-Source: AGHT+IFYndvd6tKJUn7fUMQwRysWhfG7WztQvR8JgDeRQAdonR3rrUl8HcmkPPHVBbGr7UbcvGKMpg==
X-Received: by 2002:a05:600c:15cb:b0:425:7835:437f with SMTP id 5b1f17b1804b1-4264a3df69fmr14475275e9.13.1720103683182;
        Thu, 04 Jul 2024 07:34:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca60bsm26944765e9.31.2024.07.04.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 15/19] virtiofs: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:03 +0200
Message-ID: <20240704143307.1212454-16-jiri@resnulli.us>
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

