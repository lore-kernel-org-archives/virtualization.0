Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3117838C
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010392; cv=none; b=bFZUQ6BEwrlWeR2khaUtOq/NIFzRMbu96avj2dGpFxD3ce5oJtLzxW7j/Nj3XBtSfFLPYXk0X0KZxTHHuCWSDHZt2VlsUueyv3qZfABduLl3P/CDARnkm4S61rf3pw/IpJolSgkMjmbmqNEUw8OSeWAwJdmCiLXFQLSTmUuxAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010392; c=relaxed/simple;
	bh=DuZwD2k/HbSvCWrSGmEmgbcabolWH/toD7EYHkyB+xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMJFjBZxnTa28jRpISQXs7ln0H4x9SdK7W6Tvb6r5Fdg0ZaB12iTIpqYo/6yr5ExuAxzJJgrx6A7WkGnWL+fnsBkN9AhccvHa5V+n2s1olCKFLYaxHvWb7N4dRzHJypEwPDr7siOdmk6qIe4uqrcH13cgRAfuNIMgC7B1VnfSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ogMJ9zYf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ogMJ9zYf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe785b234so55307321fa.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010389; x=1720615189; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV1isAQSzu50Ovk9e0Ce18eiKqecGc73DEzIzinqUZ8=;
        b=ogMJ9zYfyGRhjowfBt8x3ee/pIU00F60vFW+kdjcRceZtNnDnsilhXOSOIfv82kqYy
         /jfVND2TSOh9tZCFKeikTmXyBXRe2OogMRlft4WqN7ebdJtVsLTuUnpA4RDeIYkyl073
         pVKKISdabRm3/uT1KWNeLJ5zchYHZ3Pxan8C4qGTRxUYPFeXKR0YTHkKEdO/IAyw6dqH
         VjTmMBHuoPs9eyN/M2EXLdinzs4g6R1lXxcE8OF74xRxTFJ4SqiMAI0sHeZOBoAlf1ly
         zi6qULJfOVLRNKQgcfLheo/58zFOsgIATvdsXVYhBEUVG/VvAymXY/iyLsVNLrDncco9
         VTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010389; x=1720615189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV1isAQSzu50Ovk9e0Ce18eiKqecGc73DEzIzinqUZ8=;
        b=KGhkgHMAxWBCXmKFkwyWlLYgWPKLhQ6e1F9Z7j/L29cWAAgAAa+y422SiESdnjhGyc
         Z9e/uLe6YlVaQE635Y7+vLzR1rXN3bw4Fj+JopatVqcmpOAjrq2Dw7tQLBGFOG7wlrsr
         I6lIqIbD/GpDZ9Yq4IQhFlINm2aKbgInPhmeZFqzGTl8UX32tUMCAoemAi1HGU9TkkDB
         qRm7gNdqtuOgfE60uONZN/RXvOXtUXhkw9foxsZTCMMPU6dVHb8MOP4puCBzzy1ihbmw
         fYlWvCQj2gch5uy+2MIv2hWyr/g7I8Ulh2jnEm+L2dbUCPvvFxHupK2TmCs8HLN04JxZ
         7q4w==
X-Gm-Message-State: AOJu0YzIbrjT//vcWJ63h5NRPMEWq38Ash+8a7Pd1NrLdkjstjo2mlrB
	fBrLxH24+fImRtu6xuKL6CfL/ShW2JplBXOt8CzXVWjJ6QLpvjeNs1NeV3lGZYMAc0kCf9VmXgo
	/
X-Google-Smtp-Source: AGHT+IFFTWvZNLfrxmyTaecJrCB7fdjD/1j7svcFDYXa3Ayo6Lt0NDmvLK1TVlU4EuvqmwAEVdYIZQ==
X-Received: by 2002:a2e:a786:0:b0:2ec:56ce:d51f with SMTP id 38308e7fff4ca-2ee5e3adc1dmr88650701fa.20.1720010388840;
        Wed, 03 Jul 2024 05:39:48 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257fb4fabdsm145204765e9.46.2024.07.03.05.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 11/19] virtio_console: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:05 +0200
