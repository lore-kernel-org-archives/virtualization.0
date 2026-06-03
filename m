Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA893F65FC
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511958; cv=none; b=oQlDY8bPCUkeJM6y5Bun52T1CjJabwejIh1janWxK4CTDQw8wiXDwrFa2a0T0+vjYXn+V0P2h91ADsHjlgfG/N/lchXs3b3vhvrcS4iWotANRkWHpQb0SpF4rdsI+FVJ3znuZbKt4ENP8wiHpC4aftLUK265hv+npF2H5jAO3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511958; c=relaxed/simple;
	bh=CqNk9t46yf5UVVFk728877Xh90GabgM+PGo8g/wAQ/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkHyC7lytmS26X0bQuLxve3Jb9/Dez935402RWJ8YJCspf1ehmcDsfTE4ekiNc0m23lxhM2tFmro9v7xfSA02UIR75grqeeNSuW9WsjWR/ahC9yCCrle1npyY9pZzG4qNT0AVCVvZfNbUy7QoeB5qLNTDQJ43nQc0wgkYN8qaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2yIIC0t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2yIIC0t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so32440405ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511954; x=1781116754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5xYwJR/7gD/yfsO3m8o5L05lOBT0oAU75aIhtLSm4Y=;
        b=q2yIIC0tXDjjLuDzkNrjt9QJm2chOmMocICzmZvLpJv34Bbghf5CI4z57q0KvOuax4
         rBGV5Ik6AUfmbdiGKaIuxHkBcHM5aSjpyXgM/5kXdLDPXqWCWLJxxfKK92y1F5mPkNXY
         A3wvoOb6++/BE2nMn6SS6ycWPRr5/o5c6bIUQ3zHO9EbMkSlFHRiFdLqtTHEJDJDnrCq
         z0TaoaLR4aJpYRU/6dU67Eqvm/F//eB8Rl2cVtiIcNctb9gebo5J+7fO38MVphqF/Qxq
         uRiusFtUMi48a9Z8r30ZPUHnLzXwQHr3Y7oDR18JXIbG/aM9AEU8LXX6mFFHy7feL5wO
         UYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511954; x=1781116754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5xYwJR/7gD/yfsO3m8o5L05lOBT0oAU75aIhtLSm4Y=;
        b=LpqDGk6gODeO7gUgI69c+dK2isa3zXmlzfycGaFroKn50nNLdYB6hkWo57sbiQXTyM
         fWSLegaIwnbR7uVMfjV+Q8ZR6RSwGYjA9Rs8wKZtY/ErcQCk1TAM+FDceFFBgYH9ubf7
         H+tWthCTJfNzwiWuLvvA0wHiMSZVhfUG/OOG6uE789idQgVcROs7tohSb/Nkaho/fCiw
         60iEOWp4EdpEfSynfq8EYDV5QCJnVsgwBDkzVvAxdsRNkRE0K9yT3vH80UDiBBllPCUS
         WZJLE3q9h9BqluM4E99KkxuMDu9uiXW/oAIYk8+6DQx3DKajU29YIHXXhPRn5VX38YsW
         VtuQ==
X-Gm-Message-State: AOJu0Yx3nuU6No8kz+0LQPWIhdPmg5JPqU/VFCFR/7ju5+ucFibAsW7J
	wxrf8NdgeXqiquLqCDUW1C/ekkcfPzt1Sb0KP1AJuy4kK6FUkuduSow4
X-Gm-Gg: Acq92OE0Xswfinx3bPWfxNKr4nqCEb5ncbC1SpTgbLsgKT+I8hTnU1wytPVx+tYTXk5
	tmQzoFQASanNeTgjHXcneei5YnZQgOwkh+7TjwZMwqchbsjVnKT4m03xVDlGzp01d9rPu66zHcC
	e9wweyiaDu/znYGnesEnma5CJh2GFbSM8t1zbcb1wqYvzsqxsBdxZfuReQeVkXCzqgZ4Pm+zYjX
	e9wz6Lm4DnrdAFUMTVPv4tQgvZ8mpn86MTpkrFvCwrAFImHKTA9pcNAAuEQDPMvLHUQrGZTCabn
	08HVoS4Aq0WDbhgISaWfFJxRLYwMc8T8JewIwHNPW5Mgw3szlp2SqHwf9HCF4xxL5C5gP4Vvfqq
	JkmYr2UW2jfR7BI+JDWuWsNXxwKS1/dZVT5xKq0FIrLEN1wdg6D8BEpZAsQx/Q/AvUiENuo9Z8x
	2r8K5dV2D39JsRrr0QGZwUmh3GcImvtuxkijXy2dX9hmUJ+8pdlDevMl9q3KTgHQNVKpmsN7608
	aHeXcdT6pnNWZQR6UoizpE1byebdGa4PWMaiQs3j0AIFP6y
X-Received: by 2002:a17:903:1a4e:b0:2c0:f807:a760 with SMTP id d9443c01a7336-2c163a5a5cdmr46440595ad.13.1780511954182;
        Wed, 03 Jun 2026 11:39:14 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm32764915ad.74.2026.06.03.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:39:12 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH v3 1/4] virtio_console: refactor __send_to_port() buffer ownership
Date: Thu,  4 Jun 2026 03:37:54 +0900
Message-Id: <20260603183757.21587-2-baver.bae@gmail.com>
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

Modify __send_to_port() to take ownership of a struct port_buffer *
instead of a void * raw buffer.

Previously, put_chars() would pass a raw kmemdup'd buffer and free it
immediately after __send_to_port() returned. This caused a potential
Use-After-Free and data corruption if the virtqueue was shared with
nonblocking writers, as virtqueue_get_buf() might return an older
completed buffer, causing the newly added buffer to be kfree'd while the
host is still DMAing from it.

