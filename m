Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE643F7877
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511962; cv=none; b=QZZWET59Q2vtnu8Pugvpf9xCiyYCxn+RTADjb9wpmaC8Lxl+tQ/XyKvwC0voLlV5lFdPLAqt6zM/gm6ib5Mxzej2dMzhRTE7eMHhSdmozVCa/9v1r+o5eiQ+FGwf72x00MKxC6eB0NT0bkjabcrD/Xv3CF3cL+L1P9hBMzVDVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511962; c=relaxed/simple;
	bh=/d5vu6FzDjUdc5vpSBDYQ8aC7S33EdRfCZpNFO9YxIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhGmTKigWEO/+gjFBukjRJCuYRCVUvyO30BI7pUDPRYo2Y/0A/DygPZJuw2zn6GBojAleJ6O+wm3lAQgkLb2SX3wdG6rj3kSjaXNPn1vld6z9pZUFhXCdG42VOvsP1f0ADFeGvqfCuoatosSIamX2Y3bV2B6eYrAp198qgAJPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5xcVt3N; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5xcVt3N"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so35408115ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511957; x=1781116757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79BiaAS61yq6Rc+Pw8/ABQwHPoIuPnEBPhTKKYRqkTY=;
        b=f5xcVt3N8J14s3fsHwy0fxKQinuY+bvgNTU1UIUpCjHP1uRGqn0SsVoZEeUe/EonOV
         v+HcNM2Ods1dVXic+/pzR/vI6htUXtbCApJ+L4lJtnqQlWaKmBRhugqLJuUX7wh4I8YH
         mLGAahuzOMjAaVe5d/t38Boqp98N0ty7dWnzHocRovg6EdvuSie0Ex5LDS5XdtOSZV4o
         78ya8IA8dPLLVoqxJvXcCbJ4S9HnCIldSyEwbsbvBdaWe57YW/GqsNraf7VzNqpmSWMM
         tmb/AyZdEuhMEx09LCJdXDLH9fZniuFrYJzHGRlrJpdXgQ3tOKLTDQaxYfu+WeXGOVU+
         ajHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511957; x=1781116757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79BiaAS61yq6Rc+Pw8/ABQwHPoIuPnEBPhTKKYRqkTY=;
        b=hBXYMAMmZYRjId5JER64KyAcN+w5vkQ/GrSV2HJ9V76731VwDmCkho2OxJlLSdeRnJ
         OOxCw1S1+UsV9PczBasMlv5TpjUYmpLxRQcK88JfuGwQdjKyw5yko9Q220AOfRdgLjGt
         IGB6LpPCeQWeM1Dsi/QyHz4hsZ0RXtSfbpLI1xYKpVT5UNvZJdAuy486kg2xut3TIDjO
         ZNbPOx4SKBWuUOOzT42Czlf2wImQOKN+jWfdZnikQJjNdVlkCCLiIqyweTLQofowFZH+
         2vqY3+8MBUiDpFslHAAXr9aOKeBmM+C2m0eTN+xxgVoBAVbyCCtwVvQP/Id/S8ABzzZV
         FP6Q==
X-Gm-Message-State: AOJu0YxsbFXIjm9OU7mi5HMcr7dMHhk3FDFp7o555ZUVOKoGxpFMuHTo
	ffjiLoSCtHlLlFwwe6aWioiGahtuv7NlUBskZCKWQ5SSNCA2RYsPw+Nn
X-Gm-Gg: Acq92OFi4Qg4G54Mi7XKMjYxwAq8ItmxlmNn0NyBpCmquUGa0dG09Gkl54CPd8gjWat
	gRMNFw7ZvAc4Q8WE3qNudNSEArCZ50X+oHFjIR1JWid3c5x2nO0MHtP5AIK/oZp061DHm76rB+A
	ns2vhS2dncBiFmkok2NoyUvRryMh+NSQkBYb2Mf83BNlG2RaQnmKe7J7EBARmONHq7KAaNKHCME
	2poXqi5ZVIBvXVzNfY+fnednGzQxhZX4Mtoe4F7qF/ENQRH6y/H2gY07IzBtJb/zzt0NYluhYlI
	T9WHbA38ez38qi4uiTnqa1s0P69uNjg2oNfDrXUXkz47XmZmt0kGwBrqvN6UrxcbJgyUce9PpcT
	QvwmoQhg+Z6ZJusmYGD6Hr4sIWnRlWB0WGpwjI97bsRt3UWSZpG8JgZGegdMZ6r4jc18ETVhBAZ
	l2AaeEVjWYrZEHqGz972az5iLcDjD9KbjZF8O9p69j/vFs6RdqIRTJViHTE8AzB24EGJySNalWV
	uJqnfgxvCjWcnyh5Sry8KM2ZzQLDQ6+7kSDkg==