Message-ID: <20240703123913.969202-12-jiri@resnulli.us>
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
 drivers/char/virtio_console.c | 44 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d9ee2dbc7eab..23dbf1c18c90 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1804,8 +1804,7 @@ static void config_work_handler(struct work_struct *work)
 
 static int init_vqs(struct ports_device *portdev)
 {
-	vq_callback_t **io_callbacks;
-	char **io_names;
+	struct virtio_queue_info *vqs_info;
 	struct virtqueue **vqs;
 	u32 i, j, nr_ports, nr_queues;
 	int err;
@@ -1814,15 +1813,12 @@ static int init_vqs(struct ports_device *portdev)
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
-	io_callbacks = kmalloc_array(nr_queues, sizeof(vq_callback_t *),
-				     GFP_KERNEL);
-	io_names = kmalloc_array(nr_queues, sizeof(char *), GFP_KERNEL);
+	vqs_info = kcalloc(nr_queues, sizeof(*vqs_info), GFP_KERNEL);
 	portdev->in_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
 					GFP_KERNEL);
 	portdev->out_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
 					 GFP_KERNEL);
-	if (!vqs || !io_callbacks || !io_names || !portdev->in_vqs ||
-	    !portdev->out_vqs) {
+	if (!vqs || !vqs_info || !portdev->in_vqs || !portdev->out_vqs) {
 		err = -ENOMEM;
 		goto free;
 	}
@@ -1833,30 +1829,28 @@ static int init_vqs(struct ports_device *portdev)
 	 * 0 before others.
 	 */
 	j = 0;
-	io_callbacks[j] = in_intr;
-	io_callbacks[j + 1] = out_intr;
-	io_names[j] = "input";
-	io_names[j + 1] = "output";
+	vqs_info[j].callback = in_intr;
+	vqs_info[j + 1].callback = out_intr;
+	vqs_info[j].name = "input";
+	vqs_info[j + 1].name = "output";
 	j += 2;
 
 	if (use_multiport(portdev)) {
-		io_callbacks[j] = control_intr;
-		io_callbacks[j + 1] = NULL;
-		io_names[j] = "control-i";
-		io_names[j + 1] = "control-o";
+		vqs_info[j].callback = control_intr;
+		vqs_info[j].name = "control-i";
+		vqs_info[j + 1].name = "control-o";
 
 		for (i = 1; i < nr_ports; i++) {
 			j += 2;
-			io_callbacks[j] = in_intr;
-			io_callbacks[j + 1] = out_intr;
-			io_names[j] = "input";
-			io_names[j + 1] = "output";
+			vqs_info[j].callback = in_intr;
+			vqs_info[j + 1].callback = out_intr;
+			vqs_info[j].name = "input";
+			vqs_info[j + 1].name = "output";
 		}
 	}
 	/* Find the queues. */
-	err = virtio_find_vqs(portdev->vdev, nr_queues, vqs,
-			      io_callbacks,
-			      (const char **)io_names, NULL);
+	err = virtio_find_vqs_info(portdev->vdev, nr_queues, vqs,
+				   vqs_info, NULL);
 	if (err)
 		goto free;
 
@@ -1874,8 +1868,7 @@ static int init_vqs(struct ports_device *portdev)
 			portdev->out_vqs[i] = vqs[j + 1];
 		}
 	}
-	kfree(io_names);
-	kfree(io_callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return 0;
@@ -1883,8 +1876,7 @@ static int init_vqs(struct ports_device *portdev)
 free:
 	kfree(portdev->out_vqs);
 	kfree(portdev->in_vqs);
-	kfree(io_names);
-	kfree(io_callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return err;
-- 
2.45.2

