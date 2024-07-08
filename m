Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC43CF6A
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424926; cv=none; b=jUVoU7v6aELtwzueI/0V8VVy4g3eJhlbEljWpLhw+y1JuVyqHayqeTt42cFDWUbqLtPOAOs0Lw82eUrk6PMPomioIsDxoFKMraCrsnrWmAOfL8w+MUnDfasCpd69xC/CoGOdsSNgcA0jS5Z+AZVIbeuROFU/Ptmsrruwd5bUPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424926; c=relaxed/simple;
	bh=pDqigonvOjcrChGdKjWXDhZw37X7BnFYz7MjB8yOYJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmuAdGfhaFnt6RXOc7p4oxUZnVBsOubiIm+dSS34wi5t4tBCFZo4wyDFTJzl9BiksUBf6lLwTeTvXT4Nfpdy1XH3YngXu7BldqqqUFh5wvwHO/AIGxUtNNBCdPpDd50un3SFaI1jTd1T6AGFX50CHTexaH4meQnJ0gkRjWeIA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kjS9Yhi4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kjS9Yhi4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so14994395e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424923; x=1721029723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC0flQJ/nnjYGCQouxTxSf0adCylJd/RjHqeDKE0PUs=;
        b=kjS9Yhi4pWtDukYZzLd4H3AwE2qmKv6xhq1fajz5qbNLkpISSdJPAk9k5FsVD1k9Z/
         t4KgxPGe+l94UTbma7iqhnCJHNorsQLRUE/rhOHsl9FET+1Ly882kVc2gi8eazppvA+X
         Q9FWrYR4IUFA0NO+TpSvrBxf5r3n50QvYq3LR3J6AAoHgJFpxbTL60yp0BGAUWe4Z/+d
         s/yZAXIYzFVntCVfLSUfHd11YpoiT0BvTvxICywY0Sb9ancURVFbyjixe/4WxX/EjRI1
         7HwPnxEmPrvAI4tZwS7Oo0rxXSs/6rNthsaM8z4ZV2U/izKq4ZtxhoRKvMjGG1YLS/yV
         jdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424923; x=1721029723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC0flQJ/nnjYGCQouxTxSf0adCylJd/RjHqeDKE0PUs=;
        b=gQ7wLOZcXe5G08i32De6xsLK8HnFRn0VcOtSte0Bbpbz+bLunSyDj3yKl0CXPuWrDM
         ztLrkW/ehOGwasADVomGxKDjRCnqjTpEU2n+a0Noq05VZbtXV2ihURLx6RmG0kzAJgJs
         lg26i+FS4qkgzW8tB6lhs8Gy/P4Xko5wRot1B6pkWzryP8LWN4dcIv4cFtkFicP9s1T0
         qmp/685hUhCtQy8bwvVgh86M2bv4+qQ7iP7uIPnMzymBidr0G+CJgOfcAGtlfoscrGS7
         oMraF/5EPAh8HSC2gWgtuETwjoTwtGsTjGUl62BCW7XDTC/aQ4qPFH6I/JiJRUBrerqz
         2Ieg==
X-Gm-Message-State: AOJu0YxZBjbG2wHn+CSRWV0QHbr9EjTxB3CeOwi3MEJT0+nZRX7J+J8B
	kufg4W8L8URk1kftTe0+j8JfI+H4xJsKnQNppuOM/f8wlZ5mlPYWkkM1Y2DhsTZ7YXTrS2nPGQn
	8X1E=
X-Google-Smtp-Source: AGHT+IGSBgeU+1ZPwXilaK6qocCTAHtGMbxCNZvU7xJNzrsdQRIyrbR34Kos2UJDxsWkqpopGEJUjQ==
X-Received: by 2002:a05:600c:468b:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-4265fe1fb98mr34695675e9.31.1720424922936;
        Mon, 08 Jul 2024 00:48:42 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679f9783d0sm9908152f8f.9.2024.07.08.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 15/19] virtiofs: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:10 +0200
Message-ID: <20240708074814.1739223-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
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