X-Received: by 2002:a17:903:4b50:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c163a24bf2mr49279105ad.6.1780511957045;
        Wed, 03 Jun 2026 11:39:17 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm32764915ad.74.2026.06.03.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:39:16 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH v3 2/4] virtio_console: fix hot-unplug races in TX paths
Date: Thu,  4 Jun 2026 03:37:55 +0900
Message-Id: <20260603183757.21587-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603183757.21587-1-baver.bae@gmail.com>
References: <20260603183757.21587-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

When a port is hot-unplugged, unplug_port() nullifies port->portdev.
However, concurrent TX paths (__send_to_port, put_chars) could read a
stale pointer or encounter a NULL pointer dereference.

Add READ_ONCE(port->portdev) and NULL checks in the TX paths. In
__send_to_port(), move the out_vq assignment inside the outvq_lock and
check portdev under the lock. Correspondingly, update unplug_port() to
NULL out port->portdev while holding the outvq_lock to serialize with
__send_to_port().

In put_chars(), return count instead of 0 on unplug to prevent the hvc
layer from spinning in an infinite retry loop.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 37 +++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index bbf5b3825f12..589a12261e23 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -600,11 +600,19 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	int err;
 	unsigned long flags;
 	unsigned int len;
-
-	out_vq = port->out_vq;
+	struct ports_device *portdev;
 
 	spin_lock_irqsave(&port->outvq_lock, flags);
 
+	portdev = READ_ONCE(port->portdev);
+
+	if (!portdev) {
+		in_count = 0;
+		goto free_and_done;
+	}
+
+	out_vq = port->out_vq;
+
 	reclaim_consumed_buffers(port);
 
 	err = virtqueue_add_outbuf(out_vq, sg, nents, buf, GFP_ATOMIC);
@@ -1110,12 +1118,24 @@ static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 	struct port *port;
 	struct scatterlist sg[1];
 	struct port_buffer *pbuf;
+	struct ports_device *portdev;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
 
-	pbuf = alloc_buf(port->portdev->vdev, count, 0, GFP_ATOMIC);
+	/*
+	 * Silently drop output if device hot-unplug is in progress.
+	 * portdev was NULLed by unplug_port() after hvc_remove() was
+	 * already called, so the hvc layer will stop invoking put_chars()
+	 * very soon. Returning count avoids a pointless retry loop in the
+	 * interim.
+	 */
+	portdev = READ_ONCE(port->portdev);
+	if (!portdev)
+		return count;
+
+	pbuf = alloc_buf(portdev->vdev, count, 0, GFP_ATOMIC);
 	if (!pbuf)
 		return -ENOMEM;
 
@@ -1503,11 +1523,16 @@ static void unplug_port(struct port *port)
 	remove_port_data(port);
 
 	/*
-	 * We should just assume the device itself has gone off --
-	 * else a close on an open port later will try to send out a
-	 * control message.
+	 * Null out portdev under outvq_lock so that __send_to_port()
+	 * cannot race: it checks port->portdev inside the same lock
+	 * and bails out if NULL, preventing any buffer from being
+	 * enqueued to an already torn-down virtqueue.  Also prevents
+	 * a close on an open port later from sending a stale control
+	 * message.
 	 */
+	spin_lock_irq(&port->outvq_lock);
 	port->portdev = NULL;
+	spin_unlock_irq(&port->outvq_lock);
 
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
 	device_destroy(&port_class, port->dev->devt);
-- 
2.34.1

