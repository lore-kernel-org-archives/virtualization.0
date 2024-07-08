Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227447A7C
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424924; cv=none; b=GA2lvHp9O5A1HPoIjgM6AjGbIfj6mSeEeQtiwzhRtHYS23ZczfqsKjX4+DLTuFn2SahC33JN49N7ZNj4jP5HOnEwmpbmxR14AxmgctfIa9QFRn8FXZmnBXdHCAwCxjR73fPssVM2yZj89u1FbCQAfktgaHKLw7Zu1/Zt2j6Wjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424924; c=relaxed/simple;
	bh=DCOinkDww81TL8hhf5WDhFZp6MihLjpvW2bUJTGtHXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ9EVUJjTsKKo2pGQqjPz3hGlMDsmQ1kY/Yp3QZfnOmHfXeEQro5PE0sU2DqISzL42SvNcwB8GJ5KzxSuRxCLTJvvyWwg7Bvq8K+AkVE+HThRpRbhHyLJSf3DR+Rp+iCeTQKfLmrhsiERmy7xGgBH6jYgndUEKdNQ9ogNGLe1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hnrMsZMy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hnrMsZMy"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52eafec1e84so1393090e87.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424921; x=1721029721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulEZOUkFdkA9Jrig8eucohv8bSt/6ESDv4E3tPj0O24=;
        b=hnrMsZMy0no9gkV+5dfjzGEqdXJXElQBhcP08PsXWWrDXl/L4zrq5y2n2L9jooSFqp
         heF4S/IIC3qH9uAZpPtWHIdv/7TH3leohfpWfoyMZ+OU1FgjnBKFJJAsvO18tdAfgQtU
         FIHvURwczdTe+xMFqznwgrn7FVItS8AgKGhTkYlEFSz/4U+AtW1tYn0Esep93vHBUiRH
         dn/HqyZYmjpaTr2SxvfOtf9AnVyjlS726KNp9cBVa3O2YcptVpHtbzEKcw2lg+BtB1Jn
         o+l9MhaMCpFBbdwMjfUVOAUhfQDs4MVM7icDttM1g4O0y/nTvoe2oXLTYqKTT54VOx4l
         WLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424921; x=1721029721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulEZOUkFdkA9Jrig8eucohv8bSt/6ESDv4E3tPj0O24=;
        b=ml2mGiv0pxZDwWdtItGIGy6/bYT9pOQ6tl+fqHqZ5PwIQix+UUTpkHzpfuLFzLkJiH
         Rgd1AoG7CNLwZrGnUiFsVqwUtqSoXHMBN0zGywwK7tv5x1sK6Aa9NSrD+d0SDyIC+XCO
         arVmr3Jncrnywf17CqiKwtRC7AVf0YRh9030wNqCOhg8p88JXoN/I4tSjC/oUzVmlWLe
         dhP4rhcTGdccLiuEHCxWc7cSXPvKT6kVLwiHdbQAPG0vn6p78nlWEszPWlAv3upnYyb1
         K8MQt41Si0zEtUY9RpAnrVy2siQeo8TkMcftD/1sB+9colDMywY/70m4sT2CY4RXjXaa
         FKEg==
X-Gm-Message-State: AOJu0YyG1980wUYgaE4bCtxL7wOavgjAKXLVslzej8O19HLxiFtOxeOv
	73H28pj+4vUHSpclX+24cgRM4enQKqAimfsE1P4Go0UICYTT5lT91zrepEVNzn3ktYmiP3z/8/H
	FU8A=
X-Google-Smtp-Source: AGHT+IEKm84qHWu7uB6ESP0KzVm9hK3SHy2KMLIQIgFLv+0zWEioEkh3RrYQXwwnXtXoO4I+6Sqo2A==
X-Received: by 2002:ac2:5999:0:b0:52e:9407:ddcd with SMTP id 2adb3069b0e04-52ea0628c53mr7942521e87.18.1720424921192;
        Mon, 08 Jul 2024 00:48:41 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm151760005e9.7.2024.07.08.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 14/19] scsi: virtio_scsi: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:09 +0200
Message-ID: <20240708074814.1739223-15-jiri@resnulli.us>
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
---
 drivers/scsi/virtio_scsi.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 89ca26945721..bf9346a66df2 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -841,19 +841,16 @@ static int virtscsi_init(struct virtio_device *vdev,
 	int err;
 	u32 i;
 	u32 num_vqs, num_poll_vqs, num_req_vqs;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	struct irq_affinity desc = { .pre_vectors = 2 };
 
 	num_req_vqs = vscsi->num_queues;
 	num_vqs = num_req_vqs + VIRTIO_SCSI_VQ_BASE;
 	vqs = kmalloc_array(num_vqs, sizeof(struct virtqueue *), GFP_KERNEL);
-	callbacks = kmalloc_array(num_vqs, sizeof(vq_callback_t *),
-				  GFP_KERNEL);
-	names = kmalloc_array(num_vqs, sizeof(char *), GFP_KERNEL);
+	vqs_info = kcalloc(num_vqs, sizeof(*vqs_info), GFP_KERNEL);
 
-	if (!callbacks || !vqs || !names) {
+	if (!vqs || !vqs_info) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -869,22 +866,20 @@ static int virtscsi_init(struct virtio_device *vdev,
 		 vscsi->io_queues[HCTX_TYPE_READ],
 		 vscsi->io_queues[HCTX_TYPE_POLL]);
 
-	callbacks[0] = virtscsi_ctrl_done;
-	callbacks[1] = virtscsi_event_done;
-	names[0] = "control";
-	names[1] = "event";
+	vqs_info[0].callback = virtscsi_ctrl_done;
+	vqs_info[0].name = "control";
+	vqs_info[1].callback = virtscsi_event_done;
+	vqs_info[1].name = "event";
 	for (i = VIRTIO_SCSI_VQ_BASE; i < num_vqs - num_poll_vqs; i++) {
-		callbacks[i] = virtscsi_req_done;
-		names[i] = "request";
+		vqs_info[i].callback = virtscsi_req_done;
+		vqs_info[i].name = "request";
 	}
 
-	for (; i < num_vqs; i++) {
-		callbacks[i] = NULL;
-		names[i] = "request_poll";
-	}
+	for (; i < num_vqs; i++)
+		vqs_info[i].name = "request_poll";
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -900,8 +895,7 @@ static int virtscsi_init(struct virtio_device *vdev,
 	err = 0;
 
 out:
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 	if (err)
 		virtscsi_remove_vqs(vdev);
-- 
2.45.2

