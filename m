Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DE1A08D1
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075460; cv=none; b=kjyCoVlrK+Z9A6KlSoQn7anQTbAkfsM1BAd+AIU5S6YYFqTgz99Dyn1VmnjMXU2SgnvqnVIBK8jLTncSxpfvXa/iKqcHDZ9/aG7a47rvA4ZOBUgTbSZLlw3aE0J8zGIxbBNcWgV2/XQRhDIKA577alniW8gAbVozJNFmN+rswpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075460; c=relaxed/simple;
	bh=HGXmcn0Z00776tfRiNWrxS46ZytSPKb2jP5GhrUU9NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUnYJRxnnRqcIj78IK69QfckZDDBc9L1n7239N/J9KEdw41Do51ulWQS0hjweogFQV96alqCVQ4GdxN3wl8q2hGw0H1dO1tr4Z185WdoeF09HSick+JAZDukFrDM9ncDmC7HNTOAE6PSN2azxmDwgyHz1Ly+6MBmYCN3f7oeBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=q0iXzJY1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q0iXzJY1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso1747375e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075457; x=1720680257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgWs1Xkj5oOEI1ZXk9IRL4ofPHhYA1ClDPhNXOYqXbk=;
        b=q0iXzJY1AEly08ADm8kAj24E2S4TpPNSAy+53YR0FnxZKUHymMjz4GSCjnIkuO6gPu
         gwzqf3hnrtqriKlrSesTdkZtYYG+VVGhy14iU61yKcAtisJXQ6oVIpjIaoDHKHoJQKc/
         FW7FOk8KgPREQKw0tPrbnfkNyUARQYdtJP1OucDcktj7ZC+0MWV1UKNV/X2B0nujvnOs
         D1D6O1QNiI2F7jAQwn4xcV4GbODouFdqinh1TiQToUg1BaoRVmxt5jWxRHhnlTXCfLAL
         yCEfkM2Uty/EOcunOz0MmsYdT0dpCt6/fsPKPSKKhR9TBqEz5gmayGDz+xUYCnrlSajS
         cKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075457; x=1720680257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgWs1Xkj5oOEI1ZXk9IRL4ofPHhYA1ClDPhNXOYqXbk=;
        b=InH+pEyigubeO1CNQOe+bnUBjWKu16FZlIPuceNtgXfpwfW4xurVUgUAlrowIW5X2b
         sJsJzAt8Totesejd3qnL5nwwzWpEtdCebL2LPjQYyrHklWSqrn/6HzPXH25LnfTaiqYR
         2kGPEPl97wVL+bnXOaHcrT3WvGLoV2J5dNe5EirHIaamJfIlAHOi8S0SgnysEPcWPzRF
         BW9ydUTByIseN2V759RZN1pVVOp3/VhBoYe2wfiPUPmpeescujvFqLkov0PyBnw/i2gm
         5+4WlXM0oMQ0ENp2Gej6mHZ3YPqlTiRYqn0QK0V2YZBp3TL4ebXKaSYDu9080cmGBCky
         tVzA==
X-Gm-Message-State: AOJu0YzwJceIxcZBlVHygb3zlEpH+KDEuIhB0SEqPlX0yx2V5qJgXCW5
	ll9vsHvY0o2zFxe66Sap3QLC+bXhGE8NpOJqvNYdBG2QXT+5a8YEveiXPibewE/PTrzEc4+A1mq
	7
X-Google-Smtp-Source: AGHT+IG3mKaN5tP/ExYRe2euvG/C5+inHJyXZrpRTiC921C8iGYb+9rkGcA7HwA2UcNbKdPDL0PXbQ==
X-Received: by 2002:a05:600c:4f11:b0:424:ac13:ee3c with SMTP id 5b1f17b1804b1-4264a3e162emr4975085e9.21.1720075456917;
        Wed, 03 Jul 2024 23:44:16 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28333dsm11021775e9.40.2024.07.03.23.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:16 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 11/19] virtio_console: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:42 +0200
Message-ID: <20240704064350.1097716-12-jiri@resnulli.us>
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
---
 drivers/char/virtio_console.c | 44 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d9ee2dbc7eab..903d83a1ffe8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1804,8 +1804,7 @@ static void config_work_handler(struct work_struct *work)
 
 static int init_vqs(struct ports_device *portdev)
 {
-	vq_callback_t **io_callbacks;
-	char **io_names;
+	struct virtqueue_info *vqs_info;
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

