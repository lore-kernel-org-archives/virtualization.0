Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A01DA58
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103681; cv=none; b=DICKp4l9p4dnGOIsI4wbYCph3n2BmxtnpKA+6c2XvaWqFzmPLrkoi0O9wGnvN5gdqutwSAYKyN6BDjKdmdb5EukjJzpTGh8k8WFsLPP2jDG1E+Q2ePC4/fv4CklovQ+e16a9Ik8by75n054ikgIyZXzJEaEUb2I+KSAuMRvy2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103681; c=relaxed/simple;
	bh=DCOinkDww81TL8hhf5WDhFZp6MihLjpvW2bUJTGtHXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRZoEY9L2MrAuMMeeCnbWwYrRUVVrK9Knbbdpo6b9OxcsCEkcLSz9WTHt/PGCkdOsuybwDVRABb/q2EploptGw1PVVFdQb5PHe5Hd++65kmfSvfV6DGm5+8IwPOZ67+w3lLQ1UMV85p8x9TORizzXo07cVI2/evpL41aC1DqPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WtUMkKI6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WtUMkKI6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso4746395e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103678; x=1720708478; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulEZOUkFdkA9Jrig8eucohv8bSt/6ESDv4E3tPj0O24=;
        b=WtUMkKI6qSCHPFNML4cvAfpIISPOKxIcEtRl7zMwwSckX3Crp9OsICkMS15S9W4Om9
         sgViOo+IHC4aVSY3SCMrFBNQJgrvLeeSzWlgqPrixCACLQhz/M3YNWEst8VqK4rwDoUV
         lqvojZucJSj6WRuZ/TWbDytlCLO9gMKODpJXUknpld+uCI1XteOs259ieXAZhDbyU9ot
         LyRXDXrwSW4ZaK3nJPLKGxrr551LMMcMTrKaNdH9/bKdM4LOGgvdbJxQuOE1h84ShXc8
         4bsGtUamXk/q7zsqt/eBpPM/YN4O8vYBlRwLY3YJxUL1NdoOW9jBy5KCn92mQTC2/WJN
         LpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103678; x=1720708478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulEZOUkFdkA9Jrig8eucohv8bSt/6ESDv4E3tPj0O24=;
        b=KKuiOq9/+u6R37m4YlmhhSyTkZiUR613Ebp3UPn7ijRtoGiv384SyEADDTvvxYvVEf
         2HIuAk/YVYX2t/jifL4l+QlOTVUhh2tFfwyZYZXG3NTmZinx+6mqui07YDRBvI0VqIYa
         lRuPoXlxgZzbqhv3+lGRy0QI1hnnsETzmsXo8q9CGSI/i/fEnpffHOYWzVgr+BFqEVmX
         wQHyVfwHmZrqEMKdmOH1ywJhhopvpAJ8N/cqS/iZEc8HDlinskqBskZkJKHOWzOsmxdq
         B4eTLsXFGtNu/1pV04x/9iJm6wwUH2MmZTk53lY0h64nZLtwaMPw6HxEqmBDad2+ABJh
         HO+Q==
X-Gm-Message-State: AOJu0Yw5Iakb9Yw5Zrq4VulB0q/tQ/sbAULNEOv5t9eiPQMkDsvXH3Qm
	tSlinFAREVHripJfy6Mtnsm2/8GF6FzqVrSmh6rIEe3/uGcEsZCQdCu7fmB8KxXSyotLzLWIj7Z
	71wU=
X-Google-Smtp-Source: AGHT+IHpzJX/uGkQb3Q1oWelJBzzU4byv0hR+8SQNvjA95gjHYu5q+0YiPt+hzeyM9lI6jqEKp7w9A==
X-Received: by 2002:adf:f744:0:b0:367:96bd:1277 with SMTP id ffacd0b85a97d-3679dd6524amr1472633f8f.44.1720103678059;
        Thu, 04 Jul 2024 07:34:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a2ee695csm666547f8f.98.2024.07.04.07.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 14/19] scsi: virtio_scsi: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:02 +0200
Message-ID: <20240704143307.1212454-15-jiri@resnulli.us>
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