By transferring ownership of the allocated port_buffer to __send_to_port(),
we ensure that the exact buffer returned by the host is the one that gets
freed, resolving the memory lifecycle mismatch.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 69 +++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..bbf5b3825f12 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -402,7 +402,7 @@ static void reclaim_dma_bufs(void)
 }
 
 static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
-				     int pages)
+				     int pages, gfp_t gfp)
 {
 	struct port_buffer *buf;
 
@@ -436,11 +436,10 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
-		buf->buf = dma_alloc_coherent(buf->dev, buf_size, &buf->dma,
-					      GFP_KERNEL);
+		buf->buf = dma_alloc_coherent(buf->dev, buf_size, &buf->dma, gfp);
 	} else {
 		buf->dev = NULL;
-		buf->buf = kmalloc(buf_size, GFP_KERNEL);
+		buf->buf = kmalloc(buf_size, gfp);
 	}
 
 	if (!buf->buf)
@@ -595,7 +594,7 @@ static void reclaim_consumed_buffers(struct port *port)
 
 static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 			      int nents, size_t in_count,
-			      void *data, bool nonblock)
+			      struct port_buffer *buf, bool nonblock)
 {
 	struct virtqueue *out_vq;
 	int err;
@@ -608,14 +607,14 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 
 	reclaim_consumed_buffers(port);
 
-	err = virtqueue_add_outbuf(out_vq, sg, nents, data, GFP_ATOMIC);
+	err = virtqueue_add_outbuf(out_vq, sg, nents, buf, GFP_ATOMIC);
 
 	/* Tell Host to go! */
 	virtqueue_kick(out_vq);
 
 	if (err) {
 		in_count = 0;
-		goto done;
+		goto free_and_done;
 	}
 
 	if (out_vq->num_free == 0)
@@ -632,10 +631,19 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	 * buffer and relax the spinning requirement.  The downside is
 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
 	 * console driver writes something out.
+	 *
+	 * Spin until host returns the buffer.
+	 * Capture the returned buf so we can free it.
+	 * If broken, buf == NULL and buf stays in the vq;
+	 * remove_vqs() will call virtqueue_detach_unused_buf() -> free_buf().
 	 */
-	while (!virtqueue_get_buf(out_vq, &len)
+	while (!(buf = virtqueue_get_buf(out_vq, &len))
 		&& !virtqueue_is_broken(out_vq))
 		cpu_relax();
+
+free_and_done:
+	if (buf)
+		free_buf(buf, false);
 done:
 	spin_unlock_irqrestore(&port->outvq_lock, flags);
 
@@ -816,14 +824,14 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	count = min((size_t)(32 * 1024), count);
 
-	buf = alloc_buf(port->portdev->vdev, count, 0);
+	buf = alloc_buf(port->portdev->vdev, count, 0, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = copy_from_user(buf->buf, ubuf, count);
 	if (ret) {
-		ret = -EFAULT;
-		goto free_buf;
+		free_buf(buf, true);
+		return -EFAULT;
 	}
 
 	/*
@@ -835,15 +843,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 	 */
 	nonblock = true;
 	sg_init_one(sg, buf->buf, count);
-	ret = __send_to_port(port, sg, 1, count, buf, nonblock);
-
-	if (nonblock && ret > 0)
-		goto out;
-
-free_buf:
-	free_buf(buf, true);
-out:
-	return ret;
+	return __send_to_port(port, sg, 1, count, buf, nonblock);
 }
 
 struct sg_list {
@@ -932,7 +932,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 		goto error_out;
 
 	occupancy = pipe_buf_usage(pipe);
-	buf = alloc_buf(port->portdev->vdev, 0, occupancy);
+	buf = alloc_buf(port->portdev->vdev, 0, occupancy, GFP_KERNEL);
 
 	if (!buf) {
 		ret = -ENOMEM;
@@ -946,11 +946,12 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 	sg_init_table(sgl.sg, sgl.size);
 	ret = __splice_from_pipe(pipe, &sd, pipe_to_sg);
 	pipe_unlock(pipe);
+
 	if (likely(ret > 0))
 		ret = __send_to_port(port, buf->sg, sgl.n, sgl.len, buf, true);
-
-	if (unlikely(ret <= 0))
+	else
 		free_buf(buf, true);
+
 	return ret;
 
 error_out:
@@ -1108,21 +1109,25 @@ static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 {
 	struct port *port;
 	struct scatterlist sg[1];
-	void *data;
-	int ret;
+	struct port_buffer *pbuf;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
 
-	data = kmemdup(buf, count, GFP_ATOMIC);
-	if (!data)
+	pbuf = alloc_buf(port->portdev->vdev, count, 0, GFP_ATOMIC);
+	if (!pbuf)
 		return -ENOMEM;
 
-	sg_init_one(sg, data, count);
-	ret = __send_to_port(port, sg, 1, count, data, false);
-	kfree(data);
-	return ret;
+	memcpy(pbuf->buf, buf, count);
+	pbuf->len = count;
+	sg_init_one(sg, pbuf->buf, count);
+
+	/*
+	 * Ownership of pbuf is transferred to __send_to_port().
+	 * Do not touch or free pbuf after this call.
+	 */
+	return __send_to_port(port, sg, 1, count, pbuf, false);
 }
 
 /*
@@ -1295,7 +1300,7 @@ static int fill_queue(struct virtqueue *vq, spinlock_t *lock)
 
 	nr_added_bufs = 0;
 	do {
-		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
+		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
-- 
2.34.1

